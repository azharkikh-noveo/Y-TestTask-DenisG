//
//  DiscoverTarget+TargetType.swift
//  TMAPI
//

import Foundation
import Moya
import TMCore

extension DiscoverTarget: TargetType {
    
    var baseURL: URL {
        BaseURLProvider.baseURL.appendingPathComponent("3/discover")
    }

    var path: String {
        switch self {
        case .discoverMovies:
            return "movie"
        }
    }

    var method: Moya.Method {
        switch self {
        case .discoverMovies:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case let .discoverMovies(page):
            return .tmRequestParameters(with: ["page": page])
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
