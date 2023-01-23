//
//  SubscriptionToken.swift
//  TMDiscover
//

import Foundation

struct SubscriptionToken {
    private let _loadNext: () -> Void
    
    init(loadNext: @escaping () -> Void) {
        self._loadNext = loadNext
    }
    
    func loadNext() {
        _loadNext()
    }
}
