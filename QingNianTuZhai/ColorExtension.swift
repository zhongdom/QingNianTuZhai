//
//  ColorExtension.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(r:Int,g:Int,b:Int,a:Double){
        
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a))
    }
    
    convenience init(r:Int,g:Int,b:Int){
        
        self.init(r:r,g:g,b:b,a:1.0)
    }
    
    
    convenience init(rex:Int) {
        
        let r = CGFloat((rex & 0xFF0000) >> 16)
        let g = CGFloat((rex & 0xFF00) >> 8)
        let b = CGFloat(rex & 0xFF)
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        
    }
    
    //随机颜色
    class func randomColor()-> UIColor {
        
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
        
    }
    
    
    //主题颜色
    class func appColor()-> UIColor {
        
        return UIColor(r: 39, g: 140, b: 212)
        
    }
    
    
    
    
}
