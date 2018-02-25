//
//  HomeTableViewController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 17/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: BasicViewController {
    
    private var dataArr = [HomeModel]()
    private var isLoadNewData = true
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self;
        
        // ios 11之前必须设置,才能自动计算行高
        view.estimatedRowHeight = 80
        view.rowHeight = UITableViewAutomaticDimension
        
        // ios 11之后必须设置，同时实现代理方法才能正常显示 header 和 footer
        view.estimatedSectionHeaderHeight = 0;
        view.estimatedSectionFooterHeight = 0;
        
        view.register(cellWithClass: HomeTableViewCell.self)
        view.register(headerFooterViewClassWith: UITableViewHeaderFooterView.self)
        
        view.separatorStyle = .none
        
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        HUD.showLoding()
        self.fetchData()
        
        self.themeChangedHandler = {[weak self] theme -> Void in
            Logger.info("主题改变了\(theme)")
            self?.navigationController?.navigationBar.barTintColor = AppTheme.share.naviBgColor
        }
        
        // 注册 peek 和 pop
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
    
    override func setupUI() {
        
        self.title = "首页"
        
        self.view.backgroundColor = AppTheme.share.bgColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "toggleTheme", style: .plain, target: self, action: #selector(toggleTheme))
        
        self.view.addSubview(self.tableView)
        
        self.tableView.addHeaderRefresh {
            self.isLoadNewData = true
            self.fetchData()
        }
        
        self.tableView.addFooterRefresh {
            self.fetchData()
        }
    }
    
    override func setupConstraints() {
        if #available(iOS 11, *) {
            self.tableView.snp.makeConstraints{
                $0.edges.equalTo(self.view.safeAreaLayoutGuide)
            }
        } else {
            self.tableView.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
        }
        
    }
    
    @objc func toggleTheme() {
        if AppTheme.share.theme.elementsEqual("night") {
            AppTheme.share.theme = Theme.day.rawValue
        } else {
            AppTheme.share.theme = Theme.night.rawValue
        }
        
    }

    func fetchData () {
        
        var id = 0
        var param = [String: Int]()
        
        if (self.isLoadNewData) {
            let first = self.dataArr.first
            id = first?.id ?? 0
            param = ["since_id": id]
        } else {
            let lastModel = self.dataArr.last
            id = lastModel?.id ?? 0
            param = ["max_id": id]
        }

        Logger.info("请求的param是： \(param)")
        
        APIManage.share.provider.request(.home(param:param)){result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let response = try moyaResponse.filterSuccessfulStatusCodes()
                    let json = JSON(response.data)
                    var newData : [HomeModel] = []
                    for item in json["posts"].arrayValue {
                        newData.append(HomeModel(fromJson: item))
                    }
                    
                    if (self.isLoadNewData) {
                        if (newData.count > 0) {
                            self.dataArr.insert(contentsOf: newData, at: 0)
                            self.tableView.reloadData()
                        } else {
                            HUD.showInfo("没有新的数据")
                        }
                        self.isLoadNewData = false
                        self.tableView.endHeaderRefresh()
                    } else {
                        if (newData.count > 0) {
                            self.dataArr.append(contentsOf: newData)
                            self.tableView.reloadData()
                            self.tableView.endFooterRefresh()
                        } else {
                            self.tableView.endFooterRefresh(showNoMore: true)
                            HUD.showInfo("没有更多数据了")
                        }
                    }
                    
                } catch {
                    self.tableView.endRefresh()
                    HUD.showError(error)
                }
                
            case let .failure(error):
                print(error)
                self.tableView.endRefresh();
                // 提示错误
                HUD.showError(error)
            }
            
            HUD.dismissLoding()
        }
        
//        Alamofire.request("http://www.qingniantuzhai.com/api/posts", parameters: param).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                var newData : [HomeModel] = []
//                for item in json["posts"].arrayValue {
//                    newData.append(HomeModel(fromJson: item))
//                }
//
//                if (self.isLoadNewData) {
//                    if (newData.count > 0) {
//                        self.dataArr.insert(contentsOf: newData, at: 0)
//                        self.tableView.reloadData()
//                    } else {
//                        HUD.showInfo("没有新的数据")
//                    }
//                    self.isLoadNewData = false
//                    self.tableView.endHeaderRefresh()
//                } else {
//                    if (newData.count > 0) {
//                        self.dataArr.append(contentsOf: newData)
//                        self.tableView.reloadData()
//                        self.tableView.endFooterRefresh()
//                    } else {
//                        self.tableView.endFooterRefresh(showNoMore: true)
//                        HUD.showInfo("没有更多数据了")
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//                self.tableView.endRefresh();
//                // 提示错误
//            }
//            HUD.dismissLoding()
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeTableViewCell.self, for: indexPath)
        cell.model = self.dataArr[indexPath.section]
        
        return cell
    }
    
    // TODO: 滑出屏幕取消下载
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //...
//        let myCell = cell as! HomeTableViewCell
//        myCell.imageView.kf.cancelDownloadTask()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        view?.contentView.backgroundColor = AppTheme.share.bgColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = self.dataArr[indexPath.section]
        let vc = ArticleViewController()
        vc.title = model.title
        vc.articleId = model.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
}

// MARK: 3D Touch
extension HomeViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let indexPath = tableView.indexPathForRow(at: location)
        let model = self.dataArr[(indexPath?.section)!]
        let vc = ArticleViewController()
        vc.title = model.title
        vc.articleId = model.id
        
        // 设置控制器内容和peek视图的大小,设置大小使用preferredContentSize 属性，如果为0的话则系统自动配置最佳大小
        vc.preferredContentSize =  .zero
        previewingContext.sourceRect = (self.tableView.cellForRow(at: indexPath!)?.frame)!

        return  vc //CustomNavigationController(rootViewController: vc)
    }
    
    // TODO: 解决无法返回的问题
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
//        showDetailViewController(viewControllerToCommit, sender: self)
    }
    
}



