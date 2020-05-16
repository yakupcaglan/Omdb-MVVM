//
//  MovieNetworkServiceType.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Alamofire

enum Constants {
    static let omdbAPIKey = "cbcfb5af"
}

protocol MovieNetworkServiceType: AnyObject {
    func searchFilms(query: String, completion: @escaping (Result<SearchResponse, NetworkError>) -> Void)
    func getMovieDetail(movieID: String, completion: @escaping (Result<MovieDetailResponse, NetworkError>) -> Void)
}

public enum NetworkError: Error {
    case invalidURI
    case internalError(AFError)
}

final class MovieNetworkService: MovieNetworkServiceType {
     
    private let requestQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).requestQueue")
  
    private let session: Session
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 30.0
        self.session = Session(configuration: configuration, requestQueue: requestQueue)
    }
    
    public func searchFilms(query: String, completion: @escaping (Result<SearchResponse, NetworkError>) -> Void) {
        session.request(endpoint: Endpoint.search(query: query),
                        dataType: SearchResponse.self,
                        requestQueue: requestQueue,
                        completion: completion)
    }
    
    public func getMovieDetail(movieID: String, completion: @escaping (Result<MovieDetailResponse, NetworkError>) -> Void) {
        session.request(endpoint: Endpoint.getMovieDetail(movieID: movieID),
                        dataType: MovieDetailResponse.self,
                        requestQueue: requestQueue,
                        completion: completion)
    }
}
