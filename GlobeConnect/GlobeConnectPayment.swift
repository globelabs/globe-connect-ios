//
//  GlobeConnectPayment.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import Foundation

public extension GlobeConnect {
    public func sendPaymentRequest(
        amount: Float,
        description: String,
        endUserId: String,
        referenceCode: String,
        transactionOperationStatus: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let sendPaymentURL = "https://devapi.globelabs.com.ph/payment/v1/transactions/amount?access_token="+self.accessToken!

        // set the payload
        let data: [String: Any] = [
            "amount"                      : String(format: "%.2f", amount),
            "description"                 : description,
            "endUserId"                   : endUserId,
            "referenceCode"               : referenceCode,
            "transactionOperationStatus"  : transactionOperationStatus
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
                    url: sendPaymentURL,
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

    public func getLastReferenceCode(
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // set the url
        let getLastReferenceCodeURL = "https://devapi.globelabs.com.ph/payment/v1/transactions/getLastRefCode?app_id="+self.appId!+"&app_secret="+self.appSecret!

        // set the header/s
        var headers = Dictionary<String, String>()
        headers["Content-Type"] = "application/json; charset=utf-8"

        // send the request
        self.sendRequest(url: getLastReferenceCodeURL, method: .GET, success: success, failure: failure)
    }
}
