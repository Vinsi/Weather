//
//  StoryBoarded.swift
//  Weather
//
//  Created by Vinsi on 29/04/2021.
//

import Foundation
import UIKit

protocol StoryBoarded {
    static func create() -> Self
}

extension StoryBoarded {
    
    static func create() -> Self {
        let id = String(describing: self)
        let storyBoard = UIStoryboard(name:"Main",bundle: Bundle.main)
        return storyBoard.instantiateViewController(identifier: id) as! Self
    }
}
