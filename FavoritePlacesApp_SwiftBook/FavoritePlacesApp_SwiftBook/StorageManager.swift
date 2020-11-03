//
//  StorageManager.swift
//  FavoritePlacesApp_SwiftBook
//
//  Created by Анас Бен Мустафа on 10/30/20.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
    
}
