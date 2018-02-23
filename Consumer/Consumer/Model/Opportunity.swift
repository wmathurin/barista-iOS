//
//  Opportunity.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/22/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class Opportunity: Record, StoreProtocol {
    static let objectName: String = "Opportunity"
    
    enum Field: String {
        case accountName = "AccountId"
        case createdBy = "CreatedById"
        case name = "Name"
        case orderGroupId = "SBQQ__OrderGroupID__c"
        case ordered = "SBQQ__Ordered__c"
        case primaryQuote = "SBQQ__PrimaryQuote__c"
        case type = "Type"
        
        static let allFields = [accountName.rawValue, createdBy.rawValue, name.rawValue, orderGroupId.rawValue, ordered.rawValue, primaryQuote.rawValue, type.rawValue]
    }
    
    var accountName: String? {
        get { return self.data[Field.accountName.rawValue] as? String}
        set { self.data[Field.accountName.rawValue] = newValue}
    }
    var name: String? {
        get { return self.data[Field.name.rawValue] as? String}
        set { self.data[Field.name.rawValue] = newValue}
    }
    var orderGroupId: String? {
        get { return self.data[Field.orderGroupId.rawValue] as? String}
        set { self.data[Field.orderGroupId.rawValue] = newValue}
    }
    var ordered: String? {
        get { return self.data[Field.ordered.rawValue] as? String}
        set { self.data[Field.ordered.rawValue] = newValue}
    }
    var primaryQuote: String? {
        get { return self.data[Field.primaryQuote.rawValue] as? String}
        set { self.data[Field.primaryQuote.rawValue] = newValue}
    }
    var type: String? {
        get { return self.data[Field.type.rawValue] as? String}
        set { self.data[Field.type.rawValue] = newValue}
    }
    
    override static var indexes: [[String : String]] {
        return super.indexes + [
            ["path" : Field.accountName.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.name.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.primaryQuote.rawValue, "type" : kSoupIndexTypeString]
        ]
    }
    
    override static var readFields: [String] {
        return super.readFields + Field.allFields
    }
    override static var createFields: [String] {
        return super.createFields + [Field.accountName.rawValue, Field.name.rawValue]
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
    
    static var orderPath: String = Field.accountName.rawValue
}
