import java.util.Arrays;

class Solution {
	private boolean isValid(int[] piles, int k, int H) {
		int sum = Arrays.stream(piles).map(pile -> (int) Math.ceil(pile / (double) k)).sum();
		return sum <= H;
	}

	private int lowerBound(int[] piles, int low, int high, int H) {
		int mid = (low + high) >> 1;
		if (high == low)
			return low;

		if (isValid(piles, mid, H))
			return lowerBound(piles, low, mid, H);
		return lowerBound(piles, mid + 1, high, H);
	}

	public int minEatingSpeed(int[] piles, int H) {
		int max = Arrays.stream(piles).max().getAsInt();
		return lowerBound(piles, 1, max, H);
	}
}