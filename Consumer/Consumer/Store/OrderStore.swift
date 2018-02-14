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
    
    // get products from order soql
    // SELECT Id,name,(select Id, OrderId, OrderItemNumber, PricebookEntry.Product2.Name, PricebookEntry.Product2.id, Quantity, UnitPrice FROM OrderItems ) from order where id=\(orderId)
    
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
    
    override func records() -> [Order] {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(Order.objectName, withOrderPath: Order.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(Order.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return Order.from(results)
    }
    
    func pendingOrder() -> Order? {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(Order.objectName, withOrderPath: Order.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(Order.objectName) failed: \(error!.localizedDescription)")
            return nil
        }
        let records:[Order] = Order.from(results)
        let pending = records.filter({$0.orderStatus() == .pending})
        return pending.last
    }
}
