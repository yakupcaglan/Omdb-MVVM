//
//  ConnectivityManager.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Alamofire

public enum NetworkConnectionStatus: String {
    case online
    case offline
}

// MARK:- NetworkConntectionStatus

protocol NetworkConntectionProtocol {
    func checkConntection(complation: @escaping (NetworkConnectionStatus) ->Void)
}

// MARK:- ConnectivityMananger

class ConnectivityManager: NetworkConntectionProtocol {
        
    let reachabilityManager = NetworkReachabilityManager()
        
    func checkConntection(complation: @escaping (NetworkConnectionStatus) -> Void) {
        reachabilityManager?.startListening { (status) in
            switch status {
            case .reachable(.cellular):
                complation(.online)
            case .reachable(.ethernetOrWiFi):
                complation(.online)
            case .notReachable:
                complation(.offline)
            case .unknown:
                complation(.offline)
            }
        }
    }
}


