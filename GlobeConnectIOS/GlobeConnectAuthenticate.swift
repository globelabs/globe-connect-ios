//
//  GlobeConnectAuthenticate.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 02/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

let kSafariViewControllerCloseNotification = "kSafariViewControllerCloseNotification"

public class Authenticate: UIViewController, SFSafariViewControllerDelegate {
    let authenticationPageURL = "https://developer.globelabs.com.ph/dialog/oauth"
    
    // Types
    public typealias SuccessHandler = (JSON) -> Void
    public typealias ErrorHandler = (Error) -> Void
    
    var safariViewController: SFSafariViewController?
    var observer = AnyObject?.self
    
    public func listenForRequest(url: URL) -> Void {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: kSafariViewControllerCloseNotification),
            object: url
        )
    }
    
    public func login(
        viewController: AnyObject?,
        appId: String,
        appSecret: String,
        success: SuccessHandler? = nil,
        failure: ErrorHandler? = nil
    ) -> Void {
        // prepare the url
        let pageURL = URL(string: self.authenticationPageURL + "?app_id=" + appId)
        
        // open it via Safari
        safariViewController = SFSafariViewController(url: pageURL!)
        safariViewController!.delegate = self
        
        // show it to the view
        viewController?.present(safariViewController!, animated: true, completion: nil)
        
        // create now an observer to listen for requests coming back to the app
        self.observer = NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: kSafariViewControllerCloseNotification),
            object: nil,
            queue: OperationQueue.main,
            using : { notification in
                let extractedURL = notification.object as! URL
                let responseURL = String(describing: extractedURL)
                
                // remove observer
                if (self.observer != nil) {
                    NotificationCenter.default.removeObserver(self.observer!)
                }
                
                // extract the code from the url
                let code = self.extractCode(responseURL)
                
                if (code == nil) {
                    // close Safari
                    self.safariViewController!.dismiss(animated: true, completion: nil)
                    
                    failure?("Something went wrong while processing your request." as! Error)
                }
                
                // request for the access token or something
                self.requestAccessToken(
                    appId: appId,
                    appSecret: appSecret,
                    code: code!,
                    success: { json in
                        // close Safari
                        self.safariViewController!.dismiss(animated: true, completion: nil)
                        
                        success?(json)
                    },
                    failure: { error in
                        // close Safari
                        self.safariViewController!.dismiss(animated: true, completion: nil)
                        
                        failure?(error)
                    }
                )
            }
        ) as? AnyObject?.Type
    }
    
    internal func extractCode(_ urlString: String) -> String? {
        var code: String? = nil
        let url = URL(string: urlString)
        let urlQuery = (url?.query != nil) ? url?.query : urlString
        let components = urlQuery?.components(separatedBy: "&")
        for comp in components! {
            if (comp.range(of: "code=") != nil) {
                code = comp.components(separatedBy: "=").last
            }
        }
        return code
    }
    
    internal func requestAccessToken(
        appId: String,
        appSecret: String,
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
            "app_id": appId,
            "app_secret": appSecret,
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
        
        // send request
        HTTPRequest(url: accessTokenURL, headers: headers)
            .post(
                parameters: body,
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
    
    public func safariViewControllerDidFinish(
        _ controller: SFSafariViewController
    ) -> Void {
        controller.dismiss(animated: true, completion: nil)
    }
}
