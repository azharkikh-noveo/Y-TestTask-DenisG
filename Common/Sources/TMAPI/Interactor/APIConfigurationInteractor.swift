//
//  APIConfigurationInteractor.swift
//  TMAPI
//

import Foundation
import TMCore

public let getAPIConfigurationInteractor = dependencyContainer.bind(
    APIConfigurationInteractorType.self,
    to: { APIConfigurationInteractor.shared }
)

public protocol APIConfigurationInteractorType: AnyObject {
    
    var apiConfiguration: APIConfigurationResponse? { get set }
}

final class APIConfigurationInteractor {
    
    // For the moment, just store it in the memory.
    // Later, we can cache it to UserDefaults (and preload in `init`)
    public var apiConfiguration: APIConfigurationResponse?
    
    static let shared = APIConfigurationInteractor()
}

// MARK: - APIConfigurationInteractorType

extension APIConfigurationInteractor: APIConfigurationInteractorType {}
