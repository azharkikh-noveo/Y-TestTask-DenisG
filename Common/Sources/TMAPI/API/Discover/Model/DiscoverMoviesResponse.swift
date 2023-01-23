//
//  DiscoverMoviesResponse.swift
//  TMAPI
//

import Foundation

public struct DiscoverMoviesResponse: TMAPIModel, Decodable {
    public let page: Int
    public let results: [Movie]
}
