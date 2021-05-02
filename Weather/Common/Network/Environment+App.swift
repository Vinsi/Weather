//
//  Environment+App.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation

extension Environment: EnvironmentType {
    
    var baseURL: String {
        return "http://api.openweathermap.org"
    }
    
    var path: String? {
        return "data"
    }
    
    var token: String {
        return "ff5985d0cc21520ade2c48c3167a1a8e"
    }
    
    var apiPath: String {
        return [baseURL,path].compactMap({$0}).joined(separator: "/")
    }
}
