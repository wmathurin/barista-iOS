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
    
    func getRecords<T:Product>(forCategory category: Category? = nil) -> [T] {
        if let category = category, let categoryId = category.id {
            let queryString: String = "SELECT \(Product.selectFieldsString()) FROM {\(Product.objectName)} WHERE {\(Product.objectName):\(Product.Field.locallyDeleted.rawValue)} != 1 AND {\(Product.objectName):\(Product.Field.categoryId.rawValue)} = '\(categoryId)' ORDER BY {\(Product.objectName):\(Product.orderPath)} ASC"
            
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

}
