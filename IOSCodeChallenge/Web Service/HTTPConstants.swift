//
//  HTTPConstants.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//


import Foundation
import Alamofire

//MARK: - API Resource Path
public enum APIResourcePath : String {
    
    case challenge = "master/challenge.json"
    
    var string : String { return self.rawValue }
}

//MARK: - API Keys
public enum APIKeys : String {
    
    case message = "message"
    case statusCode = "statusCode"
    case status = "status"
    
    var string : String { return self.rawValue }
}
