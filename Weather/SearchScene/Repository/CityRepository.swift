//
//  CityRepository.swift
//  Weather
//
//  Created by Vinsi on 02/05/2021.
//

import Foundation

final class CityRepository: RepositoryType {
    
    typealias Result = [CityModel]
    func getAll(onCompletion: (Bool, [CityModel]) -> ()) {
        guard let city: [CityModel] = try? JsonUtility().decodeFromJson(named: "city.list", type: [CityModel].self) else {
            onCompletion(false,[CityModel]())
            return
        }
        onCompletion(true, city)
    }
}
