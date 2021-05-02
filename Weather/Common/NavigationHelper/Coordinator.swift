//
//  Coordinator.swift
//  Weather
//
//  Created by Vinsi on 29/04/2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set}
    func start()
}
