//
//  GlobeConnectSubscriberTests.swift
//  GlobeConnect
//
//  Created by Rico Maglayon on 05/12/2016.
//  Copyright © 2016 Openovate Labs. All rights reserved.
//

import XCTest
@testable import GlobeConnect

class GlobeConnectSubscriberTests: XCTestCase {
    var globeConnect: GlobeConnect?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.globeConnect = GlobeConnect(
            accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
        )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSubscriberBalance() {
        let expectation = self.expectation(description: "testGetSubscriberBalance")
        
        self.globeConnect?.getSubscriberBalance(
            address: "639271223448",
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
    
    func testGetSubscriberReloadAmount() {
        let expectation = self.expectation(description: "testGetSubscriberReloadAmount")
        
        self.globeConnect?.getSubscriberReloadAmount(
            address: "639271223448",
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
