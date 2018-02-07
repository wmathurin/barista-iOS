//
//  FeaturedProductTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/6/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class FeaturedProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    
    var productName: String? = nil {
        didSet {
            self.productNameLabel.text = self.productName
        }
    }
    
    var productImageURL: String? {
        didSet {
            if let productImageURL = productImageURL {
                self.productImageView.loadImageUsingCache(withUrl: productImageURL)
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productNameLabel.textColor = UIColor.white
        self.productNameLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
