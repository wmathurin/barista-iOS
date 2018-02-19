//
//  ListItemControl.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/19/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ListItemControl: ProductConfigControlBase {
    
    var controlColor: UIColor? {
        didSet {
            self.controlButton.backgroundColor = controlColor
        }
    }
    var textColor: UIColor? {
        didSet {
            self.valueLabel.textColor = textColor
        }
    }
    var labelFont: UIFont! {
        didSet {
            self.valueLabel.font = labelFont
        }
    }
    var label: String? {
        didSet {
            self.valueLabel.text = label
        }
    }
    
    fileprivate var controlButton = UIView()
    fileprivate var valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.controlButton.translatesAutoresizingMaskIntoConstraints = false
        self.controlButton.isUserInteractionEnabled = false
        self.addSubview(self.controlButton)
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.valueLabel.isUserInteractionEnabled = false
        self.addSubview(self.valueLabel)
        
        self.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        self.controlButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.controlButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.controlButton.heightAnchor.constraint(equalTo: self.controlButton.widthAnchor).isActive = true
        self.controlButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        self.valueLabel.leftAnchor.constraint(equalTo: self.controlButton.rightAnchor, constant:10.0).isActive = true
        self.valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        //
    }
}
