# Module 20: Graph Algorithms

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master advanced graph algorithms beyond basic DFS/BFS
- ✅ Implement shortest path algorithms (Dijkstra, Bellman-Ford, Floyd-Warshall)
- ✅ Solve minimum spanning tree problems (Kruskal, Prim)
- ✅ Handle network flow and maximum flow problems
- ✅ Apply graph algorithms to real-world optimization problems

## 🎯 Module Overview
Advanced graph algorithms solve complex optimization and connectivity problems:
- **Shortest Paths** - Finding optimal routes in weighted graphs
- **Minimum Spanning Trees** - Connecting all nodes with minimum cost
- **Network Flow** - Maximizing flow through networks
- **Advanced Traversals** - Topological sorting, strongly connected components

**Time Investment:** 10-12 hours
**Difficulty Level:** Advanced
**Prerequisites:** Basic Graph Concepts (Module 10), Union-Find, Priority Queues

## 📖 Core Concepts

### 1. Shortest Path Algorithms

#### Dijkstra's Algorithm (Single Source, Non-negative Weights)
```java
import java.util.*;

public class DijkstraAlgorithm {
    static class Edge {
        int to, weight;
        Edge(int to, int weight) {
            this.to = to;
            this.weight = weight;
        }
    }
    
    static class Node implements Comparable<Node> {
        int vertex, distance;
        Node(int vertex, int distance) {
            this.vertex = vertex;
            this.distance = distance;
        }
        
        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.distance, other.distance);
        }
    }
    
    public int[] dijkstra(List<List<Edge>> graph, int source) {
        int n = graph.size();
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        
        PriorityQueue<Node> pq = new PriorityQueue<>();
        dist[source] = 0;
        pq.offer(new Node(source, 0));
        
        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.vertex;
            
            // Skip if we've found a better path
            if (current.distance > dist[u]) continue;
            
            // Relax all neighbors
            for (Edge edge : graph.get(u)) {
                int v = edge.to;
                int weight = edge.weight;
                
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new Node(v, dist[v]));
                }
            }
        }
        
        return dist;
    }
    
    // Path reconstruction
    public List<Integer> getPath(int[] parent, int target) {
        List<Integer> path = new ArrayList<>();
        for (int i = target; i != -1; i = parent[i]) {
            path.add(i);
        }
        Collections.reverse(path);
        return path;
    }
    
    // Dijkstra with path tracking
    public Result dijkstraWithPath(List<List<Edge>> graph, int source, int target) {
        int n = graph.size();
        int[] dist = new int[n];
        int[] parent = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        Arrays.fill(parent, -1);
        
        PriorityQueue<Node> pq = new PriorityQueue<>();
        dist[source] = 0;
        pq.offer(new Node(source, 0));
        
        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.vertex;
            
            if (u == target) break; // Early termination
            if (current.distance > dist[u]) continue;
            
            for (Edge edge : graph.get(u)) {
                int v = edge.to;
                int weight = edge.weight;
                
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    parent[v] = u;
                    pq.offer(new Node(v, dist[v]));
                }
            }
        }
        
        return new Result(dist[target], getPath(parent, target));
    }
    
    static class Result {
        int distance;
        List<Integer> path;
        Result(int distance, List<Integer> path) {
            this.distance = distance;
            this.path = path;
        }
    }
}
```

#### Bellman-Ford Algorithm (Handles Negative Weights)
```java
public class BellmanFordAlgorithm {
    static class Edge {
        int from, to, weight;
        Edge(int from, int to, int weight) {
            this.from = from;
            this.to = to;
            this.weight = weight;
        }
    }
    
    public int[] bellmanFord(int n, List<Edge> edges, int source) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[source] = 0;
        
        // Relax edges n-1 times
        for (int i = 0; i < n - 1; i++) {
            for (Edge edge : edges) {
                if (dist[edge.from] != Integer.MAX_VALUE &&
                    dist[edge.from] + edge.weight < dist[edge.to]) {
                    dist[edge.to] = dist[edge.from] + edge.weight;
                }
            }
        }
        
        // Check for negative cycles
        for (Edge edge : edges) {
            if (dist[edge.from] != Integer.MAX_VALUE &&
                dist[edge.from] + edge.weight < dist[edge.to]) {
                throw new RuntimeException("Graph contains negative cycle");
            }
        }
        
        return dist;
    }
    
    // Detect negative cycle reachable from source
    public boolean hasNegativeCycle(int n, List<Edge> edges, int source) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[source] = 0;
        
        // Relax edges n-1 times
        for (int i = 0; i < n - 1; i++) {
            for (Edge edge : edges) {
                if (dist[edge.from] != Integer.MAX_VALUE) {
                    dist[edge.to] = Math.min(dist[edge.to], 
                                           dist[edge.from] + edge.weight);
                }
            }
        }
        
        // Check if any distance can still be reduced
        for (Edge edge : edges) {
            if (dist[edge.from] != Integer.MAX_VALUE &&
                dist[edge.from] + edge.weight < dist[edge.to]) {
                return true;
            }
        }
        
        return false;
    }
}
```

