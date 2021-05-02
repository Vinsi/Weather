//
//  WeatherService.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation
import Moya

enum OpenWeatherMapAPI {
    case forcast(city: String)
    case current(cityId: String)
    
    var version: String {
        "2.5"
    }
}

extension OpenWeatherMapAPI: TargetType {
    
    var url: String {
        [AppConfiguration.shared.selectedEnvironment.apiPath,
         version].joined(separator: "/")
    }
    
    var queryParameter: String {
        var params = [String:String]()
        params["appid"] = AppConfiguration.shared.selectedEnvironment.token
        params["units"] = "metric"
        
        switch self {
        case .forcast(let city):
            params["q"] = city
        case .current( let cityID):
            params["id"] = cityID
        }
        return params.reduce("") {
            $0 + "\($1.0)=\($1.1)&"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: url + "?" + queryParameter) else {
            fatalError("baseURL not found")
        }
        return url
    }
    
    var path: String {
        return "forecast"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["ContentType": "application/json"]
    }
}
