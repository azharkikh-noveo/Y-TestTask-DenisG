//
//  AppCoordinator.swift
//  TrendingMovies
//

import UIKit
import TMUI
import TMDiscover
import TMCore
import TMResources

final class AppCoordinator {
    private let window: WindowType
    
    private let rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    init(window: WindowType) {
        self.window = window
    }
    
    func start() {
        let listScene = MoviesListScene(router: moviesListRouter())
        let controller = listScene.viewController
        rootNavigationController.viewControllers = [controller]
        window.rootViewController = rootNavigationController
    }
}

// MARK: - MoviesListSceneRouter

private extension AppCoordinator {
    func moviesListRouter() -> MoviesListScene.RouterType {
        return .init(with: self) { strongSelf, event in
            switch event {
            case let .didSelectMovie(movieId):
                strongSelf.pushMovieDetails(movieId: movieId)
            }
        }
    }
    
    func pushMovieDetails(movieId: MovieId) {
        let scene = MovieDetailsScene(movieId: movieId)
        let viewController = scene.viewController
        rootNavigationController.pushViewController(viewController, animated: true)
    }
}
