
//
//  HomePageController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import WebKit
import Kingfisher
import MBProgressHUD

class HomePageController: UITableViewController {
    
    var isFirstTimeLoadData = true
    
    var titleStr:String?
    
    var catagory:String?
    
    var dataArr = [HomePageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if titleStr != nil {
        
            navigationItem.title = titleStr!
        }else{
            
            navigationItem.titleView = UIImageView(image: UIImage(named: "title-logo"))
        }
        
        tableView.tableFooterView = UIView()
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "loadNewData")
        tableView.mj_header.beginRefreshing()
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(target: self, action: "removeCache", image: "Paint_Brush", highlightImage: "Paint_Brush")
        
    }
    
    //清理缓存
    @objc private func removeCache() {
        
        KingfisherManager.sharedManager.cache.clearDiskCache()
        
        //清理webview产生的缓存  只能在iOS9以上才能使用
        let websiteDataTypes: Set<String> = [
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeOfflineWebApplicationCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeLocalStorage,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeSessionStorage,
            WKWebsiteDataTypeIndexedDBDatabases,
            WKWebsiteDataTypeWebSQLDatabases
        ]
        
        let date = NSDate(timeIntervalSince1970: 0)
        
        WKWebsiteDataStore.defaultDataStore().removeDataOfTypes(websiteDataTypes, modifiedSince: date) { () -> Void in
            
            MBProgressHUD.showSuccess("清理成功")
            
        }
        
    }
    
    
    func loadNewData() {
        
        var since_id = 0
        
        if dataArr.count > 0 {
        
            let model = dataArr[0]
            since_id = model.ID!
            
        }
    
        var urlStr = ""
        
        if catagory != nil  {
            
            urlStr = "http://www.qingniantuzhai.com/api/posts?category=\(catagory!)&since_id=\(since_id)"
        }else{
            
            urlStr = "http://www.qingniantuzhai.com/api/posts?since_id=\(since_id)"
        }
        
        
        Alamofire.request(.GET, urlStr).responseJSON { [unowned self](response) -> Void in
            
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    let arr = json["posts"].arrayValue
                    
                    var tempArr = [HomePageModel]()
                    
                    if arr.count > 0{
                    
                        for item in arr {
                            
                            let dict = item.dictionaryValue
                            let model = HomePageModel(dictionary: dict)
                            tempArr.append(model)
                        }
                        
                        self.dataArr = tempArr + self.dataArr
                        
                        
                        self.tableView.reloadData()
                        
                        
                        if self.isFirstTimeLoadData {
                            
                            self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "loadMoreData")
                            self.isFirstTimeLoadData = false
                        }
                        
                    }else{
                        
                        if self.isFirstTimeLoadData{
                        
                            let label = UILabel()
                            label.textAlignment = .Center
                            label.text = "没有内容"
                            label.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 60)
                            self.view.insertSubview(label, aboveSubview: self.tableView)
                        
                        }
                        
                    }
                    
                    
                }
                
                self.tableView.mj_header.endRefreshing()
            case .Failure(let error):
                print(error)
                
                self.tableView.mj_header.endRefreshing()
            }
        }
    
        
    }
    
    
    func loadMoreData() {
        
        let model = dataArr.last!
        let since_id = model.ID!
        
        var urlStr = ""
        
        if catagory != nil  {
            
            urlStr = "http://www.qingniantuzhai.com/api/posts?category=\(catagory!)&max_id=\(since_id)"
        }else{
            
            urlStr = "http://www.qingniantuzhai.com/api/posts?max_id=\(since_id)"
        }
        
        
        
        Alamofire.request(.GET, urlStr).responseJSON { [unowned self](response) -> Void in
            
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    let arr = json["posts"].arrayValue
                    
                    var tempArr = [HomePageModel]()
                    
                    
                    if arr.count > 0 {
                    
                        for item in arr {
                            
                            let dict = item.dictionaryValue
                            let model = HomePageModel(dictionary: dict)
                            tempArr.append(model)
                        }
                        
                        self.dataArr = self.dataArr + tempArr
                        
                        
                        self.tableView.reloadData()
                    }else{
                        MBProgressHUD.showError("没有更多数据了")
                    }
                    
                    
                }
                
                self.tableView.mj_footer.endRefreshing()
            case .Failure(let error):
                print(error)
                
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HomePageCell", forIndexPath: indexPath) as! HomePageCell
        cell.model = dataArr[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = dataArr[indexPath.row]
        
        let vc = HomeDetailViewController()
        vc.ID = model.ID
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
