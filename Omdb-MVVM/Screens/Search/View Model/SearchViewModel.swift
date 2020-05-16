//
//  SearchViewModel.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

// MARK:- SearchViewModelProtocol

protocol SearchViewModelProtocol: AnyObject {
    
    var delegate: SearchViewModelDelegate? { get set }
    
    var numberOfitems: Int { get }
    
    func item(by index: Int) -> SearchMovieItem?
    
    func searchMovies(with query: String)
}

// MARK:- SearchViewModelDelegate

protocol SearchViewModelDelegate: AnyObject {
    
    func searchMoviesDidChange()
    
    func setLoading(loading: Bool)
}

// MARK:- SearchViewModel

final class SearchViewModel: SearchViewModelProtocol {
    
    weak var delegate: SearchViewModelDelegate?
    
    private let processQueue = DispatchQueue(label: "movie.processQueue", qos: .background)
    
    private var requests: [URLSessionDataTask] = []
    
    private var movieNetworkService: MovieNetworkService
    
    required init(movieNetworkService: MovieNetworkService) {
        self.movieNetworkService = movieNetworkService
    }
    
    var searchMovieItems: [SearchMovieItem] = [] {
        didSet {
            delegate?.searchMoviesDidChange()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            delegate?.setLoading(loading: isLoading)
        }
    }
    
    
    var numberOfitems: Int {
        return searchMovieItems.count
    }
    
    func item(by index: Int) -> SearchMovieItem? {
        let item = searchMovieItems
        guard item.indices.contains(index) else { return nil}
        
        return searchMovieItems[index]
    }
    
    // MARK:- Fetch Movies
    
    func searchMovies(with query: String) {
        
        guard query.trimmingCharacters(in: .whitespaces) != "" else {
            searchMovieItems = [SearchMovieItem]()
            return
        }
        let queryLast = query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        isLoading = true
        
            self.movieNetworkService.searchFilms(query: queryLast) { [weak self] (result) in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch result {
                case .success(let item):
                    self.searchMovieItems = item.search
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        
    }
}


