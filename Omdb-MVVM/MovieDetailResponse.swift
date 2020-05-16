//
//  aa.swift
//  Omdb-MVVM
//
//  Created by yakup caglan on 16.05.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

struct MovieDetailResponse: Decodable {
    let title: String
    let released: String
    let genre: String
    let director: String
    let actors : String
    let plot: String
    let poster: String?
    let imdbRating: String
    let runtime: String
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
        case runtime = "Runtime"
        case country = "Country"
        case imdbRating
    }
}
