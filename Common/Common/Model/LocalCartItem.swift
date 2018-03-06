//
//  LocalCartItem.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/27/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation

public struct LocalCartItem {
    public let product:Product
    public var options:[LocalCartOption]
    public var quantity:Int
    
    public init(product:Product, options:[LocalCartOption], quantity:Int) {
        self.product = product
        self.options = options
        self.quantity = quantity
    }
}
