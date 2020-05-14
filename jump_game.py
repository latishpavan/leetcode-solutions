def canReachUtil(arr: List[int], curr_index: int, visited: List[bool]) -> bool:
    if curr_index < 0 or curr_index >= len(arr) or visited[curr_index]:
        return False

    if arr[curr_index] == 0:
        return True

    visited[curr_index] = True
    
    right = canReachUtil(arr, curr_index + arr[curr_index], visited)
    left = canReachUtil(arr, curr_index - arr[curr_index], visited)
    
    return left or right
    

class Solution:

    def canReach(self, arr: List[int], start: int) -> bool:
        visited = [False] * len(arr)
        return canReachUtil(arr, start, visited)
