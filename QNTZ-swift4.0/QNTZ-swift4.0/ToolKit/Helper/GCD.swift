//
//  GCD.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 19/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import Foundation

public struct GCD {
    
    public static let mainQueue: DispatchQueue = {
        return .main
    }()
    
    public static let backgroundQueue: DispatchQueue = {
        return .global(qos: .background)
    }()
    
    public static func delay(_ delay: Double, block: @escaping () -> Void) {
        GCD.mainQueue.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: block
        )
    }
    
    public static func runOnMainThread(_ block: @escaping () -> Void) {
        GCD.mainQueue.async(execute: block)
    }
    
    public static func runOnBackgroundThread(_ block: @escaping () -> Void) {
        GCD.backgroundQueue.async(execute: block)
    }
    
    public static func synced(_ lock: AnyObject, closure: () -> Void) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform. or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
