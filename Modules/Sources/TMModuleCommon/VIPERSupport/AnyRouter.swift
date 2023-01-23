//
//  AnyRouter.swift
//  TMCore
//

import Foundation

// MARK: - AnyRouter

public final class AnyRouter<Event>: RouterType {
    private let routeEvent: (Event) -> Void

    public init(play: @escaping (Event) -> Void) {
        self.routeEvent = play
    }

    public func route(event: Event) {
        routeEvent(event)
    }
}

extension AnyRouter where Event == Never {
    public static var empty: AnyRouter<Event> {
        return AnyRouter(play: { _ in })
    }
}
