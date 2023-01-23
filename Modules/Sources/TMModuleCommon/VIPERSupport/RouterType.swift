//
//  RouterType.swift
//  TMCore
//

import Foundation

public protocol RouterType {
    associatedtype Event

    func route(event: Event)
}
