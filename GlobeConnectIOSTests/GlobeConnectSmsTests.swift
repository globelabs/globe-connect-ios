//
//  GlobeConnectSmsTests.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 02/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import XCTest
@testable import GlobeConnectIOS

class GlobeConnectSmsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSendBinaryMessage() {
        let expectation = self.expectation(description: "testSendBinaryMessage")
        
        let globeConnect = GlobeConnectIOS(
            shortCode: "21584130",
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )
        
        globeConnect.sendBinaryMessage(
            address: "09271223448",
            message: "Lorem ipsum",
            header: "06050423F423F4",
            success: { json in
                dump(json)
                
                expectation.fulfill()
            },
            failure: { error in
                print("error")
                print(error)
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testSendMessage() {
        let expectation = self.expectation(description: "testSendMessage")
        
        let globeConnect = GlobeConnectIOS(
            shortCode: "21584130",
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )
        
        globeConnect.sendMessage(
            address: "+639271223448",
            message: "Lorem ipsum",
            success: { json in
                dump(json)
                
                expectation.fulfill()
            },
            failure: { error in
                print("error")
                print(error)
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
