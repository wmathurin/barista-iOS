//
//  LocalCartStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/27/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSDKCore
import SalesforceSwiftSDK

class LocalCartStore {
    static let instance = LocalCartStore()
    
    fileprivate var inProgressItem:LocalCartItem?
    
    func cartCount() -> Int {
        if let account = AccountStore.instance.myAccount(),
            let opportunity = OpportunityStore.instance.opportunitiesInProgressForAccount(account).first,
            let primary = opportunity.primaryQuote {
            let lineGroups = QuoteLineGroupStore.instance.lineGroupsForQuote(primary)
            return lineGroups.count
        }
        return 0
    }
    
    func currentCart() -> [LocalCartItem?] {
        // will only show commited cart items. In progress items should be ignored
        var cartItems:[LocalCartItem] = []
        if let account = AccountStore.instance.myAccount(),
            let opportunity = OpportunityStore.instance.opportunitiesInProgressForAccount(account).first,
            let primary = opportunity.primaryQuote {
            let lineGroups = QuoteLineGroupStore.instance.lineGroupsForQuote(primary)
            for group in lineGroups {
                guard let groupId = group.id else { continue }
                let items = QuoteLineItemStore.instance.lineItemsForGroup(groupId)
                var primaryItem:LocalCartItem?
                for (index, item) in items.enumerated() {
                    guard let quantity = item.quantity,
                        let productId = item.product else { continue }
                    if index == 0 {
                        guard let product = ProductStore.instance.product(from: productId) else { break }
                        primaryItem = LocalCartItem(product: product, options: [], quantity: quantity)
                    } else {
                        if let option = ProductOptionStore.instance.optionFromOptionalSKU(productId) {
                            let optionItem = LocalCartOption(product: option, quantity: quantity)
                            primaryItem?.options.append(optionItem)
                        }
                    }
                }
                if let item = primaryItem {
                    cartItems.append(item)
                }
            }
        }
        return cartItems
    }
    
    func remove(_ item:LocalCartItem) {
        
    }
    
    func beginConfiguring(_ item:LocalCartItem) {
        self.inProgressItem = item
    }
    
    func updateInProgressItem(_ withOption:LocalCartOption) {
        // todo - update with rules from platform
        
        //rules
        // if integer type - update quantity
        // else if existing type, remove current, add new
        
        guard let optionType = withOption.product.optionType, let _ = self.inProgressItem else {return}
        if let index = self.inProgressItem!.options.index(where: { (cartOption) -> Bool in
            guard let optionFamily = withOption.product.productFamily else {return false}
            return cartOption.product.productFamily == optionFamily
        }) {
            // update value or remove existing based on type
            switch optionType {
            case .integer:
                if withOption.quantity > 0 {
                    print("updating quantity for: \(self.inProgressItem!.options[index].product.productName) to: \(withOption.quantity)")
                    self.inProgressItem!.options[index].quantity = withOption.quantity
                } else {
                    print("removing quantity for: \(self.inProgressItem!.options[index].product.productName)")
                    self.inProgressItem!.options.remove(at: index)
                }
            case .slider:
                print("removing added item: \(self.inProgressItem!.options[index].product.productName)")
                self.inProgressItem!.options.remove(at: index)
                
                print("adding new line item: \(withOption.product.productName) with quantity: \(withOption.quantity)")
                self.inProgressItem!.options.append(withOption)
            case .picklist, .multiselect:
                print("removing added item: \(self.inProgressItem!.options[index].product.productName)")
                self.inProgressItem!.options.remove(at: index)
            }
        } else {
            // doesn't exist, add line item and set quantity
            print("adding new line item: \(withOption.product.productName) with quantity: \(withOption.quantity)")
            self.inProgressItem!.options.append(withOption)
        }
    }
    
    func commitToCart(completion:@escaping (Bool) -> Void) {
        // todo - update with validation from platform
        guard let account = AccountStore.instance.myAccount(), let inProgress = self.inProgressItem else {return}
        // rules
        // if no current opportunity, create new opportunity from logged in user
        // if no current quote, create new quote
        // create new quote line group for in progress cart item
        // assign quote number to line group
        // create new quote line for each product
        // assign quote line group to each quote line
        guard let pricebook = PricebookStore.instance.freePricebook() else {
            self.showError("Could not find pricebook")
            completion(false)
            return
        }
        self.getOrCreateNewOpportunity(forAccount: account, pricebook: pricebook) { (opportunity) in
            guard let opty = opportunity else {
                self.showError("Unable to create or retrieve Opportunity record")
                completion(false)
                return
            }
            self.getOrCreateNewQuote(forOpportunity: opty, withAccount: account, completion: { (quote) in
                guard let newQuote = quote else {
                    self.showError("Unable to create or retriece Quote record")
                    completion(false)
                    return
                }
                self.createNewLineGroup(forQuote: newQuote, completion: { (quoteLineGroup) in
                    guard let group = quoteLineGroup else {
                        self.showError("Unable to create QuoteLineGroup record")
                        completion(false)
                        return
                    }
                    guard let productId = inProgress.product.productId else {
                        self.showError("Product missing product ID")
                        completion(false)
                        return
                    }
                    let mainItem = QuoteLineItem(withLineGroup: group, forProduct: productId, quantity: inProgress.quantity, lineNumber: 1)
                    QuoteLineItemStore.instance.upsertNewEntries(entry: mainItem)
                    for (index, option) in inProgress.options.enumerated() {
                        guard let optionID = option.product.optionSKU else {
                            self.showError("Option missing product ID")
                            continue
                        }
                        let lineItem = QuoteLineItem(withLineGroup: group, forProduct: optionID, quantity: option.quantity, lineNumber: index + 2)
                        QuoteLineItemStore.instance.upsertNewEntries(entry: lineItem)
                    }
                    QuoteLineItemStore.instance.syncUp(completion: { (syncUpState) in
                        if let complete = syncUpState?.isDone() {
                            if complete == true {
                                QuoteLineItemStore.instance.syncDown(completion: { (syncDownState) in
                                    if let complete = syncUpState?.isDone() {
                                        if complete == true {
                                            self.inProgressItem = nil
                                            completion(true)
                                        } else {
                                            self.showError("Failed syncing down line items")
                                            completion(false)
                                        }
                                    }
                                })
                            }
                        }
                    })
                })
                
            })
        }
        
    }
    
