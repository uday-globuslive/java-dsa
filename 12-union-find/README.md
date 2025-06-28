# Module 12: Union-Find (Disjoint Set)

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master the Union-Find data structure and its operations
- ✅ Implement both naive and optimized versions (path compression, union by rank)
- ✅ Solve connectivity and grouping problems efficiently
- ✅ Apply Union-Find to graph algorithms and dynamic connectivity
- ✅ Understand when Union-Find is the optimal solution approach

## 🎯 Module Overview
Union-Find (Disjoint Set Union) is a data structure that efficiently handles dynamic connectivity queries. It's essential for:
- **Graph connectivity** - Connected components, MST algorithms
- **Dynamic networks** - Social networks, network connectivity
- **Clustering problems** - Group similar elements
- **Percolation** - Physics and probability applications

**Time Investment:** 4-6 hours
**Difficulty Level:** Intermediate
**Prerequisites:** Arrays, Basic Graph Concepts

## 📖 Core Concepts

### 1. Basic Union-Find Structure
```java
// Naive Implementation
class UnionFind {
    private int[] parent;
    private int components;
    
    public UnionFind(int n) {
        parent = new int[n];
        components = n;
        for (int i = 0; i < n; i++) {
            parent[i] = i; // Each element is its own parent initially
        }
    }
    
    // Find root of element x
    public int find(int x) {
        if (parent[x] != x) {
            return find(parent[x]); // Recursive path to root
        }
        return x;
    }
    
    // Union two sets
    public boolean union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return false; // Already connected
        
        parent[rootX] = rootY; // Make one root parent of other
        components--;
        return true;
    }
    
    // Check if two elements are connected
    public boolean connected(int x, int y) {
        return find(x) == find(y);
    }
    
    public int getComponents() {
        return components;
    }
}
```

### 2. Optimized Union-Find with Path Compression
```java
class OptimizedUnionFind {
    private int[] parent;
    private int[] rank;    // Height of tree (for union by rank)
    private int[] size;    // Size of component (for union by size)
    private int components;
    
    public OptimizedUnionFind(int n) {
        parent = new int[n];
        rank = new int[n];
        size = new int[n];
        components = n;
        
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            rank[i] = 0;
            size[i] = 1;
        }
    }
    
    // Find with path compression
    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]); // Path compression
        }
        return parent[x];
    }
    
    // Union by rank optimization
    public boolean unionByRank(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return false;
        
        // Union by rank: attach smaller tree under larger tree
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++; // Increment rank only when ranks are equal
        }
        
        components--;
        return true;
    }
    
    // Union by size optimization
    public boolean unionBySize(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return false;
        
        // Union by size: attach smaller component to larger
        if (size[rootX] < size[rootY]) {
            parent[rootX] = rootY;
            size[rootY] += size[rootX];
        } else {
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
        
        components--;
        return true;
    }
    
    public int getComponentSize(int x) {
        return size[find(x)];
    }
    
    public boolean connected(int x, int y) {
        return find(x) == find(y);
    }
    
    public int getComponents() {
        return components;
    }
}
```

### 3. Advanced Union-Find Applications

#### Weighted Union-Find
```java
class WeightedUnionFind {
    private int[] parent;
    private double[] weight; // Weight from node to its parent
    
    public WeightedUnionFind(int n) {
        parent = new int[n];
        weight = new double[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            weight[i] = 0.0;
        }
    }
    
    public int find(int x) {
        if (parent[x] != x) {
            int originalParent = parent[x];
            parent[x] = find(parent[x]);
            weight[x] += weight[originalParent];
        }
        return parent[x];
    }
    
    public void union(int x, int y, double ratio) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) return;
        
        parent[rootX] = rootY;
        weight[rootX] = weight[y] - weight[x] + ratio;
    }
    
    public double getRatio(int x, int y) {
        if (find(x) != find(y)) return -1.0; // Not connected
        return weight[x] - weight[y];
    }
}
```

