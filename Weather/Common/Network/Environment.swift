//
//  Environment.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation

enum Environment: String {
    case production = "prod"
    case staging = "uat"
}

protocol EnvironmentType {
    
    var baseURL: String { get }
    var path: String? { get }
    var apiPath: String { get }
    var token: String { get }
}



final class AppConfiguration {
    
    private var environment: EnvironmentType = Environment.production
    static let shared = AppConfiguration()
    func configure(environment: EnvironmentType) {
        self.environment = environment
    }
        
    var selectedEnvironment: EnvironmentType {
        return environment
    }
}
