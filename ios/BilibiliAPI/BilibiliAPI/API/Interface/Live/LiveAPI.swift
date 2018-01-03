//
//  BilibiliLiveAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/28.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension BilibiliAPI
{
    /// Get live play url info.
    /// - GET: http://live.bilibili.com/api/playurl?player=1&quality=0&cid=23058&otype=json
    ///
    /// - Parameters:
    ///   - cid: Live cid (unique identifier for a live room).
    ///   - quality: Video quality.
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func getLiveURL(cid: Int, quality: Video.Quality = .normal, success: Callback<LivePlayURL>, failure: Callback<LivePlayURL>) {
        var parameters = Parameters()
        parameters["cid"] = cid
        parameters["quality"] = quality.rawValue
        parameters["player"] = 1
        parameters["otype"] = "json"
        BilibiliRequest.request(url: BilibiliURL.LIVE_PLAY_URL, parameters: parameters, success: success, failure: failure)
    }
}
