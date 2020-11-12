//
//  NetWorkWeatherManager.swift
//  Sunny
//
//  Created by Анас Бен Мустафа on 11/11/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import CoreLocation


protocol NetworkWeatherManagerDelegate: class {
    func updateInterface(_: NetWorkWeatherManager, with currentWeather: CurrentWeather)
}


class NetWorkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var delegate: NetworkWeatherManagerDelegate?
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(WeatherAPI)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(WeatherAPI)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    private func performRequest (withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let currentWeather = self.parseJSON(from: data) {
                    self.delegate?.updateInterface(self, with: currentWeather)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(from data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(WeatherJSONModel.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
