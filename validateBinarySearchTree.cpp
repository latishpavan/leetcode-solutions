/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
private:
	void inorderTraversal(TreeNode *node, TreeNode * &prevNode, bool *res) 
	{
		if (node == NULL || !*res) return;

		inorderTraversal(node->left, prevNode, res);
        if (!prevNode) prevNode = node;
        else *res &= prevNode->val < node->val;
        prevNode = node;
		inorderTraversal(node->right, prevNode, res);
	}
public:
    bool isValidBST(TreeNode* root)
    {
        bool res = true;
        TreeNode *prev = NULL;
        inorderTraversal(root, prev, &res);
        return res;
    }
};
