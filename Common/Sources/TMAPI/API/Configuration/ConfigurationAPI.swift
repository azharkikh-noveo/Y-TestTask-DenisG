//
//  ConfigurationAPI.swift
//  TMAPI
//

import Foundation
import Moya
import TMCore

public let getConfigurationAPI = dependencyContainer.bind(
    ConfigurationAPIType.self,
    to: { ConfigurationAPI() }
)

public protocol ConfigurationAPIType {
    func getAPIConfiguration() async throws -> APIConfigurationResponse
}

final class ConfigurationAPI {
    private let provider = MoyaProvider<ConfigurationTarget>(plugins: [NetworkLoggerPlugin.default])
}

extension ConfigurationAPI: ConfigurationAPIType {
    
    func getAPIConfiguration() async throws -> APIConfigurationResponse {
        try await provider.requestDecodable(.getAPIConfiguration)
    }
}
