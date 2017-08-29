//
//  PlayURL.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/7/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public struct PlayURL: Codable
{
    public var from: String
    public var result: String
    public var seekParam: String
    public var seekType: String
    public var timelength: Int
    public var format: String
    public var acceptFormats: String
    public var acceptQualities: [Int]
    public var dowloadURLs: [Durl]
    
    public struct Durl: Codable {
        public var length: Int
        public var order: Int
        public var size: Int
        public var url: String
        public var backupURLs: [String]
        
        private enum CodingKeys: String, CodingKey {
            case backupURLs = "backup_url"
            case length
            case order
            case size
            case url
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case acceptFormats = "accept_format"
        case acceptQualities = "accept_quality"
        case dowloadURLs = "durl"
        case format
        case from
        case result
        case seekParam = "seek_param"
        case seekType = "seek_type"
        case timelength
    }
}


public struct LivePlayURL: Codable
{
    public var currentQuality: Int
    public var acceptQualities: [String]
    public var dowloadURLs: [Durl]
    
    public struct Durl: Codable {
        public var length: Int
        public var order: Int
        public var url: String
        
        private enum CodingKeys: String, CodingKey {
            case length
            case order
            case url
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case currentQuality = "current_quality"
        case acceptQualities = "accept_quality"
        case dowloadURLs = "durl"
    }
}
