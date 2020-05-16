//
//  Layouting.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

typealias LayoutingViewController = UIViewController & Layouting

public protocol Layouting: AnyObject {
    
    associatedtype ViewType: UIView & Layoutable
    
    var layoutableView: ViewType { get }
}

public extension Layouting where Self: UIViewController {
    
    var layoutableView: ViewType {
        guard let aView = view as? ViewType else {
            fatalError("view property has not been inialized yet, or not initialized as \(ViewType.self).")
        }
        return aView
    }
}
