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

extension AnyRouter {
    
    public convenience init<Unretained: AnyObject>(
        with object: Unretained,
        play: @escaping (Unretained, Event) -> Void
    ) {
        let routeEvent = { [weak object] event in
            guard let object = object else {
                assertionFailure("Object \(type(of: object)) could not be retained.")
                return
            }
            
            play(object, event)
        }
        self.init(play: routeEvent)
    }
}

extension AnyRouter where Event == Never {
    public static var empty: AnyRouter<Event> {
        return AnyRouter(play: { _ in })
    }
}
