//
//  NetworkService.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/21/20.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(for searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(searchText)" // URL адрес, по которому делаем запрос на сервер
        let params = ["term" : "\(searchText)", "limit" : "20", "media" : "music"]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { dataResponse  in
            AF.request(url).responseData { (dataResponse) in // делаем запрос и получаем данные с него в dataResponse
                if let error = dataResponse.error {
                    print (error.localizedDescription)
                    completion(nil)
                    return
                }
                
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    completion(objects)
                } catch let error as NSError{
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
    
    
}
