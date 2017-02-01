//
//  GlobeConnect.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 01/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

open class GlobeConnectIOS {
    public var appId: String?
    public var appSecret: String?
    public var shortCode: String?
    public var accessToken: String?
    
    // Types
    public typealias SuccessHandler = (JSON) -> Void
    public typealias ErrorHandler = (_ error: Error) -> Void
    
    let dataEncoding: String.Encoding = .utf8
    
    public init(
        appId: String? = nil,
        appSecret: String? = nil,
        shortCode: String? = nil,
        accessToken: String? = nil
    ) {
        // all of these are optional but we want to make sure that atleast one
        // of these variable have a value
        self.appId = appId ?? ""
        self.appSecret = appSecret ?? ""
        self.shortCode = shortCode ?? ""
        self.accessToken = accessToken ?? ""
    }
    
    func sendRequest(
        url: String,
        method: HTTPMethodType,
        payload: String? = nil,
        headers: Dictionary<String, String>? = [:],
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) {        
        if method == .GET {
            let parameters = payload ?? ""
            
            HTTPRequest(url: url, headers: headers)
                .get(
                    parameters: parameters,
                    success: { data, _ in
                        DispatchQueue.global(qos: .utility).async {
                            do {
                                let jsonResult = try JSON.parse(jsonData: data)
                                DispatchQueue.main.async {
                                    success?(jsonResult)
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    failure?(error)
                                }
                            }
                        }
                    }, failure: { error in
                        failure?(error)
                    })
        } else {
            HTTPRequest(url: url, headers: headers)
                .post(
                    parameters: payload!,
                    success: { data, _ in
                        DispatchQueue.global(qos: .utility).async {
                            do {
                                let jsonResult = try JSON.parse(jsonData: data)
                                DispatchQueue.main.async {
                                    success?(jsonResult)
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    failure?(error)
                                }
                            }
                        }
                    }, failure: { error in
                        failure?(error)
                    })
        }
    }
}
