//
//  BusinessLogicHelper.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import Foundation

/**
 Number of days `1 | 7 | 30 ` corresponds to a day, a week, or a month of content.
 
 - Parameter name: time-period.
 - Used in: path.
 - type: string.
 */
enum TimePeriod : String {
    case Day = "1"
    case Week = "7"
    case Month = "30"
    
    func getDisplayName() -> String {
        
        switch self {
            
        case .Day:
            return "Day"
            
        case .Week:
            return "Week"
            
        case .Month:
            return "Month"
        }
    }
}


class BusinessLogicHelper {

    /**
     Searches for and presence of a given string in the title of the given array.
     
     
     - parameter searchKeyword: String to search, must contain a value.
     - parameter resultsArray: Array to search, must hold MostViewedResults types.
     - returns: Filtered array
     */
    static func filterBySearchKeywords(searchKeyword: String, resultsArray : Array<MostViewedResults>) -> Array<MostViewedResults> {
        
        if searchKeyword.characters.count == 0 {
            return resultsArray
        }
    
        let filteredArray = resultsArray.filter({
            (result : MostViewedResults) -> Bool in
            return (result.title?.localizedCaseInsensitiveContains(searchKeyword))!
        })

        return filteredArray
    }
    
}
