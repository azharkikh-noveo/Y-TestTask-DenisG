//
//  UIImageView+Ext.swift
//  TMUI
//

import UIKit
import Nuke

extension UIImageView {
    
    public func setImage(from imageURL: URL) {
        Task { @MainActor in
            let response = try await ImagePipeline.shared.image(for: imageURL)
            image = response.image
        }
    }
}
