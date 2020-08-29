//
//  HttpRequest.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import Foundation

final class HttpRequest : NSObject {
    
    var path: APIResourcePath
    var method: APIMethod
    var params: [String : Any]?
    
    init(path: APIResourcePath, method: APIMethod , params:  [String : Any]?) {
        
        self.path = path
        self.method = method
        self.params = params
    }
}
