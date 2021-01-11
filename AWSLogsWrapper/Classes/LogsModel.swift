//
//  LogsModel.swift
//  SportsMe
//
//  Created by RAJASEKHAR on 11/04/20.
//  Copyright © 2020 SportsMe. All rights reserved.
//

import Foundation
import RealmSwift

class LogsModel: Object {
    @objc dynamic var message = ""
    @objc dynamic var timestamp: Int = 0
    @objc dynamic var isUploading: Bool = false
    
    required init() {
        super.init()
    }
    
    convenience init(message: String, timestamp: NSNumber) {
        self.init()
        self.message = message
        self.timestamp = timestamp.intValue
    }
    
    override static func primaryKey() -> String? {
        return "timestamp"
    }
}

extension LogsModel {
    class func getAllLogsFromDB() -> Results<LogsModel>? {
        do {
            let realm = try Realm()
            return realm.objects(LogsModel.self).filter(NSPredicate(format: "isUploading = %d", false)).sorted(byKeyPath: "timestamp", ascending: true)
        }
        catch let error {
            print("Could not fetch logs from DB, error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func writeLogToDB() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self, update: .modified)
            }
        } catch let error {
            print("Could not write log to DB error: \(error.localizedDescription)")
        }
    }
    
    class func deleteLogFromDB(timestamp: NSNumber) {
        do {
            let realm = try Realm()
            try realm.write {
                let logsList = realm.objects(LogsModel.self).filter("timestamp = %@", timestamp.intValue)
                if let log = logsList.first {
                    realm.delete(log)
                }
            }
        }
        catch let error {
            print("Could not delete log from DB error: \(error.localizedDescription)")
        }
    }
    
    class func deleteAllLogsFromDB() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(LogsModel.self).filter(NSPredicate(format: "isUploading = %d", true)))
            }
        }
        catch let error {
            print("Could not delete all logs from database: ", error.localizedDescription)
        }
    }
}
