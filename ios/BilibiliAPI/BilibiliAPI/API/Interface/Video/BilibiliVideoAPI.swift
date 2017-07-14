//
//  BilibiliVideoAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/11.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension BilibiliAPI
{
    //[GET] http://app.bilibili.com/x/v2/view?actionKey=appkey&aid=12104863&appkey=4ebafd7c4951b366&build=4310&device=phone&mobi_app=iphone&platform=ios&ts=1499791930&sign=1b70fc6101dea6d7ec75a9d02c50a3e6
    public static func getVideoInfo(aid: Int, user: User? = nil, success: Callback<Video>, failure: Callback<Video>) {
        var parameters = Parameters()
        parameters["aid"] = aid
//        parameters["access_key"] = user?.key
        BilibiliRequest.request(url: BilibiliURL.VIDEO_INFO, parameters: parameters, sign: true, keyPath: "data", success: success, failure: failure)
    }
}
