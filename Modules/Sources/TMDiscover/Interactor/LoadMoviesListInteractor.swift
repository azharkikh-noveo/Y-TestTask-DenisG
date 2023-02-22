//
//  LoadMoviesListInteractor.swift
//  TMDiscover
//

import Foundation
import TMCore
import TMAPI

typealias LoadMoviesError = APIError

enum LoadMoviesEvent {
    case newPage([Movie])
    case error(LoadMoviesError)
    case noMoreData
}

let getLoadMoviesListInteractor = dependencyContainer.bind(
    LoadMoviesListInteractorType.self,
    to: { LoadMoviesListInteractor() }
)

protocol LoadMoviesListInteractorType {
    /// Subscribes for data updates.
    /// - Parameter didLoadNextPage: Closure, which will be called when the data is updated.
    /// Includes only new data, you should merge manually with old if needed.
    /// - Parameter didReceiveError: Closure, which will be called when error is occured.
    /// - Returns: Closure, which should be called in order to request new portion of data.
    func subscribeForUpdates(
        update: @MainActor @escaping (LoadMoviesEvent) -> Void
    ) -> SubscriptionToken
}

// MARK: LoadMoviesListInteractor

final class LoadMoviesListInteractor {
    private let discoverAPI = getDiscoverAPI()
    private let logger = getLogger()
    private let taskInteractor = getTaskInteractor()
}

// MARK: - LoadMoviesListInteractorType

extension LoadMoviesListInteractor: LoadMoviesListInteractorType {
    
    func subscribeForUpdates(
        update: @MainActor @escaping (LoadMoviesEvent) -> Void
    ) -> SubscriptionToken {
        
        let pagesLoader = PagesLoader(
            discoverAPI: discoverAPI,
            update: update
        )
        
        return SubscriptionToken(loadNext: { [weak self] in
            self?.taskInteractor.runTask { @MainActor in
                await pagesLoader.loadNextPageIfNeeded()
            }
        })
    }
}

// MARK: - PagesLoader

fileprivate actor PagesLoader {
    private let discoverAPI: DiscoverAPIType
    
    private var nextPageToLoad = 1
    private var isLoading = false
    private let update: @MainActor (LoadMoviesEvent) -> Void
    
    init(
        discoverAPI: DiscoverAPIType,
        update: @MainActor @escaping (LoadMoviesEvent) -> Void
    ) {
        self.discoverAPI = discoverAPI
        self.update = update
    }
    
    func loadNextPageIfNeeded() async {
        if isLoading {
            return
        }
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        guard nextPageToLoad <= Constants.maxPage else {
            await update(.noMoreData)
            return
        }
        
        do {
            let newMovies = try await discoverAPI.getTrendingMovies(page: nextPageToLoad)
            nextPageToLoad = newMovies.page + 1
            await update(.newPage(newMovies.results))
        } catch {
            await update(.error(LoadMoviesError(error: error)))
        }
    }
}

// MARK: - Constants

private extension PagesLoader {
    enum Constants {
        /// According to the [API](https://developers.themoviedb.org/3/discover/movie-discover), maximum is 1000.
        /// Practically, API throws an error if page is bigger then 500
        static let maxPage = 1000
    }
}
