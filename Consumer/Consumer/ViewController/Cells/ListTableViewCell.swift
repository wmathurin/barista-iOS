//
//  CategoryCollectionViewCell.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ListTableViewCell: BaseTableViewCell, CellSelectedProtocol {
    
    func selected(attribute: CategoryAttribute) {
        let attributeValues: [CategoryAttributeValue] = CategoryAttributeValueStore.instance.attributes(for: attribute)
        attributeValues.forEach { print("\($0.name)") }
    }
    
}
