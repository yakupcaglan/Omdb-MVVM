//
//  SearchMovieItem.swift
//  Omdb
//
//  Created by yakup caglan on 13.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

struct SearchMovieItem: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String?
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
