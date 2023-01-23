//
//  AppInfo.swift
//  TMCore

import Foundation

public let getAppInfo = dependencyContainer.bind(
    AppInfoType.self,
    to: { AppInfo.shared }
)

public protocol AppInfoType {
    var theMovieDBAPIKey: String { get }
    var theMovieDBHost: String { get }
}

public struct AppInfo: AppInfoType {
    static let shared = AppInfo()
    
    public var theMovieDBAPIKey: String {
        value(for: .theMovieDBAPIKey)
    }
    
    public var theMovieDBHost: String {
        value(for: .theMovieDBHost)
    }
}

private extension AppInfo {
    
    func value<T>(for key: AppInfoKey) -> T {
        guard let infoDictionary = Bundle.main.infoDictionary,
              let root = infoDictionary["TrendingMovies"] as? [String: Any],
              let value = root[key.rawValue] as? T
        else {
            fatalError("key \(key.rawValue) of type \(T.self) not found")
        }
        
        return value
    }
}