#### Union-Find with Rollback
```java
class RollbackUnionFind {
    private int[] parent;
    private int[] rank;
    private int components;
    private Stack<Operation> history;
    
    private static class Operation {
        int x, y, oldParentY, oldRankX, oldComponents;
        
        Operation(int x, int y, int oldParentY, int oldRankX, int oldComponents) {
            this.x = x;
            this.y = y;
            this.oldParentY = oldParentY;
            this.oldRankX = oldRankX;
            this.oldComponents = oldComponents;
        }
    }
    
    public RollbackUnionFind(int n) {
        parent = new int[n];
        rank = new int[n];
        components = n;
        history = new Stack<>();
        
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            rank[i] = 0;
        }
    }
    
    public int find(int x) {
        while (parent[x] != x) {
            x = parent[x];
        }
        return x;
    }
    
    public boolean union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        
        if (rootX == rootY) {
            history.push(new Operation(-1, -1, -1, -1, components));
            return false;
        }
        
        if (rank[rootX] < rank[rootY]) {
            int temp = rootX;
            rootX = rootY;
            rootY = temp;
        }
        
        history.push(new Operation(rootX, rootY, parent[rootY], rank[rootX], components));
        
        parent[rootY] = rootX;
        if (rank[rootX] == rank[rootY]) {
            rank[rootX]++;
        }
        components--;
        return true;
    }
    
    public void rollback() {
        if (history.isEmpty()) return;
        
        Operation op = history.pop();
        if (op.x == -1) return; // No-op union
        
        parent[op.y] = op.oldParentY;
        rank[op.x] = op.oldRankX;
        components = op.oldComponents;
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Connected Components
- **Use Case:** Find number of connected components in graph
- **Key Insight:** Each union reduces component count by 1
- **Example Problems:** Number of Islands, Friend Circles

### Pattern 2: Percolation
- **Use Case:** Check if path exists from top to bottom
- **Key Insight:** Add virtual top and bottom nodes
- **Example Problems:** Percolation, Surrounded Regions

### Pattern 3: Minimum Spanning Tree
- **Use Case:** Find MST using Kruskal's algorithm
- **Key Insight:** Sort edges, use Union-Find to detect cycles
- **Example Problems:** Connecting Cities, Network Delay Time

### Pattern 4: Dynamic Connectivity
- **Use Case:** Handle connectivity queries with updates
- **Key Insight:** Union-Find excels at dynamic connectivity
- **Example Problems:** Accounts Merge, Redundant Connection

## 💻 Practice Problems

### Easy Level
1. **Friend Circles (LeetCode 547)**
   - Count connected components in friendship graph
   - Time: O(n²α(n)), Space: O(n)

2. **Number of Islands (LeetCode 200)**
   - Can be solved with Union-Find or DFS
   - Union-Find approach: O(mn × α(mn))

### Medium Level
3. **Accounts Merge (LeetCode 721)**
   - Group accounts belonging to same person
   - Union accounts with common emails

4. **Redundant Connection (LeetCode 684)**
   - Find edge that creates cycle in tree
   - Use Union-Find to detect when cycle is formed

5. **Most Stones Removed (LeetCode 947)**
   - Connect stones in same row/column
   - Count stones minus number of components

6. **Satisfiability of Equality Equations (LeetCode 990)**
   - Process equality and inequality constraints
   - Union equal variables, check inequalities

### Hard Level
7. **Number of Islands II (LeetCode 305)**
   - Dynamic island creation with connectivity queries
   - Online Union-Find with coordinate compression

8. **Minimize Malware Spread (LeetCode 924)**
   - Remove node that minimizes malware spread
   - Complex Union-Find application with simulation

## 🧠 Problem-Solving Templates

### Template 1: Basic Connected Components
```java
public int countComponents(int n, int[][] edges) {
    UnionFind uf = new UnionFind(n);
    
    for (int[] edge : edges) {
        uf.union(edge[0], edge[1]);
    }
    
    return uf.getComponents();
}
```

### Template 2: Grid-based Union-Find
```java
public int numIslands(char[][] grid) {
    if (grid == null || grid.length == 0) return 0;
    
    int m = grid.length, n = grid[0].length;
    UnionFind uf = new UnionFind(m * n);
    int islands = 0;
    
    // Count initial islands
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '1') {
                islands++;
            }
        }
    }
    
    int[][] directions = {{0,1}, {1,0}, {0,-1}, {-1,0}};
    
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '1') {
                for (int[] dir : directions) {
                    int x = i + dir[0], y = j + dir[1];
                    if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == '1') {
                        if (uf.union(i * n + j, x * n + y)) {
                            islands--;
                        }
                    }
                }
            }
        }
    }
    
    return islands;
}
```

### Template 3: Kruskal's MST Algorithm
```java
public int minimumCostToConnectSticks(int[] sticks) {
    Arrays.sort(sticks);
    UnionFind uf = new UnionFind(sticks.length);
    int totalCost = 0;
    
    for (int i = 1; i < sticks.length; i++) {
        int cost = sticks[i] + sticks[i-1];
        if (uf.union(i, i-1)) {
            totalCost += cost;
        }
    }
    
    return totalCost;
}
```

## ⚡ Optimization Techniques

### 1. Path Compression
- **Benefit:** Reduces tree height to nearly constant
- **Implementation:** Make every node point directly to root
- **Amortized Complexity:** O(α(n)) per operation

### 2. Union by Rank/Size
- **Benefit:** Keeps trees balanced
- **Union by Rank:** Attach tree with smaller height to larger height
- **Union by Size:** Attach smaller component to larger component

### 3. Small to Large Technique
```java
// For problems requiring merging data structures
public void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    
    if (size[rootX] < size[rootY]) {
        // Swap to ensure rootX has larger component
        int temp = rootX;
        rootX = rootY;
        rootY = temp;
    }
    
    parent[rootY] = rootX;
    size[rootX] += size[rootY];
    
    // Merge additional data structures here
    mergeSets(rootX, rootY);
}
```

## 📈 Complexity Analysis

### Time Complexities (with optimizations)
- **Find:** O(α(n)) amortized
- **Union:** O(α(n)) amortized  
- **Connected:** O(α(n)) amortized
- **α(n):** Inverse Ackermann function (effectively constant for practical values)

### Space Complexity
- **Basic:** O(n) for parent array
- **With rank/size:** O(n) for additional arrays
- **Weighted:** O(n) for weight information

### Real-world Performance
- α(n) ≤ 4 for n ≤ 2^65536 (astronomically large)
- In practice, Union-Find operations are nearly O(1)

## 🎯 Key Takeaways

1. **When to Use Union-Find:**
   - Dynamic connectivity queries
   - Connected components in graphs
   - Cycle detection in undirected graphs
   - Clustering and grouping problems

2. **Common Pitfalls:**
   - Forgetting path compression optimization
   - Not using union by rank/size
   - Confusing find() return values
   - Off-by-one errors in grid problems

3. **Best Practices:**
   - Always implement path compression
   - Use union by rank or size for balance
   - Consider coordinate compression for sparse grids
   - Test with both connected and disconnected cases

4. **Alternative Approaches:**
   - DFS/BFS for static connectivity (when no updates)
   - Segment trees for range connectivity
   - Link-cut trees for dynamic tree connectivity

## 🚀 Next Steps
- Master the basic operations and optimizations
- Practice grid-based problems with coordinate mapping
- Study Kruskal's algorithm application
- Move to **Module 13: Advanced Trees** for segment trees and more

---
*Union-Find is a fundamental data structure that appears in many algorithmic contexts. The key is understanding when dynamic connectivity is the core problem and applying the appropriate optimizations for your use case.*
