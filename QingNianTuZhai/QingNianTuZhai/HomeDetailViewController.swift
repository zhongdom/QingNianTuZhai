//
//  HomeDetailViewController.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/14.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class HomeDetailViewController: UIViewController {
    
    var ID:Int?
    
    var webView = WKWebView()
    
    override func loadView() {
        
        view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.show("正在加载", toView: view)
        
        
        getData()
    
    }
    
    func getData() {
    
        let urlStr = "http://www.qingniantuzhai.com/api/posts/\(ID!)?comments=3"
        Alamofire.request(.GET, urlStr).responseJSON { (response) -> Void in
            
            switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let dict = json["post"].dictionaryValue
                    
                    if let htmlStr = self.genretateHtmlString(dict) {
                        
                        if let path = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "www"){
                        
                            let baseURL = NSURL(fileURLWithPath: path)
                            
                            self.webView.loadHTMLString(htmlStr, baseURL: baseURL)
                        }

                    }
                    
                }
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
            case .Failure(let error):
                print(error)
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
        
    }
    
    
    func genretateHtmlString(dictionary:[String:JSON])-> String? {
    
        let title = dictionary["title"]?.stringValue
        let name = dictionary["user"]?["name"].stringValue
        let time = dictionary["created_at"]?.stringValue
        let content = dictionary["content"]?.stringValue
        
        
        //拼接评论
        var commentsStr = ""
        if let commentPath = NSBundle.mainBundle().pathForResource("comment", ofType: "html", inDirectory: "www") {
        
            if let str = try? String(contentsOfFile:commentPath , encoding: NSUTF8StringEncoding) {
                
                let separaArr = str.componentsSeparatedByString("%@")
            
                if let commentArr = dictionary["comments"]?.arrayValue {
                    
                    for (i,dic) in commentArr.enumerate() {
                        
                        let tempDic = dic.dictionaryValue
                        let userDic = tempDic["user"]?.dictionaryValue
                        
                        var comment = "\(separaArr[0])\(userDic!["avatar_url"]!.stringValue)\(separaArr[1])\(userDic!["name"]!.stringValue)\(separaArr[2])\(tempDic["created_at"]!.stringValue)\(separaArr[3])\(tempDic["content"]!.stringValue)\(separaArr[4])"
                        comment = comment.stringByReplacingOccurrencesOfString("%d", withString: "\(userDic!["favo_count"]!.stringValue)", options: NSStringCompareOptions.LiteralSearch, range: nil)
                        
                        if i < commentArr.count - 1 {
                            comment += "<hr />"
                        }
                        
                        
                        commentsStr += comment
                        
                    }
                    
                }
                
            }
            
        }
        
   
        if let path = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "www") {
        
            if let str = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) {
                
                let separaArr = str.componentsSeparatedByString("%@")
                
                let htmlStr = "\(separaArr[0])\(title!)\(separaArr[1])\(title!)\(separaArr[2])\(name!)\(separaArr[3])\(time!)\(separaArr[4])\(content!)\(separaArr[5])\(commentsStr)\(separaArr[6])"
                
                
                return htmlStr
                
            }
            
        }
        
        
        return nil
    }

}