#### Floyd-Warshall Algorithm (All Pairs Shortest Path)
```java
public class FloydWarshallAlgorithm {
    public int[][] floydWarshall(int[][] graph) {
        int n = graph.length;
        int[][] dist = new int[n][n];
        
        // Initialize distances
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
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
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
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
    
    // Path reconstruction for Floyd-Warshall
    public List<Integer> reconstructPath(int[][] next, int i, int j) {
        if (next[i][j] == -1) return new ArrayList<>();
        
        List<Integer> path = new ArrayList<>();
        path.add(i);
        
        while (i != j) {
            i = next[i][j];
            path.add(i);
        }
        
        return path;
    }
    
    public PathResult floydWarshallWithPath(int[][] graph) {
        int n = graph.length;
        int[][] dist = new int[n][n];
        int[][] next = new int[n][n];
        
        // Initialize
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                dist[i][j] = (i == j) ? 0 : 
                           (graph[i][j] != 0 ? graph[i][j] : Integer.MAX_VALUE);
                next[i][j] = (graph[i][j] != 0) ? j : -1;
            }
        }
        
        // Main algorithm
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && 
                        dist[k][j] != Integer.MAX_VALUE &&
                        dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                        next[i][j] = next[i][k];
                    }
                }
            }
        }
        
        return new PathResult(dist, next);
    }
    
    static class PathResult {
        int[][] distances;
        int[][] next;
        PathResult(int[][] distances, int[][] next) {
            this.distances = distances;
            this.next = next;
        }
    }
}
```

### 2. Minimum Spanning Tree Algorithms

#### Kruskal's Algorithm (Union-Find Based)
```java
public class KruskalAlgorithm {
    static class Edge implements Comparable<Edge> {
        int from, to, weight;
        Edge(int from, int to, int weight) {
            this.from = from;
            this.to = to;
            this.weight = weight;
        }
        
        @Override
        public int compareTo(Edge other) {
            return Integer.compare(this.weight, other.weight);
        }
    }
    
    static class UnionFind {
        int[] parent, rank;
        
        UnionFind(int n) {
            parent = new int[n];
            rank = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
        }
        
        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }
        
        boolean union(int x, int y) {
            int px = find(x), py = find(y);
            if (px == py) return false;
            
            if (rank[px] < rank[py]) {
                parent[px] = py;
            } else if (rank[px] > rank[py]) {
                parent[py] = px;
            } else {
                parent[py] = px;
                rank[px]++;
            }
            return true;
        }
    }
    
    public List<Edge> kruskal(int n, List<Edge> edges) {
        Collections.sort(edges); // Sort by weight
        UnionFind uf = new UnionFind(n);
        List<Edge> mst = new ArrayList<>();
        
        for (Edge edge : edges) {
            if (uf.union(edge.from, edge.to)) {
                mst.add(edge);
                if (mst.size() == n - 1) break; // MST complete
            }
        }
        
        return mst;
    }
    
    public int mstWeight(int n, List<Edge> edges) {
        List<Edge> mst = kruskal(n, edges);
        return mst.stream().mapToInt(e -> e.weight).sum();
    }
}
```

