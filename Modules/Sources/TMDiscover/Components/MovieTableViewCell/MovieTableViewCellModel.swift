//
//  MovieTableViewCellModel.swift
//  TMDiscover
//

import Foundation

struct MovieTableViewCellModel: Hashable, Equatable {
    let movieId: MovieId
    
    let thumbnailURL: URL?
    let title: String
    let releaseDate: String
}
