//
//  TestError.swift
//  TMCore
//

import Foundation

#if DEBUG

public struct TestError: Error, LocalizedError {
    
    public init() {}
    
    public var errorDescription: String? {
        "Testing error description"
    }
}

#endif
