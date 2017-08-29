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

class BilibiliAPITests: XCTestCase
{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - Video
    
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
    
    func testGetVideoPlayURL() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getPlayURL(cid: 19965680, quality: .normal, success: { (response) in
            XCTAssert(response.code == .OK, "Request failed (\(response.code)).")
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
    
    func testGetDanmakus() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getDanmakus(cid: 10602259, success: { (response) in
            XCTAssert(response.hasPrefix("<?xml"), "Result error.")
            expectation.fulfill()
        }, failure: { (response) in
            XCTAssert(false, "Request failed. \(response)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    func testGetComments() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getComments(aid: 13599724, page: 0, success: { (response) in
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
    
    //MARK: - Live
    
    func testGetLivePlayURL() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getLiveURL(cid: 23058, quality: .normal, success: { (response) in
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
    
    //MARK: - Bangumi
    
    func testGetBangumiInfo() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getBangumiInfo(sid: 844, success: { (response) in
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
    
    func testGetBangumiRecommendation() {
        let expectation = self.expectation(description: "Requesting...")
        
        BilibiliAPI.getBangumiRecommendation(sid: 844, success: { (response) in
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
