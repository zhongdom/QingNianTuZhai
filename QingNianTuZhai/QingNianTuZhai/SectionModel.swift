//
//  SectionModel.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/22.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import Foundation
import SwiftyJSON

class SectionModel {

//    "id":5,
//    "icon":"http://ww4.sinaimg.cn/large/005XDTNfgw1evcssfb6roj303k03ka9z.jpg",
//    "name":"你有我能睡",
//    "slug":"sleep",
//    "description":"翻译自国外各种恶搞睡着的爆笑图片~",
//    "post_counts":22
    
    var ID:Int?
    var icon:String?
    var name:String?
    var slug:String?
    var description:String?
    var post_counts:Int?
    
    init(dictionary:Dictionary<String,JSON>) {
        
        ID = dictionary["id"]?.intValue
        icon = dictionary["icon"]?.stringValue
        name = dictionary["name"]?.stringValue
        slug = dictionary["slug"]?.stringValue
        description = dictionary["description"]?.stringValue
        post_counts = dictionary["post_counts"]?.intValue
    }
    
    
    
    
}
