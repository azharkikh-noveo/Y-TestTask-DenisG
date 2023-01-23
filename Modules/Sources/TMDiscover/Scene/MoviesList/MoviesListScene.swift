//
//  MoviesListScene.swift
//  TMDiscover
//

import UIKit
import TMModuleCommon

public enum MoviesListSceneEvent {
    case didSelectMovie(movieId: MovieId)
}

enum MoviesListUnit: UnitType {
    typealias Event = MoviesListSceneEvent
    typealias View = MoviesListViewType
    typealias Presenter = MoviesListPresenterType
}

public final class MoviesListScene {
    public typealias RouterType = AnyRouter<MoviesListSceneEvent>
    
    private let moviesListViewController: MoviesListViewController
    private let moviesListPresenter: MoviesListPresenter
    
    public init(router: RouterType) {
        moviesListViewController = StoryboardScene.MoviesListViewController.moviesListViewController.instantiate()
        moviesListPresenter = MoviesListPresenter(
            view: moviesListViewController,
            router: router
        )
        moviesListViewController.presenter = moviesListPresenter
    }
}

// MARK: - Scene

extension MoviesListScene: Scene {
    public var viewController: UIViewController {
        moviesListViewController
    }
}
