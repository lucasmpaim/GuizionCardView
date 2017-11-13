//
//  ColorString.swift
//  guizion-card-view
//
//  Created by Lucas Paim on 13/11/2017.
//
//  https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values

import Foundation
import UIKit


extension UIColor {
    
    convenience init(hex: String) {
        // Trim leading '#' if needed
        var cleanedHexString = hex
        if hex.hasPrefix("#") {
            cleanedHexString = String(hex.dropFirst())
        }
        
        // String -> UInt32
        var rgbValue: UInt32 = 0
        Scanner(string: cleanedHexString).scanHexInt32(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
