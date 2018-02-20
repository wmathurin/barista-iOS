//
//  Theme.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/5/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

struct Theme {
    
    // Colors
    static var headingTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
    static var tabBarUnselectedColor: UIColor {
        get {
            return UIColor(displayP3Red: 247.0/255.0, green: 244.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        }
    }
    
    static var tabBarSelectedColor: UIColor {
        get {
            return UIColor(displayP3Red: 250.0/255.0, green: 200.0/255.0, blue: 19.0/255.0, alpha: 1.0)
        }
    }
    
    static var menuTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 47.0/255.0, green: 26.0/255.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    static var cartItemTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 28.0/255.0, green: 15.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        }
    }
    
    static var cartAddButtonTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
    
    static var cartCancelButtonTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 3.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigDividerColor: UIColor {
        get {
            return UIColor(displayP3Red: 3.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigAddToCartColor: UIColor {
        get {
            return UIColor(displayP3Red: 3.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigCancelAddToCartColor: UIColor {
        get {
            return UIColor(displayP3Red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0)
        }
    }
    
    static var productConfigTopBgGradColor: UIColor {
        get {
            return UIColor(displayP3Red: 46.0/255.0, green: 25.0/255.0, blue: 18.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigBottomBgGradColor: UIColor {
        get {
            return UIColor(displayP3Red: 28.0/255.0, green: 15.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigTableSeparatorColor: UIColor {
        get {
            return UIColor(displayP3Red: 151.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        }
    }
    
    static var productConfigSliderMaxTrackColor: UIColor {
        get {
            return UIColor(displayP3Red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        }
    }
    
    static var appMainControlColor: UIColor {
        get {
            return UIColor(displayP3Red: 3.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
    }
    
    static var appMainControlTextColor: UIColor {
        get {
            return UIColor(displayP3Red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
    
    static var appDestructiveControlColor: UIColor {
        get {
            return UIColor(displayP3Red: 3.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
    }
    
    // Fonts
    
    static func appBoldFont(_ size:CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-DemiBold", size: size)
    }
    
    static var appBoldFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 12.0)
        }
    }
    
    static var menuTextFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 12.0)
        }
    }
    
    static var tabBarFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 11.0)
        }
    }
    
    static var cartButtonFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 12.0)
        }
    }
    
    static var cartItemNameFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 13.0)
        }
    }
    
    static var cartItemDescriptionFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-Medium", size: 13.0)
        }
    }
    
    static var productConfigButtonFont: UIFont? {
        get {
            return UIFont(name: "DrukText-Medium", size: 16.0)
        }
    }
    
    static var productConfigItemNameFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 18.0)
        }
    }
    
    static var productConfigItemPriceFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-Medium", size: 14.0)
        }
    }
    
    static var productConfigItemDescriptionFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-Medium", size: 12.0)
        }
    }
    
    static var productConfigItemCellFont: UIFont? {
        get {
            return UIFont(name: "AvenirNext-DemiBold", size: 14.0)
        }
    }
}
