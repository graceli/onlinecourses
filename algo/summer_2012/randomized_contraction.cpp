#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Vertex {
	public:
		Vertex(int v);
		int get_label();

	private:
		int vertex_label;
};

Vertex::Vertex(int v)
:vertex_label(v)
{}

class Edge {
	public:
		Edge(int u, int v);
		int get_v1();
		int get_v2();

	private:
		int v1;
		int v2;
};

Edge::Edge(int u, int v)
:v1(u), v2(v)
{}

class Graph {
	public:
		Graph(const string &filename);
		
		// void build_graph();
		// void add_node();
		// void merge_nodes(Vertex a, Vertex b);
		
		//stream operator overload for printing out the object
	private:
		// adjacency list representation of the graph
		map<Vertex, vector<Vertex*> > adj_list;
};

Graph::Graph(const string &filename){
	// read in file into an adjacency list	
}

int main(){
	cout << "Hello" << endl;
	// implement random contraction using naive edge contractions
	// while there are more than 2 vertices:
	// 	pick a remaining edge (u,v) uniformly at random
	// 	merge u and v into a single vertex
	// 	remove self-loops
	// 
	// return cut represented by final 2 vertices
	return 0;
}
