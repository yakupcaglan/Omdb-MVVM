//
//  SearchResponse.swift
//  Omdb
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

struct SearchResponse: Decodable {
    let search: [SearchMovieItem]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
