/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit

// MARK: Protocol Definition
/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: AnyObject {
    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: UINib { get }
    
    static var bundle: Bundle { get }
}

// MARK: Default implementation
public extension NibLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
    
    static var bundle: Bundle {
        return Bundle.main
    }
}

// MARK: Support for instantiation from NIB
public extension NibLoadable where Self: UIView {
    /**
     Returns a `UIView` object instantiated from nib
     - returns: A `NibLoadable`, `UIView` instance
     */
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
