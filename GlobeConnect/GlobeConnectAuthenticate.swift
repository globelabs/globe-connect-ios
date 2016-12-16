//
//  GlobeConnectAuthenticate.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 02/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnect {
    public func getAccessToken(
        code: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let accessTokenURL = "https://developer.globelabs.com.ph/oauth/access_token"

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
        
        // set the payload
        let payload: [String : String] = [
            "app_id": self.appId!,
            "app_secret": self.appSecret!,
            "code": code
        ]

        // build the payload
        var body: String = ""
        for (key, value) in payload {
            body = body.appending(key)
            body = body.appending("=")
            body = body.appending(value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            body = body.appending("&")
        }

        // send the request
        self.sendRequest(
            url: accessTokenURL,
            method: .POST,
            payload: body,
            headers: headers,
            success: success,
            failure: failure
        )
    }

    public func getAccessUrl() -> String {
        return "https://developer.globelabs.com.ph/dialog/oauth?app_id=" + self.appId!
    }
}
