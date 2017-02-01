//
//  GlobeConnectPaymentTests.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import XCTest
@testable import GlobeConnectIOS

class GlobeConnectPaymentTests: XCTestCase {
    var globeConnect: GlobeConnectIOS?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.globeConnect = GlobeConnectIOS(
            appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
            appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSendPaymentRequest() {
        let expectation = self.expectation(description: "testSendPaymentRequest")
        
        self.globeConnect?.sendPaymentRequest(
            amount: 0.00,
            description: "My Application",
            endUserId: "9271223448",
            referenceCode: "41301000112",
            transactionOperationStatus: "Charged",
            success: { json in
                
                expectation.fulfill()
            },
            failure: { error in
                print(error)
                expectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testGetLastReferenceCode() {
        let expectation = self.expectation(description: "testGetLastReferenceCode")
        
        self.globeConnect?.getLastReferenceCode(
            success: { json in
                dump(json)
                expectation.fulfill()
            },
            failure: { error in
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
