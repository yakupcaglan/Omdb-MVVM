//
//  AppStyle.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

enum AppStyle {
    
    enum Colors {
        
        static let mainBackgroundColor = UIColor.black
        
        static let customYellow = UIColor.rgb(red: 203, green: 166, blue: 72)
    }
}

enum FirebaseConfigKey {
    static let lodostTextkey = "loodosText"
}
