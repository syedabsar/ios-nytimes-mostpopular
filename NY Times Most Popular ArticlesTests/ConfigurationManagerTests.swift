//
//  ConfigurationManagerTests.swift
//  NYTimes_MostPopularArticles
//
//  Created by Syed Absar Karim on 8/6/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import XCTest
@testable import NYTimes_MostPopularArticles

class ConfigurationManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApiPathMostViewed() {
        // Given a section and time period, the API path should always be returned.
        
        XCTAssertNotNil(ConfigurationManager.apiPathMostViewed(section: "all-sections", timePeriod: "1"))
    }
    
    func testApiPathSectionsListAvailable() {
        // Given a section and time period, the API path should always be returned.
        
        XCTAssertNotNil(ConfigurationManager.apiPathSectionsList())
        
    }
    
    func testApiPathSectionsListValidURL() {
    
        let url = URL(string: ConfigurationManager.apiPathSectionsList())

        XCTAssertNotNil(url)
    }
    
    func testApiKeyAvailable() {
        
        let urlString = ConfigurationManager.apiPathSectionsList()
        
        XCTAssertTrue(urlString.contains("api-key="))
    }

    
}
