//
//  CustomNavigationController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import JZNavigationExtension

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 方法1，设置导航栏背景颜色，导航栏不透明
//        navigationBar.setBackgroundImage(UIImage.imageWithColor(color: AppearanceConfig.share.naviBgColor), for: .default)
        // 方法2，设置导航栏颜色，默认有半透明效果
        navigationBar.barTintColor = AppTheme.share.naviBgColor
        
        // 是否开启半透明
        navigationBar.isTranslucent = AppTheme.share.naviTranslucent

        // 去除导航栏默认分割线
//        navigationBar.shadowImage = UIImage()
        
        //设置标题属性
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: AppTheme.share.naviTitleColor,
                                             NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(AppTheme.share.naviTitleFontSize))]
        
        self.jz_fullScreenInteractivePopGestureEnabled = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigationbar_back"), style: .plain, target: self, action: #selector(back))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func back() {
        self.popViewController(animated: true)
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

