//
//  HTTPClient.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import Foundation
import Alamofire

typealias JsonResponse = (_ data : Data?,_ error : Error?,_ statusCode : Int) -> ()

public class HTTPClient {
    
    static func callRestApi(method : APIMethod, params : [String : Any]?, url : String?, headers: [String:String]?, rawJsonOnCompletion : @escaping JsonResponse) {
        
        guard let url = url else { rawJsonOnCompletion(nil, nil, 0); return }
        
        AF.request(url, method: method.associatedHttpMethod() , parameters: params, encoding: URLEncoding.default, headers: HTTPHeaders(headers ?? [:])).responseData(completionHandler: { (response) in
            
            switch(response.result) {
                
            case .success(let data):
                rawJsonOnCompletion(data, nil, response.response?.statusCode ?? 0)
            case .failure(let error):
                rawJsonOnCompletion(nil, error, response.response?.statusCode ?? 0)
            }
        })
    }
}
