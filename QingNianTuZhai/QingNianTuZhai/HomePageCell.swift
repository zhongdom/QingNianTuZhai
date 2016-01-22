//
//  HomePageCell.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import Kingfisher

class HomePageCell: UITableViewCell {

    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    var model:HomePageModel? {
        
        didSet{
            
            pictureImageView.setImageWithURLString((model?.picture)!, placeholderImage: UIImage(named: "loading"))
            
            title.text = model?.title
        
            author.text = "\(model!.sectionName!)  ●  \(model!.showTime)  ●  \(model!.readCount!)个人阅读"
        }
    }
    
    

}
