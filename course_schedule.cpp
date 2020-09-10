#include <vector>
#include <iostream>

using namespace std;

class Solution
{
public:
	bool dfs(const vector<vector<int>> &graph, vector<bool> &rec_stack, int vertex)
	{
		if (rec_stack[vertex])
			return true;

		rec_stack[vertex] = true;

		for (int neighbor_vertex : graph[vertex])
		{
			bool ret = dfs(graph, rec_stack, neighbor_vertex);
			if (ret)
				return true;
		}

		rec_stack[vertex] = false;
		return false;
	}

	bool has_cycle(const vector<vector<int>> &graph, int size)
	{
		for (auto vertex = 0; vertex < graph.size(); vertex++)
		{
			vector<bool> rec_stack(size, false);
			bool is_cyclic = dfs(graph, rec_stack, vertex);
			if (is_cyclic)
				return true;
		}

		return false;
	}

	auto build_graph(const vector<vector<int>> &prerequisites, int num_courses)
	{
		vector<vector<int>> graph(num_courses);

		for (auto pair : prerequisites)
		{
			graph[pair[0]].push_back(pair[1]);
		}

		return graph;
	}

	bool canFinish(int numCourses, vector<vector<int>> &prerequisites)
	{
		vector<vector<int>> graph = build_graph(prerequisites, numCourses);
		return !has_cycle(graph, numCourses);
	}
};