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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.categoryLabel.font = Theme.menuTextFont
        self.categoryLabel.textColor = Theme.menuTextColor
    }
}
