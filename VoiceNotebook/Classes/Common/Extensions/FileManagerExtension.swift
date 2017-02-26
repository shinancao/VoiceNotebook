//
//  FileManagerExtension.swift
//  VoiceNotebook
//
//  Created by Shinancao on 2017/2/26.
//  Copyright © 2017年 ZhangNan. All rights reserved.
//

import Foundation

extension FileManager {
    public static var documentsDir: String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    public static var tempDir: String {
        return NSTemporaryDirectory()
    }
    
    public static var audioDir: String {
        return documentsDir + "/audio/"
    }
    
    public func clearDir(_ dirPath: String) {
        
        let fileArray:[AnyObject]? = subpaths(atPath: dirPath) as [AnyObject]?
        for fn in fileArray!{
            try! removeItem(atPath: dirPath + "/\(fn)")
        }
    }
    
    //return: true create success, false create failed
    public func createDir(_ dirPath: String) -> Bool {
        
        if !self.fileExists(atPath: dirPath) {
            do {
                try createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch {
                return false
            }
        } else {
            return true
        }
    }
    
}
