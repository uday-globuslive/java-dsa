# Module 10: Graphs

## Learning Objectives
By the end of this module, you will:
- Understand graph terminology and representations
- Master graph traversal algorithms (DFS and BFS)
- Implement fundamental graph algorithms
- Solve graph problems like shortest paths, cycles, connectivity
- Apply graph patterns to complex algorithmic challenges

## Module Content

### 10.1 Graph Fundamentals

#### Graph Terminology
```java
/*
Graph Types:
1. Directed vs Undirected
2. Weighted vs Unweighted
3. Cyclic vs Acyclic (DAG - Directed Acyclic Graph)
4. Connected vs Disconnected
5. Simple vs Multi-graph

Key Terms:
- Vertex/Node: Basic unit of graph
- Edge: Connection between vertices
- Degree: Number of edges connected to a vertex
- Path: Sequence of vertices connected by edges
- Cycle: Path that starts and ends at same vertex
- Connected Component: Maximal set of connected vertices

Graph Representations:
1. Adjacency Matrix: 2D array
2. Adjacency List: Array of lists
3. Edge List: List of edges
*/
```

#### Graph Representations
```java
import java.util.*;

// Adjacency List Representation
class Graph {
    private int V; // Number of vertices
    private List<List<Integer>> adj; // Adjacency list
    private boolean directed;
    
    public Graph(int V, boolean directed) {
        this.V = V;
        this.directed = directed;
        adj = new ArrayList<>(V);
        for (int i = 0; i < V; i++) {
            adj.add(new ArrayList<>());
        }
    }
    
    public void addEdge(int u, int v) {
        adj.get(u).add(v);
        if (!directed) {
            adj.get(v).add(u);
        }
    }
    
    public List<Integer> getNeighbors(int v) {
        return adj.get(v);
    }
    
    public int getVertexCount() {
        return V;
    }
    
    public void printGraph() {
        for (int i = 0; i < V; i++) {
            System.out.print(i + ": ");
            for (int neighbor : adj.get(i)) {
                System.out.print(neighbor + " ");
            }
            System.out.println();
        }
    }
}

// Weighted Graph
class WeightedGraph {
    private int V;
    private List<List<Edge>> adj;
    private boolean directed;
    
    static class Edge {
        int dest;
        int weight;
        
        Edge(int dest, int weight) {
            this.dest = dest;
            this.weight = weight;
        }
    }
    
    public WeightedGraph(int V, boolean directed) {
        this.V = V;
        this.directed = directed;
        adj = new ArrayList<>(V);
        for (int i = 0; i < V; i++) {
            adj.add(new ArrayList<>());
        }
    }
    
    public void addEdge(int u, int v, int weight) {
        adj.get(u).add(new Edge(v, weight));
        if (!directed) {
            adj.get(v).add(new Edge(u, weight));
        }
    }
    
    public List<Edge> getNeighbors(int v) {
        return adj.get(v);
    }
}

// Adjacency Matrix Representation
class GraphMatrix {
    private int[][] matrix;
    private int V;
    private boolean directed;
    
    public GraphMatrix(int V, boolean directed) {
        this.V = V;
        this.directed = directed;
        matrix = new int[V][V];
    }
    
    public void addEdge(int u, int v) {
        matrix[u][v] = 1;
        if (!directed) {
            matrix[v][u] = 1;
        }
    }
    
    public void addWeightedEdge(int u, int v, int weight) {
        matrix[u][v] = weight;
        if (!directed) {
            matrix[v][u] = weight;
        }
    }
    
    public boolean hasEdge(int u, int v) {
        return matrix[u][v] != 0;
    }
    
    public int getWeight(int u, int v) {
        return matrix[u][v];
    }
}
```

### 10.2 Graph Traversal Algorithms

