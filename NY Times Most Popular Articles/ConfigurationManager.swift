//
//  ConfigurationManager.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//
//
//import Foundation

class ConfigurationManager {

    static let scheme = "https://"
    static let host = "api.nytimes.com"
    static let basePath = "/svc/mostpopular/v2"
    static let path = "/mostviewed/{section}/{time-period}.json"
    static let apiKey = "4820a19587ef4514a6e6a39d90bf1ef9"

    
    public static func apiPathMostViewed(section : String, timePeriod: String) -> String {

        if section.characters.count == 0 || timePeriod.characters.count == 0 {
            assertionFailure("section and time period are needed.")
        }
        
        return setApiKey(path: scheme + host + basePath + "/mostviewed/\(section)/\(timePeriod).json")
    }
    
    public static func apiPathSectionsList() -> String {
        
        return setApiKey(path: scheme + host + basePath + "/viewed/sections.json")
    }
    
    private static  func setApiKey(path: String) -> String {
        return path + "?api-key="+apiKey
    }
}
