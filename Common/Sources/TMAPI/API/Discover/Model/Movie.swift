//
//  Movie.swift
//  TMAPI
//

import Foundation

public typealias MovieId = Int

public struct Movie: TMAPIModel, Decodable {
    public let id: MovieId
    public let title: String
    public let releaseDate: String?
    public let posterPath: String?
}
