//
//  ImageURLInteractor.swift
//  TMModuleCommon
//

import Foundation
import TMAPI
import TMUI
import TMCore

public let getImageURLInteractor = dependencyContainer.bind(
    ImageURLInteractorType.self,
    to: { ImageURLInteractor() }
)

public protocol ImageURLInteractorType {
    func getPosterURL(posterPath: String?) -> URL?
}

final class ImageURLInteractor {
    private let apiConfigurationInteractor = getAPIConfigurationInteractor()
    private let mainScreen = getMainScreen()
    private let logger = getLogger()
}

extension ImageURLInteractor: ImageURLInteractorType {
    
    func getPosterURL(posterPath: String?) -> URL? {
        guard let posterPath = posterPath else {
            logger.debug("PosterPath is missing")
            return nil
        }
        
        guard let apiConfiguration = apiConfigurationInteractor.apiConfiguration else {
            logger.error("APIConfiguration is missing")
            return nil
        }
        
        guard let baseUrl = URL(string: apiConfiguration.images.secureBaseUrl) else {
            logger.error("BaseURL is not URL: \(apiConfiguration.images.secureBaseUrl)")
            return nil
        }
        
        let availableSizes = Set(apiConfiguration.images.posterSizes)
        let appropriateSizesForScreen = mainScreen.appropriateImageSizes
        let firstAppropriateSize = availableSizes.intersection(appropriateSizesForScreen).first
        guard let appropriateSize = firstAppropriateSize else {
            logger.error("No appropriate size found")
            return nil
        }
        
        return baseUrl
            .appendingPathComponent(appropriateSize.rawValue)
            .appendingPathComponent(posterPath)
    }
}

// MARK: - Appropriate size for image

fileprivate extension ScreenType {
    var appropriateImageSizes: Set<APIConfigurationResponse.ImageSize> {
        if size.width <= 320 {
            return [.width342, .width185, .original]
        }
        return [.width342, .width500, .width780, .original]
    }
}
