//
//  MoviesTarget+TargetType.swift
//  TMAPI
//

import Foundation
import Moya

extension MoviesTarget: TargetType {
    var baseURL: URL {
        BaseURLProvider.baseURL.appendingPathComponent("3/movie")
    }
    
    var path: String {
        switch self {
        case let .movieDetails(movieId):
            return "\(movieId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movieDetails:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .movieDetails:
            return .tmRequestParametersDefault
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
