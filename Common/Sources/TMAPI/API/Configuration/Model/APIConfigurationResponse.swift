//
//  APIConfigurationResponse.swift
//  TMAPI
//

import Foundation

public struct APIConfigurationResponse: TMAPIModel, Decodable {
    public let images: Images
}

public extension APIConfigurationResponse {
    
    enum ImageSize: String, Decodable {
        case original
        case width92 = "w92"
        case width154 = "w154"
        case width185 = "w185"
        case width342 = "w342"
        case width500 = "w500"
        case width780 = "w780"
    }
    
    struct Images: Decodable {
        public let baseUrl: String
        public let secureBaseUrl: String
        public let posterSizes: [ImageSize]
    }
}
