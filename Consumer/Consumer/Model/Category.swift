//
//  Category.swift
//  Consumer
//
//  Created by David Vieser on 1/30/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class Category: Record, StoreProtocol {
    static let objectName: String = "Category__c"
    
    enum Field: String {
        //        case ownerId = "OwnerId"
        case name = "Name"
        
        static let allFields = [name.rawValue]
    }
    
    
    //    fileprivate(set) lazy var ownerId: String? = data[Field.ownerId.rawValue] as? String
    fileprivate(set) lazy var name: String? = data[Field.name.rawValue] as? String
    
    override static var indexes: [[String : String]] {
        return super.indexes + [
            //            ["path" : Field.id.rawValue, "type" : kSoupIndexTypeString],
            //            ["path" : Field.ownerId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.name.rawValue, "type" : kSoupIndexTypeString],
            //            ["path" : Field.entryId.rawValue, "type" : kSoupIndexTypeString]
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
