//
//  MoviesListViewController.swift
//  TMDiscover
//

import UIKit
import TMUI
import TMResources

protocol MoviesListViewType: AnyObject {
    typealias Unit = MoviesListUnit
    
    func setSectionItems(_ items: [Unit.SectionItem])
}

final class MoviesListViewController: UIViewController {
    typealias Unit = MoviesListUnit
    var presenter: Unit.Presenter!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: MovieTableViewCell.self)
            tableView.register(cellType: LoadingTableViewCell.self)
            dataSource = makeDataSource() // This also assigns dataSource to UITableView
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = MovieTableViewCell.Constants.estimatedHeight
            tableView.delegate = self
            tableView.prefetchDataSource = self
        }
    }
    
    private var dataSource: Unit.DataSource!
}

// MARK: - View events

extension MoviesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
}

// MARK: - MoviesListViewType

extension MoviesListViewController: MoviesListViewType {
    func setSectionItems(_ items: [Unit.SectionItem]) {
        var snapshot = Unit.Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        // Disable animations to have smoother scrollIndicator contentOffset updates
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate

extension MoviesListViewController: UITableViewDelegate {
    
    private func itemIdentifier(at indexPath: IndexPath) -> MoviesListUnit.SectionItem {
        dataSource.snapshot().itemIdentifiers(inSection: .main)[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch itemIdentifier(at: indexPath) {
        case .loading:
            break
        case let .movie(model):
            presenter.didSelectMovieCell(model: model)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch itemIdentifier(at: indexPath) {
        case .loading:
            return false
        case .movie:
            return true
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension MoviesListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastRow = indexPaths.last?.row {
            presenter.viewWantsToPrefetch(atLastRow: lastRow)
        }
    }
}

// MARK: - Helpers

private extension MoviesListViewController {
    
    func makeDataSource() -> Unit.DataSource {
        return Unit.DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .loading:
                let cell: LoadingTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case let .movie(model):
                let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: model)
                return cell
            }
        }
    }
    
    func setup() {
        navigationItem.title = L10n.MoviesList.title
    }
}
