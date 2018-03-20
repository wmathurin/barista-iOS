//
//  OrderTableViewCell.swift
//  Provider
//
//  Created by Nicholas McDonald on 3/19/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import Common

class OrderTableViewCell: UITableViewCell {
    
    fileprivate var userImageView = UIImageView()
    fileprivate var itemNameLabels:[UILabel] = []
    fileprivate var optionsLabels:[UILabel] = []
    fileprivate var optionContainer = UIStackView()
    var iconImageView = UIImageView()
    
    var imageURL: String? {
        didSet {
            iconImageView.loadImageUsingCache(withUrl: imageURL)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        self.userImageView.translatesAutoresizingMaskIntoConstraints = false
        self.userImageView.backgroundColor = UIColor.brown
        self.addSubview(self.userImageView)
        
        self.userImageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        self.userImageView.widthAnchor.constraint(equalTo: self.userImageView.heightAnchor, multiplier: 1.0).isActive = true
        self.userImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant:40).isActive = true
        self.userImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:38).isActive = true
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        container.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        container.addSubview(self.optionContainer)
        
        self.optionContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.optionContainer.alignment = .leading
        self.optionContainer.distribution = .fillEqually
        self.optionContainer.axis = .vertical
        
        self.optionContainer.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant:173).isActive = true
        self.optionContainer.rightAnchor.constraint(equalTo: container.rightAnchor, constant:-173).isActive = true
        self.optionContainer.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.optionContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant:-20).isActive = true
        
        self.layoutIfNeeded()
        self.userImageView.round()
        
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 120.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(product:Product, options:[LocalProductOption]) {
        let productImage = UIImageView()
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.loadImageUsingCache(withUrl: product.iconImageURL)
        
        let itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = Theme.appBoldFont(24.0)
        itemNameLabel.textColor = Theme.cartItemTextColor
        itemNameLabel.text = product.name
        self.itemNameLabels.append(itemNameLabel)
        self.optionContainer.addArrangedSubview(itemNameLabel)
        
        for option in options {
            guard let type = option.product.optionType, let name = option.product.productDescription else { return }
            let optionLabel = UILabel()
            optionLabel.translatesAutoresizingMaskIntoConstraints = false
            optionLabel.font = Theme.appMediumFont(20.0)
            optionLabel.textColor = Theme.cartItemTextColor
            if type == .integer {
                optionLabel.text = "(\(option.quantity)) \(name)"
            } else {
                optionLabel.text = name
            }
            self.optionsLabels.append(optionLabel)
            self.optionContainer.addArrangedSubview(optionLabel)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
//        self.itemName = ""
        for label in self.optionsLabels {
            label.removeFromSuperview()
        }
        self.optionsLabels.removeAll()
    }

}
