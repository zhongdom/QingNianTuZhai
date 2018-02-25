//
//  BasicTableViewCell.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 17/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    
    // MARK: Initializing
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // Override point
    }
    
    func setupConstraints() {
        // Override point
    }
}
