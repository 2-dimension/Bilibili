//
//  BaseStorage.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/29.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import Foundation
import SQLite

protocol IStorage
{
    var database: Connection? { get set }
    
    var filename: String { get }
    var filepath: String { get }
    var version: Int { get }
    init()
    func onCreate()
    func onUpgrade(_ oldVersion: Int, _ newVersion: Int)
    
}

extension IStorage
{
    init() {
        self.init()
        self.onCreate()
        if version != 1 {
            self.onUpgrade(version, 1)
        }
    }
}
