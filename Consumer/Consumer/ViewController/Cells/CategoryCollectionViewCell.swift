//
//  CategoryCollectionViewCell.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var category: Category? = nil {
        didSet {
            if let category = category {
                categoryLabel.text = category.name
                categoryImageView.loadImageUsingCache(withUrl: category.iconURL)
//                categoryImageView.tintImage(withColor: UIColor.blue)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryLabel.font = Theme.menuTextFont
        self.categoryLabel.textColor = Theme.menuTextColor
    }
}
