//
//  User.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/14.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

class User
{
    
}


struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case points = "product_cost"
        case description
    }
}
