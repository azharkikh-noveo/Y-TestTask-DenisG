//
//  TestError.swift
//  TMCore
//

import Foundation

public struct TestError: Error, LocalizedError {
    
    public init() {}
    
    public var errorDescription: String? {
        "Testing error description"
    }
}
