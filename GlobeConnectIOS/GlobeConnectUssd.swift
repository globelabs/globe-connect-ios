//
//  GlobeConnectUSSD.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnectIOS {
    public func sendUssdRequest(
        address: String,
        message: String,
        flash: Bool,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the request url
        let sendUssdRequestURL = "https://devapi.globelabs.com.ph/ussd/v1/outbound/"+self.shortCode!+"/send/requests?access_token="+self.accessToken!
        
        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": message
                ],
                "address"       : address,
                "senderAddress" : self.shortCode!,
                "flash"         : flash
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
                    url: sendUssdRequestURL,
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
    
    public func replyUssdRequest(
        address: String,
        message: String,
        sessionId: String,
        flash: Bool,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the request url
        let replyUssdRequestURL = "https://devapi.globelabs.com.ph/ussd/v1/outbound/"+self.shortCode!+"/reply/requests?access_token="+self.accessToken!
        
        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundUSSDMessageRequest" : [
                "outboundUSSDMessage" : [
                    "message": message
                ],
                "address"       : address,
                "senderAddress" : self.shortCode!,
                "sessionID"     : sessionId,
                "flash"         : flash
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
                    url: replyUssdRequestURL,
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
