#include <iostream>
#include <cmath>
#include <vector>

namespace adt
{
	class segment_tree
	{
	private:
		int arr_size;
		std::vector<int> arr;
		std::vector<int> tree;
		void build(int, int, int);
		void update_helper(int, int, int, int, int);
		int query_helper(int, int, int, int, int);

	public:
		segment_tree(std::vector<int>);
		void update(int, int);
		int query(int, int);
		void print();
	};
} // namespace adt

int get_nearest_two_power(int n)
{
	return pow(2, ceil(log(n) / log(2)));
}

adt::segment_tree::segment_tree(const std::vector<int> arr)
{
	this->arr = arr;
	arr_size = arr.size();
	tree = std::vector<int>(get_nearest_two_power(2 * arr_size));
	build(1, 0, arr_size);
}

void adt::segment_tree::build(int index, int left_ind, int right_ind)
{
	if (right_ind - left_ind < 2)
	{
		tree[index] = arr[left_ind];
		return;
	}

	int mid = (left_ind + right_ind) / 2;
	build(index * 2, left_ind, mid);
	build(index * 2 + 1, mid, right_ind);
	tree[index] = tree[index * 2] + tree[index * 2 + 1];
}

int adt::segment_tree::query_helper(
	int query_left,
	int query_right,
	int tree_index,
	int range_left_index,
	int range_right_index)
{
	/*
		possible cases
		no overlap - return 0
		complete overlap - return the node value
		partial overlap - recur for left and right nodes until complete overlap is found
	*/

	// no overlap
	if (query_left >= range_right_index or query_right <= range_left_index)
		return 0;

	// complete overlap
	if (query_left <= range_left_index and query_right >= range_right_index)
		return tree[tree_index];

	// partial overlap
	int mid = (range_left_index + range_right_index) / 2;
	return query_helper(
			   query_left,
			   query_right,
			   tree_index * 2,
			   range_left_index,
			   mid) +
		   query_helper(
			   query_left,
			   query_right,
			   tree_index * 2 + 1,
			   mid,
			   range_right_index);
}

int adt::segment_tree::query(int left_ind, int right_ind)
{
	return query_helper(
		left_ind,
		right_ind,
		1,
		0,
		arr_size);
}

void adt::segment_tree::update_helper(
	int index,
	int new_value,
	int tree_index,
	int range_left_index,
	int range_right_index)
{
	tree[tree_index] += new_value - arr[index];

	if (range_right_index - range_left_index < 2)
	{
		arr[index] = new_value;
		return;
	}

	int mid = (range_left_index + range_right_index) / 2;
	if (index < mid)
		update_helper(index, new_value, tree_index * 2, range_left_index, mid);
	else
		update_helper(index, new_value, tree_index * 2 + 1, mid, range_right_index);
}

void adt::segment_tree::update(int index, int new_value)
{
	update_helper(
		index,
		new_value,
		1,
		0,
		arr_size);
}

void adt::segment_tree::print()
{
	for (auto ele : tree)
	{
		std::cout << ele << " ";
	}

	std::cout << std::endl;
}

class NumArray
{
private:
	adt::segment_tree *st;

public:
	NumArray(vector<int> &nums)
	{
		if (nums.size() > 0)
			st = new adt::segment_tree(nums);
	}

	void update(int i, int val)
	{
		if (st != NULL)
			st->update(i, val);
	}

	int sumRange(int i, int j)
	{
		if (st != NULL)
			return st->query(i, j + 1);
		return 0;
	}
};

/**
 * Your NumArray object will be instantiated and called as such:
 * NumArray* obj = new NumArray(nums);
 * obj->update(i,val);
 * int param_2 = obj->sumRange(i,j);
 */