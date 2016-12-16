//
//  GlobeConnectAmax.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 02/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnect {
    public func sendRewardRequest(
        address: String,
        promo: String,
        rewardsToken: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) {
        // set the url
        let sendRewardRequestURL = "https://devapi.globelabs.com.ph/rewards/v1/transactions/send"

        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundRewardRequest" : [
                "app_id"        : self.appId!,
                "app_secret"    : self.appSecret!,
                "rewards_token" : rewardsToken,
                "address"       : address,
                "promo"         : promo
            ]
        ]

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )

            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                self.sendRequest(
                    url: sendRewardRequestURL,
                    method: .POST,
                    payload: jsonPayload,
                    headers: headers,
                    success: success,
                    failure: failure
                )
            }
        } catch let error as NSError {
            // oops, error in converting it to JSON
            failure?(error)
        }
    }
}
