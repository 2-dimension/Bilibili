//
//  BilibiliURL.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

struct BilibiliURL
{
    static let BASE = "https://www.bilibili.com"
    static let BASE_APP = "https://app.bilibili.com"
    static let BASE_API = "https://api.bilibili.com"
    static let BASE_BANGUMI = "https://bangumi.bilibili.com"
    static let BASE_LIVE = "https://live.bilibili.com"
    static let BASE_PASSPORT = "https://passport.bilibili.com"
    static let BASE_COMMENT = "https://comment.bilibili.com"
    static let BASE_INTERFACE = "https://interface.bilibili.com"
    
    static let VIDEO_INFO = BASE_APP + "/x/v2/view"
    static let VIDEO_PLAY_URL = BASE_INTERFACE + "/playurl"
    static let VIDEO_COMMENTS = BASE_API + "/x/reply"
    
    static let BANGUMI_INFO = BASE_BANGUMI + "/api/season_v5"
    static let BANGUMI_REC  = BASE_BANGUMI + "/api/season/recommend/rnd/" // + [SID].json
    
    static let LIVE_PLAY_URL = BASE_LIVE + "/api/playurl"
}
