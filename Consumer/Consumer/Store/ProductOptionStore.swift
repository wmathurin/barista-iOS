//
//  ProductOptionStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/24/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class ProductOptionStore: Store<ProductOption> {
    static let instance = ProductOptionStore()
    
    override func records() -> [ProductOption] {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(ProductOption.objectName, withOrderPath: ProductOption.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(ProductOption.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return ProductOption.from(results)
    }
    
    func options(_ forProduct:Product) -> [ProductOption]? {
        guard let productID = forProduct.productId else {return nil}
        let query = SFQuerySpec.newExactQuerySpec(ProductOption.objectName, withPath: ProductOption.Field.configuredProduct.rawValue, withMatchKey: productID, withOrderPath: ProductOption.orderPath, with: .ascending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(ProductOption.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return ProductOption.from(results)
    }
    
    func families(_ forProduct:Product) -> [ProductFamily]? {
        guard let options = self.options(forProduct) else {return nil}
        var familiesDict :[String:Array<ProductOption>] = [:]
        for option in options {
            guard let optionFamily = option.productFamily else { break }
            if let _ = familiesDict[optionFamily] {
                familiesDict[optionFamily]?.append(option)
            } else {
                familiesDict[optionFamily] = [option]
            }
        }
        let families: [ProductFamily] = familiesDict.flatMap { (optionFamily, optionsArray) in
            guard let first = optionsArray.first, let type = first.optionType else { return nil }
            let sortedOptions = optionsArray.sorted(by: { (first, second) -> Bool in
                guard let firstOrder = first.orderNumber, let secondOrder = second.orderNumber else { return false }
                return firstOrder < secondOrder
            })
            return ProductFamily(familyName: optionFamily, type: type, options: sortedOptions)
        }
        return families
    }
}
