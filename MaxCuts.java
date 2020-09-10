import java.util.Arrays;

class GridDiff {
	private long vertical;
	private long horizontal;
	private static final long MODULO = (long) Math.pow(10, 9) + 7;

	public GridDiff(long horizontal, long vertical) {
		this.horizontal = horizontal;
		this.vertical = vertical;
	}

	public long getHorizontal() {
		return this.horizontal;
	}

	public long getVertical() {
		return this.vertical;
	}

	public void setHorizontal(long val) {
		horizontal = val;
	}

	public void setVertical(long val) {
		vertical = val;
	}

	public long getProduct() {
		return (horizontal % MODULO * vertical % MODULO) % MODULO;
	}
}

public class MaxCuts {
	public int maxArea(int h, int w, int[] horizontalCuts, int[] verticalCuts) {
		Arrays.sort(horizontalCuts);
		Arrays.sort(verticalCuts);

		long horizontalInit = Math.max(h - horizontalCuts[horizontalCuts.length - 1], horizontalCuts[0]);
		long verticalInit = Math.max(w - verticalCuts[verticalCuts.length - 1], verticalCuts[0]);

		GridDiff maxDiff = new GridDiff(horizontalInit, verticalInit);

		for (int i = 1; i < horizontalCuts.length; i++) {
			maxDiff.setHorizontal(Math.max(maxDiff.getHorizontal(), (long) horizontalCuts[i] - horizontalCuts[i - 1]));
		}

		for (int i = 1; i < verticalCuts.length; i++) {
			maxDiff.setVertical(Math.max(maxDiff.getVertical(), (long) verticalCuts[i] - verticalCuts[i - 1]));
		}

		return (int) maxDiff.getProduct();
	}
}
