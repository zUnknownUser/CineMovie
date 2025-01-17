//
//  Model.swift
//  CineMovie
//
//  Created by Lucas Amorim on 17/01/25.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct MovieListResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
}

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
}
