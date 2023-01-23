//
//  MovieDetailsScene.swift
//  TMDiscover
//

import UIKit
import TMModuleCommon

enum MovieDetailsUnit: UnitType {
    typealias Event = Never
    typealias View = MovieDetailsViewType
    typealias Presenter = MovieDetailsPresenterType
}

public final class MovieDetailsScene {
    public typealias RouterType = AnyRouter<Never>
    
    private let movieDetailsViewController: MovieDetailsViewController
    private let movieDetailsPresenter: MovieDetailsPresenter
    
    public init(movieId: MovieId) {
        movieDetailsViewController = StoryboardScene.MovieDetailsViewController.movieDetailsViewController.instantiate()
        movieDetailsPresenter = MovieDetailsPresenter(
            movieId: movieId,
            view: movieDetailsViewController,
            router: AnyRouter.empty
        )
        movieDetailsViewController.presenter = movieDetailsPresenter
    }
}

// MARK: - Scene

extension MovieDetailsScene: Scene {
    public var viewController: UIViewController {
        movieDetailsViewController
    }
}
