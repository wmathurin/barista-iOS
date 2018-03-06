//
//  AccountViewController.swift
//  Consumer
//
//  Created by David Vieser on 2/5/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import SmartStore
import Common

class AccountViewController: UIViewController {

    @IBAction func smartStoreDebugButtonPressed(_ sender: Any) {
        let smartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: kDefaultSmartStoreName) as! SFSmartStore)
        present(smartStoreViewController, animated: true, completion: nil)
    }
    
    fileprivate var quote:Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let createQuote = UIButton(type: .custom)
        createQuote.translatesAutoresizingMaskIntoConstraints = false
        createQuote.setTitle("Create Quote", for: .normal)
        createQuote.setTitleColor(UIColor.red, for: .normal)
        createQuote.addTarget(self, action: #selector(createQuoteOutOfThinAir), for: .touchUpInside)
        self.view.addSubview(createQuote)
        
        createQuote.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        createQuote.topAnchor.constraint(equalTo: self.view.topAnchor, constant:20.0).isActive = true
        
        let addLine = UIButton(type: .custom)
        addLine.translatesAutoresizingMaskIntoConstraints = false
        addLine.setTitle("Add Line Item", for: .normal)
        addLine.setTitleColor(UIColor.red, for: .normal)
        addLine.addTarget(self, action: #selector(addLineToQuote), for: .touchUpInside)
        self.view.addSubview(addLine)
        
        addLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        addLine.topAnchor.constraint(equalTo: createQuote.bottomAnchor, constant:10.0).isActive = true
        
        QuoteStore.instance.syncDown { (quoteSyncState) in
            if let complete = quoteSyncState?.isDone(), complete == true {
                let records  = QuoteStore.instance.records()
                print("quote records: \(records)")
            }
        }
        
        var count:Int = 0
        func quoteSyncCompletion(count: Int) {
            if count == 4 {
                let quotes = QuoteStore.instance.records()
                let lineItems = QuoteLineItemStore.instance.records()
                let groups = QuoteLineGroupStore.instance.records()
                let opportunities = OpportunityStore.instance.records()
                print("break here")
            }
        }
        
        QuoteLineItemStore.instance.syncDown { (syncState) in
            if let complete = syncState?.isDone(), complete == true {
                count = count + 1
                quoteSyncCompletion(count: count)
            }
        }
        
        QuoteLineItemStore.instance.syncDown { (syncState) in
            if let complete = syncState?.isDone(), complete == true {
                count = count + 1
                quoteSyncCompletion(count: count)
            }
        }
        
        QuoteLineGroupStore.instance.syncDown { (syncState) in
            if let complete = syncState?.isDone(), complete == true {
                count = count + 1
                quoteSyncCompletion(count: count)
            }
        }
        
        OpportunityStore.instance.syncDown { (syncState) in
            if let complete = syncState?.isDone(), complete == true {
                count = count + 1
                quoteSyncCompletion(count: count)
            }
        }
    }
    
    @objc func createQuoteOutOfThinAir() {
        let current = QuoteStore.instance.records()
        if let first = current.first {
            let firstOpty = first.opportunity
            let firstCreatedBy = first.createdById
            let firstOwnerId = first.ownerId
            let firstAccount = first.account
            let firstPricebook = first.pricebookId
            
            let quote = Quote()
            quote.opportunity = firstOpty
            quote.ownerId = firstOwnerId
            quote.account = firstAccount
            quote.pricebookId = firstPricebook
            quote.status = .draft
            
            QuoteStore.instance.create(quote, completion: { (syncState) in
                print("syncState: \(syncState)")
                if let complete = syncState?.isDone(), complete == true {
                    let records = QuoteStore.instance.records()
                    self.quote = records.first
                    print("records")
                }
            })
        }
    }
    
    @objc func addLineToQuote() {
        guard let q = self.quote else {return}
        let product = ProductStore.instance.records().first!
        let lineItem = QuoteLineItem()
        lineItem.product = product.productId
//        lineItem.lineNumber = 1
        lineItem.quote = q.quoteId
        lineItem.quantity = 1
        
        QuoteLineItemStore.instance.create(lineItem) { (syncState) in
            print("syncState: \(syncState)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
