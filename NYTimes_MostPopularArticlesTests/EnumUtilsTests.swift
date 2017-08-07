//
//  EnumUtilsTests.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/6/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import XCTest
@testable import NYTimes_MostPopularArticles

enum SampleEnum : String {
    case Value1 = "1"
    case Value2 = "2"
    case Value3 = "3"
}

class EnumUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIterateEnumCount() {
        // Given Any Enum, The number of iterations should be equal to number of enum items.
        enum SampleEnum : String {
            case Value1 = "1"
            case Value2 = "2"
            case Value3 = "3"
        }

        var counter = 0
        for _ in EnumUtils.iterateEnum(SampleEnum.self) {
            counter += 1
        }
        
        XCTAssertEqual(counter, 3)
    }
    
    func testIterateEnumValues() {
        // Given Any Enum, The values iterated should be inclusive.
        
        var array = Array<String>()
        for enumValue in EnumUtils.iterateEnum(SampleEnum.self) {
            array.append(enumValue.rawValue)
        }
        
        XCTAssertEqual(Set(array), Set([SampleEnum.Value1.rawValue,SampleEnum.Value2.rawValue,SampleEnum.Value3.rawValue]))
    }

    
    func testEnumIterationPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            var array = Array<String>()
            for enumValue in EnumUtils.iterateEnum(SampleEnum.self) {
                array.append(enumValue.rawValue)
            }

        }
    }
    
}
