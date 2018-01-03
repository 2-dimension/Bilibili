//
//  EmoticonManager.swift
//  bukaios
//
//  Created by YaeSakura on 2017/4/24.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//
//
//import Foundation
//import YYKit
//
//class EmoticonManager
//{
//    private static var _emoticonGroups : [EmoticonGroup]? = nil
//    private static var _emoticonDictionary : [String : Emoticon]? = nil
//
//    private static var bundlePath : String {
//        return Bundle.main.bundlePath + "/Emoticon.bundle"
//    }
//
//    static var emoticonGroups : [EmoticonGroup] {
//        if _emoticonGroups != nil { return _emoticonGroups! }
//
//        _emoticonGroups = [EmoticonGroup]()
//
//        guard let packages = NSDictionary(contentsOfFile: bundlePath + "/emoticons.plist")?["packages"] as? [[String : Any]] else {
//            return _emoticonGroups!
//        }
//
//        for package in packages {
//            let plistPath = bundlePath + "/" + (package["id"] as! String) + "/info.plist"
//            let emoticonInfo = NSDictionary(contentsOfFile: plistPath) as! [String : Any]
//            if let emoticonGroup = EmoticonGroup.model(with: emoticonInfo) {
//                emoticonGroup.path = bundlePath + "/" + (package["id"] as! String)
//                
//                for emoticon in emoticonGroup.emoticons {
//                    emoticon.group = emoticonGroup
//                }
//
//                _emoticonGroups!.append(emoticonGroup)
//            }
//        }
//
//        return _emoticonGroups!
//    }
//
//    static var emoticonDictionary: [String : Emoticon] {
//        if _emoticonDictionary != nil {
//            return _emoticonDictionary!
//        }
//
//        _emoticonDictionary = [String : Emoticon]()
//        for group in emoticonGroups {
//            for emoticon in group.emoticons {
//                if !emoticon.chs.isEmpty { _emoticonDictionary![emoticon.chs] = emoticon }
//                if !emoticon.cht.isEmpty { _emoticonDictionary![emoticon.cht] = emoticon }
//            }
//        }
//
//        return  _emoticonDictionary!
//    }
//}

