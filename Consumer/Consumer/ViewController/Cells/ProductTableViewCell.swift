//
//  ProductTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/5/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductTableViewCell: BaseTableViewCell {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView?.round()
    }
}
