//
//  MoviesAPI.swift
//  TMAPI
//

import Foundation
import Moya
import TMCore

public let getMoviesAPI = dependencyContainer.bind(
    MoviesAPIType.self,
    to: { MoviesAPI() }
)

public protocol MoviesAPIType {
    func getMovieDetails(movieId: MovieId) async throws -> MovieDetails
}

final class MoviesAPI {
    private let provider = MoyaProvider<MoviesTarget>(plugins: [NetworkLoggerPlugin.default])
}

extension MoviesAPI: MoviesAPIType {
    
    func getMovieDetails(movieId: MovieId) async throws -> MovieDetails {
        try await provider.requestDecodable(.movieDetails(movieId: movieId))
    }
}
