//
//  NY_Times_Most_Popular_ArticlesTests.swift
//  NY Times Most Popular ArticlesTests
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit
import XCTest
@testable import NYTimes_MostPopularArticles

class NYTimes_MostPopularArticlesTests: XCTestCase {
    
    var storyboard : UIStoryboard?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.storyboard = UIStoryboard(name: "Main",
                                       bundle: Bundle.main)
        
        XCTAssertNotNil(self.storyboard)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMasterView() {
        
        let masterViewController = self.storyboard?.instantiateViewController(withIdentifier: "MasterViewController")
        
        XCTAssertNotNil(masterViewController)
        XCTAssertTrue(masterViewController is MasterViewController)
        
    }
    
    func testDetailView() {
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
        
        XCTAssertNotNil(detailViewController)
        XCTAssertTrue(detailViewController is DetailViewController)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
