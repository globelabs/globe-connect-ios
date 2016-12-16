//
//  GlobeConnectLocationQuery.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 02/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnect {
    public func getLocation(
        address: String,
        accuracy: Int = 10,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        var locationUrl = "https://devapi.globelabs.com.ph/location/v1/queries/location?access_token="
        locationUrl += self.accessToken!+"&address="+address+"&requestedAccuracy="+String(accuracy)
        
        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"
        
        // send the request
        self.sendRequest(
            url: locationUrl,
            method: .GET,
            headers: headers,
            success: success,
            failure: failure
        )
    }
}
