//
//  HomeTableViewCell.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 17/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: BasicTableViewCell {

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
//        view.backgroundColor = UIColor.randomColor();
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.text = "title"
        view.numberOfLines = 0
//        view.backgroundColor = UIColor.randomColor()
        return view
    }()
    
    private lazy var subTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor.lightGray
        view.text = "subtitle"
        view.numberOfLines = 0
//        view.backgroundColor = UIColor.randomColor()
        return view
    }()
    
    var model: HomeModel? {
        didSet {
            guard let `model` = model  else {
                return
            }

            self.iconImageView.setImage(urlString: model.mainImg)
            self.title.text = model.title
            self.subTitle.text = "\(model.category.name ?? "类别")  ●  发布时间 \(model.createdAt.prefix(10))  ●  \(Int(model.viewsCount) ) 人阅读"
            
            self.layoutIfNeeded()
        }
    }
    
    override func setupUI() {
        self.addSubviews(iconImageView, title, subTitle)
    }
    
    override func setupConstraints() {
        self.iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.size.equalTo(CGSize(width: 80, height: 60))

            $0.top.greaterThanOrEqualToSuperview().offset(8).priority(.high)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-8).priority(.high)
        }
        
        self.title.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8);
            $0.leading.equalToSuperview().offset(80 + 8 + 8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        self.subTitle.snp.makeConstraints{
            $0.top.equalTo(self.title.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(self.title)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
    }

}
