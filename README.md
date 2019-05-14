# MapImplementation

## 字典
```swift
java里映射Map(HashMap、TreeMap(红黑树))
oc、swift、python里的字典dict
```
### 定义字典的接口
```swift
protocol  MapAble {
    associatedtype K
    associatedtype V
    func add(key:K,Value:V)         // 添加key、value
    func contains(key:K) ->Bool     // 检查是否存在key
    func remove(key:K) -> V?        // 移除key
    func getSize() ->Int            // 获取字典的大小
    func isEmpty() -> Bool          // 判断字典是否为空
    func get(key:K) -> V?           // 根据key获取value 不存在key返回nill
    func set(key:K,value:V) throws  // 更新key对应的value 不存在key抛出异常
}
```
<!-- more -->
### 实现基于链表的LinkedMap字典
#### 设计每个节点存放key，value的链表
```swift

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
```
#### 根据带有key，value的节点的链表实现字典
```swift

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

```
#### LinkedMap的使用
```swift
let map = LinkedMap<String,String>()
for i in 0...9 {
    map.add(key: "key\(i)", Value: "value\(i)")
}
print("添加后的字典-------\n"+map.debugDescription)
try map.set(key: "key5", value: "T##String")
print("变更key5的字典-------\n"+map.debugDescription)
_ = map.remove(key: "key8")
print("删除key8后的字典-------\n"+map.debugDescription)
```
#### 打印结果 
```swift
添加后的字典-------
 {
 "key9":"value9",
 "key8":"value8",
 "key7":"value7",
 "key6":"value6",
 "key5":"value5",
 "key4":"value4",
 "key3":"value3",
 "key2":"value2",
 "key1":"value1",
 "key0":"value0",
 }
 变更key5的字典-------
 {
 "key9":"value9",
 "key8":"value8",
 "key7":"value7",
 "key6":"value6",
 "key5":"T##String",
 "key4":"value4",
 "key3":"value3",
 "key2":"value2",
 "key1":"value1",
 "key0":"value0",
 }
 删除key8后的字典-------
 {
 "key9":"value9",
 "key7":"value7",
 "key6":"value6",
 "key5":"T##String",
 "key4":"value4",
 "key3":"value3",
 "key2":"value2",
 "key1":"value1",
 "key0":"value0",
 }
 Program ended with exit code: **0**
```

### 实现基于二分搜索树的TreeMap字典
#### `实现每个节点存放key，value的二叉搜索树`
```swift

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

```

#### 根据二叉搜索树实现TreeMap
```swift

class BSTMap<K,V>:MapAble,CustomDebugStringConvertible where K:Comparable {
    
    
    var data: BST<K,V>
    init() {
        self.data = BST<K,V>()
    }
    func add(key: K, Value: V) {
        self.data.add(key: key, value: Value)
    }
    
    func contains(key: K) -> Bool {
        return self.data.contains(key: key)
    }
    
    func remove(key: K) -> V? {
        let data = self.data.get(key: key)
        self.data.remove(key: key)
        return data
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
        self.data.inOrder()
        return ""
    }
    
}
```
#### LinkedMap的使用

let map1 = BSTMap<String,String>()

for i in 0...9 {
    map1.add(key: "key\(i)", Value: "value\(i)")
}
print("添加后的字典-------\n")
map1.debugDescription
try map1.set(key: "key5", value: "T##String")
print("变更key5的字典-------\n")
map1.debugDescription
_ = map1.remove(key: "key8")
print("删除key8后的字典-------\n")
map1.debugDescription
```
#### 打印结果 
```swift
添加后的字典-------
"key0":"value0"
"key1":"value1"
"key2":"value2"
"key3":"value3"
"key4":"value4"
"key5":"value5"
"key6":"value6"
"key7":"value7"
"key8":"value8"
"key9":"value9"
变更key5的字典-------
"key0":"value0"
"key1":"value1"
"key2":"value2"
"key3":"value3"
"key4":"value4"
"key5":"T##String"
"key6":"value6"
"key7":"value7"
"key8":"value8"
"key9":"value9"
删除key8后的字典-------
"key0":"value0"
"key1":"value1"
"key2":"value2"
"key3":"value3"
"key4":"value4"
"key5":"T##String"
"key6":"value6"
"key7":"value7"
"key9":"value9"
Program ended with exit code: 0
```