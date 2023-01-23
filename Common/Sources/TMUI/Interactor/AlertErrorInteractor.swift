//
//  AlertErrorInteractor.swift
//  TMModuleCommon
//

import UIKit
import TMCore
import TMResources
import SwiftMessages

public let getAlertErrorInteractor = dependencyContainer.bind(
    AlertErrorInteractorType.self,
    to: { AlertErrorInteractor() }
)

public protocol AlertErrorInteractorType {
    func showError(message: String)
    func showRecoverableError(message: String, didTapOnError: @escaping () -> Void)
}

final class AlertErrorInteractor {}

// MARK: - AlertErrorInteractorType

extension AlertErrorInteractor: AlertErrorInteractorType {
    func showError(message: String) {
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.error)
        view.button?.isHidden = true
        view.configureContent(title: L10n.Common.ErrorAlert.title, body: message)
        
        SwiftMessages.show(view: view)
    }
    
    func showRecoverableError(message: String, didTapOnError: @escaping () -> Void) {
        let message = message + ". " + L10n.Common.ErrorAlert.tapToRetry
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.warning)
        view.button?.isHidden = true
        view.configureContent(
            title: L10n.Common.ErrorAlert.title,
            body: message,
            iconImage: UIImage(systemName: "arrow.clockwise.circle") ?? Images.placeholder.image
        )
        
        view.tapHandler = { _ in
            SwiftMessages.hide()
            didTapOnError()
        }
        
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        
        SwiftMessages.show(config: config, view: view)
    }
}
