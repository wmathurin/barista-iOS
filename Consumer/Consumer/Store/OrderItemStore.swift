//
//  OrderItemStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/9/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class OrderItemStore: Store<OrderItem> {
    static let instance = OrderItemStore()
    
    fileprivate func orderItemsQueryString() -> String {
        let queryString = "SELECT \(OrderItem.Field.itemId.rawValue),\(OrderItem.Field.orderId.rawValue),\(OrderItem.Field.orderItemNumber.rawValue),\(OrderItem.Field.pricebookEntry.rawValue),\(OrderItem.Field.quantity.rawValue),\(OrderItem.Field.unitPrice.rawValue) FROM {\(OrderItem.objectName)}"
        return queryString
    }
    
    fileprivate func orderItemsQueryString(for order:Order) -> String {
        guard let orderId = order.orderId else { return "" }
        let queryString = "SELECT \(OrderItem.selectFieldsString()) FROM {\(OrderItem.objectName)}"
        //WHERE {\(OrderItem.objectName):\(OrderItem.Field.orderId.rawValue)} = '\(orderId)'"
        return queryString
    }
    
    func items(from order:Order) -> [OrderItem] {
        guard let orderId = order.orderId else { return [] }
        let query = SFQuerySpec.newExactQuerySpec(OrderItem.objectName,
                                                  withPath: OrderItem.Field.orderId.rawValue,
                                                  withMatchKey: orderId,
                                                  withOrderPath: OrderItem.Field.itemId.rawValue,
                                                  with: .ascending,
                                                  withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(OrderItem.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return OrderItem.from(results)
    }
    
    func syncDownItems(for order:Order, completion: SyncCompletion = nil) {
        let queryString = self.orderItemsQueryString(for: order)
        let target = SFSoqlSyncDownTarget.newSyncTarget(queryString)
        let options = SFSyncOptions.newSyncOptions(forSyncDown: .leaveIfChanged)
        smartSync.syncDown(with: target, options: options, soupName: OrderItem.objectName, update: completion ?? { _ in return })
    }
    
    override func records() -> [OrderItem] {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(OrderItem.objectName, withOrderPath: OrderItem.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(OrderItem.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return OrderItem.from(results)
    }
}
