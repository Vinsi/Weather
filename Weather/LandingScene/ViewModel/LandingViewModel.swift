//
//  LandingViewModel.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation
import RxSwift

protocol LandingViewTypeModel {
    
    var date: String { get }
    var temperature: Float  { get }
    var FLTTemperature: Float  { get }
    var maxTemperature: Float { get }
    var minTemperature: Float { get }
    var iconURL: String  { get }
    var mainDescription:  String { get }
    var description: String { get}
    var windSpeed: Float { get }
}

extension List: LandingViewTypeModel {
    
    var date: String {
        return dtTxt ?? ""
    }
    
    var temperature: Float {
        Float(main?.temp ?? 0)
    }
    
    var FLTTemperature: Float {
        Float(main?.tempKf ?? 0)
    }
    
    var maxTemperature: Float {
        Float(main?.tempMax ?? 0)
    }
    
    var minTemperature: Float {
        Float(main?.tempMin ?? 0)
    }
    
    var iconURL: String {
        guard let icon =  weather?.first?.icon else {
            return ""
        }
        return "http://openweathermap.org/img/w/" + icon + ".png"
    }
    
    var mainDescription: String {
        weather?.first?.main?.rawValue ?? ""
    }
    
    var description: String {
        weather?.first?.weatherDescription ?? ""
    }
    
    var windSpeed: Float {
        Float(wind?.speed ?? 0)
    }
}

extension String {
    
    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}

final class LandingViewModel {
    private let disposeBag = DisposeBag()
    private let foreCastRepo = ForeCastRepository()
    let list = BehaviorSubject<[LandingViewTypeModel]>(value: [])
    let title = BehaviorSubject<String> (value: "")

    func load() {
        LocationServiceManager.shared.city.asObserver().subscribe {[weak self] selectedCity in
            guard case .next(.some(let city)) = selectedCity else {
                return
            }
            self?.title.onNext(city.capitalizingFirstLetter)
            self?.loadWeatherInfo(forCity: city )
        }.disposed(by: disposeBag)
    }
    
    func loadWeatherInfo(forCity city: String) {
    
        foreCastRepo.get(city: city) { (success, result) in
            self.list.onNext(result?.list ?? [] )
        }
    }
}

