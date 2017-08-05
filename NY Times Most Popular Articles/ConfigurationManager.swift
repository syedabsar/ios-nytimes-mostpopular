//
//  ConfigurationManager.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import Foundation

class ConfigurationManager {

    let scheme = "https://"
    let host = "api.nytimes.com"
    let basePath = "/svc/mostpopular/v2"
    let path = "/mostviewed/{section}/{time-period}.json"
    let apiKey = "4820a19587ef4514a6e6a39d90bf1ef9"

    
    func apiPathMostViewed(section : String, timePeriod: String) -> String {

        return setApiKey(path: scheme + host + basePath + "/mostviewed/\(section)/\(timePeriod).json")
    }
    
    func setApiKey(path: String) -> String {
        return path + "?api-key="+apiKey
    }
}
