//
//  NetworkControllerProtocol.swift
//  NYTimes_MostPopularArticles
//
//  Created by Syed Absar Karim on 8/7/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import Foundation

protocol NetworkControllerProtocol {
    
    /**
     Gets a Data object corresponding to given URL String.
     
    
     - parameter urlString: Full URL of the resource.
     - parameter completionHandler: Callback with opionally the returned data and error.
     
     This method accepts a string value representing the full url and a callback handler with optionally the data and error
     */
    func getData(urlString : String, completionHandler: @escaping (Data?, Error?) -> Void)
    
    /**
     Gets a JSON dictionary object corresponding to given URL String.
     
     
     - parameter urlString: Full URL of the resource.
     - parameter completionHandler: Callback with opionally the returned data and error.
     
     This method accepts a string value representing the full url and a callback handler with optionally the data and error
     */
    func getJSON(urlString : String, completionHandler: @escaping (AnyObject, Error?) -> Void)
}
