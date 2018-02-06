//
//  FeaturedProductTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/6/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class FeaturedProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: Product? = nil {
        didSet {
            DispatchQueue.main.async(execute: {
                self.productNameLabel.text = self.product?.name
                if let featuredImageURL = self.product?.featuredImageURL {
                    self.productImageView.loadImageUsingCache(withUrl: featuredImageURL)
                }
            })
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
