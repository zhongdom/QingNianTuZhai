//
//  CustomTabBarController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit

class CustomTableViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setAppearance()
        setupTabBar()
        clickBackTop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

}

extension CustomTableViewController {
    
    private func setAppearance() {
        
        // 设置背景颜色
        let bgImage = UIImage.imageWithColor(color: AppTheme.share.tabbarBgColor, size: CGSize(width: Metric.screenWidth, height: Metric.tabbarHeight))
        self.tabBar.backgroundImage = bgImage
        
        // 是否开启半透明
        self.tabBar.isTranslucent = AppTheme.share.tabbarTranslucent
        
        // 设置文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : AppTheme.share.tabbarTextNormal], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : AppTheme.share.tabbarTextSelected], for: .selected)

        // 设置分割线颜色
//        let seperatetImage = UIImage.imageWithColor(color: AppearanceConfig.share.tabbarTopSpetator, size: CGSize(width: Metric.screenWidth, height: 1))
//        self.tabBar.shadowImage = seperatetImage
    }
    
    private func setupTabBar() {
        
        addChildViewController(childController: HomeViewController(),
                               title: "首页",
                               normalImage: #imageLiteral(resourceName: "tabbar_icon_home_normal"),
                               selectedImageName: #imageLiteral(resourceName: "tabbar_icon_home_press"))

        addChildViewController(childController: ViewController(),
                               title: "节点",
                               normalImage: #imageLiteral(resourceName: "tabbar_icon_home_normal"),
                               selectedImageName: #imageLiteral(resourceName: "tabbar_icon_home_press"))

        addChildViewController(childController: BasicViewController(),
                               title: "消息",
                               normalImage: #imageLiteral(resourceName: "tabbar_icon_home_normal"),
                               selectedImageName: #imageLiteral(resourceName: "tabbar_icon_home_press"))

        addChildViewController(childController: BasicViewController(),
                               title: "更多",
                               normalImage: #imageLiteral(resourceName: "tabbar_icon_home_normal"),
                               selectedImageName: #imageLiteral(resourceName: "tabbar_icon_home_press"))
    }
    
    private func addChildViewController(childController: UIViewController, title: String, normalImage: UIImage?, selectedImageName: UIImage?) {
        childController.tabBarItem.image = normalImage?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = selectedImageName?.withRenderingMode(.alwaysOriginal)
        childController.title = title
        let nav = CustomNavigationController(rootViewController: childController)
        nav.navigationBar.isTranslucent = false
        addChildViewController(nav)
    }
    
    private func clickBackTop() {
//        self.rx.didSelect
//            .scan((nil, nil)) { state, viewController in
//                return (state.1, viewController)
//            }
//            // 如果第一次选择视图控制器或再次选择相同的视图控制器
//            .filter { state in state.0 == nil || state.0 === state.1 }
//            .map { state in state.1 }
//            .filterNil()
//            .subscribe(onNext: { [weak self] viewController in
//                self?.scrollToTop(viewController)
//            })
//            .disposed(by: rx.disposeBag)
    }
    
    private func scrollToTop(_ viewController: UIViewController) {
//        if viewController.isKind(of: HomeViewController.self) {
//            NotificationCenter.default.post(.init(name: Notification.Name.V2.DidSelectedHomeTabbarItemName))
//            return
//        }
//        if let navigationController = viewController as? UINavigationController {
//            let topViewController = navigationController.topViewController
//            let firstViewController = navigationController.viewControllers.first
//            if let viewController = topViewController, topViewController === firstViewController {
//                self.scrollToTop(viewController)
//            }
//            return
//        }
//        guard let scrollView = viewController.view.subviews.first as? UIScrollView else { return }
//        scrollView.scrollToTop()
    }
    
}
