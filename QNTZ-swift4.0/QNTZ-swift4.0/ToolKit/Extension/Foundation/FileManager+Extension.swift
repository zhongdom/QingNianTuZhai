//
//  FileManager+Extension.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 20/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import Foundation

extension FileManager {
    /// 存文件到沙盒
    ///
    /// - Parameters:
    ///   - data: 数据源
    ///   - savePath: 保存位置
    /// - Returns: 删除或者保存错误
    @discardableResult class func save(_ data: Data, savePath: String) -> Error? {
        if FileManager.default.fileExists(atPath: savePath) {
            do {
                try FileManager.default.removeItem(atPath: savePath)
            } catch let error {
                return error
            }
        }
        do {
            try data.write(to: URL(fileURLWithPath: savePath))
        } catch let error {
            return error
        }
        return nil
    }
    
    /// 在沙盒创建文件夹
    ///
    /// - Parameter path: 文件夹地址
    /// - Returns: 创建错误
    @discardableResult class func create(at path: String) -> Error? {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                return error
            }
        }
        return nil
    }
    
    /// 在沙盒中删除文件
    ///
    /// - Parameter path: 需要删除的文件地址
    /// - Returns: 删除错误
    @discardableResult
    class func delete(at path: String) -> Error? {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch let error {
                return error
            }
            return nil
        }
        return NSError(domain: "File does not exist", code: -1, userInfo: nil) as Error
    }
    
    class func rename(oldFileName: String, newFileName: String) -> Bool {
        do {
            try FileManager.default.moveItem(atPath: oldFileName, toPath: newFileName)
            return true
        } catch {
            return false
        }
    }
    
    class func copy(oldFileName: String, newFileName: String) -> Bool {
        do {
            try FileManager.default.copyItem(atPath: oldFileName, toPath: newFileName)
            return true
        } catch {
            return false
        }
    }
    
    class var document: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    class var library: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
    }
    
    class var temp: String {
        return NSTemporaryDirectory()
    }
    
    class var caches: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    }
}

extension FileManager {
    
    class func fileSizeOfCache() -> Int {
        // 取出文件夹下所有文件数组
        guard let fileArr = FileManager.default.subpaths(atPath: FileManager.caches) else { return 0 }
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr {
            // 把文件名拼接到路径中
            let path = FileManager.caches.appendingPathComponent(file)
            // 取出文件属性
            do {
                let floder = try FileManager.default.attributesOfItem(atPath: path)
                // 用元组取出文件大小属性
                for (abc, bcd) in floder {
                    // 累加文件大小
                    if abc == FileAttributeKey.size {
                        size += (bcd as AnyObject).integerValue
                    }
                }
            } catch {
                print(error)
            }
        }
        let mm = size / 1024 / 1024
        return mm
    }
    
    
    /// 清除cache文件夹所有内容
    class func clearCache(complete: @escaping ((Int) -> Void)) {
        GCD.runOnBackgroundThread {
            let size = fileSizeOfCache()
            
            // 取出文件夹下所有文件数组
            guard let fileArr = FileManager.default.subpaths(atPath: FileManager.caches) else { return }
            // 遍历删除
            for file in fileArr {
                let path = FileManager.caches.appendingPathComponent(file)
                if FileManager.default.fileExists(atPath: path) {
                    do {
                        try FileManager.default.removeItem(atPath: path)
                    } catch {
                        print(error)
                    }
                }
            }
            GCD.runOnMainThread {
                GCD.delay(0.2, block: {
                    complete(size)
                })
            }
        }
    }
    
}
