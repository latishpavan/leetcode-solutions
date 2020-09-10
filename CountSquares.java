import java.util.*;

public class CountSquares {
	public int countSquares(int[][] matrix) {
		int nRows = matrix.length;
		int nCols = matrix[0].length;
		int res = 0;

		for (int i = 0; i < nRows; i++) {
			for (int j = 0; j < nCols; j++) {
				if (i > 0 && j > 0 && matrix[i][j] > 0)
					matrix[i][j] = Collections.min(List.of(matrix[i][j - 1], matrix[i - 1][j], matrix[i - 1][j - 1]))
							+ 1;

				res += matrix[i][j];
			}
		}

		return res;
	}
}
