//
//  CustomTabBarController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit

class CustomTableViewController: UITabBarController {
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return selectedViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
