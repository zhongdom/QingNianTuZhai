//
//  WKWebLeaksAvoider.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 25/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.

import WebKit

class WKWebViewLeakAvoider: NSObject, WKScriptMessageHandler {
    weak var delegate: WKScriptMessageHandler?
    
    init(delegate:WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(userContentController, didReceive: message)
    }
}
