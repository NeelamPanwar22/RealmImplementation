//
//  HTTPHandler.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//


import Foundation

typealias ResultCallback<R,E:Error> = (Result<R,E>)->Void

//MARK: - HTTP Handler
public class HTTPHandler {
    
    public static var header : [String : String]? {
        return ["authorization" : ""]
    }
    
    static func handleAPICallFor<OUTPUT: Codable>(request : HttpRequest, shouldAddHeader : Bool = false, responseOnCompletion : @escaping ResultCallback<OUTPUT?,APIError>) {
        
        /*
         If no internet, return empty response with internetDown status
         */
        
        if !ReachabilityManager.shared.connectedToNetwork() {
            responseOnCompletion(.failure(.internalServerError))
        }
        
        /*
         Call Rest Api of Http Client
         */
        
        let requestUrl = String(format: "%@%@", APIUrl.base.value, request.path.rawValue)
        
        HTTPClient.callRestApi(method: request.method , params: request.params, url: requestUrl, headers: shouldAddHeader ? header : nil) { (response, error,result) in
            
            print(response as Any)
            if let e = error {
                responseOnCompletion(.failure(.internalServerError))
                debugPrint("The error is : \(e)")
            }
            else {
                /*
                 Parse data to codeable 
                 */
                debugPrint("Success")
                do{
                    let decoder = JSONDecoder()
                    let respData = try decoder.decode(OUTPUT.self, from: response ?? Data())
                    responseOnCompletion(.success(respData))
                }
                catch let decodeError {
                    debugPrint(decodeError.localizedDescription)
                }
            }
        }
    }
    
}


