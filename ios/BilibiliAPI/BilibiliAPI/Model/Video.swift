//
//  Video.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/12.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Video: Codable
{
    public var aid: Int
    public var attribute: Int
    public var copyright: Int
    public var ctime: Int
    public var desc: String
    public var duration: Int
    public var pic: String
    public var pubdate: Int
    public var redirectUrl: String
    public var state: Int
    public var tags: String?
    public var tid: Int
    public var videos: Int
    public var title: String
    public var tname: String
    
    public var owner: Owner
    public var season: Season
//    public var relates: Video
    public var rights: Rights
    public var stat: Stat
    
    public var pages: [Page]
    
    private enum CodingKeys: String, CodingKey {
        case aid
        case attribute
        case copyright
        case ctime
        case desc
        case duration
        case owner
        case pages
        case pic
        case pubdate
        case redirectUrl = "redirect_url"
//        case relates
        case rights
        case season
        case stat
        case state
        case tags
        case tid
        case title
        case tname
        case videos
    }
    
    public struct Stat: Codable {
        public var aid: Int
        public var coin: Int
        public var danmaku: Int
        public var favorite: Int
        public var hisRank: Int
        public var like: Int
        public var nowRank: Int
        public var reply: Int
        public var share: Int
        public var view: Int
        
        private enum CodingKeys: String, CodingKey {
            case aid
            case coin
            case danmaku
            case favorite
            case hisRank = "his_rank"
            case like
            case nowRank = "now_rank"
            case reply
            case share
            case view
        }
    }
    
    public struct Owner: Codable {
        public var face: String
        public var mid: Int
        public var name: String
    }
    
    public struct Page: Codable {
        public var cid: Int
        public var duration: Int
        public var from: String
        public var page: Int
        public var part: String
        public var vid: String
        public var weblink: String
        public var metas: [Meta]
        
        public struct Meta: Codable {
            public var size: Int64
            public var quality: Int
            public var format: String
        }
    }
    
    public struct Rights: Codable {
        public var bp: Int
        public var download: Int
        public var elec: Int
        public var hd5: Int
        public var movie: Int
        public var noReprint: Int
        public var pay: Int
        
        private enum CodingKeys: String, CodingKey {
            case bp
            case download
            case elec
            case hd5
            case movie
            case noReprint = "no_reprint"
            case pay
        }
    }
    
    public struct History: Codable {
        public var cid: UInt64
        public var progress: Double
    }
}

extension Video
{
    public enum Quality: Int {
        case low = 1    //流畅
        case normal     //高清
        case high       //超清
        case HD         //1080HD
    }
}