    func submitOrder(completion:@escaping (Bool) -> Void) {
        if let account = AccountStore.instance.myAccount(),
            let opportunity = OpportunityStore.instance.opportunitiesInProgressForAccount(account).first,
            let primary = opportunity.primaryQuote,
            let quote = QuoteStore.instance.quoteFromId(primary) {
            quote.status = .presented
            opportunity.stage = .negotiationReview
            QuoteStore.instance.updateEntry(entry: quote, completion: { (quoteSync) in
                guard let quoteState = quoteSync else { return }
                if quoteState.isDone() {
                    OpportunityStore.instance.updateEntry(entry: opportunity, completion: { (optSync) in
                        guard let optyState = quoteSync else { return }
                        if optyState.isDone() {
                            completion(true)
                        } else if optyState.hasFailed() {
                            self.showError("Failed syncing opportunity update")
                            completion(false)
                        }
                    })
                } else if quoteState.hasFailed() {
                    self.showError("Failed syncing quote update")
                    completion(false)
                }
            })
            
        }
    }
    
    func showError(_ reason:String) {
        // todo log to screen/file
        print("LocalCartStore error: \(reason)")
    }
}

extension LocalCartStore {
    fileprivate func getOrCreateNewOpportunity(forAccount account:Account, pricebook:Pricebook, completion:@escaping (Opportunity?) -> Void) {
        let inProgress = OpportunityStore.instance.opportunitiesInProgressForAccount(account)
        if inProgress.count == 0 {
            let newOpty = Opportunity()
            newOpty.accountName = account.accountId
            newOpty.name = account.name
            newOpty.stage = .prospecting
            newOpty.closeDate = Date(timeIntervalSinceNow: 90001)
            newOpty.pricebookId = pricebook.pricebookId
            let optyId = newOpty.externalId
            OpportunityStore.instance.createEntry(entry: newOpty, completion: { (syncState) in
                if let complete = syncState?.isDone(), complete == true {
                    guard let synced = OpportunityStore.instance.record(forExternalId: optyId) else {
                        completion(nil)
                        return
                    }
                    completion(synced)
                }
            })
        } else {
            completion(inProgress.first!)
        }
    }
    
    fileprivate func getOrCreateNewQuote(forOpportunity opportunity:Opportunity, withAccount account:Account, completion:@escaping (Quote?) -> Void) {
        // assign opportunity primary quote and sync up
        if let primary = opportunity.primaryQuote, let quote = QuoteStore.instance.quoteFromId(primary) {
            completion(quote)
        } else {
            let newQuote = Quote()
            newQuote.primaryQuote = true
            newQuote.opportunity = opportunity.id
            newQuote.account = account.accountId
            newQuote.pricebookId = opportunity.pricebookId
            newQuote.lineItemsGrouped = true
            newQuote.primaryQuote = true
            let newQuoteId = newQuote.externalId
            QuoteStore.instance.create(newQuote, completion: { (syncState) in
                if let complete = syncState?.isDone(), complete == true {
                    guard let synced = QuoteStore.instance.record(forExternalId: newQuoteId) else {
                        completion(nil)
                        return
                    }
                    opportunity.primaryQuote = synced.quoteId
                    OpportunityStore.instance.upsertEntries(record: opportunity)
                    OpportunityStore.instance.syncUp()
                    completion(synced)
                }
            })
        }
    }
    
    fileprivate func createNewLineGroup(forQuote quote:Quote, completion:@escaping (QuoteLineGroup?) -> Void) {
        let newLineGroup = QuoteLineGroup()
        newLineGroup.account = quote.account
        newLineGroup.groupName = self.inProgressItem?.product.name
        newLineGroup.quote = quote.quoteId
        let lineGroupId = newLineGroup.externalId
        QuoteLineGroupStore.instance.createEntry(entry: newLineGroup) { (syncState) in
            if let complete = syncState?.isDone(), complete == true {
                guard let synced = QuoteLineGroupStore.instance.record(forExternalId: lineGroupId) else {
                    completion(nil)
                    return
                }
                completion(synced)
            }
        }
    }
}
