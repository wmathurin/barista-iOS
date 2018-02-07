//
//  OrderStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class OrderStore: Store<Order> {
    static let instance = OrderStore()
    
    func records<T:Order>(forUser user:String) -> [T] {
        let queryString = "SELECT \(Order.selectFieldsString()) FROM {\(Order.objectName)} WHERE {\(Order.Field.orderOwner.rawValue):\(user)"
        
        let query = SFQuerySpec.newSmartQuerySpec(queryString, withPageSize: 100)!
        var error: NSError? = nil
        let results: [Any] = self.store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch Order list failed: \(error!.localizedDescription)")
            return []
        }
        return Order.from(results)
    }
}
