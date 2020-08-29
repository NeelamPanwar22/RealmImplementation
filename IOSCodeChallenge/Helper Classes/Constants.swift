//
//  Constants.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 28/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import Foundation

protocol JSONAble {}

extension JSONAble {
    
    func toDict() -> [String : Any] {
        var dict = [String : Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if !(/(child.value as? String)?.isEmpty) {
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
}

