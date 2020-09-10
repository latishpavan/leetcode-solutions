import java.util.*;

public class MergeIntervals {
	public int[][] merge(int[][] intervals) {
		List<int[]> res = new LinkedList<>();
		Arrays.sort(intervals, Comparator.comparingInt(ints -> ints[0]));

		int i = 0;
		while (i < intervals.length) {
			int[] currentInterval = intervals[i];
			int j = i + 1;

			while (j < intervals.length) {
				int[] otherInterval = intervals[j];
				// complete overlap
				if (otherInterval[1] <= currentInterval[1])
					j++;
				// partial overlap
				else if (currentInterval[1] >= otherInterval[0]) {
					currentInterval[1] = otherInterval[1];
				} else
					break;
			}

			i = j;
			res.add(currentInterval);
		}

		return res.toArray(new int[][] {});
	}
}
