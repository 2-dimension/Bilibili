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
    let aid: Int
    let attribute: Int
    let copyright: Int
    let ctime: Int
    let desc: String
    let duration: Int
    let pic: String
    let pubdate: Int
    let redirectUrl: String
    let state: Int
    let tags: String?
    let tid: Int
    let videos: Int
    let title: String
    let tname: String
    
    let owner: Owner
    let season: Season
//    let relates: Video
    let rights: Rights
    let stat: Stat
    
    let pages: [Page]
    
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
        let aid: Int
        let coin: Int
        let danmaku: Int
        let favorite: Int
        let hisRank: Int
        let like: Int
        let nowRank: Int
        let reply: Int
        let share: Int
        let view: Int
        
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
        let face: String
        let mid: Int
        let name: String
    }
    
    public struct Page: Codable {
        let cid: Int
        let duration: Int
        let from: String
        let page: Int
        let part: String
        let vid: String
        let weblink: String
        let metas: [Meta]
        
        public struct Meta: Codable {
            let size: Int64
            let quality: Int
            let format: String
        }
    }
    
    public struct Rights: Codable {
        let bp: Int
        let download: Int
        let elec: Int
        let hd5: Int
        let movie: Int
        let noReprint: Int
        let pay: Int
        
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
        let cid: UInt64
        let progress: Double
    }
}
