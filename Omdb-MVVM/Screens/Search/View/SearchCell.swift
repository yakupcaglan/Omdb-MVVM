//
//  TVShowCell.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 14.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SDWebImage

final class SearchCell: TableViewCell<SearchMovieItem> {
   
    // MARK:- Load Cell Items
    
    override func updateLayoutItem(_ item: SearchMovieItem?) {
        
        guard let item = item else { return }
        
        self.titleLabel.text = item.title
        self.dateLabel.text = item.year
        self.typeLabel.text = item.type?.capitalized
        
        guard let posterURL = item.poster else { return }
        
        if let url = URL(string: posterURL) {
            self.posterImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "noimage2"))
        }
        
    }
    
    // MARK: - Properties
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FjallaOne", size: 20)
        label.numberOfLines = 2
        label.textColor = AppStyle.Colors.customYellow
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, typeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    

    // MARK: - Setup UI
    
    override func setupViews() {
        backgroundColor = AppStyle.Colors.mainBackgroundColor
        accessoryType = .disclosureIndicator
        add(posterImageView, stackView)
    }
    
    override func setupLayout() {
        
        posterImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.87)
            $0.width.equalToSuperview().multipliedBy(0.27)
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(8)
            $0.trailing.equalTo(-20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview()
        }
    }
}
