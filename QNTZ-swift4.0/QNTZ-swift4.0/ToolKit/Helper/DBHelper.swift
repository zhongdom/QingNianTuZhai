//
//  DBHelper.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 29/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import WCDBSwift

struct DBTableName {
    static let articleTable = "t_\(String(describing: ArticleModel.self))"
}


class DBHelper {
    
    public static var share = DBHelper()
    
    var database: Database!
    
    init(path: String? = nil) {
        
        let path = path ?? FileManager.caches.appendingPathComponent("/data/default.db")
        
        self.database = Database(withPath: path)

    }
    
    func createTables() {
        do {
            try self.database.create(table: DBTableName.articleTable, of: ArticleModel.self)
        } catch  {
            Logger.error(error)
        }
    }
}
