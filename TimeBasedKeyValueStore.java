import java.util.*;

class ListEntry {
	private int timestamp;
	private String value;

	public ListEntry(int timestamp, String value) {
		this.timestamp = timestamp;
		this.value = value;
	}

	public int getTimestamp() {
		return this.timestamp;
	}

	public String getValue() {
		return this.value;
	}
}

class TimeMap {
	private Map<String, List<ListEntry>> timestamps;

	public TimeMap() {
		timestamps = new HashMap<>();
	}

	private int lowerBound(List<ListEntry> list, int value, int low, int high) {
		int mid = (low + high) / 2;

		if (high - low == 1)
			return low;
		int midValue = list.get(mid).getTimestamp();

		if (midValue == value)
			return mid;
		else if (midValue > value)
			return lowerBound(list, value, low, mid);
		return lowerBound(list, value, mid, high);
	}

	public void set(String key, String value, int timestamp) {
		timestamps.putIfAbsent(key, new ArrayList<>());
		timestamps.get(key).add(new ListEntry(timestamp, value));
	}

	public String get(String key, int timestamp) {
		if (!timestamps.containsKey(key))
			return "";
		List<ListEntry> entries = timestamps.get(key);
		if (entries.get(0).getTimestamp() > timestamp)
			return "";

		int index = lowerBound(entries, timestamp, 0, entries.size());
		return entries.get(index).getValue();
	}
}
