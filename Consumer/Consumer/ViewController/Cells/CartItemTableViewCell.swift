//
//  CartItemCollectionViewCell.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/12/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    fileprivate var itemNameLabel = UILabel()
    fileprivate var descriptionLabel1 = UILabel()
    fileprivate var descriptionLabel2 = UILabel()
    fileprivate var descriptionLabel3 = UILabel()
    fileprivate var priceLabel = UILabel()
    
    var itemName:String? {
        didSet {
            self.itemNameLabel.text = itemName
        }
    }
    var description1:String? {
        didSet {
            self.descriptionLabel1.text = description1
        }
    }
    var description2:String? {
        didSet {
            self.descriptionLabel2.text = description2
        }
    }
    var description3:String? {
        didSet {
            self.descriptionLabel3.text = description3
        }
    }
    var price:String? {
        didSet {
            self.priceLabel.text = price
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(container)
        container.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        container.addSubview(self.itemNameLabel)
        container.addSubview(self.descriptionLabel1)
        container.addSubview(self.descriptionLabel2)
        container.addSubview(self.descriptionLabel3)
        container.addSubview(self.priceLabel)
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel1.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel3.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.itemNameLabel.font = Theme.cartItemNameFont
        self.itemNameLabel.textColor = Theme.cartItemTextColor
        self.descriptionLabel1.font = Theme.cartItemDescriptionFont
        self.descriptionLabel1.textColor = Theme.cartItemTextColor
        self.descriptionLabel2.font = Theme.cartItemDescriptionFont
        self.descriptionLabel2.textColor = Theme.cartItemTextColor
        self.descriptionLabel3.font = Theme.cartItemDescriptionFont
        self.descriptionLabel3.textColor = Theme.cartItemTextColor
        self.priceLabel.font = Theme.cartItemDescriptionFont
        self.priceLabel.textColor = Theme.cartItemTextColor
        
        self.itemNameLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant:20).isActive = true
        self.descriptionLabel1.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor).isActive = true
        self.descriptionLabel2.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor).isActive = true
        self.descriptionLabel3.leftAnchor.constraint(equalTo: self.itemNameLabel.leftAnchor).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant:-20).isActive = true
//        self.itemNameLabel.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant:-10).isActive = true
//        self.descriptionLabel1.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant:-10).isActive = true
//        self.descriptionLabel2.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant:-10).isActive = true
//        self.descriptionLabel3.rightAnchor.constraint(equalTo: self.priceLabel.leftAnchor, constant:-10).isActive = true
        
        self.itemNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant:10).isActive = true
        self.descriptionLabel1.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor).isActive = true
        self.descriptionLabel2.topAnchor.constraint(equalTo: self.descriptionLabel1.bottomAnchor).isActive = true
        self.descriptionLabel3.topAnchor.constraint(equalTo: self.descriptionLabel2.bottomAnchor).isActive = true
        self.descriptionLabel3.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant:-10).isActive = true
        self.priceLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
    }
    
    override func prepareForReuse() {
        self.itemName = ""
        self.description1 = ""
        self.description2 = ""
        self.description3 = ""
        self.price = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
