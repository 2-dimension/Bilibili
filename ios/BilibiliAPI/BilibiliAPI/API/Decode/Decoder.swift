//
//  Decoder.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension JSONDecoder
{
    open func decode<T>(_ type: T.Type, from json: String) throws -> T where T : Decodable {
        let data = Data()
        return try decode(type, from: data)
    }
}

extension Decodable
{
    
}
