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
        case getTracks(searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case presentTracks(searchResponse: SearchResponse?)
        case presentFooterView
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayTracks(searchViewModel: SearchViewModel)
        case displayFooterVIew
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
