//
//  AppDelegate.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        self.window?.rootViewController = CustomTableViewController()
        self.window?.makeKeyAndVisible()
        
        AppSetup.prepare()
        
        self.registHomeScreenQuickActions()
        
        return true
    }
    
    // 收到内存警告，清理内存
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
        ImageCache.default.clearMemoryCache()
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// MARK: 3D Touch
extension AppDelegate {
    
    //动态注册Home Screen Quick Actions
    func registHomeScreenQuickActions(){
        if #available(iOS 9.1, *) {
            
            // UIApplicationShortcutItem 代表一个item
            // type： 唯一标示符的属性
            // localizedTitle: 显示的标题
            // localizedSubtitle: 显示的二级标题
            // icon：显示的图片，可以自定义，也可以使用系统提供的样式
            // userInfo: 包含一些信息
            
            // 自定义的icon
            //icon:UIApplicationShortcutIcon(templateImageName: "like")
            
            let item1 = UIApplicationShortcutItem(type: "com.mycompany.myapp.newmessage", localizedTitle: "title", localizedSubtitle: "subtitle", icon: UIApplicationShortcutIcon(type: .home), userInfo: nil)
            
            UIApplication.shared.shortcutItems = [item1];
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print(shortcutItem)
        if let userInfo = shortcutItem.userInfo {
            print(userInfo)
        }
    }
}

