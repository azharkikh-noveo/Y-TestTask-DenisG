//
//  TemplateView.swift
//  TMModuleCommon
//

import UIKit

private struct Constants {}
private let consts = Constants()

protocol TemplateViewType: AnyObject {}

final class TemplateViewController: UIViewController {
    typealias Unit = TemplateUnit
    var presenter: Unit.Presenter!
}

// MARK: - View events

extension TemplateViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - TemplateViewType

extension TemplateViewController: TemplateViewType {}
