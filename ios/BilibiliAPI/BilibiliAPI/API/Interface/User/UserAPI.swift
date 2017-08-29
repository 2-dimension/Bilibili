//
//  BilibiliUserAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension BilibiliAPI
{
    public static func getUserInfo(uid: Int, success: Callback<UserInfo>, failure: Callback<UserInfo>) {
        var parameters = Parameters()
        parameters["aid"] = uid
        parameters["_"] = Int(Date().timeIntervalSince1970)
        BilibiliRequest.request(url: BilibiliURL.VIDEO_INFO, parameters: parameters, configs: [.sign, .keypath("data")], success: success, failure: failure)
    }
}
