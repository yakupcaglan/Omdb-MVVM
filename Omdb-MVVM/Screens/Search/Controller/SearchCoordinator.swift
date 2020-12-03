//
//  SearchCoordinator.swift
//  Omdb-MVVM
//
//  Created by Yakup Çağlan on 3.12.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class SearchCoordinator: MainCoordinator {
    func presentDetailView(movieID: String) {
        let detailView = dependencyContainer.makeDetailViewController(movieID: movieID)
        navigationController.pushViewController(detailView, animated: true)
    }
}