#### Depth-First Search (DFS)
```java
import java.util.*;

public class GraphDFS {
    
    // Recursive DFS
    public void dfsRecursive(Graph graph, int start) {
        boolean[] visited = new boolean[graph.getVertexCount()];
        dfsRecursiveHelper(graph, start, visited);
    }
    
    private void dfsRecursiveHelper(Graph graph, int v, boolean[] visited) {
        visited[v] = true;
        System.out.print(v + " ");
        
        for (int neighbor : graph.getNeighbors(v)) {
            if (!visited[neighbor]) {
                dfsRecursiveHelper(graph, neighbor, visited);
            }
        }
    }
    
    // Iterative DFS using stack
    public void dfsIterative(Graph graph, int start) {
        boolean[] visited = new boolean[graph.getVertexCount()];
        Stack<Integer> stack = new Stack<>();
        
        stack.push(start);
        
        while (!stack.isEmpty()) {
            int v = stack.pop();
            
            if (!visited[v]) {
                visited[v] = true;
                System.out.print(v + " ");
                
                // Add neighbors to stack (in reverse order for consistent traversal)
                List<Integer> neighbors = graph.getNeighbors(v);
                for (int i = neighbors.size() - 1; i >= 0; i--) {
                    if (!visited[neighbors.get(i)]) {
                        stack.push(neighbors.get(i));
                    }
                }
            }
        }
    }
    
    // DFS to find all paths
    public List<List<Integer>> findAllPaths(Graph graph, int start, int end) {
        List<List<Integer>> paths = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();
        boolean[] visited = new boolean[graph.getVertexCount()];
        
        findAllPathsHelper(graph, start, end, visited, currentPath, paths);
        return paths;
    }
    
    private void findAllPathsHelper(Graph graph, int current, int end, 
                                   boolean[] visited, List<Integer> currentPath, 
                                   List<List<Integer>> paths) {
        visited[current] = true;
        currentPath.add(current);
        
        if (current == end) {
            paths.add(new ArrayList<>(currentPath));
        } else {
            for (int neighbor : graph.getNeighbors(current)) {
                if (!visited[neighbor]) {
                    findAllPathsHelper(graph, neighbor, end, visited, currentPath, paths);
                }
            }
        }
        
        // Backtrack
        currentPath.remove(currentPath.size() - 1);
        visited[current] = false;
    }
    
    // Check if graph has cycle (for directed graph)
    public boolean hasCycle(Graph graph) {
        int V = graph.getVertexCount();
        boolean[] visited = new boolean[V];
        boolean[] recursionStack = new boolean[V];
        
        for (int i = 0; i < V; i++) {
            if (!visited[i]) {
                if (hasCycleHelper(graph, i, visited, recursionStack)) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    private boolean hasCycleHelper(Graph graph, int v, boolean[] visited, boolean[] recursionStack) {
        visited[v] = true;
        recursionStack[v] = true;
        
        for (int neighbor : graph.getNeighbors(v)) {
            if (!visited[neighbor]) {
                if (hasCycleHelper(graph, neighbor, visited, recursionStack)) {
                    return true;
                }
            } else if (recursionStack[neighbor]) {
                return true; // Back edge found
            }
        }
        
        recursionStack[v] = false;
        return false;
    }
}
```

