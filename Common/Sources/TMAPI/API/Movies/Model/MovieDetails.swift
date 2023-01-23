//
//  MovieDetails.swift
//  TMAPI
//

import Foundation

public struct MovieDetails: TMAPIModel, Decodable {
    public let id: MovieId
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let releaseDate: String?
    
    public init(id: MovieId, title: String, overview: String, posterPath: String?, releaseDate: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}
