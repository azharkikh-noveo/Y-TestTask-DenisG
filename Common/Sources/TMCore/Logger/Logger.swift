//
//  Logger.swift
//  TMCore
//

import Foundation
import os.log

public let getLogger = dependencyContainer.bind(
    LoggerType.self,
    to: { Logger.shared }
)

public protocol LoggerType {
    func log(level: OSLogType, _ message: String)
}

public extension LoggerType {
    
    func log(_ message: String) {
        log(level: .default, message)
    }
    
    func error(_ message: String) {
        log(level: .error, message)
    }
    
    func debug(_ message: String) {
        log(level: .debug, message)
    }
}

final class Logger {
    static let shared = Logger()
    
    private init() {}
}

// MARK: - LoggerType

extension Logger: LoggerType {
    func log(level: OSLogType, _ message: String) {
        os_log("%@", log: .default, type: level, message)
    }
}
