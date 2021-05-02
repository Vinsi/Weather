//
//  ForecastRepository.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation
import Moya

final class ForeCastRepository: RepositoryType {
    
    typealias Result = ForeCastModel?
    private var provider: MoyaProvider<OpenWeatherMapAPI> = MoyaProvider<OpenWeatherMapAPI>()
    
    convenience init(provider: MoyaProvider<OpenWeatherMapAPI> = MoyaProvider<OpenWeatherMapAPI>()) {
        self.init()
        self.provider = provider
    }
    
    func get(city: String, onCompletion: @escaping RepoResultCallBack) {

        provider.request(.forcast(city: city), completion: { (result) in
            switch result {
            case .success(let response):
                
                do {
                    let results: ForeCastModel = try JSONDecoder().decode(ForeCastModel.self, from: response.data)
                    onCompletion(true, results)
                }
                catch _ {
                    onCompletion(false, nil)
                }
            default:
                onCompletion(false, nil)
            }
            
        })
    }
}

final class SearchRepository: RepositoryType {
    
    typealias Result = CurrentCityWeatherModel?
    private var provider: MoyaProvider<OpenWeatherMapAPI>?
    
    convenience init(provider: MoyaProvider<OpenWeatherMapAPI> = MoyaProvider<OpenWeatherMapAPI>()) {
        self.init()
        self.provider = provider
    }
    
    func get(cityID: String, onCompletion: @escaping RepoResultCallBack) {
       
        provider?.request(.current(cityId: cityID), completion: { (result) in
            switch result {
            case .success(let response):
                
                do {
                    let results: CurrentCityWeatherModel = try JSONDecoder().decode(CurrentCityWeatherModel.self, from: response.data)
                    onCompletion(true, results)
                }
                catch _ {
                    onCompletion(false, nil)
                }
            default:
                onCompletion(false, nil)
            }
        })
    }
}
