//
//  AppDelegate.swift
//  TrendingMovies
//
//  Created by Denis Gaskov on 11/01/2023.
//

import UIKit
import TMLaunch
import TMUI

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // Must be lazy, in order to be instantiated in `didFinishLaunchingWithOptions`
    private lazy var window = getWindow()
    private lazy var launcher: AppLauncherType? = {
        let launcher = getAppLauncher()
        launcher.delegate = self
        return launcher
    }()
    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        launcher?.launch()
        window.makeKeyAndVisible()
        return true
    }
}

// MARK: - AppLauncherDelegate

extension AppDelegate: AppLauncherDelegate {
    
    func appLauncherDidLaunch(_ launcher: AppLauncherType) {
        let appCoordinator = AppCoordinator(window: window)
        // Retain the AppCoordinator in AppDelegate
        self.appCoordinator = appCoordinator
        // And we can start the main flow.
        appCoordinator.start()
        
        // AppLauncher is not needed anymore, so we can delete it
        self.launcher = nil
    }
}
