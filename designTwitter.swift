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

extension Stack {
    func take(_ num: Int) -> [Type] {
        var res = [Type]()
        let limit = max(self.count - num, 0)
        
        for ind in stride(from: self.count - 1, through: limit, by: -1) {
            res.append(self.arr[ind])
        }
        
        return res
    }
}

struct Tweet {
    let tweetId: Int
    let count: Int
}

class User {
    var followers = Set<Int>()
    var followees = Set<Int>()
    var tweets = Stack<Tweet>()
    
    func addFollower(_ id: Int) {
        followers.insert(id)
    }
    
   func removeFollower(_ id: Int) {
        followers.remove(id)
    }
    
    func addFollowee(_ id: Int) {
        followees.insert(id)
    }
    
    func removeFollowee(_ id: Int) {
        followees.remove(id)
    }
    
    func addTweet(id: Int, count: Int) {
        tweets.push(Tweet(tweetId: id, count: count))
    }
    
    func getTweets() -> [Tweet] {
        return tweets.take(10)
    }
}

class Twitter {
    var database = [Int: User]()
    var globalTweetCounter = 0
    
    private func getOrAddUser(_ id: Int) -> User {
        guard let user = database[id] else {
            let user = User()
            database[id] = user
            return user
        }
        
        return user
    }
    
    func postTweet(_ userId: Int, _ tweetId: Int) {
        let user = getOrAddUser(userId)
        user.addTweet(id: tweetId, count: globalTweetCounter)
        globalTweetCounter += 1
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        let user = getOrAddUser(userId)
        var tweets = user.getTweets()
        
        for followeeId in user.followees {
            tweets.append(contentsOf: database[followeeId]!.getTweets())
        }
        
        let res = tweets.sorted { $0.count > $1.count }
        return res.prefix(10).map { $0.tweetId }
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        guard followerId != followeeId else { return }
        
        let followee = getOrAddUser(followeeId)
        let follower = getOrAddUser(followerId)
        followee.addFollower(followerId)
        follower.addFollowee(followeeId)
    }
    
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        guard followerId != followeeId else { return }
        
        let followee = getOrAddUser(followeeId)
        let follower = getOrAddUser(followerId)
        followee.removeFollower(followerId)
        follower.removeFollowee(followeeId)
    }
}


/**
 * Your Twitter object will be instantiated and called as such:
 * let obj = Twitter()
 * obj.postTweet(userId, tweetId)
 * let ret_2: [Int] = obj.getNewsFeed(userId)
 * obj.follow(followerId, followeeId)
 * obj.unfollow(followerId, followeeId)
 */
