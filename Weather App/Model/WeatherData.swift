//
//  WeatherModel.swift
//  Weather App
//
//  Created by Administrator on 18/06/2023.
//

import Foundation

struct WeatherData : Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Double?
    let wind: Wind?
    let rain: Rain?
    let snow: Snow?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let message: String?
}

struct Coord : Codable {
    let lat: Double
    let lon: Double
}

struct Weather : Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main : Codable {
    let temp: Double
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Double?
    let seaLevel: Double?
    let grndLevel: Double?
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind : Codable {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

struct Rain : Codable {
    let oneHour: Double?
    let threeHour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

struct Clouds : Codable {
    let all: Double
}

struct Snow : Codable {
    let oneHour: Double?
    let threeHour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

struct Sys : Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
