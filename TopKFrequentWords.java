import java.util.*;
import java.util.stream.Collectors;
import java.util.function.Function;

public class TopKFrequentWords {
	public List<String> topKFrequent(String[] words, int k) {
		List<String> results = new ArrayList<>();
		Map<String, Long> frequencies = Arrays.stream(words)
				.collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

		Queue<Map.Entry<String, Long>> maxHeap = new PriorityQueue<>((a, b) -> {
			String keyOne = a.getKey();
			String keyTwo = b.getKey();
			long valueOne = a.getValue();
			long valueTwo = b.getValue();

			return valueOne != valueTwo ? Long.compare(valueTwo, valueOne) : keyOne.compareToIgnoreCase(keyTwo);
		});

		for (Map.Entry<String, Long> entry : frequencies.entrySet()) {
			maxHeap.offer(entry);
		}

		while (k > 0 && !maxHeap.isEmpty()) {
			results.add(maxHeap.poll().getKey());
			k--;
		}

		return results;
	}
}
