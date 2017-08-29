//
//  BilibiliRequest.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Alamofire

open class BilibiliRequest
{
    
    /// Generic request method for bilibili request.
    ///
    /// - Parameters:
    ///   - url: Request URL.
    ///   - method: HTTP method.
    ///   - parameters: Request parameters.
    ///   - configs: <#Configs#>
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters:Parameters?,
        configs: [Config]? = nil,
        success: BilibiliAPI.Callback<T>,
        failure: BilibiliAPI.Callback<T>) {
        
        let params = ParametersBuilder(parameters)
            .sign(configs?.contains(.sign) ?? false)
            .deviceInfo(!(configs?.contains(.brief) ?? true))
            .build()
        
        var keyPath: String? = nil
        for e in configs ?? [] {
            switch e {
            case .keypath(let str) :
                keyPath = str
            default: break
            }
        }
        
        Alamofire.request(url, method: method, parameters: params).response {
            response in
            if response.error == nil {
                // Success
                if  let data = response.data,
                    let json = String.init(data: data, encoding: .utf8),
                    let dict = [String:Any](json: json) {
                    
                    let code = dict["code"] as? Int ?? 0
                    let message = dict["message"] as? String
                    
                    if let nested = dict.value(forKeyPath: keyPath) as? [String:Any] {
                        let result = code == 0 ? try! T.object(from: nested) : nil
                        
                        let biliResponse = BilibiliResponse(code, message, result)
                        if biliResponse.code == .OK { success?(biliResponse) }
                        else { failure?(biliResponse) }
                    } else {
                        failure?(BilibiliResponse(.FAIL))
                    }
                }
            } else { failure?(BilibiliResponse(.FAIL)) }
        }
    }
    
    /// Generic request method for bilibili request when T is Array.
    ///
    /// - Parameters:
    ///   - url: Request URL.
    ///   - method: HTTP method.
    ///   - parameters: Request parameters.
    ///   - configs: <#Configs#>
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters:Parameters?,
        configs: [Config]? = nil,
        success: BilibiliAPI.Callback<Array<T>>,
        failure: BilibiliAPI.Callback<Array<T>>) {
        
        let params = ParametersBuilder(parameters)
            .sign(configs?.contains(.sign) ?? false)
            .deviceInfo(!(configs?.contains(.brief) ?? true))
            .build()
        
        var keyPath: String? = nil
        for e in configs ?? [] {
            switch e {
            case .keypath(let str) :
                keyPath = str
            default: break
            }
        }
        
        Alamofire.request(url, method: method, parameters: params).response {
            response in
            if response.error == nil {
                // Success
                if  let data = response.data,
                    let json = String.init(data: data, encoding: .utf8),
                    let dict = [String:Any](json: json) {
                    
                    let code = dict["code"] as? Int ?? 0
                    let message = dict["message"] as? String
                    
                    if let nested = dict.value(forKeyPath: keyPath) as? [[String:Any]] {
                        let result = try! T.array(from: nested)
                        
                        let biliResponse = BilibiliResponse(code, message, result)
                        if biliResponse.code == .OK { success?(biliResponse) }
                        else { failure?(biliResponse) }
                    } else {
                        failure?(BilibiliResponse(.FAIL))
                    }
                }
            } else { failure?(BilibiliResponse(.FAIL)) }
        }
    }
    
    /// Basic parameters builder for standard buka request.
    internal class ParametersBuilder {
        private var rawParameters: Parameters!
        private var sign: Bool = false
        private var deviceInfo: Bool = false
        
        init(_ rawParameters: Parameters?) {
            self.rawParameters = rawParameters ?? Parameters()
        }
        
        func sign(_ bool: Bool) -> Self {
            self.sign = bool
            return self
        }
        
        func deviceInfo(_ bool: Bool) -> Self {
            self.deviceInfo = bool
            return self
        }
        
        func build() -> Parameters {
            if !JSONSerialization.isValidJSONObject(rawParameters) {
                return Parameters()
            }
            
            var parameters = rawParameters!
            if deviceInfo {
                parameters["build"] = UIApplication.shared.buildVersion
                parameters["device"] = "phone"
                parameters["mobi_app"] = "iphone"
                parameters["platform"] = "ios"
                parameters["ts"] = Int(Date().timeIntervalSince1970)
            }
            if sign {
                parameters["appkey"] = sign ? BilibiliAuth.APP_KEY : nil
                parameters["actionKey"] = sign ? "appkey" : nil
                parameters["sign"] = sign ? BilibiliAuth.generateSign(parameters) : nil
            }
            
            return parameters
        }
    }
    
    /// Request configuration.
    public enum Config: Hashable, Equatable {
        case sign                           // Calculate sign with app key & secret when request.
        case brief                          // Request without device info.
        case keypath(String)                // Path of json where real data exists.
        
        public var hashValue: Int {
            switch self {
            case .sign: return "sign".hashValue
            case .brief: return "brief".hashValue
            case .keypath(_): return "keypath".hashValue
            }
        }
        
        public static func ==(lhs: Config, rhs: Config) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }
    
    
}

extension BilibiliRequest {
    static let DEFAULT_DATA_KEY_PATH = "data"
}
