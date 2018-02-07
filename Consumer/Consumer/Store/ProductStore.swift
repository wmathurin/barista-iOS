//
//  CategoryStore.swift
//  Consumer
//
//  Created by David Vieser on 1/30/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class ProductStore: Store<Product> {
    static let instance = ProductStore()
    
    //SELECT {ProductCategoryAssociation__c:Product__c} FROM {ProductCategoryAssociation__c WHERE {ProductCategoryAssociation__c:Category__c} ==
    
    
    func records<T:Product>(forCategory category: Category? = nil) -> [T] {
        if let category = category, let categoryId = category.id {
            let queryString = "SELECT \(Product.selectFieldsString()) FROM {\(ProductCategoryAssociation.objectName)}, {\(Product.objectName)} WHERE {\(ProductCategoryAssociation.objectName):\(ProductCategoryAssociation.Field.categoryId.rawValue)} = '\(categoryId)' AND {\(Product.objectName):\(Product.Field.id.rawValue)} = {\(ProductCategoryAssociation.objectName):\(ProductCategoryAssociation.Field.productId.rawValue)} ORDER BY {\(Product.objectName):\(Product.Field.name.rawValue)} ASC"
            
            let query:SFQuerySpec = SFQuerySpec.newSmartQuerySpec(queryString, withPageSize: 100)!
            var error: NSError? = nil
            let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
            guard error == nil else {
                SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch Products for Category failed: \(error!.localizedDescription)")
                return []
            }
            return Product.from(results)
        }
        return []
    }

    func featuredProducts<T:Product>() -> [T] {
        let queryString = "SELECT \(Product.selectFieldsString()) FROM {\(Product.objectName)} WHERE {\(Product.objectName):\(Product.Field.isFeaturedItem.rawValue)} = 1"
        
        let query:SFQuerySpec = SFQuerySpec.newSmartQuerySpec(queryString, withPageSize: 100)!
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch Featured Product list failed: \(error!.localizedDescription)")
            return []
        }
        return Product.from(results)
    }

}