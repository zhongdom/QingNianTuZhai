//
//  AppSetup.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

struct AppSetup {
    static func prepare() {
        setupKeyboardManager()
        setupFPS()
        setupLog()
        HUD.configureAppearance()
        
        DBHelper.share.createTables()
    }
}

// MARK: - didFinishLaunchingWithOptions
extension AppSetup {
    
    /// 键盘自处理
    private static func setupKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 70
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
//        IQKeyboardManager.sharedManager().disabledDistanceHandlingClasses = [
//            CreateTopicViewController.self
//        ]
//        IQKeyboardManager.sharedManager().disabledToolbarClasses = [
//            TopicDetailViewController.self,
//            CreateTopicViewController.self
//        ]
//        IQKeyboardManager.sharedManager().disabledTouchResignedClasses = [
//            TopicDetailViewController.self
//        ]
    }
    
    private static func setupFPS() {
        #if DEBUG
            DispatchQueue.main.async {
                let label = FPSLabel(frame: CGRect(x: (AppDelegate.shared.window?.frame.size.width)! - 55 - 8, y: Metric.statueBarHeight, width: 55, height: 20))
                label.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                AppDelegate.shared.window?.addSubview(label)
            }
        #endif
    }
    
    private static func setupLog() {
        #if DEBUG
            Logger.logLevel = .debug
        #else
            Logger.logLevel = .warning
        #endif
    }
}
