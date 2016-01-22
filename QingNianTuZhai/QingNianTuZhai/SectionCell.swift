//
//  SectionCell.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/14.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import UIKit
import Kingfisher

class SectionCell: UITableViewCell {
    
    @IBOutlet weak var iconIV: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var introLabel: UILabel!
    
    
    var model:SectionModel? {
    
        didSet{
            
            iconIV.setImageWithURLString((model?.icon)!, placeholderImage: UIImage(named: "loading"))
            nameLabel.text = model?.name!
            introLabel.text = model?.description!
            
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
