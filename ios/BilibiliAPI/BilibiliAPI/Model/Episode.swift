//
//  Episode.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/12.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Episode: Codable
{
    public var aid: Int
    public var coins: Int
    public var cover: String
    public var danmaku: String
    public var episodeID: String
    public var episodeStatus: Int
    public var index: Int
    public var indexTitle: String
    public var isWebplay: String
    public var mid: Int
    public var page: String
    public var updateTime: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aid = Int(try values.decode(String.self, forKey: .aid)) ?? 0
        coins = Int(try values.decode(String.self, forKey: .coins)) ?? 0
        cover = try values.decode(String.self, forKey: .cover)
        danmaku = try values.decode(String.self, forKey: .danmaku)
        episodeID = try values.decode(String.self, forKey: .episodeID)
        episodeStatus = try values.decode(Int.self, forKey: .episodeStatus)
        index = Int(try values.decode(String.self, forKey: .index)) ?? 0
        indexTitle = try values.decode(String.self, forKey: .indexTitle)
        isWebplay = try values.decode(String.self, forKey: .isWebplay)
        mid = Int(try values.decode(String.self, forKey: .mid)) ?? 0
        page = try values.decode(String.self, forKey: .page)
        updateTime = try values.decode(String.self, forKey: .updateTime)
    }
    
    private enum CodingKeys: String, CodingKey {
        case aid = "av_id"
        case coins
        case cover
        case danmaku
        case episodeID = "episode_id"
        case episodeStatus = "episode_status"
        case index = "index"
        case indexTitle = "index_title"
        case isWebplay = "is_webplay"
        case mid
        case page
        case updateTime = "update_time"
    }
}
