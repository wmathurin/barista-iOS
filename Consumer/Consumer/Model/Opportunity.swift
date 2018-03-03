//
//  Opportunity.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/22/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

enum OpportunityStage: String {
    case prospecting = "Prospecting"
    case qualification = "Qualification"
    case needsAnalysis = "Needs Analysis"
    case valueProposition = "Value Proposition"
    case idDecisionMakes = "Id. Decision Makers"
    case perceptionAnalysis = "Perception Analysis"
    case proposalPriceQuote = "Proposal/Price Quote"
    case negotiationReview = "Negotiation/Review"
    case closedWon = "Closed Won"
    case closedLost = "Closed Lost"
}

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
        case stage = "StageName"
        case pricebook = "Pricebook2Id"
        case closeDate = "CloseDate"
        
        static let allFields = [accountName.rawValue, createdBy.rawValue, name.rawValue, orderGroupId.rawValue, ordered.rawValue, primaryQuote.rawValue, type.rawValue, stage.rawValue, pricebook.rawValue, closeDate.rawValue]
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
    var stage: OpportunityStage? {
        get { return OpportunityStage(rawValue: (self.data[Field.stage.rawValue] as? String)!)}
        set { self.data[Field.stage.rawValue] = newValue?.rawValue}
    }
    var pricebookId: String? {
        get { return self.data[Field.pricebook.rawValue] as? String}
        set { self.data[Field.pricebook.rawValue] = newValue}
    }
    var closeDate: Date? {
        get {
            guard let date = self.data[Field.closeDate.rawValue] as? String else {return nil}
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: date)
        }
        set {
            if let date = newValue {
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone(abbreviation: "GMT")
                formatter.dateFormat = "yyyy-MM-dd"
                self.data[Field.closeDate.rawValue] = formatter.string(from: date)
            }
        }
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
        return super.createFields + Field.allFields //[Field.accountName.rawValue, Field.name.rawValue]
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
    
    static var orderPath: String = Field.accountName.rawValue
}
