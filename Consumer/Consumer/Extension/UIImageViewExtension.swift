//
//  UIImageViewExtension.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSwiftSDK

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    public func mask(curveHeight: CGFloat) {
        let maskPath: UIBezierPath = UIBezierPath()
       
        maskPath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY + min(curveHeight,0)))
        maskPath.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY))
        maskPath.addLine(to: CGPoint(x: frame.maxX, y: bounds.minY))
        maskPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY + min(curveHeight,0)))
        
        maskPath.addQuadCurve(to: CGPoint(x: bounds.minX, y: bounds.maxY + min(curveHeight,0)), controlPoint: CGPoint(x: bounds.midX, y: bounds.maxY - max(curveHeight, 0)))
        
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    public func loadImageUsingCache(withUrl urlString : String?) {
        guard urlString != nil else {
            return
        }
        let url = URL(string: urlString!)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString! as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard error == nil else {
                SalesforceSwiftLogger.log(type(of:self), level:.error, message: "\(String(describing: url)) failed to download")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString! as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
    func tintImage(withColor color: UIColor) {
        if let originalImage = image {
            let templateImage = originalImage.withRenderingMode(.alwaysTemplate)
            image = templateImage
            tintColor = color
        }
    }
}
