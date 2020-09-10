import java.util.*;
import java.util.stream.Collectors;
import java.util.function.Function;

public class DistantBarcodes {
	public int[] rearrangeBarcodes(int[] barcodes) {
		int[] results = new int[barcodes.length];

		Map<Integer, Long> counts = Arrays.stream(barcodes).boxed()
				.collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

		Queue<Map.Entry<Integer, Long>> heap = new PriorityQueue<>((a, b) -> Long.compare(b.getValue(), a.getValue()));

		for (Map.Entry<Integer, Long> entry : counts.entrySet()) {
			heap.offer(entry);
		}

		int arrIndex = 0;
		boolean evenCompleted = false;

		while (!heap.isEmpty()) {
			Map.Entry<Integer, Long> entry = heap.poll();
			int key = entry.getKey();
			long value = entry.getValue();

			while (value > 0) {
				results[arrIndex] = key;
				value--;
				arrIndex += 2;

				if (arrIndex >= results.length && !evenCompleted) {
					arrIndex = 1;
					evenCompleted = true;
				}
			}
		}

		return results;
	}
}
