//
//  GlobeConnectSubscriber.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnectIOS {
    public func getSubscriberBalance(
        address: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let getSubscriberBalanceURL = "https://devapi.globelabs.com.ph/location/v1/queries/balance?access_token="+self.accessToken!+"&address="+address
        
        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        // send the request
        self.sendRequest(url: getSubscriberBalanceURL, method: .GET, success: success, failure: failure)
    }
    
    public func getSubscriberReloadAmount(
        address: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let getSubscriberReloadAmountURL = "https://devapi.globelabs.com.ph/location/v1/queries/reload_amount?access_token="+self.accessToken!+"&address="+address
        
        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        // send the request
        self.sendRequest(url: getSubscriberReloadAmountURL, method: .GET, success: success, failure: failure)
    }
}
