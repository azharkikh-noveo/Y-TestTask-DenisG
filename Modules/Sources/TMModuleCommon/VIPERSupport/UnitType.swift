//
//  UnitType.swift
//  TMCore
//

import Foundation

public protocol UnitType {
    associatedtype Event
    typealias Router = AnyRouter<Event>
}
