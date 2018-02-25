//
//  UIScrollView+Refresh.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 19/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
// 添加上下拉刷新

import Foundation
import UIKit
import PullToRefreshKit

extension UIScrollView {
    
    func addHeaderRefresh(handle: @escaping () -> Void) {
//        configRefreshHeader(with: DefaultRefreshHeader.header(), action: handle)
        let header = ElasticRefreshHeader()
        header.backgroundColor = AppTheme.share.bgColor
        configRefreshHeader(with: header, action: handle)
    }
    
    func addFooterRefresh(handle: @escaping () -> Void) {
        let footer = DefaultRefreshFooter.footer()
        footer.setText("上拉加载更多", mode: .pullToRefresh)
        footer.setText("点击加载更多", mode: .tapToRefresh)
        footer.setText("正在加载", mode: .refreshing)
        footer.setText("没有更多数据了", mode: .noMoreData)
        footer.setText("点击加载更多数据", mode: .scrollAndTapToRefresh)
        footer.backgroundColor = AppTheme.share.bgColor
        configRefreshFooter(with:footer, action: handle)
    }
    
    func beginHeaderRefresh() {
        switchRefreshHeader(to: HeaderRefresherState.refreshing)
        switchRefreshFooter(to: .normal)
    }
    
    func endHeaderRefresh() {
        switchRefreshHeader(to: HeaderRefresherState.normal(.none, 0))
        switchRefreshFooter(to: .normal)
    }
    
    func endFooterRefresh(showNoMore: Bool = false) {
        switchRefreshFooter(to: .normal)
        
        if showNoMore {
            switchRefreshFooter(to: .noMoreData)
        }
    }
    
    func endRefresh(showNoMore: Bool = false) {
        
        guard showNoMore else {
            switchRefreshHeader(to: HeaderRefresherState.normal(.none, 0))
            switchRefreshFooter(to: .normal)
            return
        }
        endFooterRefresh(showNoMore: showNoMore)
    }
    
}
