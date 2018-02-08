//
//  CategoryAttributeStore.swift
//  Consumer
//
//  Created by David Vieser on 1/30/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class CategoryAttributeStore: Store<CategoryAttribute> {
    static let instance = CategoryAttributeStore()
    
    func attributes<T:CategoryAttribute>(forCategory category: Category?) -> [T] {
        guard category?.id != nil else {
            return []
        }
        
        let queryString = "SELECT \(CategoryAttribute.selectFieldsString()) FROM {\(CategoryAttribute.objectName)} WHERE {\(CategoryAttribute.objectName):\(CategoryAttribute.Field.categoryId.rawValue)} = '\(category!.id!)'"
        
        let query:SFQuerySpec = SFQuerySpec.newSmartQuerySpec(queryString, withPageSize: 100)!
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch Attributes for Category failed: \(error!.localizedDescription)")
            return []
        }
        return CategoryAttribute.from(results)
    }

}
