//
//  SearchResponce.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/21/20.
//

import UIKit

struct SearchResponse : Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track : Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}


