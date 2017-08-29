//
//  BilibiliAuth.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import CommonCrypto

//let APP_KEY     = "84956560bc028eb7"
//let APP_SECRET  = "94aba54af9065f71de72f5508f1cd42e"

class BilibiliAuth
{
    static var APP_KEY     = "c1b107428d337928"
    static var APP_SECRET  = "ea85624dfcf12d7cc7b2b3a94fac1f2c"
    
    static func generateSign(_ parameters: [String:Any]) -> String {
        
        let sortedKeys = parameters.keys.sorted(by: <)
        
        var keyValues: [String] = []
        for key in sortedKeys {
            if let value = parameters[key] {
                let str = "\(key)=\(value)"
                keyValues.append(str)
            }
        }
        
        let plain = keyValues.joined(separator: "&")
        let crypto = (plain + APP_SECRET).md5()
        
        return crypto
    }
}
