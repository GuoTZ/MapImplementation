//
//  LinkedMap.swift
//  MapImplementation
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa

class LinkedMap<K,V>:MapAble,CustomDebugStringConvertible where K:Comparable {

    
    var data: LinkedList<K,V>
    init() {
        self.data = LinkedList<K,V>()
    }
    func add(key: K, Value: V) {
        self.data.add(key: key, value: Value)
    }
    
    func contains(key: K) -> Bool {
        return self.data.contains(key: key)
    }
    
    func remove(key: K) -> V? {
        return self.data.remove(key: key)
    }
    
    func get(key: K) -> V? {
        return self.data.get(key: key)
    }
    
    func set(key: K, value: V) throws {
        try self.data.set(key: key, value: value)
    }
    
    func getSize() -> Int {
        return self.data.getSize()
    }
    
    func isEmpty() -> Bool {
        return self.data.isEmpty()
    }
    
    var debugDescription: String {
        return self.data.debugDescription
    }
    
}
