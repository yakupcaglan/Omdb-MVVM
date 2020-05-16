//
//  DetailViewModel.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

// MARK:- DetailViewModelProtocol

protocol DetailViewModelProtocol {
    
    var delegate: DetailViewModelDelegate? { get set }
    
    func loadMovieDetail()
}

// MARK:- DetailViewDelegate

protocol DetailViewModelDelegate: AnyObject {
    
    func movieDidLoad(_ movie: MovieDetailResponse)
    
    func setLoading(loading: Bool)
}

// MARK:- DetailViewModel

final class DetailViewModel: DetailViewModelProtocol {
    
    weak var delegate: DetailViewModelDelegate?
    
    private let processQueue = DispatchQueue(label: "movie.processQueue", qos: .background)
    
    private var movieNetworkService: MovieNetworkService
    
    private let movieID: String

    
    private var movieDetail: MovieDetailResponse? {
        didSet {
            if let detail = movieDetail {
                delegate?.movieDidLoad(detail)
            }
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            delegate?.setLoading(loading: isLoading)
        }
    }
    
    required init(movieID: String, movieNetworkService: MovieNetworkService) {
        self.movieID = movieID
        self.movieNetworkService = movieNetworkService
    }
    
    // MARK:- Fetch Movies Detail

    func loadMovieDetail() {

        isLoading = true

        processQueue.async {
            self.movieNetworkService.getMovieDetail(movieID: self.movieID) { (result) in
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.movieDetail = response
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
