//
//  GlobeConnectAuthenticate.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import XCTest
@testable import GlobeConnect

class GlobeConnectAuthenticate: XCTestCase {
    var globeConnect: GlobeConnect?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.globeConnect = GlobeConnect(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e"
        )
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetAccessToken() {
        let expectation = self.expectation(description: "testGetAccessToken")

        self.globeConnect?.getAccessToken(
            code: "M8s6gAarub9pebhgEAqKsxdByxHoM5kzf4Mp5js98Bzot8bqjrfaRdG4H4jknpFzr8gKtdx4jnUqbA8KsxqA48frR698IKLRb5S5LBxauo9EkxCMrzk6uorxGEu67Tay49aTxxzu8ozznukMEaXCBRB8GuKjR5MSpB65zIbkA8Bf5eA94se848KUb589RteGkdEFBEddEH6xqRyfjMBqatE4ppBsAe56Bfq4BkjHrXA9Rsqzp5RhMAA6Mu65MAds",
            success: { json in                
                expectation.fulfill()
            }, failure: { error in
                print(error)
                expectation.fulfill()
            })

        waitForExpectations(timeout: 30, handler: nil)
    }

    func testGetRedirectUrl() {
        let url = (self.globeConnect?.getAccessUrl())! as String
        print(url)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
