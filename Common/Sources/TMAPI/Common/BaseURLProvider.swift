//
//  BaseURLProvider.swift
//  TMAPI
//

import Foundation
import TMCore
import Moya

enum BaseURLProvider {
    static let baseURL: URL = {
        let host = getAppInfo().theMovieDBHost
        
        var components = URLComponents()
        components.host = host
        components.scheme = "https"
        
        return components.url!
    }()
}
