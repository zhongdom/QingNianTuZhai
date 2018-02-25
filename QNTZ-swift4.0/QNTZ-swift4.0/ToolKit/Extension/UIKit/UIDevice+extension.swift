//
//  UIDevice+extension.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 08/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//  设备和系统常用值和判断

import Foundation
import UIKit
import Device

extension UIDevice {
    
    public func isX() -> Bool {
        #if DEBUG
            if (UIScreen.main.bounds.height == 812.0 || UIScreen.main.bounds.size.width == 812.0) {
                return true
            }
            return false
        #else
            switch Device.version() {
                case .iPhoneX:
                    return true
                default:
                return false
            }
        #endif
    }
}

struct Metric {
    static let navigationHeight: CGFloat = UIDevice.current.isX() ? (44 + 44): (20 + 44)
    static let statueBarHeight: CGFloat = UIDevice.current.isX() ? 44: 20
    static let tabbarHeight: CGFloat = UIDevice.current.isX() ? (49 + 34): 49
    
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
}
