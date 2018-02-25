//
//  UIImageView+Extension.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 20/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url : URL?, placeholder: UIImage? = UIImage(named: "placeholder"), animated: Bool = true) {
//        kf.indicatorType = .activity
        guard let imageURL = url else { return }
        
        // 处理默认值读不到本地图片问题
        let placeholderImg = placeholder ?? UIImage(named: "placeholder")
        
        if animated {
            kf.setImage(with: imageURL, placeholder: placeholderImg, options: [.backgroundDecode, .transition(.fade(1))])
        } else {
            kf.setImage(with: imageURL, placeholder: placeholderImg)
        }
    }
    
    func setImage(urlString URLString: String?, placeholder: UIImage? = nil, animated: Bool = true) {
        guard let urlString = URLString, let URL = URL(string: urlString) else {
            log.error("URL wrong ", URLString ?? "")
            return
        }
        setImage(url: URL, placeholder: placeholder, animated: animated)
    }
}
