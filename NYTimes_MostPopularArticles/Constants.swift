//
//  Constants.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/6/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

struct Constants {
    struct MasterViewController {
        static let SummaryCellIdentifier = "SummaryCell"
        static let PlaceholderImageName = "PlaceholderImageName"
    }
    struct ConfigurationManager {
        static let scheme = "https://"
        static let host = "api.nytimes.com"
        static let basePath = "/svc/mostpopular/v2"
        static let path = "/mostviewed/{section}/{time-period}.json"
        static let apiKey = "4820a19587ef4514a6e6a39d90bf1ef9"
    }
}
