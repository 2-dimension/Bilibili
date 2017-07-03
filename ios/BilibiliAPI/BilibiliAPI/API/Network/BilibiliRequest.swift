//
//  BilibiliRequest.swift
//  BilibiliAPI
//
//  Created by YaeSakura on 2017/6/30.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Alamofire

class BilibiliRequest
{
    
    /// Generic request method for standard buka request.
    ///
    /// - Parameters:
    ///   - url: Request URL. Default is buka main server URL.
    ///   - gzip: If response is not gizpped, set this value to false. Default is ture.
    ///   - interface: Interface name (for non-RESTful interface). e.g. func_getdetail.
    ///   - version: API version, for version adaptation. Default is 16.
    ///   - parameters: Request parameters.
    ///   - success: Success callback closure.
    ///   - failure: Failure callback closure.
//    static func request<T: NSObject, U>(
//        url: String,
//        parameters:Parameters?,
//        success: BilibiliAPI.Callback<T>,
//        failure: BilibiliAPI.Callback<U>) {
//
//        let params = ParametersBuilder(parameters)
//            .interface(interface)
//            .version(version)
//            .gzip(gzip)
//            .build()
//
//        Alamofire.request(url, method: .post, parameters: params).response {
//            response in
//            if response.error == nil {
//                // Success
//                if  let data = response.data,
//                    let unzipedData = gzip ? (data as NSData).gzipInflate() : data,
//                    let dict = [AnyHashable:Any](jsonData: unzipedData) {
//
//                    let code = BukaException(dict["ret"] as? Int ?? 0)
//                    let model = T.model(with: dict)
//
//                    if code == .OK { success?(BukaResponse(code, model)) }
//                    else { failure?(BukaResponse(code)) }
//                }
//            } else {
//                // Fail
//                failure?(BukaResponse(.FAILED))
//            }
//        }
//    }
    
    /// Basic parameters builder for standard buka request.
    class ParametersBuilder {
        private var rawParameters: Parameters!
        private var version: Int? = nil
        private var gzip: Bool = true
        
        init(_ rawParameters: Parameters?) {
            self.rawParameters = rawParameters ?? Parameters()
        }
        
        func interface(_ funcName: String) -> Self {
            rawParameters?["f"] = funcName
            return self
        }
        
        func version(_ version: Int) -> Self {
            self.version = version
            return self
        }
        
        func gzip(_ bool: Bool) -> Self {
            self.gzip = bool
            return self
        }
        
        func build() -> Parameters {
            if !JSONSerialization.isValidJSONObject(rawParameters) {
                return Parameters()
            }
            
            let data = try! JSONSerialization.data(withJSONObject: rawParameters, options: .prettyPrinted)
            let jsonParams = String(data: data, encoding: .utf8) ?? ""
            
            var params = [:] as Parameters
            
            return params
        }
    }
    
    
    
}
