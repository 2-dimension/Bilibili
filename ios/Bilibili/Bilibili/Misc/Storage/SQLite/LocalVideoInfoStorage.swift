//
//  LocalVideoInfoStorage.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/23.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import SQLite

class LocalVideoInfoStorage: IStorage
{
    // MARK: Singleton
    
    static let instance: LocalVideoInfoStorage = {
        let instance = LocalVideoInfoStorage()
        return instance
    }()
    
    //MARK: Properties
    
    var database: Connection?
    var version: Int { return 1 }
    
    var filename: String = ""
    var filepath: String { return "" }
    
    required init() {
        
    }
    
    func onCreate() {
        
    }
    
    func onUpgrade(_ oldVersion: Int, _ newVersion: Int) {
        
    }
    
    //MARK: Nested Classes
    
    class InfosTable
    {
        let table = Table("infos")
        let columns = Columns()
        
        func create(in database: Connection?) throws {
            try database?.run(table.create(ifNotExists: true) { t in
                t.column(columns.ID, primaryKey: .autoincrement)
                t.column(columns.aid)
                t.column(columns.bid)
                t.column(columns.cid)
                t.column(columns.size)
                t.column(columns.progress)
                t.column(columns.title)
                t.column(columns.desc)
                t.column(columns.videoPath)
                t.column(columns.danmakuPath)
                t.column(columns.timestamp)
            })
        }
        
        func query(_ query: QueryType, in database: Connection) throws -> [LocalVideoInfo] {
            var infos: [LocalVideoInfo] = []
            for row in try database.prepare(query) {
                let info = LocalVideoInfo()
                info.ID = row[columns.ID]
                info.aid = row[columns.aid]
                info.bid = row[columns.bid]
                info.cid = row[columns.cid]
                info.size = row[columns.size]
                info.progress = row[columns.progress]
                info.title = row[columns.title]
                info.desc = row[columns.desc]
                info.timestamp = row[columns.timestamp]
                infos.append(info)
            }
            return infos
        }
        
        func insert(_ infos: [LocalVideoInfo], in database: Connection) throws {
            try database.transaction {
                for info in infos {
                    try database.run(self.table.insert(or: .ignore,
                        self.columns.ID <- info.ID,
                        self.columns.aid <- info.aid,
                        self.columns.bid <- info.bid,
                        self.columns.cid <- info.cid,
                        self.columns.size <- info.size,
                        self.columns.progress <- info.progress,
                        self.columns.title <- info.title ?? "",
                        self.columns.desc <- info.desc ?? "",
                        self.columns.videoPath <- info.videoPath ?? "",
                        self.columns.danmakuPath <- info.danmakuPath ?? "",
                        self.columns.timestamp <- info.timestamp))
                }
            }
        }
        
        func update(_ infos: [LocalVideoInfo], in database: Connection) throws {
            try database.transaction {
                for info in infos {
                    let row = self.table.filter(self.columns.ID == info.ID)
                    try database.run(row.update(
                        self.columns.ID <- info.ID,
                        self.columns.aid <- info.aid,
                        self.columns.bid <- info.bid,
                        self.columns.cid <- info.cid,
                        self.columns.size <- info.size,
                        self.columns.progress <- info.progress,
                        self.columns.title <- info.title ?? "",
                        self.columns.desc <- info.desc ?? "",
                        self.columns.videoPath <- info.videoPath ?? "",
                        self.columns.danmakuPath <- info.danmakuPath ?? "",
                        self.columns.timestamp <- info.timestamp))
                }
            }
        }
        
        class Columns
        {
            let ID = Expression<Int64>("ID")
            let aid = Expression<Int64>("aid")
            let bid = Expression<Int64>("bid")
            let cid = Expression<Int64>("cid")
            let size = Expression<Int64>("size")
            let progress = Expression<Double>("progress")
            let title = Expression<String>("title")
            let desc = Expression<String>("desc")
            let videoPath = Expression<String>("videoPath")
            let danmakuPath = Expression<String>("danmakuPath")
            let timestamp = Expression<Double>("ts")
        }
    }
    
}
