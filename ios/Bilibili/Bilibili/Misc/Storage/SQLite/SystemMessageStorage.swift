//
//  SystemMessageStorage.swift
//  Bilibili
//
//  Created by YaeSakura on 2017/6/23.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//


import UIKit
import SQLite
import Sakura

class SystemMessageStorage
{
    // MARK: Singleton
    
    static let instance: SystemMessageStorage = {
        let instance = SystemMessageStorage()
        return instance
    }()
    
    //MARK: Properties
    
    private var database: Connection?
    
    private let filename = "system_message.db"
    private var filepath: String {
        return UIApplication.libraryDirectory + "/SQLite/"
    }
    
    private let table = MessagesTable()
     
    //MARK: Initialization
    
    init() {
        do {
            //Create directory if directory not exists.
            if !FileManager.default.fileExists(atPath: filepath, isDirectory: nil) {
                try FileManager.default.createDirectory(atPath: filepath, withIntermediateDirectories: true, attributes: nil)
            }
            
            //Create database & table.
            database = try Connection(filepath + filename)
            try table.create(in: database)
            
        } catch Result.error(let message, let code, _) {
            if database == nil { print("[SystemMessageStorage.init] Code \(code). \(message).") }
            else { print("[SystemMessageStorage.init] Code \(code). \(message).") }
        } catch { print("[SystemMessageStorage.init] Create directory failed. \(error)") }
    }
    
    //MARK: Methods
    
    /// Get messages synchronously.
    ///
    /// - Parameters:
    ///   - count: Maximum count of messages you want get.
    ///   - timestamp: Timestamp boundary (pass .greatestFiniteMagnitude for no limit).
    /// - Returns: All messages whose timestamp is less than or equal to giving timestamp.
    func getMessages(count: Int, before timestamp: Double? = nil) -> [BilibiliSystemMessage] {
        if database == nil { return [] }
        
        var timestamp = timestamp
        if timestamp == nil {
            timestamp = Double(MAXFLOAT)
        }
        let query = 	table.table
            .filter(table.columns.timestamp < timestamp!)
            .order(table.columns.ID.desc)
            .limit(count)
        
        let messages = try? table.query(query, in: database!)
        return messages ?? []
    }
    
    /// Get messages asynchronously.
    ///
    /// - Parameters:
    ///   - count: Maximum count of messages you want get.
    ///   - timestamp: Timestamp boundary (pass .greatestFiniteMagnitude for no limit).
    ///   - callback: Return all messages whose timestamp is less than or equal to giving timestamp.
    func getMessages(count: Int, before timestamp: Double? = nil, callback: @escaping ([BilibiliSystemMessage]) -> Void) {
        DispatchQueue(label: "SystemMessageStorage.GetMessages").async {
            [unowned self] in
            let messages = self.getMessages(count: count, before: timestamp)
            callback(messages)
        }
    }
    
    /// Insert messages synchronously.
    func addMessages(_ messages: [BilibiliSystemMessage]) -> Bool {
        do { try table.insert(messages, in: database!) }
        catch Result.error(let message, let code, _) {
            if database == nil { print("[SystemMessageStorage.addMessages] Code \(code). \(message).") }
            else { print("[SystemMessageStorage.addMessages] Code \(code). \(message).") }
            return false
        } catch { return false }
        return true
    }
    
    /// Insert messages asynchronously.
    func addMessages(_ messages: [BilibiliSystemMessage], callback: @escaping (Bool) -> Void) {
        DispatchQueue(label: "SystemMessageStorage.AddMessages").async {
            [unowned self] in
            let flag = self.addMessages(messages)
            callback(flag)
        }
    }
    
    /// Update messages synchronously.
    func updateMessages(_ messages: [BilibiliSystemMessage]) -> Bool {
        do  { try table.update(messages, in: database!) }
        catch Result.error(let message, let code, _) {
            if database == nil { print("[SystemMessageStorage.updateMessages] Code \(code). \(message).") }
            else { print("[SystemMessageStorage.updateMessages] Code \(code). \(message).") }
            return false
        } catch { return false }
        
        return false
    }
    
    /// Update messages asynchronously.
    func updateMessages(_ messages: [BilibiliSystemMessage], callback: @escaping (Bool) -> Void) {
        DispatchQueue(label: "SystemMessageStorage.UpdateMessages").async {
            [unowned self] in
            let flag = self.updateMessages(messages)
            callback(flag)
        }
    }
    
