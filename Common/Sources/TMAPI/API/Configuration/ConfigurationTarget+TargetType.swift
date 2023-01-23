//
//  ConfigurationTarget+TargetType.swift
//  TMAPI
//

import Foundation
import Moya

extension ConfigurationTarget: TargetType {
    var baseURL: URL {
        BaseURLProvider.baseURL.appendingPathComponent("3/configuration")
    }
    
    var path: String {
        switch self {
        case .getAPIConfiguration:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAPIConfiguration:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAPIConfiguration:
            return .tmRequestParametersDefault
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
