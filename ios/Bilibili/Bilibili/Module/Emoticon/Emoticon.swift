//
//  Emoticon.swift
//  bukaios
//
//  Created by YaeSakura on 2017/4/24.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import Foundation

@objc enum EmoticonType: Int
{
    case Image = 0
    case Emoji = 1
}

class Emoticon: NSObject
{
    var chs: String = ""
    var cht: String = ""
    var png: String = ""
    var gif: String = ""
    var code: String = ""
    var type: EmoticonType = .Image
    
    weak var group: EmoticonGroup? = EmoticonGroup()
    
    var _type: Int = 1 {
        didSet{ type = _type == 0 ? .Image : .Emoji }
    }
    
    var path: String {
        if group == nil { return "" }
        return group!.path + "/" + png
    }
    
    static func modelCustomPropertyMapper() -> [String: Any] {
        return ["_type" : "type"]
    }
    
}

class EmoticonGroup: NSObject
{
    var id: String = ""
    var name: String = ""
    var type: Int = 0
    var version: Int = 0
    var displayOnly: Int = 0
    
    var path: String = ""
    
    var emoticons: [Emoticon] = []
    
    static func modelCustomPropertyMapper() -> [String: Any] {
        return ["type" : "group_type",
                "name" : "group_name_" + (Locale.current.regionCode ?? "en").lowercased(),
                "displayOnly" : "display_only"]
    }
    
    static func modelContainerPropertyGenericClass() -> [String: Any] {
        return ["emoticons" : Emoticon.self]
    }
}
