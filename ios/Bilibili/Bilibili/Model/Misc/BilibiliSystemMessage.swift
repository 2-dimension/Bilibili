//
//  BilibiliSystemMessage.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/26.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import Foundation

class BilibiliSystemMessage
{
    var id: Int64 = 0
    var uid: Int = 0
    var timestamp: Double = 0
    
    var title: String?
    var contents: String?
    var custom: String?
    
    var type: BilibiliSystemMessageType = .store
    
    var ctrlType: Int = 0
    var ctrlParam: String?
    var ctrlText: String?
    
    var isReaded: Bool = false
}

struct BilibiliSystemMessageType : OptionSet {
    let rawValue: Int
    
    public static var store =  BilibiliSystemMessageType(rawValue: 1)
    public static var popover = BilibiliSystemMessageType(rawValue: 2)
    public static var notification = BilibiliSystemMessageType(rawValue: 4)
}
