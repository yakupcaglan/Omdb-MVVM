//
//  SplashView.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class SplashView: LayoutableView {
    
    // MARK:- Update Items
    func configure(value: String) {
        label.text = value
    }
    
    // MARK:- Properties

    private lazy var label = UILabel()
    
    func setupViews() {
        backgroundColor = .black
        label.textColor = .white
        add(label)
    }
    
    func setupLayout() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
