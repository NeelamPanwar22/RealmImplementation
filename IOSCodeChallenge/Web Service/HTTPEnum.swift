//
//  HTTPEnum.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//


import Foundation
import Alamofire

enum APIError: Error, LocalizedError {
    case jsonParsingFailure //In case No data found
    case forbidden
    case sessionExpire
    case internalServerError
    case clientError(message: String)
    case underLying(error: Error)
    
    public var localizedDescription: String {
        return self.message
    }
    
    public var errorDescription: String {
        return self.message
    }
    
    private var message:String {
        switch self {
        case .jsonParsingFailure: return "JSON parsing failure"
        case .forbidden: return "Forbidden"
        case .internalServerError: return "Internal Server Error"
        case .sessionExpire: return "Session Expire"
        case .clientError(let message): return message
        case .underLying(let error): return error.localizedDescription
        }
    }
}

enum StatusCode : Int {
    
    case success = 200
    case sessionExpired = 401
    case stripeError = 405
    case badRequest = 400
    case paramMissing = 402
    case serverErr = 500
}

//MARK: - API Method
public enum APIMethod {
    case get
    case post
    case postWithImage
    case put
    case patch
    case rawData
    
    // Conversion to Alamofire's HTTPMethod
    func associatedHttpMethod() -> HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .postWithImage:
            return HTTPMethod.post
        case .patch:
            return HTTPMethod.patch
        case .rawData:
            return HTTPMethod.get
        }
    }
}

//MARK: - API Url
public enum APIUrl : String {
    
    case base
    
    public var value : String {
        
        switch self {
        case .base :
            return "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/"
        }
    }
}


