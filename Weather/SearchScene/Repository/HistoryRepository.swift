//
//  HistoryRepository.swift
//  Weather
//
//  Created by Vinsi on 02/05/2021.
//

import Foundation

final class HistoryRepository: RepositoryType {
    typealias Result = [String]
  
    func getAll(onCompletion: (Bool, [String]) -> ()) {
        let keys =  UserDefaults.standard.object(forKey:"keyword") as? [String]
        onCompletion(true, keys ?? [])
    }
    
    func deleteAll() {
        UserDefaults.standard.set([], forKey: "keyword")
    }
    
    func insert(keyword: String) {
       var keys = UserDefaults.standard.object(forKey: "keyword") as? [String]
        keys?.append(keyword)
        UserDefaults.standard.setValue(keys, forKey: "keyword")
    }
}
