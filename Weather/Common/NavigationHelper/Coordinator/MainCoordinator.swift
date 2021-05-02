//
//  MainCoordinator.swift
//  Weather
//
//  Created by Vinsi on 29/04/2021.
//

import Foundation
import UIKit

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LandingViewController.create()
        navigationController.pushViewController(vc
                                        , animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for ( index , coordinator ) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        if let controller =  fromVC as? UIViewController {
            //childDidFinish(fromVC.)
        }
    }
}
