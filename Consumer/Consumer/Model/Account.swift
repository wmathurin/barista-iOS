//
//  Account.swift
//  Consumer
//
//  Created by Nicholas McDonald on 3/1/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class Account: Record, StoreProtocol {
    
    enum Field: String {
        case accountNumber = "AccountNumber"
        case billingAddress = "BillingAddress"
        case createdById = "CreatedById"
        case createdDate = "CreatedDate"
        case description = "Description"
        case accountId = "Id"
        case name = "Name"
        case ownerId = "OwnerId"
        case parentId = "ParentId"
        case phone = "Phone"
        
        static let allFields = [accountNumber.rawValue, billingAddress.rawValue, createdById.rawValue, description.rawValue, accountId.rawValue, name.rawValue, ownerId.rawValue, parentId.rawValue, phone.rawValue]
    }
    
    fileprivate(set) lazy var accountId: String? = data[Field.accountId.rawValue] as? String
    var accountNumber: String? {
        get { return self.data[Field.accountNumber.rawValue] as? String}
        set { self.data[Field.accountNumber.rawValue] = newValue}
    }
    var description: String? {
        get { return self.data[Field.description.rawValue] as? String}
        set { self.data[Field.description.rawValue] = newValue}
    }
    var name: String? {
        get { return self.data[Field.name.rawValue] as? String}
        set { self.data[Field.name.rawValue] = newValue}
    }
    var ownerId: String? {
        get { return self.data[Field.ownerId.rawValue] as? String}
        set { self.data[Field.ownerId.rawValue] = newValue}
    }
    
    override static var indexes: [[String : String]] {
        return super.indexes + [
            ["path" : Field.name.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.ownerId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.parentId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.accountNumber.rawValue, "type" : kSoupIndexTypeString]
        ]
    }
    
    static var objectName: String = "Account"
    
    static var orderPath: String = Field.accountId.rawValue
    
    override static var readFields: [String] {
        return super.readFields + Field.allFields
    }
    override static var createFields: [String] {
        return super.createFields + Field.allFields
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
}
