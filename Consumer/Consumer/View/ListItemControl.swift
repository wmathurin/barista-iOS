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
            self.controlButton.layer.borderColor = controlColor?.cgColor
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
    var controlIndex:Int = 0
    
    fileprivate var controlButton = UIView()
    fileprivate var valueLabel = UILabel()
    fileprivate var lastTouchPosition:CGPoint?
    fileprivate var isButtonSelected = false
    fileprivate static let buttonSize: CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.controlButton.translatesAutoresizingMaskIntoConstraints = false
        self.controlButton.isUserInteractionEnabled = false
        self.controlButton.layer.cornerRadius = ListItemControl.buttonSize / 2.0
        self.controlButton.layer.borderWidth = 1.0
        self.addSubview(self.controlButton)
        
        self.valueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.valueLabel.isUserInteractionEnabled = false
        self.addSubview(self.valueLabel)
        
        self.heightAnchor.constraint(equalToConstant: ListItemControl.buttonSize).isActive = true
        
        self.controlButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.controlButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.controlButton.heightAnchor.constraint(equalTo: self.controlButton.widthAnchor).isActive = true
        self.controlButton.widthAnchor.constraint(equalToConstant: ListItemControl.buttonSize).isActive = true
        
        self.valueLabel.leftAnchor.constraint(equalTo: self.controlButton.rightAnchor, constant:10.0).isActive = true
        self.valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        self.lastTouchPosition = touchPoint
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        self.lastTouchPosition = touchPoint
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let last = self.lastTouchPosition else {return}
        if self.bounds.contains(last) {
            self.isButtonSelected = !self.isButtonSelected
        }
        var borderWidth = self.controlButton.layer.borderWidth
        if self.isButtonSelected {
            borderWidth = ListItemControl.buttonSize / 2.0
        } else {
            borderWidth = 1.0
        }
        let anim = CABasicAnimation(keyPath: "borderWidth")
        anim.fromValue = self.controlButton.layer.borderWidth
        anim.toValue = borderWidth
        anim.duration = 0.2
        self.controlButton.layer.add(anim, forKey: "width")
        self.controlButton.layer.borderWidth = borderWidth
    }
}
