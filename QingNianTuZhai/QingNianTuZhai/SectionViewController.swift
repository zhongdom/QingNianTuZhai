//
//  SectionViewController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class SectionViewController: UITableViewController {
    
    var dataArr = [SectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        MBProgressHUD.show("正在加载", toView: view)
        getData()
    }
    
    func getData() {
        
        let urlStr = "http://www.qingniantuzhai.com/api/categories"
        Alamofire.request(.GET, urlStr).responseJSON { (response) -> Void in
            
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let arr = json["categories"].arrayValue
                    
                    for dict in arr {
                    
                        let model = SectionModel(dictionary: dict.dictionaryValue)
                        self.dataArr.append(model)
                    }
            
                    
                    self.tableView.reloadData()
                
                    
                }
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
            case .Failure(let error):
                print(error)
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sectionCell", forIndexPath: indexPath) as! SectionCell
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let model = dataArr[indexPath.row]
        let storyBoard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyBoard.instantiateInitialViewController() as! HomePageController
        vc.catagory = model.slug
        vc.titleStr = model.name
        navigationController?.pushViewController(vc, animated: true)
        
    }

}
