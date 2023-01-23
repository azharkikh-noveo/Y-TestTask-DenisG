//
//  ImageURLInteractorMock.swift
//  TMDiscoverTests
//

import Foundation

#if DEBUG

public final class ImageURLInteractorMock {
    public private(set) var getPosterURLForPosterPathCalls: [String?] = []
    public var _getPosterURL: URL?
    
    public init() {}
}

// MARK: - ImageURLInteractorType

extension ImageURLInteractorMock: ImageURLInteractorType {
    
    public func getPosterURL(posterPath: String?) -> URL? {
        getPosterURLForPosterPathCalls.append(posterPath)
        return _getPosterURL
    }
}

#endif
