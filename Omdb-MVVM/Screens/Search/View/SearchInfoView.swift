//
//  SearchInfoView.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 15.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

final class SearchInfoView: UIView {
    
    // MARK: - Properties
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "There are no results"
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializer

    private func setupViews() {
        add(infoLabel)
    }
    
    private func setupLayout() {
        
        infoLabel.snp.makeConstraints {
            let inset = UIEdgeInsets(top: 60, left: 16, bottom: 0, right: 16)
            $0.centerY.leading.trailing.equalToSuperview().inset(inset)
        }
    }
}
