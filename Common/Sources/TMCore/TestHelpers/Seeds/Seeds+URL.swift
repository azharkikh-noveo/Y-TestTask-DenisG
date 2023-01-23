//
//  Seeds+URL.swift
//  TMCore
//

import Foundation

#if DEBUG

extension Seeds {
    public enum URL {
        public static let `default` = Foundation.URL(string: "https://apple.com")!
    }
}

#endif
