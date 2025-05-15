//
//  DataExtensions.swift
//  BLEHealth+
//
//  Created by Bluepixel.
//  Copyright © 2019 Bluepixel. All rights reserved.
//

import Foundation

public extension Data {
    
    func ToHexString() -> String {
        let dataLength = count
        var dataArray = [UInt8](repeating: 0, count: dataLength)
        copyBytes(to: &dataArray, count: dataLength)
        
        var result = ""
        for i in 0...dataArray.count-1 {
            result = result + String(format: "%02X", dataArray[i])
        }
        
        return result
    }
    
    func ToInt() -> Int {
        
        let dataLength = count
        var dataArray = [UInt8](repeating: 0, count: dataLength)
        copyBytes(to: &dataArray, count: dataLength)
        
        return dataArray.count > 0 ? Int(dataArray[0]) : 0
    }
    
    var bytes: Array<UInt8> {
        return Array(self)
    }
}

extension Collection where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
    var hexa: String {
        return map{ String(format: "%02X", $0) }.joined()
    }
}

