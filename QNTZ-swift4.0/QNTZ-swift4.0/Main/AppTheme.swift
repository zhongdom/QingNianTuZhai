//
//  AppearanceConfig.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 08/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//  UI相关设置

import Foundation
import UIKit
import KVOController

// 定义主题模式
enum Theme :String {
    case day = "day"
    case night = "night"
}

class AppTheme: NSObject {
    
    public static let share: AppTheme = AppTheme()
    
    // 默认主题，应该从配置中读取，每次设置后也要同步配置状态
    // 每种颜色都根据theme来提供不用主题下的颜色值
    @objc dynamic var theme =  Theme.day.rawValue
    
    lazy var bgColor = UIColor.colorWith(r: 237, g: 238, b: 239)
    
    // 导航栏
    var naviBgColor: UIColor{
        switch Theme(rawValue: self.theme)! {
        case .night:
            return UIColor.randomColor()
        default:
            return UIColor.white
        }
    } //= UIColor.white
    lazy var naviTranslucent = true // 是否透明
    lazy var naviTitleColor = UIColor.hex(0x333333)
    lazy var naviTitleFontSize = 17.0
    
    // 状态栏颜色
    lazy var statusBarStyle = UIStatusBarStyle.default
    
    // tabbar颜色
    lazy var tabbarBgColor = UIColor.white
    lazy var tabbarTranslucent = true // 是否透明
    lazy var tabbarTextNormal = UIColor.hex(0x333333)
    lazy var tabbarTextSelected = UIColor.black
    lazy var tabbarTopSpetator = UIColor.gray
    
}

//MARK: - 给NSObject绑定一个属性(block)，主题更改时，自动执行此block
extension NSObject {
    private struct AssociatedKeys {
        static var thmemChanged = "themeChanged"
    }
    
    /// 当前主题更改时、第一次设置时 自动调用的闭包
    public typealias ThemeChangedClosure = @convention(block) (_ style:String) -> Void
    
    /// 自动调用的闭包
    /// 设置时，会设置一个KVO监听，当V2Style.style更改时、第一次赋值时 会自动调用这个闭包
    var themeChangedHandler:ThemeChangedClosure? {
        get {
            let closureObject: AnyObject? = objc_getAssociatedObject(self, &AssociatedKeys.thmemChanged) as AnyObject?
            guard closureObject != nil else{
                return nil
            }
            let closure = unsafeBitCast(closureObject, to: ThemeChangedClosure.self)
            return closure
        }
        set{
            guard let value = newValue else{
                return
            }
            let dealObject: AnyObject = unsafeBitCast(value, to: AnyObject.self)
            objc_setAssociatedObject(self, &AssociatedKeys.thmemChanged,dealObject,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            //设置KVO监听
            self.kvoController.observe(AppTheme.share, keyPath: "theme", options: [.new]){[weak self] (nav, color, change) -> Void in
                self?.themeChangedHandler?(AppTheme.share.theme)
            }
        }
    }
}

