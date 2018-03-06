//
//  ProductFamily.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/26/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation

struct ProductFamily {
    let familyName: String
    let type: ProductionOptionType
    var options: [ProductOption] = []
}
