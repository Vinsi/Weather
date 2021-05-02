//
//  JsonUtility.swift
//  Weather
//
//  Created by Vinsi on 01/05/2021.
//

import Foundation
class JsonUtility {
    
    func dataFromFile(named fileName: String) throws ->  Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    func decodeFromJson<T:Codable>(named fileName: String, type: T.Type) throws -> T? {
        guard let data = try dataFromFile(named: fileName) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
