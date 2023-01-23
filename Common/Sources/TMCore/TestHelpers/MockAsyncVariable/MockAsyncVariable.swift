//
//  MockAsyncVariable.swift
//  TMCore
//

import Foundation

#if DEBUG

public final class MockAsyncVariable<T> {
    private var value: T!
    private let group = DispatchGroup()
    
    public init() {
        group.enter()
    }
    
    public func send(value: T) {
        self.value = value
        group.leave()
    }
    
    public func async() async -> T {
        await withCheckedContinuation { continuation in
            group.notify(queue: .main) { [self] in
                continuation.resume(returning: value)
            }
        }
    }
}

public final class MockAsyncThrowingVariable<T> {
    private var result: Result<T, Error>!
    private let group = DispatchGroup()
    
    public init() {
        group.enter()
    }
    
    public func send(value: T) {
        result = .success(value)
        group.leave()
    }
    
    public func throwError(error: Error) {
        result = .failure(error)
        group.leave()
    }
    
    public func async() async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            group.notify(queue: .main) { [self] in
                continuation.resume(with: result)
            }
        }
    }
}

#endif
