//
//  Product.swift
//  Consumer
//
//  Created by David Vieser on 1/30/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class Product: Record, StoreProtocol {
    static let objectName: String = "Product2"
    
    enum Field: String {
        case name = "Name"
        case featuredImageURL = "FeaturedImageURL__c"
        case iconImageURL = "IconImageURL__c"
        case isFeaturedItem = "FeaturedItem__c"
        static let allFields = [name.rawValue, featuredImageURL.rawValue, iconImageURL.rawValue, isFeaturedItem.rawValue]
    }

    fileprivate(set) lazy var name: String? = data[Field.name.rawValue] as? String
    fileprivate(set) lazy var featuredImageURL: String? = data[Field.featuredImageURL.rawValue] as? String
    fileprivate(set) lazy var iconImageURL: String? = data[Field.iconImageURL.rawValue] as? String
    fileprivate(set) lazy var isFeaturedItem: String? = data[Field.isFeaturedItem.rawValue] as? String

    override static var indexes: [[String : String]] {
        return super.indexes + [
            ["path" : Field.name.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.featuredImageURL.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.iconImageURL.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.isFeaturedItem.rawValue, "type" : kSoupIndexTypeString],
        ]
    }
    
    override static var readFields: [String] {
        return super.readFields + Field.allFields
    }
    override static var createFields: [String] {
        return super.createFields + Field.allFields
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
    
    static var orderPath: String = Field.name.rawValue
}
