//
//  BusinessLogicHelperTests.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import XCTest
@testable import NYTimes_MostPopularArticles

class BusinessLogicHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisplayNameForTimePeriodEnum() {
        
        XCTAssertFalse(TimePeriod.Day.getDisplayName() != "Day")
        XCTAssertFalse(TimePeriod.Week.getDisplayName() != "Week")
        XCTAssertFalse(TimePeriod.Month.getDisplayName() != "Month")
    }

    func testRawValueForTimePeriodEnum() {
        
        XCTAssertFalse(TimePeriod.Day.rawValue != "1")
        XCTAssertFalse(TimePeriod.Week.rawValue != "7")
        XCTAssertFalse(TimePeriod.Month.rawValue != "30")
    }

    
    func testSearchFilterWithEmptyKeyword() {
    //Given an array and empty search string, the returned array should be same number of items.
        
        let array = BusinessLogicHelper.filterBySearchKeywords(searchKeyword: "", resultsArray: [])
     
        XCTAssertEqual(array.count, 0)
    }

    
}
