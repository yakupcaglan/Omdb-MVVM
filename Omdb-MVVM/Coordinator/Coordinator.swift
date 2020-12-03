//
//  Coordinator.swift
//  Omdb-MVVM
//
//  Created by Yakup Çağlan on 3.12.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
