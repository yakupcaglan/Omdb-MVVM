//
//  Alertable.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

protocol Alertable {
    func showAlert(title: String, message:String, actions: UIAlertAction...)
}

extension Alertable where Self: UIViewController {
    
    func showAlert(title: String, message:String, actions: UIAlertAction...){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach {
            alertController.addAction($0)
        }
        present(alertController, animated: true, completion: nil)
    }
}
