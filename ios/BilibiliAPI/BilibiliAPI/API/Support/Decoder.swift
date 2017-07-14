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
        let decoder = JSONDecoder()
        if let data = json.data(using: .utf8) {
            return try decoder.decode(type, from: data)
        }
        throw DecodingError.typeMismatch(type, .init(codingPath: [],
                                                     debugDescription: "Invalid JSON."))
    }
    
}

extension Decodable
{
    static func object(from json: String) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: json)
    }
    
    static func object(from dict: [AnyHashable:Any]) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: dict.json)
    }
    
    static func array(from json: String) throws -> [Self] {
        let decoder = JSONDecoder()
        return try decoder.decode([Self].self, from: json)
    }
    
    static func array(from dict: [AnyHashable:Any]) throws -> [Self] {
        let decoder = JSONDecoder()
        return try decoder.decode([Self].self, from: dict.json)
    }
    
}
