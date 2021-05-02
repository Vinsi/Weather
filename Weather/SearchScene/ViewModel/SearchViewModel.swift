//
//  SearchViewModel.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation
import RxSwift

protocol CityType {
    
    var id: Int? { get }
    var name: String? { get }
}

struct CityModel: Codable, CityType {
    let id: Int?
    let name: String?
}

final class SearchViewModel {
    let disposeBag = DisposeBag()
    private let searchRepo = SearchRepository()
    private let cityRepo = CityRepository()
    private let historyRepo = HistoryRepository()
    var filterdCities = BehaviorSubject<[CityType]>(value: [])
    private var cities = BehaviorSubject<[CityType]>(value: [])
    private var searchHistoryCity = BehaviorSubject<[String]>(value: [])
    var keyword = BehaviorSubject<String?>(value: nil)
    
    init() {
       let result = Observable.combineLatest(keyword.asObservable(),cities.asObservable()).map { (keyword, cities) -> [CityType] in
            guard let key = keyword else {
                return cities
            }
            return cities.filter { $0.name?.range(of: key, options: .caseInsensitive) != nil
            }
        }
        result.subscribe { [weak self] event in
            if case .next(let cities) = event {
              self?.filterdCities.onNext(cities)
            }
        }.disposed(by: disposeBag)
    }
    func load() {
    }
    
    func loadCities() {
        cityRepo.getAll { success, result in
            cities.onNext(result)
        }
    }
    
    func loadHistory() {
        historyRepo.getAll { success, result  in
            searchHistoryCity.onNext(result)
        }
    }
}
