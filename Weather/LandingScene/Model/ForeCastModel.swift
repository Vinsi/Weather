//
//  ForeCastModel.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation

// MARK: - HybrisProduct
struct ForeCastModel: Codable {
    
    let cod: String?
    let message: Int?
    let cnt: Int?
    let list: [List]?
    let city: City?

    enum CodingKeys: String, CodingKey {
        case cod
        case message
        case cnt
        case list
        case city
    }
}

// MARK: - City
struct City: Codable {
    
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coord
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lat: Double?
    let lon: Double?

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dtTxt: String?
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?

    enum CodingKeys: String, CodingKey {
        case all
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure
        case seaLevel
        case grndLevel
        case humidity
        case tempKf
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod?

    enum CodingKeys: String, CodingKey {
        case pod
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: MainEnum?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?

    enum CodingKeys: String, CodingKey {
        case speed
        case deg
        case gust
    }
}
