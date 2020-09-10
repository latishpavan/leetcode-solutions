import java.util.Arrays;

class DuplicateNumber {
	public int findDuplicate(int[] nums) {
		Arrays.sort(nums);
		int res = 0;

		for (int i = 0; i < nums.length - 1; ++i) {
			if (nums[i] == nums[i + 1]) {
				res = nums[i];
				break;
			}
		}

		return res;
	}
}