//
//  ProfileViewController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(target: self, action: "setting", image: "bar-setting", highlightImage: "bar-setting")
        
    }
    
    @objc private func setting() {
        print("设置")
    }
}
