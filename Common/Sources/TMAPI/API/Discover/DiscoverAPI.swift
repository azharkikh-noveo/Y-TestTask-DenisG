//
//  DiscoverAPI.swift
//  TMAPI
//

import Foundation
import Moya
import TMCore

public let getDiscoverAPI = dependencyContainer.bind(
    DiscoverAPIType.self,
    to: { DiscoverAPI() }
)

public protocol DiscoverAPIType {
    func getTrendingMovies(page: Int) async throws -> DiscoverMoviesResponse
}

final class DiscoverAPI {
    private let provider = MoyaProvider<DiscoverTarget>(plugins: [NetworkLoggerPlugin.default])
}

extension DiscoverAPI: DiscoverAPIType {
    
    func getTrendingMovies(page: Int) async throws -> DiscoverMoviesResponse {
        try await provider.requestDecodable(.discoverMovies(page: page))
    }
}
