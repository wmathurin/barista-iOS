//
//  Order.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class Order: Record, StoreProtocol {
    
    enum Field: String {
        case accountId = "AccountId"
        case accountNumber = "AccountNumber"
        case orderAmount = "TotalAmount"
        case orderName = "Name"
        case orderNumber = "OrderNumber"
        case orderOwner = "OwnerId"
        case status = "Status"
        
        static let allFields = [accountId.rawValue, accountNumber.rawValue, orderAmount.rawValue, orderName.rawValue, orderNumber.rawValue, orderOwner.rawValue, status.rawValue]
    }
    
    fileprivate(set) lazy var accountId: String? = data[Field.accountId.rawValue] as? String
    fileprivate(set) lazy var accountNumber: String? = data[Field.accountNumber.rawValue] as? String
    fileprivate(set) lazy var amount: Float? = data[Field.orderAmount.rawValue] as? Float
    fileprivate(set) lazy var name: String? = data[Field.orderName.rawValue] as? String
    fileprivate(set) lazy var number: Int? = data[Field.orderNumber.rawValue] as? Int
    fileprivate(set) lazy var owner: String? = data[Field.orderOwner.rawValue] as? String
    fileprivate(set) lazy var status: String? = data[Field.status.rawValue] as? String
    
    override static var indexes: [[String : String]] {
        return super.indexes + [
            ["path" : Field.accountId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.orderName.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.orderNumber.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.orderOwner.rawValue, "type" : kSoupIndexTypeString],
        ]
    }
    
    static var objectName: String = "String"
    
    static var orderPath: String = Field.orderNumber.rawValue
    
    override static var readFields: [String] {
        return super.readFields + Field.allFields
    }
    override static var createFields: [String] {
        return super.createFields + Field.allFields
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
    
    static func selectFieldsString() -> String {
        return readFields.map { return "{\(objectName):\($0)}" }.joined(separator: ", ")
    }
}
