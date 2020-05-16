//
//  RemoteConfigManager.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//


import Foundation
import Firebase

// MARK: - RemoteConfigManagerrotocol

protocol RemoteConfigManagerProtocol: AnyObject {

    func configure(exprationDuration: TimeInterval)
    
    func value(forKey key: String)-> String
}

// MARK:- RemoteConfigManager

final class RemoteConfigManager: RemoteConfigManagerProtocol {
   
    static let shared = RemoteConfigManager()
    
    private var remoteConfig: RemoteConfig = {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let appDefaults: [String: Any] = [
            FirebaseConfigKey.lodostTextkey : "Loodos"
        ]
        
        remoteConfig.setDefaults(appDefaults as? [String: NSObject])
        return remoteConfig
    }()
    
    
    func configure(exprationDuration: TimeInterval = 3600.0) {
        
        remoteConfig.fetch(withExpirationDuration: exprationDuration) { (status, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
                        
            RemoteConfig.remoteConfig().activate(completionHandler: nil)
        }
    }
    
    func value(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue!
    }
}
