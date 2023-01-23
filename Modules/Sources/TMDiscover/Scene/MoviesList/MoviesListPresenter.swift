//
//  MoviesListPresenter.swift
//  TMDiscover
//

import Foundation
import TMModuleCommon
import TMUI

protocol MoviesListPresenterType {
    func viewDidLoad()
    
    func viewWantsToPrefetch(atLastRow: Int)
    func didSelectMovieCell(model: MovieTableViewCellModel)
}

final class MoviesListPresenter {
    typealias Unit = MoviesListUnit
    
    private weak var view: Unit.View?
    private let router: Unit.Router
    
    private let imageURLInteractor = getImageURLInteractor()
    private let loadMoviesListInteractor = getLoadMoviesListInteractor()
    private let alertErrorInteractor = getAlertErrorInteractor()
    private var loadMoviesListSubscription: SubscriptionToken?
    
    private var allMovieCellModels: [MovieTableViewCellModel] = []
    
    init(view: Unit.View, router: Unit.Router) {
        self.view = view
        self.router = router
    }
}

// MARK: - MoviesListPresenterType

extension MoviesListPresenter: MoviesListPresenterType {
    func viewDidLoad() {
        // Setup subscription
        loadMoviesListSubscription = loadMoviesListInteractor.subscribeForUpdates { [weak self] update in
            guard let strongSelf = self else {
                return
            }
            
            switch update {
            case let .newPage(newPage):
                let newCellModels = strongSelf.moviesToCellModels(movies: newPage)
                strongSelf.allMovieCellModels += newCellModels
                let sectionItems: [MoviesListUnit.SectionItem] =
                    strongSelf.allMovieCellModels.map { .movie($0) } + [.loading]
                strongSelf.view?.setSectionItems(sectionItems)
            case let .error(error):
                strongSelf.alertErrorInteractor.route(error: .genericError(error))
            case .noMoreData:
                // Update view current items, without [.loading] item
                let sectionItems = strongSelf.allMovieCellModels.map { MoviesListUnit.SectionItem.movie($0) }
                strongSelf.view?.setSectionItems(sectionItems)
            }
        }
        
        // And load first page
        loadMoviesListSubscription?.loadNext()
    }
    
    func viewWantsToPrefetch(atLastRow lastRow: Int) {
        // Add 1, because we have additional [.loading] item, if there're more items to be loaded.
        let totalRowsCountInView = allMovieCellModels.count + 1
        
        // Subtract 1, because `lastRow` is index (0-based), and `totalRowsCountInView` is count (1-based)
        if lastRow >= totalRowsCountInView - 1 {
            loadMoviesListSubscription?.loadNext()
        }
    }
    
    func didScrollToBottom() {
        loadMoviesListSubscription?.loadNext()
    }
    
    func didSelectMovieCell(model: MovieTableViewCellModel) {
        router.route(event: .didSelectMovie(movieId: model.movieId))
    }
}

// MARK: - Decomposition

private extension MoviesListPresenter {
    
    func moviesToCellModels(movies: [Movie]) -> [MovieTableViewCellModel] {
        return movies.map { movie in
            let thumbnailURL = imageURLInteractor.getPosterURL(posterPath: movie.posterPath)
            
            return MovieTableViewCellModel(
                movieId: movie.id,
                thumbnailURL: thumbnailURL,
                title: movie.title,
                releaseDate: movie.releaseYear ?? ""
            )
        }
    }
}
