//
//  ErrorRouter.swift
//  TMCore
//

import UIKit
import TMAPI
import TMUI
import TMResources

public enum ErrorEvent: Error {
    case genericError(Error)
    case errorWithMessage(String)
    case defaultError
    
    var errorMessage: String {
        switch self {
        case .genericError(let error):
            return error.localizedDescription
        case .errorWithMessage(let message):
            return message
        case .defaultError:
            return L10n.Common.ErrorAlert.defaultMessageBody
        }
    }
}

extension AlertErrorInteractorType {
    public func route(error: ErrorEvent) {
        showError(message: error.errorMessage)
    }
}
