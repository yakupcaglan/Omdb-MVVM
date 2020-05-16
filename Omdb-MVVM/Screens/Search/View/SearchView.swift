//
//  HomeView.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SnapKit

final class SearchView: LayoutableView {
   
    // MARK: - Properties
    
    private (set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = AppStyle.Colors.mainBackgroundColor
        tableView.separatorColor = UIColor(white: 0.8, alpha: 0.2)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.tableFooterView = UIView()
        tableView.register(SearchCell.self)
        return tableView
    }()
    
    // MARK:- Setup UI
    
    func setupViews() {
        add(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
}
