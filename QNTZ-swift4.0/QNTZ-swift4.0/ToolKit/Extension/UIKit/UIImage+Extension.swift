//
//  UIImage+Extension.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 08/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {

    /// 重新渲染图片颜色
    ///
    /// - Parameters:
    ///   - color: 要渲染的颜色
    ///   - blendMode: 模式
    /// - Returns: 渲染后的图片
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage? {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        //let context = UIGraphicsGetCurrentContext()
        //CGContextClipToMask(context, drawRect, CGImage)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    
    /// 生成纯色图片（默认1*1）
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 尺寸，默认1*1
    /// - Returns: 图片
    class func imageWithColor(color:UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
