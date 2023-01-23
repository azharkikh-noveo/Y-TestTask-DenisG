//
//  Seeds+MovieDetails.swift
//  TMDiscoverTests
//

import Foundation
import TMCore

@testable import TMDiscover

extension Seeds {
    
    enum MovieDetails {
        static let `default` = create()
    }
}

// MARK: - Helpers

private extension Seeds.MovieDetails {
    
    static func create(
        id: MovieId = 123,
        title: String = "Movie Title",
        overview: String = "Movie description",
        posterPath: String? = "path/to/poster/image",
        releaseDate: String? = "2022-12-12"
    ) -> MovieDetails {
        return MovieDetails(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}
