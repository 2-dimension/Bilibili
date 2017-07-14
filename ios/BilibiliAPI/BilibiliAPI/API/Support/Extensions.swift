//
//  Extensions.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/11.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import CommonCrypto

extension String
{
    func md5() -> String {
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Dictionary
{
    var json: String {
        let data = (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)) ?? Data()
        return String(data: data, encoding: .utf8)!
    }
    
    init?(json: String) {
        if let data = json.data(using: .utf8) {
            self.init(jsonData: data)
        } else { return nil }
    }
    
    init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let dict = jsonObject as? Dictionary {
            self = dict
        } else { return nil }
    }
}

extension Dictionary where Key == String
{
    /// If a dictionary contains dictionary, use this method to fetch value by key path.
    /// e.g. for dict { "aaa" : { "bbb" : "ccc" } } ,
    /// dict.value(forKeyPath: "aaa.bbb") == "ccc"
    ///
    /// - Parameter keyPath: Key path in dictionay.
    /// - Returns: Value for a certain key path.
    func value(forKeyPath keyPath: String?) -> Any? {
        if keyPath == nil { return self }
        
        let keys = keyPath!.components(separatedBy: ".")
        
        var dict: Dictionary<String, Any> = self
        for (index, key) in keys.enumerated() {
            let value = dict[key]
            if value != nil && index == keys.count - 1 {
                return value
            } else if value != nil && value is Dictionary<String, Any> {
                dict = value as! Dictionary<String, Any>
            } else { break }
        }
        
        return nil
    }
}

extension UIApplication {
    var version : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }
    var buildVersion : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String }
}
