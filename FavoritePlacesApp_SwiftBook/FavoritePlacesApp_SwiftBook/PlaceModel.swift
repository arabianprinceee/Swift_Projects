//
//  PlaceModel.swift
//  FavoritePlacesApp_SwiftBook
//
//  Created by Анас Бен Мустафа on 10/25/20.
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var nameOfPlace : String = ""
    @objc dynamic var location : String?
    @objc dynamic var typeOfPlace : String?
    @objc dynamic var imageData : Data?
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.nameOfPlace = name
        self.location = location
        self.typeOfPlace = type
        self.imageData = imageData
    }
}
