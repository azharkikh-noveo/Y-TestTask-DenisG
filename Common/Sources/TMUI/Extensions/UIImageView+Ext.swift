//
//  UIImageView+Ext.swift
//  TMUI
//

import UIKit
import TMCore
import Nuke

extension UIImageView {
    
    public func setImage(from imageURL: URL) {
        getTaskInteractor().runMainTask {
            let response = try? await ImagePipeline.shared.image(for: imageURL)
            if let response {
                self.image = response.image
            }
        }
    }
}
