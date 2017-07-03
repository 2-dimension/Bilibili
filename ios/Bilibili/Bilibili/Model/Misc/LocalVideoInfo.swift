//
//  LocalVideoInfo.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/27.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import Foundation

class LocalVideoInfo
{
    var ID: Int64 = 0
    var aid: Int64 = 0
    var bid: Int64 = 0
    var cid: Int64 = 0
    
    var size: Int64 = 0
    var progress: Double = 0
    
    var title: String?
    var desc: String?
    var videoPath: String?
    var danmakuPath: String?
    
    var timestamp: Double = 0
}

