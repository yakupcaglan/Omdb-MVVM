//
//  SplashViewModel.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

// MARK:- SplashViewModelPorotocl
protocol SplashViewModelPorotocol: AnyObject {
    
    var delegate: SplashViewModelDelegate? { get set }
    
    var value: String { get }
    
    func connectionStatus()
    
    func getValueFromFirabase()
}

protocol SplashViewModelDelegate: AnyObject {
    func checkConnection(isConnect: Bool)
}

// MARK:- SplashViewModel

final class SplashViewModel: SplashViewModelPorotocol {
    
    weak var delegate: SplashViewModelDelegate?

    private let remoteConfigManeger: RemoteConfigManager
    
    private let connectivityMananger: ConnectivityManager
    
    required init(remoteConfigManeger: RemoteConfigManager, connectivityMananger: ConnectivityManager) {
        self.remoteConfigManeger = remoteConfigManeger
        self.connectivityMananger = connectivityMananger
    }

    var value: String {
        return remoteConfigManeger.value(forKey: FirebaseConfigKey.lodostTextkey)
    }

    var isConnect: Bool = false {
        didSet {
            delegate?.checkConnection(isConnect: isConnect)
        }
    }
    
    func connectionStatus() {
        connectivityMananger.checkConntection { (status) in
            switch status {
            case .online:
                self.isConnect = true
            case .offline:
                self.isConnect = false
            }
        }
    }
    
    func getValueFromFirabase() {
        remoteConfigManeger.configure(exprationDuration: 0)
    }
}
