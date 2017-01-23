//
//  GlobeConnectSms.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 01/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnectIOS {
    public func sendBinaryMessage(
        address: String,
        message: String,
        header: String,
        encoding: String? = nil,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let binarySmsURL = "https://devapi.globelabs.com.ph/binarymessaging/v1/outbound/"+self.shortCode!+"/requests?access_token="+self.accessToken!
        
        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundBinaryMessageRequest" : [
                "userDataHeader"        : header,
                "dataCodingScheme"      : 1,
                "address"               : address,
                "senderAddress"         : self.shortCode as Any,
                "access_token"          : self.accessToken as Any,
                "outboundBinaryMessage" : [
                    "message" : message
                ]
            ]
        ]
        
        // we need to convert first the payload to JSON
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )
            
            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                self.sendRequest(
                    url: binarySmsURL,
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
    
    public func sendMessage(
        address: String,
        message: String,
        clientCorrelator: String? = nil,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let sendMessageUrl = "https://devapi.globelabs.com.ph/smsmessaging/v1/outbound/"+self.shortCode!+"/requests?access_token="+self.accessToken!
        
        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        // fix the address
        let address = "tel:" + address
        
        // fix the sender address
        let sender = "tel:" + self.shortCode!
        
        // prepare the payload
        let data: [String : [String: Any]] = [
            "outboundSMSMessageRequest" : [
                "senderAddress"           : sender,
                "address"                 : [address],
                "outboundSMSTextMessage"  : [
                    "message" : message
                ]
            ]
        ]
        
        do {
            // convert it!
            let jsonData = try JSONSerialization.data(
                withJSONObject: data,
                options: JSONSerialization.WritingOptions.prettyPrinted
            )
            
            // it is now in json so we need it to be a string so we can send it
            if let jsonPayload = String(data: jsonData, encoding: String.Encoding.utf8) {
                self.sendRequest(
                    url: sendMessageUrl,
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
