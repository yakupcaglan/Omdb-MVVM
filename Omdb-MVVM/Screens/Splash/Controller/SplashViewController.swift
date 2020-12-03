//
//  SplashViewController.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

final class SplashViewController: BaseViewController<SplashView> {
    
    var coordinator: MainCoordinator?
    
    // MARK:- Properties
    
    private let viewModel: SplashViewModelPorotocol
    
    // MARK:- Life Cycle

    required init(viewModel: SplashViewModelPorotocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.connectionStatus()
        layoutableView.configure(value: viewModel.value)
    }
}

extension SplashViewController: SplashViewModelDelegate {
    
    func checkConnection(isConnect: Bool) {
        if !isConnect {
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            self.showAlert(title: "Warning", message: "Internet not connected", actions: action)
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.coordinator?.presentSearch()
            }
        }
    }
}

extension SplashViewController: Alertable { }
