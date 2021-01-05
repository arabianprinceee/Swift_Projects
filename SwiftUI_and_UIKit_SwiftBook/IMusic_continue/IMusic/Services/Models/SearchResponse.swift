//
//  SearchResponse.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 1/1/21.
//  Copyright © 2021 Анас Бен Мустафа. All rights reserved.
//

import Foundation


struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}
