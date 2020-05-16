//
//  DetailView.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import Firebase

final class DetailView: LayoutableView {
    
    // MARK:- Update Movie Detail
    
    func configure(with movie: MovieDetailResponse) {
        self.titleLabel.text = movie.title
        self.dateLabel.text = "• \(movie.released)"
        self.countryLabel.text = "• \(movie.country)"
        self.genreLabel.text = "• \(movie.genre)"
        self.imdbRate.text = "• Ratings \(movie.imdbRating)"
        self.runtimeLabel.text = "• \(movie.runtime)"
        self.overViewText.text = movie.plot
        
        guard let posterURL = movie.poster else { return }
        
        if let url = URL(string: posterURL) {
            posterImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "noimage2"))
            posterImageBlur.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "aslankral"))
        }
        
        let parameters = [
                 "movieTitle": movie.title,
                 "movieYear": movie.released,
                 "movieGenre": movie.genre,
        ]
        
        Analytics.logEvent("openedMovie", parameters: parameters)
    }
    
    // MARK:- Properties
    
    lazy var topContainerView = UIView()
    
    private lazy var bottomContainerview: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
    private lazy var posterImageBlur = UIImageView()
    
    private lazy var posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 12
        return imageview
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "FjallaOne", size: 30)
        label.numberOfLines = 2
        label.textColor = AppStyle.Colors.customYellow
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, runtimeLabel, imdbRate])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var imdbRate: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview:"
        label.font = UIFont(name: "FjallaOne", size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var overViewText: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.backgroundColor = .black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.isSelectable = false
        return textView
    }()
    
    // MARK:- Setup UI
    
    func setupViews() {

        add(topContainerView,bottomContainerview)
        topContainerView.add(posterImageBlur, blurView,
                             posterImageView, titleLabel,
                             stackView, countryLabel, genreLabel)
        
        bottomContainerview.add(overviewLabel, overViewText)
        
        
    }
    
    func setupLayout() {
        topContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.69)
        }
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageBlur.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.82)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.trailing.equalTo(-12)
            $0.leading.equalTo(12)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(12)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(8)
            $0.leading.equalTo(stackView.snp.leading)
        }
        
        countryLabel.snp.makeConstraints {
            $0.centerY.equalTo(genreLabel)
            $0.leading.equalTo(genreLabel.snp.trailing).offset(10)
        }

        bottomContainerview.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.31)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }

        overviewLabel.snp.makeConstraints {
            $0.top.leading.equalTo(20)
        }

        overViewText.snp.makeConstraints {
            let inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            $0.top.equalTo(overviewLabel.snp.bottom).offset(8)
            $0.leading.bottom.centerX.trailing.equalToSuperview().inset(inset)
        }
    }
}
