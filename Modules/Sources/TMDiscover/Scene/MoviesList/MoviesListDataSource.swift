//
//  MoviesListDataSource.swift
//  TMDiscover
//

import UIKit

extension MoviesListUnit {
    enum Section {
        case main
    }
    
    enum SectionItem: Hashable, Equatable {
        case loading
        case movie(MovieTableViewCellModel)
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>
}
