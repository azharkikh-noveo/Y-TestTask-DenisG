//
//  MovieDetailsViewController.swift
//  TMDiscover
//

import UIKit
import TMResources

protocol MovieDetailsViewType: AnyObject {
    func setTitle(title: String)
    func setPosterImageURL(url: URL)
    func setReleaseDate(releaseDate: String)
    func setDescription(description: String)
}

final class MovieDetailsViewController: UIViewController {
    typealias Unit = MovieDetailsUnit
    var presenter: Unit.Presenter!
    
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.image = Images.placeholder.image
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .preferredFont(forTextStyle: .title1)
        }
    }
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.removeAdditionalPadding()
            descriptionTextView.font = .preferredFont(forTextStyle: .body)
        }
    }
}

// MARK: - View events

extension MovieDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.viewDidLoad()
    }
}

// MARK: - MovieDetailsViewType

extension MovieDetailsViewController: MovieDetailsViewType {
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setPosterImageURL(url: URL) {
        posterImageView.setImage(from: url)
    }
    
    func setReleaseDate(releaseDate: String) {
        releaseDateLabel.text = releaseDate
    }
    
    func setDescription(description: String) {
        descriptionTextView.text = description
    }
}

// MARK: - Helpers

private extension MovieDetailsViewController {
    func setup() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
