//
//  LayoutableView.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

typealias LayoutableView = UIView & Layoutable

public protocol Layoutable: AnyObject {
    func setupViews()
    func setupLayout()
}

extension Layoutable where Self: UIView {
    
    static func create() -> Self {
        
        let view = Self()
        view.backgroundColor = AppStyle.Colors.mainBackgroundColor
        view.setupViews()
        view.setupLayout()
        
        return view
    }
}