    /// Handle messages synchronously.
    func handleMessages(_ messages: [BilibiliSystemMessage]) -> Bool {
        let r1 = updateMessages(messages)
        let r2 = addMessages(messages)
        return r1 && r2
    }
    
    /// Handle messages asynchronously.
    func handleMessages(_ messages: [BilibiliSystemMessage], callback: @escaping (Bool) -> Void) {
        DispatchQueue(label: "SystemMessageStorage.HandleMessages").async {
            [unowned self] in
            let flag = self.handleMessages(messages)
            callback(flag)
        }
    }
    
    /// Get count of all unread messages synchronously.
    func getUnreadMessagesCount() -> Int {
        if database == nil { return 0 }
        return (try? database!.scalar(table.table.where(table.columns.isReaded == false).count)) ?? 0
    }
    
    /// Get count of all unread messages asynchronously.
    func getUnreadMessagesCount(callback: @escaping (Int) -> Void) {
        DispatchQueue(label: "SystemMessageStorage.GetUnreadMessages").async {
            [unowned self] in
            let count = self.getUnreadMessagesCount()
            callback(count)
        }
    }
    
    //MARK: Nested Classes
    
    class MessagesTable
    {
        let table = Table("messages")
        let columns = Columns()
        
        func create(in database: Connection?) throws {
            try database?.run(table.create(ifNotExists: true) { t in
                t.column(columns.ID, primaryKey: .autoincrement)
                t.column(columns.title)
                t.column(columns.contents)
                t.column(columns.ctrlType)
                t.column(columns.ctrlParam)
                t.column(columns.ctrlText)
                t.column(columns.uid)
                t.column(columns.flag)
                t.column(columns.timestamp)
                t.column(columns.isReaded)
            })
        }
        
        func query(_ query: QueryType, in database: Connection) throws -> [BilibiliSystemMessage] {
            var messages: [BilibiliSystemMessage] = []
            for row in try database.prepare(query) {
                let message = BilibiliSystemMessage()
                message.id = row[columns.ID]
                message.title = row[columns.title]
                message.contents = row[columns.contents]
                message.ctrlType = row[columns.ctrlType]
                message.ctrlParam = row[columns.ctrlParam]
                message.ctrlText = row[columns.ctrlText]
                message.uid = row[columns.uid]
                message.type = BilibiliSystemMessageType(rawValue: row[columns.flag])
                message.timestamp = row[columns.timestamp]
                message.isReaded = row[columns.isReaded]
                messages.append(message)
            }
            return messages
        }
        
        func insert(_ messages: [BilibiliSystemMessage], in database: Connection) throws {
            try database.transaction {
                for message in messages {
                    try database.run(self.table.insert(or: .ignore,
                        self.columns.title <- message.title ?? "",
                        self.columns.contents <- message.contents ?? "",
                        self.columns.ctrlType <- message.ctrlType,
                        self.columns.ctrlParam <- message.ctrlParam ?? "",
                        self.columns.ctrlText <- message.ctrlText ?? "",
                        self.columns.uid <- message.uid,
                        self.columns.flag <- message.type.rawValue,
                        self.columns.timestamp <- message.timestamp,
                        self.columns.isReaded <- message.isReaded))
                }
            }
        }
        
        func update(_ messages: [BilibiliSystemMessage], in database: Connection) throws {
            try database.transaction {
                for message in messages {
                    let row = self.table.filter(self.columns.ID == message.id)
                    try database.run(row.update(
                        self.columns.title <- message.title ?? "",
                        self.columns.contents <- message.contents ?? "",
                        self.columns.ctrlType <- message.ctrlType,
                        self.columns.ctrlParam <- message.ctrlParam ?? "",
                        self.columns.ctrlText <- message.ctrlText ?? "",
                        self.columns.uid <- message.uid,
                        self.columns.flag <- message.type.rawValue,
                        self.columns.timestamp <- message.timestamp,
                        self.columns.isReaded <- message.isReaded))
                }
            }
        }
        
        class Columns
        {
            let ID = Expression<Int64>("ID")
            let title = Expression<String>("title")
            let contents = Expression<String>("contents")
            let ctrlType = Expression<Int>("ctrl_type")
            let ctrlParam = Expression<String>("ctrl_param")
            let ctrlText = Expression<String>("ctrl_text")
            let uid = Expression<Int>("uid")
            let flag = Expression<Int>("flag")
            let timestamp = Expression<Double>("ts")
            let isReaded = Expression<Bool>("readed")
        }
    }
    
}
