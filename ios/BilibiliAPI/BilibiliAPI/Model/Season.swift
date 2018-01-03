//
//  Season.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/12.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Season: Codable
{
    public var id: Int
    
    public var cover: String
    public var isFinish: String
    public var newestEpisodeID: Int
    public var newestEpisodeIndex: Int
    public var title: String
    public var totalCount: String
    public var userSeason: UserSeason?
    public var weekday: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = Int(try values.decode(String.self, forKey: .id)) ?? 0
        cover = try values.decode(String.self, forKey: .cover)
        isFinish = try values.decode(String.self, forKey: .isFinish)
        newestEpisodeID = Int(try values.decode(String.self, forKey: .newestEpisodeID)) ?? 0
        newestEpisodeIndex = Int(try values.decode(String.self, forKey: .newestEpisodeIndex)) ?? 0
        title = try values.decode(String.self, forKey: .title)
        totalCount = try values.decode(String.self, forKey: .totalCount)
        userSeason = try? values.decode(UserSeason.self, forKey: .userSeason)
        weekday = try? values.decode(String.self, forKey: .weekday)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "season_id"
        case cover
        case isFinish = "is_finish"
        case newestEpisodeID = "newest_ep_id"
        case newestEpisodeIndex = "newest_ep_index"
        case title
        case totalCount = "total_count"
        case userSeason = "user_season"
        case weekday
    }
    
    public struct UserSeason: Codable {
        public var attention: String
    }
    
}
