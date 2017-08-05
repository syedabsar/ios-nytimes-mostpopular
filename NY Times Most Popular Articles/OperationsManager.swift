//
//  DataAccessManager.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit

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
}

class OperationsManager {
    
    public func downloadImage(urlString : String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
    
        NetworkController().getData(urlString: urlString, completionHandler: {data, err in
            
            completionHandler(UIImage(data: data!), err)
        })
    }
    
    public func getMostViewed(section : String, timePeriod : TimePeriod, completionHandler: @escaping (Array<Any>?, Error?) -> Void) {
    
        let urlPath = ConfigurationManager().apiPathMostViewed(section: section, timePeriod: timePeriod.rawValue)
        
        NetworkController().getJSON(urlString: urlPath, completionHandler: {obj, err in
            
            let responseModel = MostViewedResponse(dictionary: obj as! NSDictionary)
            
            completionHandler(responseModel?.results, err)
            
        })
    }

    
}
