//
//  CustomNavigationController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import JZNavigationExtension

class CustomNaviController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置导航栏主题
        navigationBar.setBackgroundImage(UIImage(color: UIColor.appColor()), forBarPosition: .Any, barMetrics: .Default)
        navigationBar.shadowImage = UIImage()
       
        //这种方法设置会导致导航栏有一个像素的分割性，上面那种方法是没问题的
//        navigationBar.barTintColor = UIColor.appColor()
//        navigationBar.translucent = false
        
        
        //设置标题属性
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),
            NSFontAttributeName:UIFont.systemFontOfSize(CGFloat(17.0))]
        
        
        fullScreenInteractivePopGestureRecognizer = true;
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            /* 自动显示和隐藏tabbar */
            viewController.hidesBottomBarWhenPushed = true;
            
            /* 设置导航栏上面的内容 */
            // 设置左边的返回按钮
            //            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(target: self, action: "back", image: "navigationbar_back", highlightImage: "navigationbar_back_highlighted")
            
            // 设置右边的更多按钮
            //        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        }
        
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() {
        
        popViewControllerAnimated(true)
        
    }
    
    
    // MARK:设置StateBar颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }
    
}


// MARK:方便初始化UIBarButtonItem
extension UIBarButtonItem {
    
    convenience init(target:AnyObject? ,action:Selector ,image:String,highlightImage:String) {
        
        let btn = UIButton(type: .Custom)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.setBackgroundImage(UIImage(named:image)!, forState: .Normal)
        btn.setBackgroundImage(UIImage(named:highlightImage), forState: .Highlighted)
        btn.frame.size = (btn.currentBackgroundImage?.size)!
        
        self.init(customView:btn)
        
    }
    
}