#### Breadth-First Search (BFS)
```java
import java.util.*;

public class GraphBFS {
    
    // Basic BFS traversal
    public void bfs(Graph graph, int start) {
        boolean[] visited = new boolean[graph.getVertexCount()];
        Queue<Integer> queue = new LinkedList<>();
        
        visited[start] = true;
        queue.offer(start);
        
        while (!queue.isEmpty()) {
            int v = queue.poll();
            System.out.print(v + " ");
            
            for (int neighbor : graph.getNeighbors(v)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }
    }
    
    // BFS to find shortest path (unweighted graph)
    public List<Integer> shortestPath(Graph graph, int start, int end) {
        int V = graph.getVertexCount();
        boolean[] visited = new boolean[V];
        int[] parent = new int[V];
        Queue<Integer> queue = new LinkedList<>();
        
        Arrays.fill(parent, -1);
        visited[start] = true;
        queue.offer(start);
        
        while (!queue.isEmpty()) {
            int v = queue.poll();
            
            if (v == end) {
                return reconstructPath(parent, start, end);
            }
            
            for (int neighbor : graph.getNeighbors(v)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    parent[neighbor] = v;
                    queue.offer(neighbor);
                }
            }
        }
        
        return new ArrayList<>(); // No path found
    }
    
    private List<Integer> reconstructPath(int[] parent, int start, int end) {
        List<Integer> path = new ArrayList<>();
        int current = end;
        
        while (current != -1) {
            path.add(current);
            current = parent[current];
        }
        
        Collections.reverse(path);
        return path;
    }
    
    // BFS level-by-level
    public void bfsLevels(Graph graph, int start) {
        boolean[] visited = new boolean[graph.getVertexCount()];
        Queue<Integer> queue = new LinkedList<>();
        
        visited[start] = true;
        queue.offer(start);
        
        int level = 0;
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            System.out.print("Level " + level + ": ");
            
            for (int i = 0; i < levelSize; i++) {
                int v = queue.poll();
                System.out.print(v + " ");
                
                for (int neighbor : graph.getNeighbors(v)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        queue.offer(neighbor);
                    }
                }
            }
            
            System.out.println();
            level++;
        }
    }
    
    // Multi-source BFS
    public int[][] multiSourceBFS(Graph graph, List<Integer> sources) {
        int V = graph.getVertexCount();
        int[][] distances = new int[V][sources.size()];
        
        for (int i = 0; i < sources.size(); i++) {
            Arrays.fill(distances[i], -1);
            bfsFromSource(graph, sources.get(i), distances, i);
        }
        
        return distances;
    }
    
    private void bfsFromSource(Graph graph, int source, int[][] distances, int sourceIndex) {
        boolean[] visited = new boolean[graph.getVertexCount()];
        Queue<Integer> queue = new LinkedList<>();
        
        visited[source] = true;
        distances[source][sourceIndex] = 0;
        queue.offer(source);
        
        while (!queue.isEmpty()) {
            int v = queue.poll();
            
            for (int neighbor : graph.getNeighbors(v)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    distances[neighbor][sourceIndex] = distances[v][sourceIndex] + 1;
                    queue.offer(neighbor);
                }
            }
        }
    }
}
```

### 10.3 Connected Components

#### Union-Find for Connected Components
```java
public class UnionFind {
    private int[] parent;
    private int[] rank;
    private int components;
    
    public UnionFind(int n) {
        parent = new int[n];
        rank = new int[n];
        components = n;
        
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            rank[i] = 0;
        }
    }
    
    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]); // Path compression
        }
        return parent[x];
    }
    
    public boolean union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return false; // Already connected
        
        // Union by rank
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
        
        components--;
        return true;
    }
    
    public boolean connected(int x, int y) {
        return find(x) == find(y);
    }
    
    public int getComponents() {
        return components;
    }
}

// Connected Components using DFS
public class ConnectedComponents {
    
    public int countComponents(Graph graph) {
        int V = graph.getVertexCount();
        boolean[] visited = new boolean[V];
        int components = 0;
        
        for (int i = 0; i < V; i++) {
            if (!visited[i]) {
                dfs(graph, i, visited);
                components++;
            }
        }
        
        return components;
    }
    
    private void dfs(Graph graph, int v, boolean[] visited) {
        visited[v] = true;
        
        for (int neighbor : graph.getNeighbors(v)) {
            if (!visited[neighbor]) {
                dfs(graph, neighbor, visited);
            }
        }
    }
    
    public List<List<Integer>> getComponents(Graph graph) {
        int V = graph.getVertexCount();
        boolean[] visited = new boolean[V];
        List<List<Integer>> components = new ArrayList<>();
        
        for (int i = 0; i < V; i++) {
            if (!visited[i]) {
                List<Integer> component = new ArrayList<>();
                dfsComponent(graph, i, visited, component);
                components.add(component);
            }
        }
        
        return components;
    }
    
    private void dfsComponent(Graph graph, int v, boolean[] visited, List<Integer> component) {
        visited[v] = true;
        component.add(v);
        
        for (int neighbor : graph.getNeighbors(v)) {
            if (!visited[neighbor]) {
                dfsComponent(graph, neighbor, visited, component);
            }
        }
    }
}
```

### 10.4 Topological Sorting

