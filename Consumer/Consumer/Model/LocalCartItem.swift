//
//  LocalCartItem.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/27/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation

struct LocalCartItem {
    let product:Product
    var options:[LocalCartOption]
    var quantity:Int
}
