//
//  UIView + Extensions.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

extension UIView {
    
    func add(_ subViews: UIView...) {
        subViews.forEach (addSubview)
    }
}
