//
//  MovieTableViewCell.swift
//  TMDiscover
//

import UIKit
import TMUI
import TMResources

final class MovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .preferredFont(forTextStyle: .callout)
        }
    }
    @IBOutlet private weak var releaseDateLabel: UILabel! {
        didSet {
            releaseDateLabel.font = .preferredFont(forTextStyle: .footnote)
        }
    }
    
    static var bundle: Bundle {
        .module
    }
}

// MARK: - Cell configuration

extension MovieTableViewCell {
    
    func configure(with model: MovieTableViewCellModel) {
        // Reset image first
        thumbnailImageView.image = Images.placeholder.image
        
        titleLabel.text = model.title
        releaseDateLabel.text = model.releaseDate
        
        if let thumbnailURL = model.thumbnailURL {
            thumbnailImageView.setImage(from: thumbnailURL)
        }
    }
}

extension MovieTableViewCell {
    enum Constants {
        static let estimatedHeight: CGFloat = 80
    }
}
