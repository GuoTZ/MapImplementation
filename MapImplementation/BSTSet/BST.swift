//
//  BST.swift
//  SetImplementation
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa

/// 二分上搜索树的节点
class BstNode<K,V> :CustomDebugStringConvertible{
    var key:K?
    var value:V?
    var left:BstNode<K,V>?
    var right:BstNode<K,V>?
    init() {
        self.right = nil
        self.left = nil
        self.key = nil
        self.value = nil
    }
    init(key:K,value:V) {
        self.key = key
        self.value = value
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

/// 二分搜索树
class BST<K,V> where K:Comparable {
    private var root: BstNode<K,V>?
    private var size: Int
    init() {
        self.root = nil
        self.size = 0
    }
    func getSize() -> Int {
        return self.size
    }
    func isEmpty() -> Bool {
        return self.size == 0
    }
    //MARK:添加元素
    /// 添加元素
    ///
    /// - Parameter e: e description
    func add(key:K,value:V) {
        self.root = self.add(node: self.root, key: key,value: value)
    }
    // 向以node为根的二分搜索树中插入元素e，递归算法
    // 返回插入新节点后二分搜索树的根
    private func add(node:BstNode<K,V>?, key:K,value:V)->BstNode<K,V>{
        guard let node = node else {
            self.size+=1
            return BstNode.init(key: key, value: value)
        }
        if key < node.key! {
            node.left = add(node: node.left,key: key, value: value)
        } else if key > node.key! {
            node.right = add(node: node.right, key: key, value: value)
        }
        return node
    }
    
    /// 获取key对应的value
    ///
    /// - Parameter key: <#key description#>
    /// - Returns: <#return value description#>
    func get(key:K) -> V? {
        return self.get(key: key, node: self.root)?.value
    }
    
    
    func set(key:K,value:V) throws {
        let node = self.get(key: key, node: self.root)
        if node==nil {
            throw UserError.msg("key不存在")
        }
        node?.value = value
    }
    
    private func get(key:K,node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        if key < node.key! {
            return self.get(key: key, node: node.left)
        } else if key > node.key! {
            return self.get(key: key, node: node.right)
        }
        return node
    }
    // MARK:查看是否存在元素e
    /// 查看是否存在元素e
    ///
    /// - Parameter e: 查询的元素
    /// - Returns: true表示存在，否则表示不存在
    func contains(key:K) -> Bool {
        return self.contains(key: key, node: self.root)
    }
    
    private func contains(key:K,node:BstNode<K,V>?) -> Bool {
        guard let node = node else { return false }
        if key < node.key! {
            return self.contains(key: key, node: node.left)
        } else if key > node.key! {
            return self.contains(key: key, node: node.right)
        }
        return true
    }
    //MARK:前序遍历
    /// 前序遍历
    func preOrder() {
        self.preOrder(node: self.root)
    }
    
    private func preOrder(node:BstNode<K,V>?) {
        guard let node = node else { return  }
        print(node)
        preOrder(node: node.left)
        preOrder(node: node.right)
    }
    
    //MARK:中序遍历
    /// 中序遍历
    func inOrder() {
        self.inOrder(node: self.root)
    }
    private func inOrder(node:BstNode<K,V>?) {
        guard let node = node else { return }
        preOrder(node: node.left)
        print(node)
        preOrder(node: node.right)
    }
    
    //MARK:后序遍历
    /// 后序遍历
    func postOrder() {
        self.postOrder(node: self.root)
    }
    private func postOrder(node:BstNode<K,V>?) {
        guard let node = node else { return }
        postOrder(node: node.left)
        postOrder(node: node.right)
        print(node)
    }
    
    //MARK:层序遍历
    /// 层序遍历
    func levelOrder() {
        let q = Queue<BstNode<K,V>>()
        guard let root = self.root else { return  }
        q.push(e: root)
        while !q.isEmpty() {
            let cur = q.pop()
            if let cur = cur {
                print(cur)
                if cur.left != nil{
                    q.push(e: cur.left!)
                }else if cur.right != nil{
                    q.push(e: cur.right!)
                }
            }
        }
    }
    
    //MARK:前序非递归遍历
    /// 前序非递归遍历
    func preOrderRN() {
        let stack = Stack<BstNode<K,V>>()
        guard let root = self.root else { return  }
        stack.push(e: root)
        while !stack.isEmpty() {
            let cur = stack.pop()
            if let cur = cur {
                print(cur)
                if cur.left != nil{
                    stack.push(e: cur.left!)
                }else if cur.right != nil{
                    stack.push(e: cur.right!)
                }
            }
        }
    }
    
    //MARK: 寻找最小元素
    /// 寻找最小元素
    ///
    /// - Returns: return value description
    func minimum() -> K? {
        if self.size==0 {
            return nil
        }
        return self.minimum(node: self.root)?.key
    }
    private func minimum(node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        
        if node.left != nil {
            return self.minimum(node: node.left)
        }
        return node
    }
    //MARK: 寻找最大元素
    /// 寻找最大元素
    ///
    /// - Returns: return value description
    func maxmum() -> K? {
        if self.size==0 {
            return nil
        }
        return self.maxmum(node: self.root)?.key
    }
    private func maxmum(node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        if node.right == nil {
            return node
        }
        return self.maxmum(node: node.right)
    }
    
    //MARK:删除最小值
    /// 删除x最小值
    ///
    /// - Returns: return value description
    func removeMin() -> K? {
        let data = self.minimum()
        self.root = removeMin(node: self.root)
        return data
    }
    
    private func removeMin(node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        
        if node.left == nil {
            let rightNode = node.right
            node.right = nil
            size -= 1
            return rightNode
        }
        node.left = self.removeMin(node: node.left)
        return node
    }
    
    //MARK:移除最大值
    /// 移除最大值
    ///
    /// - Returns: return value description
    func removeMax() -> K? {
        let data = self.maxmum()
        self.root = self.removeMin(node: self.root)
        return data
        
    }
    private func removeMax(node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        if node.right == nil {
            let leftnode = node.left
            node.left = nil
            self.size -= 1
            return leftnode
        }
        node.right = removeMax(node: node.right)
        return node
    }
    
    //MARK:移除任意值
    /// 移除任意值
    ///
    /// - Returns: return value description
    func remove(key:K) {
        self.root = remove(key: key, node: self.root)
    }
    private func remove(key:K,node:BstNode<K,V>?) -> BstNode<K,V>? {
        guard let node = node else { return nil }
        guard let eval = node.key else { return nil }
        if key < eval {
            node.left = remove(key: key, node: node.left)
            return node
        } else if key > eval {
            node.right = remove(key: key, node: node.right)
            return node
        } else {
            // 待删除节点左子树为空的情况
            if node.left == nil {
                let rightNode = node.right
                node.right = nil
                self.size -= 1
                return rightNode
            }
            // 待删除节点右子树为空的情况
            if node.right == nil {
                let leftNode = node.left
                node.left = nil
                self.size -= 1
                return leftNode
            }
            
            let successor = self.minimum(node: node.right)
            successor?.right = self.removeMin(node: node.right)
            successor?.left = node.left
            node.left = nil
            node.right = nil
            return successor
        }
    }
    
}
