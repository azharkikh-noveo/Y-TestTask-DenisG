//
//  TMAPIModel.swift
//  TMAPI
//

import Foundation

protocol TMAPIModel {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension TMAPIModel {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        .convertFromSnakeCase
    }
}
