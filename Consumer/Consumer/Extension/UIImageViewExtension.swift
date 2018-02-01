//
//  UIImageViewExtension.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func mask(curveHeight: CGFloat) {
        let maskPath: UIBezierPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        maskPath.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY))
        maskPath.addLine(to: CGPoint(x: frame.maxX, y: bounds.minY))
        maskPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        maskPath.addQuadCurve(to: CGPoint(x: bounds.minX, y: bounds.maxY), controlPoint: CGPoint(x: bounds.midX, y: bounds.maxY - curveHeight))
        
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
