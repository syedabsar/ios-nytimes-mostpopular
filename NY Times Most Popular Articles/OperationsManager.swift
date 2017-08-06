//
//  DataAccessManager.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/4/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit

class OperationsManager {
    
    public func downloadImage(urlString : String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
    
        NetworkController().getData(urlString: urlString, completionHandler: {data, err in
            
            completionHandler(UIImage(data: data!), err)
        })
    }
    
    public func getSectionsList(completionHandler: @escaping (Array<SectionsResults>?, Error?) -> Void) {
    
        let urlPath = ConfigurationManager.apiPathSectionsList()

        NetworkController().getJSON(urlString: urlPath, completionHandler: {obj, err in
            
            let responseModel = SectionsResponse(dictionary: obj as! NSDictionary)
            
            completionHandler(responseModel?.results, err)
            
        })

    }
    
    public func getMostViewed(section : String, timePeriod : TimePeriod, offset: Int, completionHandler: @escaping (MostViewedResponse?, Error?) -> Void) {
    
        let urlPath = ConfigurationManager.apiPathMostViewed(section: section, timePeriod: timePeriod.rawValue, offset: offset)
        
        NetworkController().getJSON(urlString: urlPath, completionHandler: {obj, err in
            
            let responseModel = MostViewedResponse(dictionary: obj as! NSDictionary)
            
            completionHandler(responseModel, err)
        })
    }

    
}
