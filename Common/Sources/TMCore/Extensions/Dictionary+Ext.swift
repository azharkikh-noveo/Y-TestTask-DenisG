//
//  Dictionary+Ext.swift
//  TMCore
//

import Foundation

public func + <Key, Value>(
    left: Dictionary<Key, Value>,
    right: Dictionary<Key, Value>
) -> Dictionary<Key, Value> {
    var map = Dictionary<Key, Value>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
