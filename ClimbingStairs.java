import java.util.Map;
import java.util.HashMap;

public class ClimbingStairs {
	private Map<Integer, Integer> dp = new HashMap<>();

	private int climbStairsUtil(int n) {
		if (n <= 3)
			return n;

		if (!dp.containsKey(n)) {
			dp.put(n, climbStairsUtil(n - 1) + climbStairsUtil(n - 2));
		}

		return dp.get(n);
	}

	public int climbStairs(int n) {
		return climbStairsUtil(n);
	}
}
