import java.util.Map;
import java.util.HashMap;

public class HouseRobber {
	private Map<Integer, Integer> dp = new HashMap<>();

	public int robUtil(int[] nums, int houseToSteal) {
		if (houseToSteal >= nums.length)
			return 0;
		if (!dp.containsKey(houseToSteal))
			dp.put(houseToSteal,
					Math.max(nums[houseToSteal] + robUtil(nums, houseToSteal + 2), robUtil(nums, houseToSteal + 1)));

		return dp.get(houseToSteal);
	}

	public int rob(int[] nums) {
		return robUtil(nums, 0);
	}
}
