//
//  ArticleViewController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 19/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import Moya
import SKPhotoBrowser
import WCDBSwift

class ArticleViewController: BasicViewController {

    var articleId : Int?
    
    private lazy var webView: WKWebView = {
        
        let config = WKWebViewConfiguration()
        config.userContentController.add(WKWebViewLeakAvoider(delegate: self), name: "JSToNatvie")
        
        let view = WKWebView(frame: CGRect.zero, configuration: config)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.fetchData()
        
    }
    
    override func setupUI() {
        self.view.addSubviews(self.webView)
    }
    
    override func setupConstraints() {
        self.webView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func fetchData() {

        // 取数据库数据
        do {

            if let temp: ArticleModel = try DBHelper.share.database.getObject(fromTable: DBTableName.articleTable, where: ArticleModel.Properties.articleId == self.articleId!) {
                
                let json = JSON(temp.response)
                let dict = json["post"].dictionaryValue
                if let htmlStr = self.genretateHtmlString(dictionary: dict) {
                    if let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www"){
                        let baseURL = NSURL(fileURLWithPath: path)
                        self.webView.loadHTMLString(htmlStr, baseURL: baseURL as URL)
                    }
                }
                
                return
                
            }

            
        } catch {
            Logger.error(error)
            HUD.showError(error)
        }

       
        HUD.showLoding()
        
        // 联网获取数据
        APIManage.share.provider.request(.homeDetail(id: self.articleId!)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let response = try moyaResponse.filterSuccessfulStatusCodes()
                    
                    // 缓存本地
                    let articleModel = ArticleModel(articleId: self.articleId!, response: response.data)
                    try DBHelper.share.database.insert(objects: articleModel, intoTable: DBTableName.articleTable)
                    
                    let json = JSON(response.data)
                    let dict = json["post"].dictionaryValue
                    if let htmlStr = self.genretateHtmlString(dictionary: dict) {
                        if let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www"){
                            let baseURL = NSURL(fileURLWithPath: path)
                            self.webView.loadHTMLString(htmlStr, baseURL: baseURL as URL)
                        }
                    }
                    
                    HUD.dismissLoding()
                } catch {
                    Logger.error(error)
                    HUD.dismissLoding()
                    HUD.showError(error)
                }
                
            // do something with the response data or statusCode
            case let .failure(error):
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
                Logger.error(error)
                HUD.dismissLoding()
                HUD.showError(error)
            }
        }
        
//        let urlStr = "http://www.qingniantuzhai.com/api/posts/\(self.articleId!)?comments=20"
//        Alamofire.request(urlStr).responseJSON { (response) -> Void in
//
//            switch response.result {
//            case .success:
//
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    let dict = json["post"].dictionaryValue
//                    if let htmlStr = self.genretateHtmlString(dictionary: dict) {
//                        if let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www"){
//                            let baseURL = NSURL(fileURLWithPath: path)
//                            self.webView.loadHTMLString(htmlStr, baseURL: baseURL as URL)
//                        }
//                    }
//                }
//
//                HUD.dismissLoding()
//
//            case .failure(let error):
//                HUD.dismissLoding()
//                HUD.showError(error)
//            }
//        }
//
    }
    func genretateHtmlString(dictionary:[String:JSON])-> String? {
        
        let title = dictionary["title"]?.stringValue
        let name = dictionary["user"]?["name"].stringValue
        let time = dictionary["created_at"]?.stringValue
        let content = dictionary["content"]?.stringValue
    
        //拼接评论
        var commentsStr = ""
        if let commentPath = Bundle.main.path(forResource: "comment", ofType: "html", inDirectory: "www") {
            if let str = try? String(contentsOfFile:commentPath , encoding: String.Encoding.utf8) {
                let separaArr =  str.components(separatedBy: "%@")
                if let commentArr = dictionary["comments"]?.arrayValue {
                    for (i,dic) in commentArr.enumerated() {
                        let tempDic = dic.dictionaryValue
                        let userDic = tempDic["user"]?.dictionaryValue
                        var comment = "\(separaArr[0])\(userDic!["avatar_url"]!.stringValue)\(separaArr[1])\(userDic!["name"]!.stringValue)\(separaArr[2])\(tempDic["created_at"]!.stringValue)\(separaArr[3])\(tempDic["content"]!.stringValue)\(separaArr[4])"
                        comment = comment.replacingOccurrences(of: "%d", with: "\(userDic!["favo_count"]!.stringValue)", options: NSString.CompareOptions.literal, range: nil)
                        if (i < commentArr.count - 1) {
                            comment += "<hr />"
                        }
                        commentsStr += comment
                    }
                }
            }
        }
        
        if let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www") {
            
            if let str = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
                
                let separaArr = str.components(separatedBy: "%@")
                
                let htmlStr = "\(separaArr[0])\(title!)\(separaArr[1])\(title!)\(separaArr[2])\(name!)\(separaArr[3])\(time!)\(separaArr[4])\(content!)\(separaArr[5])\(commentsStr)\(separaArr[6])"
                return htmlStr
            }
        }
        return nil
    }
    
    deinit {
        self.webView.configuration.userContentController.removeAllUserScripts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArticleViewController: WKScriptMessageHandler {
    
    // TODO: 实现点击浏览图片
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let imgUrl = message.body as? String, imgUrl.hasPrefix("http") {
//            Logger.info("点击了\(imgUrl)")
            let photo = SKPhoto.photoWithImageURL(imgUrl)
            let browser = SKPhotoBrowser(photos: [photo])
            self.present(browser, animated: true, completion: nil)
        }
    }
}

// MARK: 3D Touch 上滑按钮
extension ArticleViewController {
    
    // WARNING: peek视图时手指上滑，唤出peek视图快速选项，应该配置在 *被弹出* 的控制器中
    override var previewActionItems: [UIPreviewActionItem] {
        
        func previewActionWithTitle(title:String, style:UIPreviewActionStyle = .default) -> UIPreviewAction {
            return UIPreviewAction(title: title, style: style) { (previewAction, viewController) -> Void in
                NSLog("\(previewAction.title)")
            }
        }
        
        let a = previewActionWithTitle(title: "a")
        let b = previewActionWithTitle(title: "b", style: .destructive)
        let c = previewActionWithTitle(title: "c", style: .selected)
        let d_e_f = UIPreviewActionGroup(title: "d&e&f ...",
                                         style: .default,
                                         actions: [previewActionWithTitle(title: "d"),
                                                   previewActionWithTitle(title: "e"),
                                                   previewActionWithTitle(title: "f")])
        return [a,b,c,d_e_f]
    }
    
}



