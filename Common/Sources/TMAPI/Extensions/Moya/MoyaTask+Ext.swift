//
//  MoyaTask+Ext.swift
//  TMAPI
//

import Foundation
import Moya
import TMCore

extension Moya.Task {
    
    static let theMovieDBDefaultParameters = [
        "api_key": getAppInfo().theMovieDBAPIKey,
        "language": getAppLocale().identifier
    ]
    
    static func tmRequestParameters(
        with customParameters: [String: Any],
        encoding: ParameterEncoding = URLEncoding.default
    ) -> Self {
        .requestParameters(parameters: customParameters + theMovieDBDefaultParameters, encoding: encoding)
    }
    
    static var tmRequestParametersDefault: Self {
        tmRequestParameters(with: [:])
    }
}
