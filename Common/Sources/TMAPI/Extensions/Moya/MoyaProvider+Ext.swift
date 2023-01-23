//
//  MoyaProvider+Ext.swift
//  TMAPI
//

import Foundation
import Moya

extension MoyaProvider {
    /// - Throws: Instance of ``MoyaError``
    func request(
        _ target: Target,
        callbackQueue: DispatchQueue? = .none,
        progress: ProgressBlock? = .none
    ) async throws -> Moya.Response {
        try await withCheckedThrowingContinuation { continuation in
            request(target, callbackQueue: callbackQueue, progress: progress) { result in
                continuation.resume(with: result)
            }
        }
    }
}

extension MoyaProvider {
    
    /// Perform API call with mapping to designated type
    /// - Parameter target: Target of this provider
    /// - Returns: Decoded model
    /// - Throws: ``APIError``
    func requestDecodable<T: TMAPIModel & Decodable>(_ target: Target) async throws -> T {
        do {
            let response = try await self.request(target)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = T.keyDecodingStrategy
            
            return try response.map(T.self, using: decoder)
        } catch {
            throw APIError(error: error)
        }
    }
}
