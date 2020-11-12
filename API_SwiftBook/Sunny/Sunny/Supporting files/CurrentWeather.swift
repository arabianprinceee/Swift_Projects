//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Анас Бен Мустафа on 11/12/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temp: Double
    var tempString: String {
        return "\(Int(temp.rounded()))"
    }
    
    
    let feelsLike: Double
    var feeldLikeString: String {
        return "\(Int(feelsLike.rounded()))"
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "smoke.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    init?(currentWeatherData: WeatherJSONModel) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        feelsLike = currentWeatherData.main.feels_like
        conditionCode = currentWeatherData.weather.first!.id
    }
}
