class LRUCacheNode<Type>: CustomStringConvertible {
    var description: String {
        return "\(value)"
    }
    
    var value: Type
    var mapIndex: Type
    var previous: LRUCacheNode<Type>?
    var next: LRUCacheNode<Type>?
    
    init(val: Type, index: Type) {
        value = val
        mapIndex = index
    }
}

class DoublyLinkedList<Type>: CustomStringConvertible {
    private var head: LRUCacheNode<Type>?
    private var tail: LRUCacheNode<Type>?
    
    var description: String {
        var node = head
        var linkedListString = ""
        
        while node != nil {
            linkedListString += "\(String(describing: node?.value)) -> "
            node = node?.next
        }
        
        return linkedListString
    }
    
    func prepend(_ node: LRUCacheNode<Type>) {
        if head == nil { // list is empty
            head = node
            tail = node
        } else { // list is not empty
            head!.previous = node
            node.next = head
            head = node
        }
    }
    
    func removeLast() -> LRUCacheNode<Type>? {
//        guard let tailNode = tail else { return }
        if let currentTail = tail {
            let prevNodeToTail = currentTail.previous
            prevNodeToTail?.next = nil
            currentTail.previous = nil
            tail = prevNodeToTail
            return currentTail
        }
        
        return nil
    }
    
    func moveToFirst(_ node: LRUCacheNode<Type>) {
        guard head !== node else { return }
        
        if tail === node {
            tail = node.previous
        }
        
        node.previous?.next = node.next
        node.next?.previous = node.previous
        node.next = head
        node.previous = nil
        head?.previous = node
        head = node
    }
}

class LruCache<Type: Hashable> {
    private var map = [Type:LRUCacheNode<Type>]()
    private let linkedList = DoublyLinkedList<Type>()
    
    let capacity: Int
    
    init(cap: Int) {
        capacity = cap
    }
    
    func get(_ key: Type) -> Type {
        if let node = map[key] {
            linkedList.moveToFirst(node)
            return node.value
        }
        
        return -1 as! Type
    }
    
    func put(_ key: Type, _ value: Type) {
        if let nodeInMap = map[key] {
            nodeInMap.value = value
            linkedList.moveToFirst(nodeInMap)
        } else {
            let newNode = LRUCacheNode<Type>(val: value, index: key)
            if map.count >= capacity  {
                let node = linkedList.removeLast()
                if node != nil {
                    map[node!.mapIndex] = nil
                }
            }
            
            linkedList.prepend(newNode)
            map[key] = newNode
        }
    }
}

class LRUCache {
    let cache: LruCache<Int>
    
    init(_ capacity: Int) {
        cache = LruCache<Int>(cap: capacity)
    }
    
    func get(_ key: Int) -> Int {
        return cache.get(key)
    }
    
    func put(_ key: Int, _ value: Int) {
        cache.put(key, value)
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
