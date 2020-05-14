import Foundation

class Stack<Type> {
    private var arr = [Type]()
    var count: Int {
        return arr.count
    }
    
    func push(_ item: Type) {
        arr.append(item)
    }
    
    func pop() -> Type {
        return arr.popLast()!
    }
    
    func top() -> Type {
        return arr.last!
    }
}

struct StackElement<Type> {
    let value: Type
    let count: Int
}

func get<Type:Comparable>(numberOfGreaterElements arr: [Type], toLeft: Bool? = nil, toRight: Bool? = nil) -> [Int] {
    let stack = Stack<StackElement<Type>>()
    
    func calculateLeft() -> [Int] {
        var res = Array(repeating: 0, count: arr.count)
        
        for ind in 0..<arr.count {
            var count = 1
            
            while stack.count > 0 && stack.top().value > arr[ind] {
                count += stack.pop().count
            }
            
            stack.push(StackElement(value: arr[ind], count: count))
            res[ind] = count
        }
        
        return res
    }
    
    func calculateRight() -> [Int] {
        var res = Array(repeating: 0, count: arr.count)
        
        for ind in stride(from: arr.count - 1, through: 0, by: -1) {
            var count = 1
            
            while stack.count > 0 && stack.top().value >= arr[ind] {
                count += stack.pop().count
            }
            
            stack.push(StackElement(value: arr[ind], count: count))
            res[ind] = count
        }
        
        return res
    }
    
    if toLeft != nil {
        return calculateLeft()
    }
    
    return calculateRight()
}


class Solution {
    private let modulo = Int(pow(Double(10), 9) + 7)
    
    func sumSubarrayMins(_ A: [Int]) -> Int {
        let right = get(numberOfGreaterElements: A, toRight: true)
        let left = get(numberOfGreaterElements: A, toLeft: true)

        var res = 0

        for ind in 0..<A.count {
            let ele = A[ind]
            res += (ele * left[ind] * right[ind]) % modulo
        }

        return res % modulo
    }

}
