//
//  BaseTableViewCell.swift
//  Consumer
//
//  Created by David Vieser on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var imageURL: String? {
        didSet {
            iconImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        imageView.round()
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
