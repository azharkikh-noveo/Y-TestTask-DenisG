//
//  LoadingTableViewCell.swift
//  TMUI
//

import UIKit

public final class LoadingTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    public static var bundle: Bundle {
        .module
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        // When cell gets off-screen, it's UIActivityIndicator stops. In that case, we have to restart it
        activityIndicator.startAnimating()
    }
}
