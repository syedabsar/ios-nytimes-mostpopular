//
//  NetworkController.swift
//  NY Times Most Popular Articles
//
//  Created by Syed Absar Karim on 8/5/17.
//  Copyright © 2017 Syed Absar Karim. All rights reserved.
//

import UIKit
import Alamofire

class NetworkController {
    
    public func getJSON(urlString : String, completionHandler: @escaping (AnyObject, Error?) -> Void) {
        Alamofire.request(urlString).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                completionHandler(json as AnyObject, response.error)
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                
               // completionHandler(data, response.error)
            }
        }
        
    }
    
}
