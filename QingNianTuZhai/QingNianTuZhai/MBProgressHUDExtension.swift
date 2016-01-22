//
//  MBProgressHUDExtension.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/13.
//  Copyright © 2016年 zhongdong. All rights reserved.
//

import MBProgressHUD

extension MBProgressHUD {
    
    class func showSuccess(message:String) {
        
        show(message, icon: "success.png")
    }
    
    class func showError(message:String) {
        
        show(message, icon: "error.png")
    }
    
    class func show(text:String ,icon:String ,var toView view:UIView? = nil) {
        
        if view == nil {
            view = UIApplication.sharedApplication().windows.last
        }
        
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.detailsLabelText = text
        hud.detailsLabelFont = UIFont.systemFontOfSize(15.0)
        hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/\(icon)"))
        hud.mode = .CustomView
        hud.removeFromSuperViewOnHide = true
        hud.hide(true, afterDelay: 1.5)
        
    }
    
    class func show(text:String,toView view:UIView) {
    
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.detailsLabelText = text
        hud.detailsLabelFont = UIFont.systemFontOfSize(15.0)
        hud.show(true)
    }
    
}
