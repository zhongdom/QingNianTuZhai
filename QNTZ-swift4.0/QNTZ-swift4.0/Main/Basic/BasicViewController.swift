//
//  BasicViewController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 08/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
// 项目所有VC需为此VC子类

import UIKit

class BasicViewController: UIViewController {
    
    private(set) var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 统一设置背景颜色
        self.view.backgroundColor = AppTheme.share.bgColor
        
        setupUI()
        
        view.setNeedsUpdateConstraints()

    }
    
    // 子类需重新此方法设置UI和添加子view
    func setupUI() {
        // Override point
    }
    
    // 子类需重写此方法设置子类约束
    func setupConstraints() {
        // Override point
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            setupConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    deinit {
        Logger.info("控制器\( self.className)已销毁")
    }
    
    // 设置导航栏默认颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return AppTheme.share.statusBarStyle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
