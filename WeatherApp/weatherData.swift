//
//  weatherData.swift
//  WeatherApp
//
//  Created by Chinmay Bapna on 03/04/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {
    let description : String
    let id : Int
}
