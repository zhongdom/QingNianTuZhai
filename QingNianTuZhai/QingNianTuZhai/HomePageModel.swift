//
//  HomePageModel.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomePageModel {

    
    var ID:Int?
    var picture:String?
    var title:String?
    var creatDate:String?
    var sectionName:String?
    var readCount:Int?
    
    var showTime:String {
    
        guard creatDate != nil else{
            return ""
        }
    
        let fomatter = NSDateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = fomatter.dateFromString(creatDate!)
        fomatter.dateFormat = "MM-dd"
    
        return fomatter.stringFromDate(date!)
    }
    

    init(dictionary:Dictionary<String,JSON>) {
    
        ID = dictionary["id"]?.intValue
        picture = dictionary["main_img"]?.stringValue
        title = dictionary["title"]?.stringValue
        creatDate = dictionary["created_at"]?.stringValue
        sectionName = dictionary["category"]!["name"].stringValue
        readCount = dictionary["views_count"]?.intValue
    }
    
    
}
