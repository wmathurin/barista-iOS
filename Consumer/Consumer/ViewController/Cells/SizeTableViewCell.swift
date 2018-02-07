//
//  CategoryCollectionViewCell.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class SizeTableViewCell: UITableViewCell {
    @IBOutlet private weak var attributeNameLabel: UILabel!
    @IBOutlet private weak var attributeIconView: UIImageView!
    
    var attributeName: String? {
        didSet {
            attributeNameLabel.text = attributeName
        }
    }
    
    var attributeIconURL: String? {
        didSet {
            attributeIconView.loadImageUsingCache(withUrl: attributeIconURL)
        }
    }
    
    override func awakeFromNib() {
        self.attributeNameLabel.font = Theme.menuTextFont
        self.attributeNameLabel.textColor = Theme.menuTextColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
