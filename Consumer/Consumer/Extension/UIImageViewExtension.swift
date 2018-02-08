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
    public func loadImageUsingCache(withUrl urlString : String?) {
        guard urlString != nil else {
            return
        }
        let imageScale = Int(UIScreen.main.scale)
        var url = URL(string:  urlString!)
        if imageScale > 1 {
            let newFileName = url?.lastPathComponent.replacingOccurrences(of: ".", with: "@\(imageScale)x.") ?? ""
            url?.deleteLastPathComponent()
            url?.appendPathComponent(newFileName)
        }
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
    
    func round() {
        layer.cornerRadius = bounds.size.width / 2
    }
}
