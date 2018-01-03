//
//  BilibiliAppAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension BilibiliAPI
{
    public static func getBangumiFeedList(success: Callback<BangumiFeedList>, failure: Callback<BangumiFeedList>) {
        var parameters = Parameters()
        parameters["type"] = 1
        parameters["sort"] = 0
        BilibiliRequest.request(url: BilibiliURL.VIDEO_COMMENTS, parameters: parameters, configs: [.brief, .keypath("data")], success: success, failure: failure)
    }
}
