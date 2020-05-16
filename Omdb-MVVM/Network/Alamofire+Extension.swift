//
//  Alamofire + Extension.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Alamofire

extension Session {
    
    /// Performs the network request with given parameters.
    ///
    /// - Parameters:
    ///   - endpoint: EndpointType.
    ///   - dataType: Decodable.
    ///   - completion: Result<Decodable, NetworkError>.
    func request<T: EndpointType, E: Decodable>(endpoint: T, dataType: E.Type, requestQueue: DispatchQueue, completion: @escaping (Result<E, NetworkError>) -> Void) {
        guard let endpointURL = endpoint.url else {
            completion(.failure(.invalidURI))
            return
        }
        
        request(endpointURL).responseDecodable(of: E.self, queue: requestQueue) { response in
            if let error = response.error {
                completion(.failure(.internalError(error)))
            } else if  let value = response.value {
                completion(.success(value))
            }
        }
    }
}

protocol EndpointType {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

enum Endpoint: EndpointType {
    case search(query: String)
    case getMovieDetail(movieID: String)
    
    var baseURL: URL {
        return URL(string: "https://omdbapi.com/")!
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .search(query):
            return [URLQueryItem(name: "s", value: query)]
        case let .getMovieDetail(movieID):
            return [URLQueryItem(name: "i", value: movieID)]
        }
    }
}

extension EndpointType {
    
    /// Returns the builded endpoint URL.
    var url: URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        let apiKeyItem = URLQueryItem(name: "apikey", value: Constants.omdbAPIKey)
        let finalQueryItems = queryItems + [apiKeyItem]
        components?.queryItems = finalQueryItems
        return components?.url
    }
}

