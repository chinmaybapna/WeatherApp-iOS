//
//  weatherModal.swift
//  WeatherApp
//
//  Created by Chinmay Bapna on 03/04/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import Foundation

struct WeatherModal {
    let conditionId : Int
    let cityName : String
    let temperature : Double
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.boult"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
            
        case 700...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
        }
    }
}
