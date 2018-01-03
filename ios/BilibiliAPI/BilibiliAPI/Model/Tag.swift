//
//  Tag.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/8/28.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct Tag: Codable
{
    public var id: Int
    public var name: String
    public var cover: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        cover = try values.decode(String.self, forKey: .cover)
        id = Int(try values.decode(String.self, forKey: .id)) ?? 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case cover
        case id = "tag_id"
        case name = "tag_name"
    }
}

