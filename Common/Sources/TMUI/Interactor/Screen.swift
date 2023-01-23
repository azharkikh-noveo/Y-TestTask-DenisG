//
//  Screen.swift
//  TMUI
//

import UIKit
import TMCore

public let getMainScreen = dependencyContainer.bind(
    ScreenType.self,
    to: { UIScreen.main }
)

public protocol ScreenType {
    var size: CGSize { get }
}

extension UIScreen: ScreenType {
    public var size: CGSize {
        bounds.size
    }
}
