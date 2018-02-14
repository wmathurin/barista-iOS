//
//  CartFooterView.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/13/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class CartFooterView: UIView {
    
    fileprivate var totalLabel = UILabel()
    fileprivate var editButton = UIButton(type: .custom)
    var total:String? {
        didSet {
            self.totalLabel.text = total
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let totalContainer = UIView()
        totalContainer.translatesAutoresizingMaskIntoConstraints = false
        totalContainer.backgroundColor = UIColor.lightGray
        self.addSubview(totalContainer)
        
        self.editButton.translatesAutoresizingMaskIntoConstraints = false
        self.editButton.setTitle("Edit Order", for: .normal)
        self.editButton.setTitleColor(Theme.cartItemTextColor, for: .normal)
        self.editButton.titleLabel?.font = Theme.cartButtonFont
        self.addSubview(editButton)
        
        let totalTextLabel = UILabel()
        totalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTextLabel.text = "TOTAL"
        totalTextLabel.font = Theme.cartItemNameFont
        totalTextLabel.textColor = Theme.cartItemTextColor
        
        self.totalLabel.translatesAutoresizingMaskIntoConstraints = false
        self.totalLabel.font = Theme.cartItemNameFont
        self.totalLabel.textColor = Theme.cartItemTextColor
        
        totalContainer.addSubview(totalTextLabel)
        totalContainer.addSubview(self.totalLabel)
        
        totalTextLabel.leftAnchor.constraint(equalTo: totalContainer.leftAnchor, constant: 20).isActive = true
        totalTextLabel.centerYAnchor.constraint(equalTo: totalContainer.centerYAnchor).isActive = true
        self.totalLabel.rightAnchor.constraint(equalTo: totalContainer.rightAnchor, constant: -20).isActive = true
        self.totalLabel.centerYAnchor.constraint(equalTo: totalContainer.centerYAnchor).isActive = true
        
        totalContainer.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        totalContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        totalContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        totalContainer.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
        
        self.editButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.editButton.topAnchor.constraint(equalTo: totalContainer.bottomAnchor, constant:20).isActive = true
        self.editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        self.editButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
