//
//  LinkedList.swift
//  SetImplementation
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa

/// 错误信息
///
/// - msg: <#msg description#>
enum UserError:Error {
    case msg(String)
}

/// 链表的节点
class Node<K,V>:CustomDebugStringConvertible {
    var key:K?
    var value:V?
    var node:Node<K,V>?
    init(key:K?,value:V?, node:Node<K,V>?) {
        self.key = key
        self.value = value
        self.node = node
    }
    init() {
        self.key = nil
        self.value = nil
        self.node = nil
    }
    var debugDescription: String {
        var keyStr = "nil"
        if let key = self.key {
            keyStr = "\"\(key)\""
        }
        var vStr = "nil"
        if let v = self.value {
            vStr = "\"\(v)\""
        }
        return keyStr+":"+vStr
    }
}


/// 每个节点存放key，value的链表
class LinkedList<K,V>:CustomDebugStringConvertible where K:Comparable {

    private var dummyHead:Node<K,V>
    private var size:Int
    
    init(){
        self.dummyHead = Node<K,V>()
        self.size = 0
    }
    
    // 获取链表中的元素个数
    public func getSize()->Int{
        return size
    }
    
    // 返回链表是否为空
    public func isEmpty()->Bool{
        return size == 0
    }
    
    /// 查找key对应的节点
    ///
    /// - Parameter key: key description
    /// - Returns: return value description
    private func getNode(key:K) -> Node<K, V>? {
        var cur:Node<K,V>? = self.dummyHead.node
        while cur != nil {
            if let curKey = cur?.key {
                if curKey == key {
                    return cur
                }
            }
            cur = cur?.node
        }
        return nil
    }
    
    /// 添加键值对
    ///
    /// - Parameters:
    ///   - key: key description
    ///   - value: value description
    func add(key:K,value:V) {
        let node = getNode(key: key)
        if node == nil {
            self.dummyHead.node = Node<K,V>.init(key: key, value: value, node: self.dummyHead.node)
            self.size += 1
        } else {
            node?.value = value
        }
    }
    
    
    /// 查询key是否存在
    ///
    /// - Parameter key: key description
    /// - Returns: return value description
    func contains(key:K) -> Bool {
        return (self.getNode(key: key) != nil)
    }
    
    /// 查询key对应的value
    ///
    /// - Parameter key: key description
    /// - Returns: return value description
    func get(key:K) -> V? {
        return self.getNode(key: key)?.value
    }
    
    
    /// 设置简直对吗
    ///
    /// - Parameters:
    ///   - key: key description
    ///   - value: value description
    /// - Throws: 当key不存在时抛出异常
    func set(key:K,value:V) throws{
        let node = self.getNode(key: key)
        if node==nil {
            throw UserError.msg("key不存在")
        }
        node?.value = value
    }
    
    /// 移除key对应的节点
    ///
    /// - Parameter key: key description
    /// - Returns: return value description
    func remove(key:K) -> V? {
        
        var prev:Node<K,V>? = self.dummyHead;
        while(prev?.node != nil){
            if let nodeKey = prev?.node?.key {
                if (nodeKey == key) {
                    break;
                }
            }
            prev = prev?.node
        }
        
        if(prev?.node != nil){
            let delNode = prev?.node
            prev?.node = delNode?.node
            delNode?.node = nil
            size -= 1
            return delNode?.value
        }
        
        return nil
        
    }
    
    
    var debugDescription: String {
        var str = "{\n"
        var node:Node<K,V>? = self.dummyHead
        for _ in 0..<self.getSize() {
            node = node?.node
            if let nodeNoNull = node {
                str.append("\t\(String(describing: nodeNoNull))" + ",\n")
            }
        }
        return str+"}"
    }
}
