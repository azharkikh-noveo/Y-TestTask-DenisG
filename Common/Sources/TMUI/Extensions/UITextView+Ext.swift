//
//  UITextView+Ext.swift
//  TMUI
//

import UIKit

extension UITextView {
    
    public func removeAdditionalPadding() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
}
