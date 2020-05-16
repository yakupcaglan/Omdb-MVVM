//
//  ViewControllerFactory.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 15.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

protocol ViewControllerFactory {
    func makeSearchViewController() -> SearchViewController
    func makeDetailViewController(movieID: String) -> DetailViewController
    func makeSplashViewController() -> SplashViewController
}
