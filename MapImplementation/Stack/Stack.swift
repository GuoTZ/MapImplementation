//
//  Stack.swift
//  SetImplementation
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa

class Stack<E> {
    var data:Array<E>
    init() {
        data = Array<E>()
    }
    
    func size() -> Int {
        return data.count
    }
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    /// 入栈
    ///
    /// - Parameter e: e description
    func push(e:E) {
        self.data.append(e)
    }
    
    /// 出栈
    ///
    /// - Returns: return value description
    func pop() -> E? {
        if self.data.isEmpty {
            return nil
        }
        let data = self.data.last
        self.data.remove(at: self.size()-1)
        return data
    }
    
    /// 查看栈顶元素
    ///
    /// - Returns: return value description
    func first() -> E? {
        if self.data.isEmpty {
            return nil
        }
        return self.data.last
    }
}
