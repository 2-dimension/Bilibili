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
    ///   - sign: Weather need signature according key & secret.
    ///   - keyPath: Path of json which real data exists.
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
    public static func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters:Parameters?,
        sign: Bool = false,
        keyPath: String? = nil,
        success: BilibiliAPI.Callback<T>,
        failure: BilibiliAPI.Callback<T>) {
        
        let params = ParametersBuilder(parameters)
            .sign(sign)
            .build()
        
        Alamofire.request(url, method: method, parameters: params).response {
            response in
            if response.error == nil {
                // Success
                if  let data = response.data,
                    let json = String.init(data: data, encoding: .utf8),
                    let dict = [String:Any](json: json) {
                    
                    let code = dict["code"] as? Int ?? -1
                    let message = dict["message"] as? String
                    let result = try? T.object(from: dict.value(forKeyPath: keyPath) as? [String:Any] ?? dict)
                    
                    let biliResponse = BilibiliResponse(code, message, result)
                    if biliResponse.code == .OK { success?(biliResponse) }
                    else { failure?(biliResponse) }
                }
            } else { failure?(BilibiliResponse(.FAIL)) }
        }
    }
    
    public static func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters:Parameters?,
        keyPath: String? = nil,
        success: BilibiliAPI.Callback<Array<T>>,
        failure: BilibiliAPI.Callback<Array<T>>) {
        
        let params = ParametersBuilder(parameters)
            .sign(true)
            .build()
        
        Alamofire.request(url, method: method, parameters: params).response {
            response in
            if response.error == nil {
                // Success
                if  let data = response.data,
                    let json = String.init(data: data, encoding: .utf8),
                    let dict = [AnyHashable:Any](json: json) {
                    
                    let code = dict["code"] as? Int ?? -1
                    let message = dict["message"] as? String
                    let result = try? T.array(from: json)
                    
                    let biliResponse = BilibiliResponse(code, message, result)
                    if biliResponse.code == .OK { success?(biliResponse) }
                    else { failure?(biliResponse) }
                }
            } else { failure?(BilibiliResponse(.FAIL)) }
        }
    }
    
    /// Basic parameters builder for standard buka request.
    internal class ParametersBuilder {
        private var rawParameters: Parameters!
        private var sign: Bool = false
        
        init(_ rawParameters: Parameters?) {
            self.rawParameters = rawParameters ?? Parameters()
        }
        
        func sign(_ bool: Bool) -> Self {
            self.sign = bool
            return self
        }
        
        func build() -> Parameters {
            if !JSONSerialization.isValidJSONObject(rawParameters) {
                return Parameters()
            }
            
            var parameters = rawParameters!
            parameters["build"] = UIApplication.shared.buildVersion
            parameters["device"] = "phone"
            parameters["mobi_app"] = "iphone"
            parameters["platform"] = "ios"
            parameters["ts"] = Int(Date().timeIntervalSince1970)
            parameters["appkey"] = sign ? APP_KEY : nil
            parameters["actionKey"] = sign ? "appkey" : nil
            parameters["sign"] = sign ? BilibiliAuth.generateSign(parameters) : nil
            
            return parameters
        }
    }
    
}

extension BilibiliRequest {
    static let DEFAULT_DATA_KEY_PATH = "data"
}
