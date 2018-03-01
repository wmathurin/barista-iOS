//
//  LocalCartStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/27/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation

class LocalCartStore {
    static let instance = LocalCartStore()
    
    fileprivate var inProgressItem:LocalCartItem?
    
    func add(_ item:LocalCartItem) {
        
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
    
    func commitToCart() {
        // todo - update with validation from platform
        
        // rules
        // if no current quote, create new opportunity from logged in user
        // if no current quote, create new quote
        // create new quote line group for in progress cart item
        // assign quote number to line group
        // create new quote line for each product
        // assign quote line group to each quote line
    }
}
