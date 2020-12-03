//
//  MainCoordinator.swift
//  Omdb-MVVM
//
//  Created by Yakup Çağlan on 3.12.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
   
    let dependencyContainer = DependencyContainer()

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashViewController = dependencyContainer.makeSplashViewController()
        splashViewController.coordinator = self
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(splashViewController, animated: true)
    }
    
    func presentSearch() {
        let searchViewController = dependencyContainer.makeSearchViewController()
        searchViewController.coordinator = self
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func presentDetailView(id: String) {
        let detailViewController = dependencyContainer.makeDetailViewController(movieID: id)
        detailViewController.coordinotor = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
}

