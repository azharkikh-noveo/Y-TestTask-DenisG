//
//  LoadingScreenViewController.swift
//  TMUI
//

import UIKit

public final class LoadingScreenViewController: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    public func indicateActivity(_ inProgress: Bool) {
        activityIndicator.isHidden = !inProgress
    }
}
