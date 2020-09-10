import java.util.Objects;

class TreeNode {
	int val;
	TreeNode left;
	TreeNode right;
}

public class BSTKthSmallestElement {
	private int count = 0;
	private int ret = 0;

	private void inorderTraversal(TreeNode node) {
		if (Objects.isNull(node))
			return;
		inorderTraversal(node.left);
		count--;
		if (count == 0) {
			ret = node.val;
		}
		inorderTraversal(node.right);
	}

	public int kthSmallest(TreeNode root, int k) {
		count = k;
		inorderTraversal(root);
		return ret;
	}
}
