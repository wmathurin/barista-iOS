//
//  CategoryAttributeStore.swift
//  Consumer
//
//  Created by David Vieser on 1/30/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

//import Foundation
//import SalesforceSwiftSDK
//import SmartStore
//import SmartSync
//
//class CategoryAttributeValueStore: Store<CategoryAttributeValue> {
//    static let instance = CategoryAttributeValueStore()
//    
//    func attributes<T:CategoryAttributeValue>(for attribute: CategoryAttribute?) -> [T] {
//        guard attribute?.id != nil else {
//            return []
//        }
//        
//        let queryString = "SELECT \(CategoryAttributeValue.selectFieldsString()) FROM {\(CategoryAttributeValue.objectName)} WHERE {\(CategoryAttributeValue.objectName):\(CategoryAttributeValue.Field.categoryId.rawValue)} = '\(attribute!.id!)' ORDER BY {\(CategoryAttributeValue.objectName):\(CategoryAttributeValue.Field.sortOrder.rawValue)} ASC"
//        
//        let query:SFQuerySpec = SFQuerySpec.newSmartQuerySpec(queryString, withPageSize: 100)!
//        var error: NSError? = nil
//        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
//        guard error == nil else {
//            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch Values for Attribute failed: \(error!.localizedDescription)")
//            return []
//        }
//        return T.from(results)
//    }
//
//}

