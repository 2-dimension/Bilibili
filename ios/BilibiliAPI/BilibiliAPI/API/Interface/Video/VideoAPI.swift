//
//  BilibiliVideoAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/11.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Alamofire

extension BilibiliAPI
{
    
    /// Get video information with av ID.
    /// - GET: http://app.bilibili.com/x/v2/view?actionKey=appkey&aid=12104863&appkey=4ebafd7c4951b366&build=4310&device=phone&mobi_app=iphone&platform=ios&ts=1499791930&sign=1b70fc6101dea6d7ec75a9d02c50a3e6
    ///
    /// - Parameters:
    ///   - aid: Av ID.
    ///   - user: Pass this parameter if need info about user and this video.
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func getVideoInfo(aid: Int, userKey: String? = nil, success: Callback<Video>, failure: Callback<Video>) {
        var parameters = Parameters()
        parameters["aid"] = aid
        parameters["access_key"] = userKey
        BilibiliRequest.request(url: BilibiliURL.VIDEO_INFO, parameters: parameters, configs: [.sign, .keypath("data")], success: success, failure: failure)
    }
    
    /// Get play url info.
    /// - GET: http://interface.bilibili.com/playurl?appkey=xxx&cid=19965680&otype=json&quality=1&type=mp4&sign=xxx
    ///
    /// - Parameters:
    ///   - cid: Video cid (unique identifier for a video).
    ///   - quality: Video quality.
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func getPlayURL(cid: Int, quality: Video.Quality = .normal, success: Callback<PlayURL>, failure: Callback<PlayURL>) {
        var parameters = Parameters()
        parameters["cid"] = cid
        parameters["quality"] = quality.rawValue
        parameters["type"] = "mp4"
        parameters["otype"] = "json"
        BilibiliRequest.request(url: BilibiliURL.VIDEO_PLAY_URL, parameters: parameters, configs: [.sign, .brief], success: success, failure: failure)
    }
    
    /// Get danmakus in manmaku pool of a certain video.
    /// - https://comment.bilibili.com/10602259.xml
    ///
    /// - Parameters:
    ///   - cid: Video cid (unique identifier for a video).
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func getDanmakus(cid: Int, success:((String) -> Void)?, failure: (() -> Void)?) {
        let url = BilibiliURL.BASE_COMMENT + "/\(cid).xml"
        Alamofire.request(url, method: .get, parameters: nil).responseString { response in
            if let result = response.result.value { success?(result) }
            else { failure?() }
        }
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - aid: <#aid description#>
    ///   - page: <#page description#>
    ///   - pageSize: <#pageSize description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    public static func getComments(aid: Int, page: Int, pageSize: Int = 20, success: Callback<Comments>, failure: Callback<Comments>) {
        var parameters = Parameters()
        parameters["oid"] = aid
        parameters["pn"] = page
        parameters["ps"] = pageSize
        parameters["type"] = 1
        parameters["sort"] = 0
        BilibiliRequest.request(url: BilibiliURL.VIDEO_COMMENTS, parameters: parameters, configs: [.brief, .keypath("data")], success: success, failure: failure)
    }
    
}