#### Prim's Algorithm (Priority Queue Based)
```java
public class PrimAlgorithm {
    static class Edge {
        int to, weight;
        Edge(int to, int weight) {
            this.to = to;
            this.weight = weight;
        }
    }
    
    static class Node implements Comparable<Node> {
        int vertex, weight;
        Node(int vertex, int weight) {
            this.vertex = vertex;
            this.weight = weight;
        }
        
        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.weight, other.weight);
        }
    }
    
    public List<Edge> prim(List<List<Edge>> graph) {
        int n = graph.size();
        boolean[] inMST = new boolean[n];
        PriorityQueue<Node> pq = new PriorityQueue<>();
        List<Edge> mst = new ArrayList<>();
        
        // Start from vertex 0
        inMST[0] = true;
        for (Edge edge : graph.get(0)) {
            pq.offer(new Node(edge.to, edge.weight));
        }
        
        while (!pq.isEmpty() && mst.size() < n - 1) {
            Node current = pq.poll();
            int v = current.vertex;
            
            if (inMST[v]) continue;
            
            // Add vertex to MST
            inMST[v] = true;
            mst.add(new Edge(v, current.weight));
            
            // Add all edges from new vertex
            for (Edge edge : graph.get(v)) {
                if (!inMST[edge.to]) {
                    pq.offer(new Node(edge.to, edge.weight));
                }
            }
        }
        
        return mst;
    }
    
    public int primWeight(List<List<Edge>> graph) {
        return prim(graph).stream().mapToInt(e -> e.weight).sum();
    }
}
```

### 3. Network Flow Algorithms

#### Ford-Fulkerson Algorithm (Maximum Flow)
```java
public class FordFulkersonAlgorithm {
    private int[][] capacity;
    private int[][] flow;
    private int n;
    
    public FordFulkersonAlgorithm(int[][] capacity) {
        this.n = capacity.length;
        this.capacity = new int[n][n];
        this.flow = new int[n][n];
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                this.capacity[i][j] = capacity[i][j];
            }
        }
    }
    
    public int maxFlow(int source, int sink) {
        int totalFlow = 0;
        int[] parent = new int[n];
        
        while (bfs(source, sink, parent)) {
            // Find minimum capacity along the path
            int pathFlow = Integer.MAX_VALUE;
            for (int v = sink; v != source; v = parent[v]) {
                int u = parent[v];
                pathFlow = Math.min(pathFlow, capacity[u][v] - flow[u][v]);
            }
            
            // Update flow along the path
            for (int v = sink; v != source; v = parent[v]) {
                int u = parent[v];
                flow[u][v] += pathFlow;
                flow[v][u] -= pathFlow; // Reverse edge
            }
            
            totalFlow += pathFlow;
        }
        
        return totalFlow;
    }
    
    private boolean bfs(int source, int sink, int[] parent) {
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(source);
        visited[source] = true;
        parent[source] = -1;
        
        while (!queue.isEmpty()) {
            int u = queue.poll();
            
            for (int v = 0; v < n; v++) {
                if (!visited[v] && capacity[u][v] - flow[u][v] > 0) {
                    visited[v] = true;
                    parent[v] = u;
                    if (v == sink) return true;
                    queue.offer(v);
                }
            }
        }
        
        return false;
    }
    
    // Get minimum cut
    public Set<Integer> getMinCut(int source) {
        Set<Integer> cut = new HashSet<>();
        boolean[] visited = new boolean[n];
        dfsResidual(source, visited);
        
        for (int i = 0; i < n; i++) {
            if (visited[i]) cut.add(i);
        }
        
        return cut;
    }
    
    private void dfsResidual(int u, boolean[] visited) {
        visited[u] = true;
        for (int v = 0; v < n; v++) {
            if (!visited[v] && capacity[u][v] - flow[u][v] > 0) {
                dfsResidual(v, visited);
            }
        }
    }
}
```

### 4. Advanced Graph Algorithms

