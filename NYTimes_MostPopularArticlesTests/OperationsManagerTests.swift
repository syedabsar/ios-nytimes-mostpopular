//
//  OperationsManagerTests.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import XCTest
@testable import NYTimes_MostPopularArticles

class OperationsManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        
    }
    
    func testMostViewed() {
        let expectation = self.expectation(description:  "Web Service Response Received")
        
        self.measure {
            
            OperationsManager().getMostViewed(section: "all-sections", timePeriod: TimePeriod.Day, offset: 0, completionHandler: { obj, err in
                
                expectation.fulfill()
            })
            
        }
        
        self.waitForExpectations(timeout: 30) { error in
            
            XCTAssertNil(error)
        }
    }
    
}
