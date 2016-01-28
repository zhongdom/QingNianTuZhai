//
//  SwiftExtension.swift
//  QingNianTuZhai
//
//  Created by zhongdong on 16/1/27.
//  Copyright © 2016年 zhongdong. All rights reserved.
//



func printLog<T>(message: T,
    file: String = __FILE__,
    method: String = __FUNCTION__,
    line: Int = __LINE__)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

