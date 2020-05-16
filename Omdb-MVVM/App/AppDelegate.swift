//
//  AppDelegate.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        RemoteConfigManager.shared.configure(exprationDuration: 500)
        
        let dependencyContainer = DependencyContainer()
        let splashViewController = dependencyContainer.makeSplashViewController()
        
        setupNavigationBarAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

private extension AppDelegate {
    
    func setupNavigationBarAppearance() {

        let appearance = UINavigationBar.appearance()
        let barButtonAppearance = UIBarButtonItem.appearance()
        
        barButtonAppearance.tintColor = AppStyle.Colors.customYellow
        
        appearance.prefersLargeTitles = true
        appearance.barStyle = .black
        
        appearance.titleTextAttributes = [.foregroundColor: AppStyle.Colors.customYellow,
                                          .font: UIFont(name: "FjallaOne", size: 16)!]
      
        appearance.largeTitleTextAttributes = [.foregroundColor: AppStyle.Colors.customYellow,
                                          .font: UIFont(name: "FjallaOne", size: 38 )!]
        
             
        barButtonAppearance.setTitleTextAttributes([
            .foregroundColor: AppStyle.Colors.customYellow,
            .font: UIFont(name: "FjallaOne", size: 16 )!,
        
        ], for: .normal)
            
        barButtonAppearance.setTitleTextAttributes([
            .foregroundColor: AppStyle.Colors.customYellow.withAlphaComponent(0.5),
            .font: UIFont(name: "FjallaOne", size: 16 )!,

        ], for: .highlighted)
        
    }
}
