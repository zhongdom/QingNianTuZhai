//
//  CustomTabbarController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    //tabBarItem的title的文字大小
    let tabBarItemFontSize:CGFloat = 11.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBarBackgroundColor()
        
        setupAllChildController()
        
        //默认选中为0
        selectedIndex = 0
        
        
    }
    
    func configTabBarBackgroundColor() {
        
        //设置tabbar背景颜色
        let bgViwe = UIView(frame: tabBar.bounds)
        bgViwe.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.5)
        tabBar.insertSubview(bgViwe, atIndex: 0)
        tabBar.opaque = true
        
        tabBar.alpha = 0.9
        
    }
    
    func setupAllChildController() {
        
        let storyBoard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc1 = storyBoard.instantiateInitialViewController()
        addChildViewController(vc1!, title: "首页", image: "tabbar_icon_home_normal", selectedImage: "tabbar_icon_home_press")
        
        let storyBoard2 = UIStoryboard(name: "Section", bundle: nil)
        let vc2 = storyBoard2.instantiateInitialViewController()
        addChildViewController(vc2!, title: "栏目", image: "tabbar_icon_category_normal", selectedImage: "tabbar_icon_category_press")
        
        let storyBoard3 = UIStoryboard(name: "Discover", bundle: nil)
        let vc3 = storyBoard3.instantiateInitialViewController()
        addChildViewController(vc3!, title: "发现", image: "tabbar_icon_explore_normal", selectedImage: "tabbar_icon_explore_press")
        
        let storyBoard4 = UIStoryboard(name: "Profile", bundle: nil)
        let vc4 = storyBoard4.instantiateInitialViewController()
        addChildViewController(vc4!, title: "我", image: "tabbar_icon_me_normal", selectedImage: "tabbar_icon_me_press")
        
        
    }
    
    func addChildViewController(childController: UIViewController,title:String,image:String,selectedImage:String) {
        
        childController.title = title
        
        
        //注意去除系统对图片的渲染，同时在此处设置tabbarItem的title的颜色和大小！！！！
        childController.tabBarItem.image = UIImage(named: image)?.tint(UIColor(r: 146, g: 146, b: 146), blendMode: .DestinationIn)
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(r: 146, g: 146, b: 146),NSFontAttributeName:UIFont.systemFontOfSize(tabBarItemFontSize)], forState: .Normal)
        
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)!.imageWithRenderingMode(.AlwaysOriginal)
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor(r: 24, g: 176, b: 138),NSFontAttributeName:UIFont.systemFontOfSize(tabBarItemFontSize)], forState: .Selected)
        
        
        
        let nav = CustomNaviController(rootViewController: childController)
        
        addChildViewController(nav)
        
    }
    
}














