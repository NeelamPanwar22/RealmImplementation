//
//  ListModel.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 25/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import Foundation
import RealmSwift

class ListDataModel : Object , Codable{
    
    @objc dynamic var id : String?
    @objc dynamic var type : String?
    @objc dynamic var date : String?
    @objc dynamic var data : String?
    
}

enum DataListType : String {
    case text , image
}
