//
//  AppLocale.swift
//  TMCore
//

import Foundation
import TMResources

public let getAppLocale = dependencyContainer.bind(
    AppLocaleType.self,
    to: { AppLocale() }
)

public protocol AppLocaleType {
    var identifier: String { get }
}

struct AppLocale {
    let identifier: String
    
    init(locale: Locale = .current) {
        if
            let regionCode = locale.regionCode,
            let languageCodeBase = L10n.languageCode.split(separator: "-").first
        {
            identifier = [
                String(languageCodeBase),
                regionCode.uppercased()
            ].joined(separator: "-")
        } else {
            identifier = L10n.languageCode
        }
    }
}

extension AppLocale: AppLocaleType {}

public extension Locale {
    static let application = Locale(identifier: getAppLocale().identifier)
}
