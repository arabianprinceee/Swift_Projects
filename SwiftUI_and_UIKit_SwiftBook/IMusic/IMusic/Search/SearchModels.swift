//
//  SearchModels.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/22/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case some
        case getTracks(searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case some
        case presentTracks(searchResponse: SearchResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
        case displayTracks(searchViewModel: SearchViewModel)
      }
    }
  }
}

struct SearchViewModel {
    struct Cell : TrackCellViewModel{
        var iconUrlString: String?
        var trackName: String
        var artistName: String
        var collectionName: String?
        var previewUrl: String?
    }
    
    let cells: [Cell]
}
