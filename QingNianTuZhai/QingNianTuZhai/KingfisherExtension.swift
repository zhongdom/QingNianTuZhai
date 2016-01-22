//
//  KingFisher.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import Kingfisher

extension UIImageView {

    func setImageWithURLString(URLSting: String, placeholderImage:UIImage?) {
        
        kf_setImageWithURL(NSURL(string: URLSting)!, placeholderImage: placeholderImage)
    }
    
    func setImageWithURLString(URLSting: String) {
        
        kf_setImageWithURL(NSURL(string: URLSting)!)
    }
}
