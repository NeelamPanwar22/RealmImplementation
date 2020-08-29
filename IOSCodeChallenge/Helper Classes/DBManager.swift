//
//  DBManager.swift
//  IOSCodeChallenge
//
//  Created by neelam panwar on 29/08/20.
//  Copyright © 2020 Neelam Panwar. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    //MARK:- Private Properties
    private var database:Realm
    
    //MARK:- Public Method
    static let sharedInstance = DBManager()
    
    private init() {
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        database = try! Realm()
    }
    
    
    func getDataFromDB() -> Results<ListDataModel> {
        
        let results: Results<ListDataModel> = database.objects(ListDataModel.self)
        return results
    }
    
    func addData(object: ListDataModel) {
        do {
            try database.write {
                database.add(object)
                debugPrint("Added new object")
            }
        }catch let error{
            debugPrint(error.localizedDescription)
        }
    }
}
