//
//  DependencyContainer.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 15.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

struct DependencyContainer {
    
    private let networkService: MovieNetworkService
    private let remoteConfigManager: RemoteConfigManager
    private let connectivityMananger: ConnectivityManager
    
    init(networkService: MovieNetworkService = .init(),
         remoteConfigManager: RemoteConfigManager = .init(),
         connectivityMananger: ConnectivityManager = .init() ) {
        
        self.networkService = networkService
        self.remoteConfigManager = remoteConfigManager
        self.connectivityMananger = connectivityMananger
    }
}

extension DependencyContainer: ViewControllerFactory {
 
    func makeSearchViewController() -> SearchViewController {
        let viewModel = SearchViewModel(movieNetworkService: MovieNetworkService())
        return SearchViewController(viewModel: viewModel)
    }
    
    func makeDetailViewController(movieID: String) -> DetailViewController {
        let viewModel = DetailViewModel(movieID: movieID, movieNetworkService: MovieNetworkService())
        return DetailViewController(viewModel: viewModel)
    }
    
    func makeSplashViewController() -> SplashViewController {
        let viewModel = SplashViewModel(remoteConfigManeger: remoteConfigManager,
                                        connectivityMananger: ConnectivityManager())
        
        return SplashViewController(viewModel: viewModel)
    }
}
