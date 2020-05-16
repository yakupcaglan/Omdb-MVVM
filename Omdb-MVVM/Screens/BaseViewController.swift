//
//  BaseViewController.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 15.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class BaseViewController<T: LayoutableView>: LayoutingViewController {
    
    typealias ViewType = T
    
    override func loadView() {
    
        view = ViewType.create()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
