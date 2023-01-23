//
//  TaskInteractor.swift
//  TMCore
//

import Foundation

public let getTaskInteractor = dependencyContainer.bind(
    TaskInteractorType.self,
    to: { TaskInteractor() }
)

public protocol TaskInteractorType {
    @discardableResult
    func runTask<Success: Sendable>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never>
}

final class TaskInteractor {}

extension TaskInteractor: TaskInteractorType {
    @discardableResult
    func runTask<Success: Sendable>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never> {
        return Task(operation: operation)
    }
}
