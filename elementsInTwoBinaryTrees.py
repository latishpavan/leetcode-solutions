# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def inorder(self, root: TreeNode, arr: List[int]) -> List[int]:
        if root is None:
            return
        
        self.inorder(root.left, arr)
        arr.append(root.val)
        self.inorder(root.right, arr)
        
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:
        arr1, arr2 = [], []
        self.inorder(root1, arr1)
        self.inorder(root2, arr2)
        
        arr1.extend(arr2)
        arr1.sort()
        
        return arr1