#### Topological Sort Implementation
```java
import java.util.*;

public class TopologicalSort {
    
    // Kahn's Algorithm (BFS-based)
    public List<Integer> topologicalSortKahn(Graph graph) {
        int V = graph.getVertexCount();
        int[] indegree = new int[V];
        List<Integer> result = new ArrayList<>();
        
        // Calculate indegrees
        for (int i = 0; i < V; i++) {
            for (int neighbor : graph.getNeighbors(i)) {
                indegree[neighbor]++;
            }
        }
        
        // Add vertices with 0 indegree to queue
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < V; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }
        
        while (!queue.isEmpty()) {
            int v = queue.poll();
            result.add(v);
            
            // Reduce indegree of neighbors
            for (int neighbor : graph.getNeighbors(v)) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }
        
        // Check for cycle
        if (result.size() != V) {
            return new ArrayList<>(); // Cycle detected
        }
        
        return result;
    }
    
    // DFS-based topological sort
    public List<Integer> topologicalSortDFS(Graph graph) {
        int V = graph.getVertexCount();
        boolean[] visited = new boolean[V];
        Stack<Integer> stack = new Stack<>();
        
        for (int i = 0; i < V; i++) {
            if (!visited[i]) {
                dfsTopological(graph, i, visited, stack);
            }
        }
        
        List<Integer> result = new ArrayList<>();
        while (!stack.isEmpty()) {
            result.add(stack.pop());
        }
        
        return result;
    }
    
    private void dfsTopological(Graph graph, int v, boolean[] visited, Stack<Integer> stack) {
        visited[v] = true;
        
        for (int neighbor : graph.getNeighbors(v)) {
            if (!visited[neighbor]) {
                dfsTopological(graph, neighbor, visited, stack);
            }
        }
        
        stack.push(v);
    }
    
    // Course Schedule Problem
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        Graph graph = new Graph(numCourses, true);
        
        for (int[] prereq : prerequisites) {
            graph.addEdge(prereq[1], prereq[0]);
        }
        
        List<Integer> order = topologicalSortKahn(graph);
        return order.size() == numCourses;
    }
    
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        Graph graph = new Graph(numCourses, true);
        
        for (int[] prereq : prerequisites) {
            graph.addEdge(prereq[1], prereq[0]);
        }
        
        List<Integer> order = topologicalSortKahn(graph);
        if (order.size() != numCourses) {
            return new int[0];
        }
        
        return order.stream().mapToInt(i -> i).toArray();
    }
}
```

### 10.5 Shortest Path Algorithms

#### Dijkstra's Algorithm
```java
import java.util.*;

public class DijkstraAlgorithm {
    
    static class Node implements Comparable<Node> {
        int vertex;
        int distance;
        
        Node(int vertex, int distance) {
            this.vertex = vertex;
            this.distance = distance;
        }
        
        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.distance, other.distance);
        }
    }
    
    public int[] dijkstra(WeightedGraph graph, int source) {
        int V = graph.getVertexCount();
        int[] distances = new int[V];
        boolean[] visited = new boolean[V];
        PriorityQueue<Node> pq = new PriorityQueue<>();
        
        Arrays.fill(distances, Integer.MAX_VALUE);
        distances[source] = 0;
        pq.offer(new Node(source, 0));
        
        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.vertex;
            
            if (visited[u]) continue;
            visited[u] = true;
            
            for (WeightedGraph.Edge edge : graph.getNeighbors(u)) {
                int v = edge.dest;
                int weight = edge.weight;
                
                if (!visited[v] && distances[u] + weight < distances[v]) {
                    distances[v] = distances[u] + weight;
                    pq.offer(new Node(v, distances[v]));
                }
            }
        }
        
        return distances;
    }
    
    // Dijkstra with path reconstruction
    public List<Integer> dijkstraPath(WeightedGraph graph, int source, int target) {
        int V = graph.getVertexCount();
        int[] distances = new int[V];
        int[] parent = new int[V];
        boolean[] visited = new boolean[V];
        PriorityQueue<Node> pq = new PriorityQueue<>();
        
        Arrays.fill(distances, Integer.MAX_VALUE);
        Arrays.fill(parent, -1);
        distances[source] = 0;
        pq.offer(new Node(source, 0));
        
        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.vertex;
            
            if (visited[u]) continue;
            visited[u] = true;
            
            if (u == target) break;
            
            for (WeightedGraph.Edge edge : graph.getNeighbors(u)) {
                int v = edge.dest;
                int weight = edge.weight;
                
                if (!visited[v] && distances[u] + weight < distances[v]) {
                    distances[v] = distances[u] + weight;
                    parent[v] = u;
                    pq.offer(new Node(v, distances[v]));
                }
            }
        }
        
        return reconstructPath(parent, source, target);
    }
    
    private List<Integer> reconstructPath(int[] parent, int source, int target) {
        List<Integer> path = new ArrayList<>();
        int current = target;
        
        while (current != -1) {
            path.add(current);
            current = parent[current];
        }
        
        if (path.get(path.size() - 1) != source) {
            return new ArrayList<>(); // No path
        }
        
        Collections.reverse(path);
        return path;
    }
}
```

