//
//  Window.swift
//  TMUI
//

import UIKit
import TMCore

public let getWindow = dependencyContainer.bind(
    WindowType.self,
    to: { UIWindow.shared }
)

public protocol WindowType: AnyObject {
    var rootViewController: UIViewController? { get set }
    
    func makeKeyAndVisible()
}

extension UIWindow: WindowType {}

extension UIWindow {
    static let shared = UIWindow(frame: UIScreen.main.bounds)
}
