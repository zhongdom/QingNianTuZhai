//
//  ArticleModel.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 03/01/2018.
//  Copyright © 2018 zhongdong. All rights reserved.
//

import Foundation
import WCDBSwift

struct ArticleModel: TableCodable {
    
    var articleId: Int
    var response: Data
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = ArticleModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case articleId = "id"
        case response
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                articleId: ColumnConstraintBinding(isPrimary: true)
            ]
        }
    }
}

