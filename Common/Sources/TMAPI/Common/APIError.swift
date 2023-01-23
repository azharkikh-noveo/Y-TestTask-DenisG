//
//  APIError.swift
//  TMAPI
//

import Foundation
import Moya
import TMResources

// MARK: - APIError

public enum APIError: Error {
    case connectionError(ConnectionError)
    case http(HTTPError)
    case other(MoyaError)
    
    public var connectionError: ConnectionError? {
        guard case let .connectionError(connectionError) = self else {
            return nil
        }
        return connectionError
    }
    
    public var isConnectionError: Bool {
        connectionError != nil
    }
}

public enum ConnectionError: Error {
    case noInternet
    case timeout
    case other
}

public struct HTTPError: Error {
    public let code: Int
    public let responseData: Data
    
    public var responseDescription: String? {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: responseData),
            let json = jsonObject as? [String: Any],
            let errors = json["errors"] as? [String]
        else {
            return nil
        }
        
        return errors.first
    }

    public init(code: Int, responseData: Data) {
        self.code = code
        self.responseData = responseData
    }
}

// MARK: - LocalizedError

extension ConnectionError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return L10n.Error.ConnectionError.noInternet
        case .timeout:
            return L10n.Error.ConnectionError.timeout
        case .other:
            return L10n.Error.ConnectionError.other
        }
    }
}

extension APIError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case let .connectionError(error):
            return error.localizedDescription
        case let .http(error):
            let description = [
                L10n.Error.httpError(error.code),
                error.responseDescription?.localizedCapitalized
            ].compactMap { $0 }.joined(separator: " ")
            return description
        case let .other(error):
            return error.errorDescription
        }
    }
}

// MARK: - Init

extension APIError {
    
    public init(error: Error) {
        switch error {
        case let error as APIError:
            self = error
        case let error as MoyaError:
            self = APIError(moyaError: error)
        default:
            assertionFailure("Unable to unwrap error \(type(of: error))")
            self = .other(.underlying(error, nil))
        }
    }
    
    private init(moyaError: MoyaError) {
        if moyaError.unwrap(cond: { $0.isActuallyNoInternetConnectionError }) {
            self = .connectionError(.noInternet)
        } else if moyaError.unwrap(cond: { $0.isActuallyTimeoutError }) {
            self = .connectionError(.timeout)
        } else if moyaError.unwrap(cond: { $0.isActuallyNetworkConnectionError }) {
            self = .connectionError(.other)
        } else if let response = moyaError.response, !(200...299).contains(response.statusCode) {
            let error = HTTPError(
                code: response.statusCode,
                responseData: response.data
            )
            self = .http(error)
        } else {
            self = .other(moyaError)
        }
    }
}

// MARK: - Private - unwrapping error

private extension Error {
    func unwrap(cond: (Error) -> Bool) -> Bool {
        var err: Error = self

        for _ in 0..<5 {
            if cond(err) {
                return true
            }

            if let underlyingAsAFError = err.asAFError?.underlyingError {
                err = underlyingAsAFError
                continue
            }

            if let underlyingAsMoyaError = (err as? MoyaError),
                case .underlying(let error, _) = underlyingAsMoyaError {
                err = error
                continue
            }
        }
        return false
    }
}

private extension Error {
    var isActuallyNoInternetConnectionError: Bool {
        let nsError = self as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet
    }

    var isActuallyTimeoutError: Bool {
        let nsError = self as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorTimedOut
    }

    var isActuallyNetworkConnectionError: Bool {
        let nsError = self as NSError
        return nsError.domain == NSURLErrorDomain
    }
}
