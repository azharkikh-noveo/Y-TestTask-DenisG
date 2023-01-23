//
//  MovieDetailsPresenter.swift
//  TMDiscover
//

import Foundation
import TMResources
import TMCore
import TMUI
import TMModuleCommon

protocol MovieDetailsPresenterType {
    func viewDidLoad()
}

final class MovieDetailsPresenter {
    typealias Unit = MovieDetailsUnit
    
    private let movieId: MovieId
    private weak var view: Unit.View?
    private let router: Unit.Router
    
    private let imageURLInteractor = getImageURLInteractor()
    private let loadMoviesDetailsInteractor = getLoadMovieDetailsInteractor()
    private let taskInteractor = getTaskInteractor()
    private let alertErrorInteractor = getAlertErrorInteractor()
    
    init(movieId: MovieId, view: Unit.View, router: Unit.Router) {
        self.movieId = movieId
        self.view = view
        self.router = router
    }
}

// MARK: - MovieDetailsPresenterType

extension MovieDetailsPresenter: MovieDetailsPresenterType {
    func viewDidLoad() {
        taskInteractor.runTask { [self] in
            do {
                let movieDetails = try await loadMoviesDetailsInteractor.getMovieDetails(movieId: movieId)
                configureView(with: movieDetails)
            } catch {
                alertErrorInteractor.route(error: .genericError(error))
            }
        }
    }
}

// MARK: - Helpers

private extension MovieDetailsPresenter {
    func configureView(with details: MovieDetails) {
        view?.setTitle(title: details.title)
        
        if let posterPath = details.posterPath,
           let posterURL = imageURLInteractor.getPosterURL(posterPath: posterPath) {
            view?.setPosterImageURL(url: posterURL)
        }
        
        view?.setDescription(description: details.overview)
        if let releaseYear = details.releaseYear {
            let releaseDate = L10n.MovieDetails.releaseYear(releaseYear)
            view?.setReleaseDate(releaseDate: releaseDate)
        }
    }
}
