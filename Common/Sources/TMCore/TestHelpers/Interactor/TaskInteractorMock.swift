//
//  TaskInteractorMock.swift
//  TMCore
//

import Foundation

#if DEBUG

protocol AnyTask {
    func awaitForResult() async
}

extension Task: AnyTask {
    func awaitForResult() async {
        _ = await result
    }
}

public final class TaskInteractorMock {
    private var taskHistory: [AnyTask] = []
    
    public func awaitAllTasks() async {
        for task in taskHistory {
            await task.awaitForResult()
        }
    }
    
    public init() {}
}

// MARK: - TaskInteractorType

extension TaskInteractorMock: TaskInteractorType {
    
    public func runTask<Success>(
        operation: @escaping @Sendable () async -> Success
    ) -> Task<Success, Never> where Success : Sendable {
        let task = Task(operation: operation)
        taskHistory.append(task)
        return task
    }
}

#endif
