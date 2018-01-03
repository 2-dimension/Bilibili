//
//  User.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/14.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct UserInfo: Codable
{
    public var id: String
    
    public var displayRank: String
    public var approve: Bool
    public var article: Int
    public var attention: Int
    public var attentions: [Int]
    public var birthday: String
    public var coins: Int
    public var description: String
    public var face: String
    public var fans: Int
    public var friend: Int
    public var im9Sign: String
    public var name: String
    public var place: String
    public var playNumber: Int
    public var rank: String
    public var regtime: Int
    public var sex: String
    public var sign: String
    public var spacesta: Int
    public var theme: String
    public var themePreview: String
    public var toutu: String
    public var toutuId: Int
    
    public var levelInfo: LevelInfo
    public var nameplate: Nameplate
    public var officialVerify: OfficialVerify
    public var pendant: Pendant
    
    private enum CodingKeys: String, CodingKey {
        case id = "mid"
        case displayRank = "DisplayRank"
        case approve
        case article
        case attention
        case attentions
        case birthday
        case coins
        case description
        case face
        case fans
        case friend
        case im9Sign = "im9_sign"
        case levelInfo = "level_info"
        case name
        case nameplate
        case officialVerify = "official_verify"
        case pendant
        case place
        case playNumber = "playNum"
        case rank
        case regtime
        case sex
        case sign
        case spacesta
        case theme
        case themePreview = "theme_preview"
        case toutu
        case toutuId
    }
    
    
    public struct LevelInfo: Codable {
        public var currentExp: Int
        public var currentLevel: Int
        public var currentMin: Int
        public var nextExp: Int?
        
        private enum CodingKeys: String, CodingKey {
            case currentExp = "current_exp"
            case currentLevel = "current_level"
            case currentMin = "current_min"
            case nextExp = "next_exp"
        }
    }
    
    public struct Nameplate: Codable {
        public var condition: String
        public var image: String
        public var imageSmall: String
        public var level: String
        public var name: String
        public var nid: Int
        
        private enum CodingKeys: String, CodingKey {
            case condition
            case image
            case imageSmall = "image_small"
            case level
            case name
            case nid
        }
    }
    
    public struct OfficialVerify: Codable {
        public var desc: String
        public var type: Int
        
        private enum CodingKeys: String, CodingKey {
            case desc
            case type
        }
    }
    
    public struct Pendant: Codable {
        public var expire: Int
        public var image: String
        public var name: String
        public var pid: Int
        
        private enum CodingKeys: String, CodingKey {
            case expire
            case image
            case name
            case pid
        }
    }
    
}

