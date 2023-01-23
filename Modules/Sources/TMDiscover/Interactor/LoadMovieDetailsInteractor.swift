//
//  LoadMovieDetailsInteractor.swift
//  TMDiscover
//

import Foundation
import TMCore
import TMAPI

let getLoadMovieDetailsInteractor = dependencyContainer.bind(
    LoadMovieDetailsInteractorType.self,
    to: { LoadMovieDetailsInteractor() }
)

protocol LoadMovieDetailsInteractorType {
    func getMovieDetails(movieId: MovieId) async throws -> MovieDetails
}

final class LoadMovieDetailsInteractor {
    private let moviesAPI = getMoviesAPI()
}

extension LoadMovieDetailsInteractor: LoadMovieDetailsInteractorType {
    func getMovieDetails(movieId: MovieId) async throws -> MovieDetails {
        try await moviesAPI.getMovieDetails(movieId: movieId)
    }
}
