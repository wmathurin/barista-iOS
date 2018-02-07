//
//  ProductTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/5/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    
    var productName: String? {
        didSet {
            productNameLabel.text = productName
        }
    }

    var productImageURL: String? {
        didSet {
            productImageView.loadImageUsingCache(withUrl: productImageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        productImageView.round()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
