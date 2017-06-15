//
//  GgmColor.swift
//  ImobileSdkAdsAdapterMoPubSample
//
//  Created by Akira Ohnishi on 2017/06/15.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import Foundation

class GgmColor {
    /// hex: format should be `#[0-9a-fA-F]{6}`
    class func parse(_ hex: String) -> UIColor? {
        if hex.characters.count != 7 {
            return nil
        }

        if !hex.hasPrefix("#") {
            return nil
        }

        return colorWithHexString(hex)
    }

    fileprivate class func colorWithHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexString))

        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    class func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0

        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)

        return hexInt
    }
}
