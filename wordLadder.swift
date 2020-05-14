import Foundation

extension String {
    static func - (left: String, right: String) -> Int {
        var count = 0
        
        for ind in left.indices {
            if left[ind] != right[ind] {
                count += 1
            }
        }
        
        return count
    }
}

class Queue<Type> {
    private var arr = [Type]()
    var count: Int { return arr.count }
    var top: Type? { return arr.last }
    var isEmpty: Bool { return arr.isEmpty }
    
    func push(_ ele: Type) {
        arr.append(ele)
    }
    
    func pop() -> Type? {
        return arr.removeFirst()
    }
}

class Vertex: CustomStringConvertible {
    let value: String
    var wordsWithDistanceOne = [String]()
    var nextLevelWords: [String]? {
        return wordsWithDistanceOne.isEmpty ? nil : wordsWithDistanceOne
        
    }
    
    var description: String {
        return "\(wordsWithDistanceOne)"
    }
    
    init(_ word: String) {
        self.value = word
    }
    
    func add(word: String) {
        wordsWithDistanceOne.append(word)
    }
}

struct QueueElement {
    let word: String
    let level: Int
}

class Solution {
    private var preprocessedDict = [String: [String]]()
    private var visited = Set<String>()
    private var wordList = [String]()
    
    private func preprocess() {
        for word in wordList {
            for ind in word.indices {
                let placeholder = String(word[word.startIndex..<ind] + "_" + word[word.index(after: ind)...])
                preprocessedDict[placeholder, default: []].append(word)
            }
        }
    }
    
    private func getNextLevelWords(_ word: String) -> [String] {
        var res = [String]()
        
        for ind in word.indices {
            let placeholder = String(word[word.startIndex..<ind] + "_" + word[word.index(after: ind)...])

            res.append(contentsOf: preprocessedDict[placeholder]!)
        }
        
        return res
    }
    
    private func traverseGraph(beginWord: String, endWord: String) -> Int {
        let queue = Queue<QueueElement>()
        queue.push(QueueElement(word: beginWord, level: 1))
        
        while !queue.isEmpty {
            let queueElement = queue.pop()!
            let word = queueElement.word
            if visited.contains(word) { continue } else { visited.insert(word) }
            
            if word == endWord { return queueElement.level }
            
            for nextLevelWord in getNextLevelWords(word) {
                queue.push(QueueElement(word: nextLevelWord, level: queueElement.level + 1))
            }
        }
        
        return 0
    }
    
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        guard wordList.contains(endWord) else { return 0 }
        self.wordList = wordList
        self.wordList.append(beginWord)
        
        self.preprocess()
        return self.traverseGraph(beginWord: beginWord, endWord: endWord)
    }
}
