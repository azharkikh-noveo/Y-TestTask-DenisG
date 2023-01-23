//
//  MovieDetailsPresenterSpec.swift
//  TMDiscoverTests
//

import Foundation
import TMCore
import Quick
import Nimble
import TMModuleCommon
import TMUI
import TMResources

@testable import TMDiscover

final class MovieDetailsPresenterSpec: QuickSpec {
    
    override func spec() {
        describe("MovieDetailsPresenter") {
            var imageURLInteractor: ImageURLInteractorMock!
            var loadMovieDetailsInteractor: LoadMovieDetailsInteractorMock!
            var taskInteractor: TaskInteractorMock!
            var errorInteractor: AlertErrorInteractorMock!
            
            var sut: MovieDetailsPresenter!
            var testView: MovieDetailsPresenter.TestView!
            
            afterEach {
                sut = nil
                
                dependencyContainer.unmock()
            }
            
            beforeEach {
                imageURLInteractor = dependencyContainer.mock(
                    ImageURLInteractorType.self,
                    to: ImageURLInteractorMock()
                )
                loadMovieDetailsInteractor = dependencyContainer.mock(
                    LoadMovieDetailsInteractorType.self,
                    to: LoadMovieDetailsInteractorMock()
                )
                taskInteractor = dependencyContainer.mock(
                    TaskInteractorType.self,
                    to: TaskInteractorMock()
                )
                errorInteractor = dependencyContainer.mock(
                    AlertErrorInteractorType.self,
                    to: AlertErrorInteractorMock()
                )
                
                testView = MovieDetailsPresenter.TestView()
                sut = MovieDetailsPresenter(
                    movieId: 123,
                    view: testView,
                    router: .empty
                )
            }
            
            context("loading returns value") {
                let movieDetails = Seeds.MovieDetails.default
                
                beforeEach {
                    sut.viewDidLoad()
                    imageURLInteractor._getPosterURL = Seeds.URL.default
                    loadMovieDetailsInteractor._getMovieDetails.send(value: movieDetails)
                    await taskInteractor.awaitAllTasks()
                }
                
                it("calls loadMovieDetailsInteractor") {
                    expect(loadMovieDetailsInteractor.getMovieDetailsCalls).to(equal([123]))
                }
                
                it("has correct properties") {
                    expect(testView.titles).to(equal([movieDetails.title]))
                    expect(testView.posterImageURLs).to(equal([Seeds.URL.default]))
                    if let releaseYear = movieDetails.releaseYear {
                        expect(testView.releaseDates).to(equal([L10n.MovieDetails.releaseYear(releaseYear)]))
                    } else {
                        expect(testView.releaseDates).to(beEmpty())
                    }
                    expect(testView.descriptions).to(equal([movieDetails.overview]))
                }
            }
            
            context("loading returns error") {
                let error = TestError()
                beforeEach {
                    sut.viewDidLoad()
                    loadMovieDetailsInteractor._getMovieDetails.throwError(error: error)
                    await taskInteractor.awaitAllTasks()
                }
                
                it("calls loadMovieDetailsInteractor") {
                    expect(loadMovieDetailsInteractor.getMovieDetailsCalls).to(equal([123]))
                }
                
                it("routes an error") {
                    expect(errorInteractor.showErrorCalls).to(equal([error.localizedDescription]))
                }
            }
        }
    }
}

// MARK: - TestView

private extension MovieDetailsPresenter {
    
    final class TestView: MovieDetailsUnit.View {
        
        private(set) var titles: [String] = []
        private(set) var posterImageURLs: [URL] = []
        private(set) var releaseDates: [String] = []
        private(set) var descriptions: [String] = []
        
        func setTitle(title: String) {
            titles.append(title)
        }
        
        func setPosterImageURL(url: URL) {
            posterImageURLs.append(url)
        }
        
        func setReleaseDate(releaseDate: String) {
            releaseDates.append(releaseDate)
        }
        
        func setDescription(description: String) {
            descriptions.append(description)
        }
    }
}
