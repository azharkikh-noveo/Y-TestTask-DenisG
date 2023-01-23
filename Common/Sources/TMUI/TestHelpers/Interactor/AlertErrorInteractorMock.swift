//
//  AlertErrorInteractorMock.swift
//  TMUI
//

import Foundation

public final class AlertErrorInteractorMock {
    public private(set) var showErrorCalls: [String] = []
    public private(set) var showRecoverableErrorCalls: [(String, () -> Void)] = []
    
    public init() {}
}

extension AlertErrorInteractorMock: AlertErrorInteractorType {
    public func showError(message: String) {
        showErrorCalls.append(message)
    }
    
    public func showRecoverableError(message: String, didTapOnError: @escaping () -> Void) {
        showRecoverableErrorCalls.append((message, didTapOnError))
    }
}
