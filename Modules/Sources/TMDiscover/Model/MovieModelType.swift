//
//  MovieModelType.swift
//  TMDiscover
//

import Foundation

protocol MovieModelType {
    var releaseDate: String? { get }
}

extension MovieModelType {
    var releaseYear: String? {
        releaseDate?.split(separator: "-").first.map(String.init)
    }
}

extension Movie: MovieModelType {}
extension MovieDetails: MovieModelType {}
