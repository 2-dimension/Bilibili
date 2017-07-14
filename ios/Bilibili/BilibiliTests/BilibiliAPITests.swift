//
//  BilibiliAPITests.swift
//  BilibiliTests
//
//  Created by YaeSakura on 2017/7/14.
//  Copyright © 2017年 2-Dimension. All rights reserved.
//

import XCTest
@testable import Bilibili
import BilibiliAPI

class BilibiliAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetVideoInfo() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getVideoInfo(aid: 12104863, success: { (response) in
            XCTAssert(response.code == .OK, "Request failed.")
            XCTAssert(response.result != nil, "Result nil.")
            expectation.fulfill()
        }, failure: { (response) in
            XCTAssert(false, "Request failed. \(response)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
}
