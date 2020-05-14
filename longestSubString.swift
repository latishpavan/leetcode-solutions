class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var first = 0, second = 0, res = 0
        let elements = Array(s), len = elements.count
        var map = [Character:Int]()
        
        while second < len {
            // print(first, second, map)
            
            let currentCharPrevIndex = map[elements[second], default: -1]
            
            if currentCharPrevIndex != -1 && currentCharPrevIndex >= first {
                res = max(res, second - first)
                first = currentCharPrevIndex + 1
            }
            
            map[elements[second]] = second
            second += 1
        }
        
        // print(first, second, map)
        return max(second - first, res)
    }
}
