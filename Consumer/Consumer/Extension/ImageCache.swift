//
//  ImageCache.swift
//  Consumer
//
//  Created by David Vieser on 2/16/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import UIKit
import SalesforceSwiftSDK

class ImageCache {
    
    static public func fetchImageUsingCache(withUrl urlString : String?, completion: ((UIImage?) -> ())? = nil) -> UIImage? {
        guard urlString != nil else {
            return nil
        }
        let imageScale = Int(UIScreen.main.scale)
        var url = URL(string:  urlString!)
        if imageScale > 1 {
            let newFileName = url?.lastPathComponent.replacingOccurrences(of: ".", with: "@\(imageScale)x.") ?? ""
            url?.deleteLastPathComponent()
            url?.appendPathComponent(newFileName)
        }
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString! as NSString) as? UIImage {
            return cachedImage
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard error == nil else {
                SalesforceSwiftLogger.log(type(of:self) as! AnyClass, level:.error, message: "\(String(describing: url)) failed to download")
                return
            }
            if let image = UIImage(data: data!) {
                imageCache.setObject(image, forKey: urlString! as NSString)
                completion?(image)
                
            }
        }).resume()
        return nil
    }
}
