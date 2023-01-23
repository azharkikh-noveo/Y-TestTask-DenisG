//
//  LoadMovieDetailsInteractorMock.swift
//  TMDicoverTests
//

import Foundation
import TMCore

@testable import TMDiscover

final class LoadMovieDetailsInteractorMock {
    private(set) var getMovieDetailsCalls: [MovieId] = []
    let _getMovieDetails = MockAsyncThrowingVariable<MovieDetails>()
}

extension LoadMovieDetailsInteractorMock: LoadMovieDetailsInteractorType {
    func getMovieDetails(movieId: MovieId) async throws -> MovieDetails {
        getMovieDetailsCalls.append(movieId)
        
        return try await _getMovieDetails.async()
    }
}
