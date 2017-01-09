//
//  MYColor
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func myBlue() -> UIColor {
        return UIColor.init(netHex: 0x01509D)
    }
    class func myRed() -> UIColor {
        return UIColor.init(netHex: 0xC01319)
    }
    class func myGreen() -> UIColor {
        return UIColor.init(netHex: 0x2E6447)
    }
    class func myOrange() -> UIColor {
        return UIColor.init(netHex: 0xECA44E)
    }

    convenience init(r: Int, g: Int, b: Int) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(r:(netHex >> 16) & 0xff, g:(netHex >> 8) & 0xff, b:netHex & 0xff)
    }
}
