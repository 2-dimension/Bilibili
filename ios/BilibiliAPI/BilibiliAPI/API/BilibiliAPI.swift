//
//  BilibiliAPI.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/14.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

open class BilibiliAPI { }

public extension BilibiliAPI {
    typealias Parameters = [String:Any]
    typealias Callback<T> = ((_ response: BilibiliResponse<T>) -> Void)?
}
