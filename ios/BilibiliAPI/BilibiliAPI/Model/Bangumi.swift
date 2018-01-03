//
//  Bangumi.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Bangumi: Codable
{
    public var id: Int
    public var seasonID: Int
    public var title: String
    public var cover: String
    
    public var alias: String?
    public var allowBP: Bool?
    public var allowDownload: String?
    public var area: String?
    public var arealimit: Int?
    public var bangumiTitle: String?
    public var brief: String?
    public var businessType: Int?
    public var coins: String?
    public var copyright: String?
    public var danmakuCount: String?
    public var edJump: Int?
    public var episodes: [Episode]?
    public var evaluate: String?
    public var favorites: String?
    public var hasUnfollow: Int?
    public var isFinish: Bool?
    public var isGuideFollow: Int?
    public var jpTitle: String?
    public var limitInfo: LimitInfo?
    public var newestEpisodeID: Int?
    public var newestEpisodeIndex: Int?
    public var originName: String?
    public var playCount: String?
    public var pubTime: String?
    public var pubTimeShow: String?
    public var rank: Rank?
    public var relatedSeasons: [Bangumi]?
    public var rights: Right?
    public var seasonStatus: Int?
    public var seasonTitle: String?
    public var seasons: [Season]?
    public var shareURL: String?
    public var spid: String?
    public var squareCover: String?
    public var staff: String?
    public var tags: [Tag]?
    public var totalCount: String?
    public var userSeason: UserSeason?
    public var viewRank: Int?
    public var vipQuality: Int?
    public var watchingCount: String?
    public var weekday: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = Int(try values.decode(String.self, forKey: .id)) ?? 0
        title = try values.decode(String.self, forKey: .title)
        alias = try? values.decode(String.self, forKey: .alias)
        allowBP = (try? values.decode(String.self, forKey: .allowBP))?.bool ?? false
        allowDownload = try? values.decode(String.self, forKey: .allowDownload)
        area = try? values.decode(String.self, forKey: .area)
        arealimit = try? values.decode(Int.self, forKey: .arealimit)
        bangumiTitle = try? values.decode(String.self, forKey: .bangumiTitle)
        brief = try? values.decode(String.self, forKey: .brief)
        businessType = try? values.decode(Int.self, forKey: .businessType)
        coins = try? values.decode(String.self, forKey: .coins)
        copyright = try? values.decode(String.self, forKey: .copyright)
        cover = try values.decode(String.self, forKey: .cover)
        danmakuCount = try? values.decode(String.self, forKey: .danmakuCount)
        edJump = try? values.decode(Int.self, forKey: .edJump)
        episodes = try? values.decode([Episode].self, forKey: .episodes)
        evaluate = try? values.decode(String.self, forKey: .evaluate)
        favorites = try? values.decode(String.self, forKey: .favorites)
        hasUnfollow = try? values.decode(Int.self, forKey: .hasUnfollow)
        isFinish = (try? values.decode(String.self, forKey: .isFinish))?.bool ?? false
        isGuideFollow = try? values.decode(Int.self, forKey: .isGuideFollow)
        jpTitle = try? values.decode(String.self, forKey: .jpTitle)
        limitInfo = try? values.decode(LimitInfo.self, forKey: .limitInfo)
        newestEpisodeID = Int((try? values.decode(String.self, forKey: .newestEpisodeID)) ?? "0") ?? 0
        newestEpisodeIndex = Int((try? values.decode(String.self, forKey: .newestEpisodeIndex)) ?? "0") ?? 0
        originName = try? values.decode(String.self, forKey: .originName)
        playCount = try? values.decode(String.self, forKey: .playCount)
        pubTime = try? values.decode(String.self, forKey: .pubTime)
        pubTimeShow = try? values.decode(String.self, forKey: .pubTimeShow)
        rank = try? values.decode(Rank.self, forKey: .rank)
        relatedSeasons = try? values.decode([Bangumi].self, forKey: .relatedSeasons)
        rights = try? values.decode(Right.self, forKey: .rights)
        seasonID = Int(try values.decode(String.self, forKey: .seasonID)) ?? 0
        seasonStatus = try? values.decode(Int.self, forKey: .seasonStatus)
        seasonTitle = try? values.decode(String.self, forKey: .seasonTitle)
        seasons = try? values.decode([Season].self, forKey: .seasons)
        shareURL = try? values.decode(String.self, forKey: .shareURL)
        spid = try? values.decode(String.self, forKey: .spid)
        squareCover = try? values.decode(String.self, forKey: .squareCover)
        staff = try? values.decode(String.self, forKey: .staff)
        tags = try? values.decode([Tag].self, forKey: .tags)
        totalCount = try? values.decode(String.self, forKey: .totalCount)
        userSeason = try? values.decode(UserSeason.self, forKey: .userSeason)
        viewRank = try? values.decode(Int.self, forKey: .viewRank)
        vipQuality = try? values.decode(Int.self, forKey: .vipQuality)
        watchingCount = try? values.decode(String.self, forKey: .watchingCount)
        weekday = try? values.decode(String.self, forKey: .weekday)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "bangumi_id"
        case alias
        case allowBP = "allow_bp"
        case allowDownload = "allow_download"
        case area
        case arealimit
        case bangumiTitle = "bangumi_title"
        case brief
        case businessType = "business_type"
        case coins
        case copyright
        case cover
        case danmakuCount = "danmaku_count"
        case edJump = "ed_jump"
        case episodes
        case evaluate
        case favorites
        case hasUnfollow = "has_unfollow"
        case isFinish = "is_finish"
        case isGuideFollow = "is_guide_follow"
        case jpTitle = "jp_title"
        case limitInfo = "limit_info"
        case newestEpisodeID = "newest_ep_id"
        case newestEpisodeIndex = "newest_ep_index"
        case originName = "origin_name"
        case playCount = "play_count"
        case pubTime = "pub_time"
        case pubTimeShow = "pub_time_show"
        case rank
        case relatedSeasons = "related_seasons"
        case rights
        case seasonID = "season_id"
        case seasonStatus = "season_status"
        case seasonTitle = "season_title"
        case seasons
        case shareURL = "share_url"
        case spid
        case squareCover
        case staff
        case tags
        case title
        case totalCount = "total_count"
        case userSeason = "user_season"
        case viewRank
        case vipQuality = "vip_quality"
        case watchingCount
        case weekday
    }
    
    public struct Rank: Codable {
        public var list: [List]
        public var totalBpCount: Int
        public var weekBpCount: Int
        
        private enum CodingKeys: String, CodingKey {
            case list
            case totalBpCount = "total_bp_count"
            case weekBpCount = "week_bp_count"
        }
        
        public struct List: Codable {
            public var face: String
            public var uid: String
            public var uname: String
        }
    }
    
    public struct Right: Codable {
        public var arealimit: Int
        public var isStarted: Int
        
        private enum CodingKeys: String, CodingKey {
            case arealimit
            case isStarted = "is_started"
        }
    }
    
    public struct UserSeason: Codable {
        public var attention: String
        public var bp: Int
        public var lastEpisodeID: Int
        public var lastEpisodeIndex: Int
        public var lastTime: String
        public var payUser: PayUser?
        public var reportTimestamp: Int
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            attention = try values.decode(String.self, forKey: .attention)
            bp = try values.decode(Int.self, forKey: .bp)
            lastEpisodeID = Int((try? values.decode(String.self, forKey: .lastEpisodeID)) ?? "0") ?? 0
            lastEpisodeIndex = Int((try? values.decode(String.self, forKey: .lastEpisodeIndex)) ?? "0") ?? 0
            lastTime = try values.decode(String.self, forKey: .lastTime)
            payUser = try values.decode(PayUser.self, forKey: .payUser)
            reportTimestamp = try values.decode(Int.self, forKey: .reportTimestamp)
        }
        
        private enum CodingKeys: String, CodingKey {
            case attention
            case bp
            case lastEpisodeID = "last_ep_id"
            case lastEpisodeIndex = "last_ep_index"
            case lastTime = "last_time"
            case payUser = "pay_user"
            case reportTimestamp = "report_ts"
        }
        
        public struct PayUser: Codable {
            public var status: Int
        }
    }
    
    public struct LimitInfo: Codable {
        public var code: Int
        public var data: Dma
        public var message: String
        
        public struct Dma: Codable {
            public var down: Int
            public var play: Int
        }
    }
}
