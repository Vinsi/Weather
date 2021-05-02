//
//  CurrentCityWeatherModel.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation

// MARK: - CurrentCityWeatherModel
struct CurrentCityWeatherModel: Codable {
    
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
}
// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure
        case humidity
    }
}

// MARK: - Sys
extension CurrentCityWeatherModel {
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let message: Double?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
        
        enum CodingKeys: String, CodingKey {
            case type
            case id
            case message
            case country
            case sunrise
            case sunset
        }
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int?
        let main: String?
        let weatherDescription: String?
        let icon: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case main
            case weatherDescription
            case icon
        }
    }
    
}