#### Strongly Connected Components (Kosaraju's Algorithm)
```java
public class StronglyConnectedComponents {
    public List<List<Integer>> kosaraju(List<List<Integer>> graph) {
        int n = graph.size();
        boolean[] visited = new boolean[n];
        Stack<Integer> finishOrder = new Stack<>();
        
        // Step 1: DFS on original graph to get finish times
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs1(graph, i, visited, finishOrder);
            }
        }
        
        // Step 2: Create transpose graph
        List<List<Integer>> transpose = createTranspose(graph);
        
        // Step 3: DFS on transpose in reverse finish order
        Arrays.fill(visited, false);
        List<List<Integer>> sccs = new ArrayList<>();
        
        while (!finishOrder.isEmpty()) {
            int v = finishOrder.pop();
            if (!visited[v]) {
                List<Integer> scc = new ArrayList<>();
                dfs2(transpose, v, visited, scc);
                sccs.add(scc);
            }
        }
        
        return sccs;
    }
    
    private void dfs1(List<List<Integer>> graph, int u, boolean[] visited, Stack<Integer> stack) {
        visited[u] = true;
        for (int v : graph.get(u)) {
            if (!visited[v]) {
                dfs1(graph, v, visited, stack);
            }
        }
        stack.push(u);
    }
    
    private void dfs2(List<List<Integer>> graph, int u, boolean[] visited, List<Integer> scc) {
        visited[u] = true;
        scc.add(u);
        for (int v : graph.get(u)) {
            if (!visited[v]) {
                dfs2(graph, v, visited, scc);
            }
        }
    }
    
    private List<List<Integer>> createTranspose(List<List<Integer>> graph) {
        int n = graph.size();
        List<List<Integer>> transpose = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            transpose.add(new ArrayList<>());
        }
        
        for (int u = 0; u < n; u++) {
            for (int v : graph.get(u)) {
                transpose.get(v).add(u);
            }
        }
        
        return transpose;
    }
}
```

