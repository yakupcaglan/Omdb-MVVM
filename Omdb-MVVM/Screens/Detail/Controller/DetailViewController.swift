//
//  DetailViewController.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class DetailViewController: BaseViewController<DetailView> {
    
    // MARK:- Life Cycle
    
    private var viewModel: DetailViewModelProtocol

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        return indicator
    }()
    
    public required init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.largeTitleDisplayMode = .never
        setupIndicator()
        
        configureNavigationBar()
        viewModel.delegate = self
        viewModel.loadMovieDetail()

    }
    
    // MARK:- Helpers
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupIndicator() {
        view.add(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: - DetailViewDelegate

extension DetailViewController: DetailViewModelDelegate {
    func setLoading(loading: Bool) {
        DispatchQueue.main.async {
            loading ? self.indicator.startAnimating() : self.indicator.stopAnimating()
        }
    }
    
    func movieDidLoad(_ movie: MovieDetailResponse) {
        DispatchQueue.main.async {
            self.layoutableView.configure(with: movie)
        }
    }
}
