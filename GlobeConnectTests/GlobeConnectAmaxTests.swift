//
//  GlobeConnectAmaxTests.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import XCTest
@testable import GlobeConnect

class GlobeConnectAmaxTests: XCTestCase {
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
    
    func testSendRewardRequest() {
        let expectation = self.expectation(description: "testSendRewardRequest")
        
        self.globeConnect?.sendRewardRequest(
            address: "9271223448",
            promo: "FREE10MB",
            rewardsToken: "w7hYKxrE7ooHqXNBQkP9lg",
            success : { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
