//
//  BangumiAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/8/25.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension BilibiliAPI
{
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - sid: <#sid description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    public static func getBangumiInfo(sid: Int, success: Callback<Bangumi>, failure: Callback<Bangumi>) {
        var parameters = Parameters()
        parameters["season_id"] = sid
        parameters["type"] = "bangumi"
        BilibiliRequest.request(url: BilibiliURL.BANGUMI_INFO, parameters: parameters, configs: [.sign, .keypath("result")], success: success, failure: failure)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - sid: <#sid description#>
    ///   - success: <#success description#>
    ///   - failure: <#failure description#>
    public static func getBangumiRecommendation(sid: Int, success: Callback<[Bangumi]>, failure: Callback<[Bangumi]>) {
        var parameters = Parameters()
        parameters["season_id"] = sid
        BilibiliRequest.request(url: BilibiliURL.BANGUMI_REC + "\(sid).json", parameters: parameters, configs: [.keypath("result.list")], success: success, failure: failure)
    }
    
    
}
