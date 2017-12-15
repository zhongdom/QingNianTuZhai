//
//  UIColor+Extension.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 08/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 快速构建rgb颜色
    ///
    /// - Parameters:
    ///   - r: r
    ///   - g: g
    ///   - b: b
    ///   - alpha: alpha
    /// - Returns: 返回rgb颜色对象，alpha默认1
    class func colorWith(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) -> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    /// 生成随机色
    ///
    /// - Returns: 返回随机色
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWith(r: r, g: g, b: b)
    }
    
    /// 16进制转UIColor
    ///
    /// - Parameters:
    ///   - hex: 16进制
    ///   - alpha: 不透明度
    /// - Returns: UIColor
    class func colorWith(hexString:String, alpha: CGFloat = 1) -> UIColor {
        var cString:String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    @nonobjc public static func hexa(_ value: UInt32) -> UIColor {
        let a = CGFloat((value & 0xFF000000) >> 24) / 255.0
        let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((value & 0xFF00) >> 8) / 255.0
        let b = CGFloat((value & 0xFF)) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    @nonobjc public static func hex(_ value: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((value & 0xFF00) >> 8) / 255.0
        let b = CGFloat((value & 0xFF)) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    public var hexString: String {
        guard let components = self.cgColor.components else { return "000000" }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
}
