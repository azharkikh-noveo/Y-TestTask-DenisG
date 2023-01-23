//
//  TemplateScene.swift
//  TMModuleCommon
//

import UIKit

enum TemplateSceneEvent {
    case didSelectItem
}

enum TemplateUnit: UnitType {
    typealias Event = TemplateSceneEvent
    typealias View = TemplateViewType
    typealias Presenter = TemplatePresenterType
}

final class TemplateScene {
    typealias RouterType = AnyRouter<TemplateSceneEvent>
    
    private let templateViewController: TemplateViewController
    private let templatePresenter: TemplatePresenter
    
    init(router: RouterType) {
        // Or, instantiate from StoryboardScene
        templateViewController = TemplateViewController()
        templatePresenter = TemplatePresenter(
            view: templateViewController,
            router: router
        )
        templateViewController.presenter = templatePresenter
    }
}

// MARK: - Scene

extension TemplateScene: Scene {
    var viewController: UIViewController {
        templateViewController
    }
}
