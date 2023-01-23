//
//  AppLauncher.swift
//  TMLaunch
//

import UIKit
import TMCore
import TMUI
import TMAPI
import TMResources

public let getAppLauncher = dependencyContainer.bind(
    AppLauncherType.self,
    to: { AppLauncher() }
)

public protocol AppLauncherDelegate: AnyObject {
    func appLauncherDidLaunch(_ launcher: AppLauncherType)
}

public protocol AppLauncherType: AnyObject {
    var delegate: AppLauncherDelegate? { get set }
    func launch()
}

final class AppLauncher {
    private let window = getWindow()
    private let configurationAPI = getConfigurationAPI()
    private let apiConfigurationInteractor = getAPIConfigurationInteractor()
    private let alertErrorInteractor = getAlertErrorInteractor()
    private let logger = getLogger()
    private let taskInteractor = getTaskInteractor()
    
    public weak var delegate: AppLauncherDelegate?
    
    private weak var loadingVC: LoadingScreenViewController?
}

// MARK: - AppLauncherType

extension AppLauncher: AppLauncherType {
    
    func launch() {
        let loadingVC = StoryboardScene.LoadingScreen.loadingScreenViewController.instantiate()
        window.rootViewController = loadingVC
        self.loadingVC = loadingVC
        
        preloadDataIfNeeded()
    }
}

// MARK: - Decomposition

private extension AppLauncher {
    
    func preloadDataIfNeeded() {
        guard apiConfigurationInteractor.apiConfiguration == nil else {
            logger.debug("Configuration already exists")
            delegate?.appLauncherDidLaunch(self)
            return
        }
        
        taskInteractor.runTask { @MainActor [self] in
            loadingVC?.indicateActivity(true)
            
            do {
                let configuration = try await configurationAPI.getAPIConfiguration()
                apiConfigurationInteractor.apiConfiguration = configuration
                logger.debug("Configuration loaded and stored.")
                delegate?.appLauncherDidLaunch(self)
            } catch {
                let error = APIError(error: error)
                showError(error: error)
            }
            
            loadingVC?.indicateActivity(false)
        }
    }
    
    func showError(error: APIError) {
        let errorMessage = error.localizedDescription
        
        if error.isConnectionError {
            alertErrorInteractor.showRecoverableError(
                message: errorMessage,
                didTapOnError: { [weak self] in
                    self?.preloadDataIfNeeded()
                }
            )
        } else {
            alertErrorInteractor.showError(message: errorMessage)
        }
    }
}
