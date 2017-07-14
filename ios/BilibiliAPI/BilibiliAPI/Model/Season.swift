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
    let episodeStatus: Int
    let isJump: Int
    let isStarted: Int
    
    let sid: String
    let cover: String
    let evaluate: String
    let isFinish: String
    let newestEpisodeID: String
    let newestEpisodeIndex: String
    let title: String
    let totalCount: String
    let weekday: String
    
    let userSeason: UserSeason
    
    private enum CodingKeys: String, CodingKey {
        case cover
        case episodeStatus = "episode_status"
        case evaluate
        case isFinish = "is_finish"
        case isJump = "is_jump"
        case isStarted = "is_started"
        case newestEpisodeID = "newest_ep_id"
        case newestEpisodeIndex = "newest_ep_index"
        case sid = "season_id"
        case title
        case totalCount = "total_count"
        case userSeason = "user_season"
        case weekday
    }
    
    public struct UserSeason: Codable {
        let attention: String
    }
    
}
