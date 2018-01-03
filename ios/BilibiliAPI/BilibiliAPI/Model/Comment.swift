//
//  Comment.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

open class Comment: Codable
{
    public var floor: Int = 0  //楼层
    public var like: Int = 0   //赞
    public var count: Int = 0  //回复数
    public var rcount: Int = 0 //回复数
    public var ctime: Int = 0  //时间戳
    public var oid: Int = 0    //视频aid
    public var mid: Int = 0
    public var rpid: Int = 0
    public var state: Int = 0
    public var parent: Int = 0
    public var type: Int = 0
    public var action: Int = 0
    public var root: Int = 0
    public var rpid_str: String = ""
    public var parent_str: String = ""
    public var root_str: String = ""
    
    public var content: Content?
    public var member: Member?  //评论用户
    
    open class Content: Codable {
        public var platform: Int = 0
        public var message: String = ""
        public var device: String = ""
        
        private enum CodingKeys: String, CodingKey {
            case platform = "plat"
            case message
            case device
        }
    }
    
    public struct Member: Codable {
        public var avatar: String
        public var levelInfo: UserInfo.LevelInfo
        public var mid: String
        public var nameplate: UserInfo.Nameplate
        public var officialVerify: UserInfo.OfficialVerify
        public var pendant: UserInfo.Pendant
        public var rank: String
        public var regYear: String?
        public var sex: String
        public var sign: String
        public var uname: String
        public var vip: Vip
        
        private enum CodingKeys: String, CodingKey {
            case avatar
            case levelInfo = "level_info"
            case mid
            case nameplate
            case officialVerify = "official_verify"
            case pendant
            case rank
            case regYear = "reg_year"
            case sex
            case sign
            case uname
            case vip
        }
        
        public struct Vip: Codable {
            public var accessStatus: Int
            public var dueRemark: String
            public var vipDueDate: Int
            public var vipStatus: Int
            public var vipStatusWarn: String
            public var vipType: Int
            
            private enum CodingKeys: String, CodingKey {
                case accessStatus
                case dueRemark
                case vipDueDate
                case vipStatus
                case vipType
                case vipStatusWarn
            }
        }
    }
}

open class Comments: Codable
{
    public var page: Page?
    public var config: Config?
    public var upper: Upper?
    
    public var hots: [Comment] = []
    public var replies: [Comment] = []
    
    private enum CodingKeys: String, CodingKey {
        case page
        case config
        case upper
        case hots
        case replies
    }
    
    public struct Page: Codable {
        public var num: Int = 0
        public var acount: Int = 0
        public var count: Int = 0
        public var size: Int = 0
        
        private enum CodingKeys: String, CodingKey {
            case num
            case acount
            case count
            case size
        }
    }
    
    public struct Config: Codable {
        public var showAdmin: Int = 0
        public var showEntry: Int = 0
        
        private enum CodingKeys: String, CodingKey {
            case showAdmin = "showadmin"
            case showEntry = "showentry"
        }
    }
    
    public struct Upper: Codable {
        public var mid: Int?
        public var top: Int?
    }
}
