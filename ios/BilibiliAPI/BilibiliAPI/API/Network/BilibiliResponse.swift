//
//  BilibiliResponse.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

open class BilibiliResponse <T>: CustomStringConvertible
{
    public var code: BilibiliException = .FAIL
    public var message: String?
    public var result: T?
    
    public init(_ code: BilibiliException,
         _ message: String? = nil,
         _ result: T? = nil) {
        self.code = code
        self.message = message
        self.result = result
    }
    
    public init(_ code: Int,
         _ message: String? = nil,
         _ result: T? = nil) {
        self.code = BilibiliException(rawValue: code) ?? .FAIL
        self.message = message
        self.result = result
    }
    
    public var description: String {
        return "Code: \(code.rawValue) Message: \(message ?? "")"
    }
}
