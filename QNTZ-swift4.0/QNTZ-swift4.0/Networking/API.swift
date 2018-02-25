//
//  API.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 22/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import Foundation
import Moya
import Result

enum API {
    case home(param: [String: Int])
    case homeDetail(id: Int)
}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: "http://www.qingniantuzhai.com/api/posts")!
    }
    
    var path: String {
        switch self {
            case let .homeDetail(id):
                return "\(id)"
            default:
                return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
            default:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case let .home(param):
                return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            case .homeDetail(_):
                return .requestParameters(parameters: ["comments": 100], encoding: URLEncoding.queryString)
//            default:
//                return .requestPlain
        }
    }
    
    var sampleData: Data {
        return "This is sample data".data(using: .utf8)!
    }
    
    var headers: [String : String]? {
        return nil
    }
}

class APIManage {
    
    public static let share = APIManage()
    
    public var provider: MoyaProvider<API>
    
    init() {
        
        // 设置状态栏菊花状态
        let networkPlugin = NetworkActivityPlugin{ (change, target)  in
            switch change {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended :
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        self.provider = MoyaProvider<API>(plugins: [networkPlugin])
    }
}