#### Floyd-Warshall Algorithm
```java
public class FloydWarshall {
    
    public int[][] allPairsShortest(int[][] graph) {
        int V = graph.length;
        int[][] dist = new int[V][V];
        
        // Initialize distances
        for (int i = 0; i < V; i++) {
            for (int j = 0; j < V; j++) {
                if (i == j) {
                    dist[i][j] = 0;
                } else if (graph[i][j] != 0) {
                    dist[i][j] = graph[i][j];
                } else {
                    dist[i][j] = Integer.MAX_VALUE;
                }
            }
        }
        
        // Floyd-Warshall algorithm
        for (int k = 0; k < V; k++) {
            for (int i = 0; i < V; i++) {
                for (int j = 0; j < V; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && 
                        dist[k][j] != Integer.MAX_VALUE &&
                        dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
        
        return dist;
    }
    
    // Detect negative cycles
    public boolean hasNegativeCycle(int[][] graph) {
        int[][] dist = allPairsShortest(graph);
        
        for (int i = 0; i < dist.length; i++) {
            if (dist[i][i] < 0) {
                return true;
            }
        }
        
        return false;
    }
}
```

## Practice Problems

### Easy Level
1. **Find Center of Star Graph** - Find center node in star graph
2. **Find if Path Exists in Graph** - Check if path exists between two nodes
3. **Number of Provinces** - Count connected components
4. **Clone Graph** - Deep copy of graph

### Medium Level
1. **Course Schedule** - Detect cycle in directed graph
2. **Number of Islands** - Count connected components in 2D grid
3. **Rotting Oranges** - Multi-source BFS problem
4. **Word Ladder** - Shortest path with word transformations
5. **Pacific Atlantic Water Flow** - DFS/BFS on 2D grid

### Hard Level
1. **Alien Dictionary** - Topological sort with constraints
2. **Network Delay Time** - Single source shortest path
3. **Critical Connections** - Find bridges in graph
4. **Minimum Spanning Tree** - Kruskal's or Prim's algorithm
5. **Shortest Path Visiting All Nodes** - TSP variant

## Key Patterns

1. **Graph Traversal**: DFS for connectivity, BFS for shortest path
2. **Cycle Detection**: DFS with recursion stack (directed), DFS with colors (undirected)
3. **Topological Sort**: For scheduling and dependency problems
4. **Shortest Path**: Dijkstra for weighted, BFS for unweighted
5. **Connected Components**: Union-Find or DFS
6. **Bipartite Check**: BFS/DFS with 2-coloring

## Time/Space Complexity

| Algorithm | Time | Space |
|-----------|------|-------|
| DFS/BFS | O(V + E) | O(V) |
| Dijkstra | O((V + E) log V) | O(V) |
| Floyd-Warshall | O(V³) | O(V²) |
| Topological Sort | O(V + E) | O(V) |
| Union-Find | O(α(V)) | O(V) |

Where V = vertices, E = edges, α = inverse Ackermann function

## Next Steps
- Implement all graph algorithms
- Practice graph problem patterns
- Study advanced algorithms (MST, strongly connected components)
- Move to **[Module 11: Tries](../11-tries/README.md)**