#### Articulation Points and Bridges
```java
public class ArticulationPointsAndBridges {
    private int timer;
    private boolean[] visited;
    private int[] disc, low, parent;
    private boolean[] ap;
    private List<int[]> bridges;
    
    public void findArticulationPoints(List<List<Integer>> graph) {
        int n = graph.size();
        timer = 0;
        visited = new boolean[n];
        disc = new int[n];
        low = new int[n];
        parent = new int[n];
        ap = new boolean[n];
        Arrays.fill(parent, -1);
        
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                apDFS(graph, i);
            }
        }
    }
    
    private void apDFS(List<List<Integer>> graph, int u) {
        int children = 0;
        visited[u] = true;
        disc[u] = low[u] = ++timer;
        
        for (int v : graph.get(u)) {
            if (!visited[v]) {
                children++;
                parent[v] = u;
                apDFS(graph, v);
                
                low[u] = Math.min(low[u], low[v]);
                
                // Check articulation point conditions
                if (parent[u] == -1 && children > 1) {
                    ap[u] = true; // Root with multiple children
                }
                
                if (parent[u] != -1 && low[v] >= disc[u]) {
                    ap[u] = true; // Non-root with condition
                }
            } else if (v != parent[u]) {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }
    
    public void findBridges(List<List<Integer>> graph) {
        int n = graph.size();
        timer = 0;
        visited = new boolean[n];
        disc = new int[n];
        low = new int[n];
        parent = new int[n];
        bridges = new ArrayList<>();
        Arrays.fill(parent, -1);
        
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                bridgeDFS(graph, i);
            }
        }
    }
    
    private void bridgeDFS(List<List<Integer>> graph, int u) {
        visited[u] = true;
        disc[u] = low[u] = ++timer;
        
        for (int v : graph.get(u)) {
            if (!visited[v]) {
                parent[v] = u;
                bridgeDFS(graph, v);
                
                low[u] = Math.min(low[u], low[v]);
                
                // Check bridge condition
                if (low[v] > disc[u]) {
                    bridges.add(new int[]{u, v});
                }
            } else if (v != parent[u]) {
                low[u] = Math.min(low[u], disc[v]);
            }
        }
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Single Source Shortest Path
- **Use Case:** Find shortest path from one source to all vertices
- **Key Insight:** Choose algorithm based on edge weights
- **Example Problems:** Network Delay Time, Cheapest Flights

### Pattern 2: All Pairs Shortest Path
- **Use Case:** Find shortest paths between all pairs of vertices
- **Key Insight:** Floyd-Warshall for dense graphs, Dijkstra for sparse
- **Example Problems:** City Connections, Graph Metrics

### Pattern 3: Minimum Spanning Tree
- **Use Case:** Connect all vertices with minimum total edge weight
- **Key Insight:** Kruskal for sparse graphs, Prim for dense graphs
- **Example Problems:** Connecting Cities, Network Design

### Pattern 4: Maximum Flow
- **Use Case:** Find maximum flow through a network
- **Key Insight:** Model as source-sink flow problem
- **Example Problems:** Maximum Bipartite Matching, Capacity Planning

## 💻 Practice Problems

### Medium Level
1. **Network Delay Time (LeetCode 743)**
   - Single source shortest path with Dijkstra
   - Find time for signal to reach all nodes

2. **Cheapest Flights Within K Stops (LeetCode 787)**
   - Modified Dijkstra with constraint on number of stops
   - Handle intermediate vertices limitation

3. **Find Critical and Pseudo-Critical Edges in MST (LeetCode 1489)**
   - MST variations with edge classification
   - Use Union-Find with edge testing

### Hard Level
4. **Alien Dictionary (LeetCode 269)**
   - Topological sort with custom ordering
   - Build dependency graph from word ordering

5. **Swim in Rising Water (LeetCode 778)**
   - Binary search + graph connectivity
   - Find minimum time to reach destination

6. **Maximum Flow Problems**
   - Bipartite matching, min-cut problems
   - Network capacity and flow optimization

## 🧠 Problem-Solving Templates

### Template 1: Dijkstra's Algorithm
```java
public int[] dijkstra(List<List<int[]>> graph, int source) {
    int n = graph.size();
    int[] dist = new int[n];
    Arrays.fill(dist, Integer.MAX_VALUE);
    
    PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
    dist[source] = 0;
    pq.offer(new int[]{source, 0});
    
    while (!pq.isEmpty()) {
        int[] current = pq.poll();
        int u = current[0], d = current[1];
        
        if (d > dist[u]) continue;
        
        for (int[] edge : graph.get(u)) {
            int v = edge[0], weight = edge[1];
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.offer(new int[]{v, dist[v]});
            }
        }
    }
    
    return dist;
}
```

### Template 2: Union-Find for MST
```java
public int mstWeight(int n, int[][] edges) {
    Arrays.sort(edges, (a, b) -> a[2] - b[2]);
    UnionFind uf = new UnionFind(n);
    int weight = 0, edgeCount = 0;
    
    for (int[] edge : edges) {
        if (uf.union(edge[0], edge[1])) {
            weight += edge[2];
            if (++edgeCount == n - 1) break;
        }
    }
    
    return weight;
}
```

## ⚡ Optimization Techniques

### 1. Algorithm Selection
- **Dijkstra:** Non-negative weights, single source
- **Bellman-Ford:** Negative weights, single source
- **Floyd-Warshall:** All pairs, dense graphs
- **A*:** Heuristic-guided search

### 2. Data Structure Optimization
- **Fibonacci Heap:** Better theoretical bounds for Dijkstra
- **Binary Heap:** Good practical performance
- **Array-based:** For dense graphs

### 3. Early Termination
- **Target reached:** Stop Dijkstra when target found
- **Bidirectional search:** Search from both ends
- **Pruning:** Skip unnecessary computations

## 📈 Complexity Analysis

### Time Complexities
- **Dijkstra:** O((V + E) log V) with binary heap
- **Bellman-Ford:** O(VE)
- **Floyd-Warshall:** O(V³)
- **Kruskal:** O(E log E)
- **Prim:** O((V + E) log V)

### Space Complexities
- **Adjacency List:** O(V + E)
- **Adjacency Matrix:** O(V²)
- **Distance Arrays:** O(V) or O(V²)

## 🎯 Key Takeaways

1. **Algorithm Selection:**
   - Consider edge weights (negative/positive)
   - Graph density (sparse/dense)
   - Single source vs all pairs

2. **Implementation Tips:**
   - Use appropriate data structures
   - Handle edge cases (disconnected graphs)
   - Consider early termination optimizations

3. **Common Applications:**
   - Route planning and navigation
   - Network optimization
   - Resource allocation
   - Social network analysis

## 🚀 Next Steps
- Practice implementing algorithms from scratch
- Study advanced topics like A* search and network flow variants
- Apply to real-world optimization problems
- Move to **Module 21: String Algorithms** for text processing

---
*Advanced graph algorithms are essential for solving complex optimization problems. Master these techniques to handle routing, networking, and resource allocation challenges in competitive programming and system design.*
