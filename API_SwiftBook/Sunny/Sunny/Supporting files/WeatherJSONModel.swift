//
//  WeatherJSONModel.swift
//  Sunny
//
//  Created by Анас Бен Мустафа on 11/12/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

struct WeatherJSONModel : Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Decodable  {
    let temp: Double
    let feels_like: Double
}

struct Weather : Decodable {
    let id: Int
}
