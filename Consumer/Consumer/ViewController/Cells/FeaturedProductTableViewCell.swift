//
//  FeaturedProductTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/6/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class FeaturedProductTableViewCell: BaseTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.font = Theme.appRegularFont(22.0)
        self.nameLabel.textColor = Theme.featureItemTextColor
    }
}
