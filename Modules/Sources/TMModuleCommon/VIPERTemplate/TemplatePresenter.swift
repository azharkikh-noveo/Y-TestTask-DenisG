//
//  TemplatePresenter.swift
//  TMModuleCommon
//

import Foundation

protocol TemplatePresenterType {
    func viewDidLoad()
}

final class TemplatePresenter {
    typealias Unit = TemplateUnit
    
    private weak var view: Unit.View?
    private let router: Unit.Router
    
    init(view: Unit.View, router: Unit.Router) {
        self.view = view
        self.router = router
    }
}

// MARK: - TemplatePresenterType

extension TemplatePresenter: TemplatePresenterType {
    func viewDidLoad() {}
}
