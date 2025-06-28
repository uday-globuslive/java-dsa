# Module 18: Greedy Algorithms

## Learning Objectives
By the end of this module, you will:
- Understand the greedy choice principle and optimal substructure
- Master classic greedy algorithms and their applications
- Recognize when greedy approach leads to optimal solutions
- Solve optimization problems using greedy strategies
- Apply greedy patterns to interview and competitive programming problems

## Module Content

### 18.1 Greedy Algorithm Fundamentals

#### Greedy Algorithm Properties
```java
/*
Greedy Algorithm Characteristics:
1. Greedy Choice Property: Local optimal choice leads to global optimal solution
2. Optimal Substructure: Problem can be broken down into subproblems
3. No Backtracking: Once a choice is made, it's never reconsidered
4. Fast Execution: Usually O(n log n) or better

When to Use Greedy:
- Activity selection problems
- Minimum spanning tree
- Huffman coding
- Fractional knapsack
- Job scheduling

When NOT to Use Greedy:
- 0/1 Knapsack problem
- Longest common subsequence
- Most shortest path problems (except specific cases)
*/
```

#### Template for Greedy Problems
```java
import java.util.*;

public class GreedyTemplate {
    
    // General greedy algorithm template
    public static <T> List<T> greedyAlgorithm(List<T> candidates, 
                                            Comparator<T> comparator,
                                            Predicate<List<T>, T> isValid) {
        List<T> solution = new ArrayList<>();
        
        // Sort candidates based on greedy criterion
        candidates.sort(comparator);
        
        for (T candidate : candidates) {
            // Check if adding this candidate maintains feasibility
            if (isValid.test(solution, candidate)) {
                solution.add(candidate);
            }
        }
        
        return solution;
    }
    
    @FunctionalInterface
    interface Predicate<T, U> {
        boolean test(T t, U u);
    }
}
```

### 18.2 Classic Greedy Problems

#### Activity Selection Problem
```java
import java.util.*;

public class ActivitySelection {
    
    static class Activity {
        int start, end;
        String name;
        
        Activity(int start, int end, String name) {
            this.start = start;
            this.end = end;
            this.name = name;
        }
        
        @Override
        public String toString() {
            return name + "[" + start + "," + end + "]";
        }
    }
    
    // Select maximum number of non-overlapping activities
    public List<Activity> selectActivities(List<Activity> activities) {
        if (activities.isEmpty()) return new ArrayList<>();
        
        // Sort by finish time (greedy choice)
        activities.sort(Comparator.comparingInt(a -> a.end));
        
        List<Activity> selected = new ArrayList<>();
        selected.add(activities.get(0));
        
        int lastEndTime = activities.get(0).end;
        
        for (int i = 1; i < activities.size(); i++) {
            Activity current = activities.get(i);
            
            // If current activity starts after last selected activity ends
            if (current.start >= lastEndTime) {
                selected.add(current);
                lastEndTime = current.end;
            }
        }
        
        return selected;
    }
    
    // Variation: Maximum weight activities (weighted job scheduling)
    public int maxWeightActivities(List<Activity> activities, int[] weights) {
        int n = activities.size();
        
        // Create indexed activities for tracking
        List<int[]> indexedActivities = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            indexedActivities.add(new int[]{activities.get(i).start, activities.get(i).end, weights[i], i});
        }
        
        // Sort by end time
        indexedActivities.sort(Comparator.comparingInt(a -> a[1]));
        
        int[] dp = new int[n];
        dp[0] = indexedActivities.get(0)[2]; // First activity weight
        
        for (int i = 1; i < n; i++) {
            // Option 1: Don't include current activity
            int exclude = dp[i - 1];
            
            // Option 2: Include current activity
            int include = indexedActivities.get(i)[2];
            int latestNonOverlapping = findLatestNonOverlapping(indexedActivities, i);
            
            if (latestNonOverlapping != -1) {
                include += dp[latestNonOverlapping];
            }
            
            dp[i] = Math.max(exclude, include);
        }
        
        return dp[n - 1];
    }
    
    private int findLatestNonOverlapping(List<int[]> activities, int current) {
        int currentStart = activities.get(current)[0];
        
        // Binary search for latest activity that ends before current starts
        int left = 0, right = current - 1, result = -1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (activities.get(mid)[1] <= currentStart) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        ActivitySelection as = new ActivitySelection();
        
        List<Activity> activities = Arrays.asList(
            new Activity(1, 3, "A1"),
            new Activity(2, 5, "A2"),
            new Activity(4, 6, "A3"),
            new Activity(6, 7, "A4"),
            new Activity(5, 8, "A5"),
            new Activity(8, 9, "A6")
        );
        
        List<Activity> selected = as.selectActivities(activities);
        System.out.println("Selected activities: " + selected);
    }
}
```

#### Fractional Knapsack
```java
import java.util.*;

public class FractionalKnapsack {
    
    static class Item {
        int weight, value;
        double ratio;
        
        Item(int weight, int value) {
            this.weight = weight;
            this.value = value;
            this.ratio = (double) value / weight;
        }
        
        @Override
        public String toString() {
            return "Item{w=" + weight + ", v=" + value + ", r=" + String.format("%.2f", ratio) + "}";
        }
    }
    
    public double fractionalKnapsack(int capacity, List<Item> items) {
        // Sort by value-to-weight ratio (greedy choice)
        items.sort((a, b) -> Double.compare(b.ratio, a.ratio));
        
        double totalValue = 0;
        int remainingCapacity = capacity;
        
        for (Item item : items) {
            if (remainingCapacity <= 0) break;
            
            if (item.weight <= remainingCapacity) {
                // Take entire item
                totalValue += item.value;
                remainingCapacity -= item.weight;
                System.out.println("Taking full item: " + item);
            } else {
                // Take fraction of item
                double fraction = (double) remainingCapacity / item.weight;
                totalValue += item.value * fraction;
                System.out.println("Taking " + String.format("%.2f", fraction) + 
                                 " of item: " + item);
                remainingCapacity = 0;
            }
        }
        
        return totalValue;
    }
    
    public static void main(String[] args) {
        FractionalKnapsack fk = new FractionalKnapsack();
        
        List<Item> items = Arrays.asList(
            new Item(10, 60),  // ratio = 6
            new Item(20, 100), // ratio = 5
            new Item(30, 120)  // ratio = 4
        );
        
        int capacity = 50;
        double maxValue = fk.fractionalKnapsack(capacity, items);
        System.out.println("Maximum value: " + maxValue);
    }
}
```

#### Job Scheduling Problems
```java
import java.util.*;

public class JobScheduling {
    
    static class Job {
        int id, deadline, profit;
        
        Job(int id, int deadline, int profit) {
            this.id = id;
            this.deadline = deadline;
            this.profit = profit;
        }
        
        @Override
        public String toString() {
            return "Job" + id + "(d=" + deadline + ",p=" + profit + ")";
        }
    }
    
    // Job scheduling to maximize profit
    public List<Job> scheduleJobs(List<Job> jobs) {
        // Sort by profit in descending order (greedy choice)
        jobs.sort((a, b) -> b.profit - a.profit);
        
        // Find maximum deadline
        int maxDeadline = jobs.stream().mapToInt(j -> j.deadline).max().orElse(0);
        
        // Initialize time slots
        boolean[] timeSlot = new boolean[maxDeadline + 1];
        List<Job> scheduledJobs = new ArrayList<>();
        
        for (Job job : jobs) {
            // Find latest available time slot before deadline
            for (int t = job.deadline; t >= 1; t--) {
                if (!timeSlot[t]) {
                    timeSlot[t] = true;
                    scheduledJobs.add(job);
                    break;
                }
            }
        }
        
        return scheduledJobs;
    }
    
    // Job scheduling with deadlines (Union-Find optimization)
    public List<Job> scheduleJobsOptimized(List<Job> jobs) {
        jobs.sort((a, b) -> b.profit - a.profit);
        
        int maxDeadline = jobs.stream().mapToInt(j -> j.deadline).max().orElse(0);
        
        // Union-Find for efficient slot finding
        int[] parent = new int[maxDeadline + 1];
        for (int i = 0; i <= maxDeadline; i++) {
            parent[i] = i;
        }
        
        List<Job> result = new ArrayList<>();
        
        for (Job job : jobs) {
            int availableSlot = findParent(parent, job.deadline);
            
            if (availableSlot > 0) {
                result.add(job);
                // Union current slot with previous slot
                parent[availableSlot] = availableSlot - 1;
            }
        }
        
        return result;
    }
    
    private int findParent(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = findParent(parent, parent[x]);
        }
        return parent[x];
    }
    
    // Minimum number of platforms needed
    public int minPlatforms(int[] arrival, int[] departure) {
        Arrays.sort(arrival);
        Arrays.sort(departure);
        
        int platforms = 0, maxPlatforms = 0;
        int i = 0, j = 0;
        
        while (i < arrival.length && j < departure.length) {
            if (arrival[i] <= departure[j]) {
                platforms++;
                maxPlatforms = Math.max(maxPlatforms, platforms);
                i++;
            } else {
                platforms--;
                j++;
            }
        }
        
        return maxPlatforms;
    }
    
    public static void main(String[] args) {
        JobScheduling js = new JobScheduling();
        
        List<Job> jobs = Arrays.asList(
            new Job(1, 2, 100),
            new Job(2, 1, 19),
            new Job(3, 2, 27),
            new Job(4, 1, 25),
            new Job(5, 3, 15)
        );
        
        List<Job> scheduled = js.scheduleJobs(jobs);
        System.out.println("Scheduled jobs: " + scheduled);
        
        int totalProfit = scheduled.stream().mapToInt(j -> j.profit).sum();
        System.out.println("Total profit: " + totalProfit);
    }
}
```

### 18.3 Greedy Graph Algorithms

#### Minimum Spanning Tree - Kruskal's Algorithm
```java
import java.util.*;

public class KruskalMST {
    
    static class Edge implements Comparable<Edge> {
        int src, dest, weight;
        
        Edge(int src, int dest, int weight) {
            this.src = src;
            this.dest = dest;
            this.weight = weight;
        }
        
        @Override
        public int compareTo(Edge other) {
            return Integer.compare(this.weight, other.weight);
        }
        
        @Override
        public String toString() {
            return "(" + src + "-" + dest + ":" + weight + ")";
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
            int rootX = find(x);
            int rootY = find(y);
            
            if (rootX == rootY) return false;
            
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
            
            return true;
        }
    }
    
    public List<Edge> kruskalMST(int vertices, List<Edge> edges) {
        List<Edge> mst = new ArrayList<>();
        UnionFind uf = new UnionFind(vertices);
        
        // Sort edges by weight (greedy choice)
        Collections.sort(edges);
        
        for (Edge edge : edges) {
            if (uf.union(edge.src, edge.dest)) {
                mst.add(edge);
                
                // MST has exactly V-1 edges
                if (mst.size() == vertices - 1) {
                    break;
                }
            }
        }
        
        return mst;
    }
    
    public static void main(String[] args) {
        KruskalMST kmst = new KruskalMST();
        
        List<Edge> edges = Arrays.asList(
            new Edge(0, 1, 4),
            new Edge(0, 7, 8),
            new Edge(1, 2, 8),
            new Edge(1, 7, 11),
            new Edge(2, 3, 7),
            new Edge(2, 8, 2),
            new Edge(2, 5, 4),
            new Edge(3, 4, 9),
            new Edge(3, 5, 14),
            new Edge(4, 5, 10),
            new Edge(5, 6, 2),
            new Edge(6, 7, 1),
            new Edge(6, 8, 6),
            new Edge(7, 8, 7)
        );
        
        List<Edge> mst = kmst.kruskalMST(9, edges);
        System.out.println("Minimum Spanning Tree: " + mst);
        
        int totalWeight = mst.stream().mapToInt(e -> e.weight).sum();
        System.out.println("Total weight: " + totalWeight);
    }
}
```

#### Prim's Algorithm for MST
```java
import java.util.*;

public class PrimMST {
    
    static class Edge {
        int dest, weight;
        
        Edge(int dest, int weight) {
            this.dest = dest;
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
    
    public List<int[]> primMST(List<List<Edge>> graph) {
        int vertices = graph.size();
        boolean[] inMST = new boolean[vertices];
        int[] key = new int[vertices];
        int[] parent = new int[vertices];
        
        Arrays.fill(key, Integer.MAX_VALUE);
        Arrays.fill(parent, -1);
        
        PriorityQueue<Node> pq = new PriorityQueue<>();
        
        // Start from vertex 0
        key[0] = 0;
        pq.offer(new Node(0, 0));
        
        List<int[]> mstEdges = new ArrayList<>();
        
        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.vertex;
            
            if (inMST[u]) continue;
            
            inMST[u] = true;
            
            // Add edge to MST (except for starting vertex)
            if (parent[u] != -1) {
                mstEdges.add(new int[]{parent[u], u, key[u]});
            }
            
            // Update keys of adjacent vertices
            for (Edge edge : graph.get(u)) {
                int v = edge.dest;
                int weight = edge.weight;
                
                if (!inMST[v] && weight < key[v]) {
                    key[v] = weight;
                    parent[v] = u;
                    pq.offer(new Node(v, weight));
                }
            }
        }
        
        return mstEdges;
    }
    
    public static void main(String[] args) {
        PrimMST pmst = new PrimMST();
        
        // Create adjacency list representation
        int vertices = 5;
        List<List<Edge>> graph = new ArrayList<>();
        for (int i = 0; i < vertices; i++) {
            graph.add(new ArrayList<>());
        }
        
        // Add edges
        graph.get(0).add(new Edge(1, 2));
        graph.get(0).add(new Edge(3, 6));
        graph.get(1).add(new Edge(0, 2));
        graph.get(1).add(new Edge(2, 3));
        graph.get(1).add(new Edge(3, 8));
        graph.get(1).add(new Edge(4, 5));
        graph.get(2).add(new Edge(1, 3));
        graph.get(2).add(new Edge(4, 7));
        graph.get(3).add(new Edge(0, 6));
        graph.get(3).add(new Edge(1, 8));
        graph.get(4).add(new Edge(1, 5));
        graph.get(4).add(new Edge(2, 7));
        
        List<int[]> mst = pmst.primMST(graph);
        System.out.println("Minimum Spanning Tree edges:");
        for (int[] edge : mst) {
            System.out.println(edge[0] + " - " + edge[1] + " : " + edge[2]);
        }
    }
}
```

### 18.4 Advanced Greedy Problems

#### Gas Station Problem
```java
public class GasStation {
    
    // Find starting gas station to complete circular tour
    public int canCompleteCircuit(int[] gas, int[] cost) {
        int totalGas = 0, totalCost = 0;
        int currentGas = 0, start = 0;
        
        for (int i = 0; i < gas.length; i++) {
            totalGas += gas[i];
            totalCost += cost[i];
            currentGas += gas[i] - cost[i];
            
            // If we can't reach next station, try starting from next station
            if (currentGas < 0) {
                start = i + 1;
                currentGas = 0;
            }
        }
        
        // Check if solution exists
        return (totalGas >= totalCost) ? start : -1;
    }
    
    public static void main(String[] args) {
        GasStation gs = new GasStation();
        
        int[] gas = {1, 2, 3, 4, 5};
        int[] cost = {3, 4, 5, 1, 2};
        
        int start = gs.canCompleteCircuit(gas, cost);
        System.out.println("Starting station: " + start);
    }
}
```

#### Jump Game Problems
```java
public class JumpGame {
    
    // Jump Game I: Can reach last index
    public boolean canJump(int[] nums) {
        int maxReach = 0;
        
        for (int i = 0; i < nums.length; i++) {
            if (i > maxReach) return false;
            maxReach = Math.max(maxReach, i + nums[i]);
            
            if (maxReach >= nums.length - 1) return true;
        }
        
        return true;
    }
    
    // Jump Game II: Minimum jumps to reach last index
    public int jump(int[] nums) {
        int jumps = 0, currentMax = 0, nextMax = 0;
        
        for (int i = 0; i < nums.length - 1; i++) {
            nextMax = Math.max(nextMax, i + nums[i]);
            
            // When we reach the end of current jump range
            if (i == currentMax) {
                jumps++;
                currentMax = nextMax;
            }
        }
        
        return jumps;
    }
    
    public static void main(String[] args) {
        JumpGame jg = new JumpGame();
        
        int[] nums1 = {2, 3, 1, 1, 4};
        System.out.println("Can jump: " + jg.canJump(nums1));
        System.out.println("Min jumps: " + jg.jump(nums1));
        
        int[] nums2 = {3, 2, 1, 0, 4};
        System.out.println("Can jump: " + jg.canJump(nums2));
    }
}
```

#### Candy Distribution
```java
import java.util.Arrays;

public class CandyDistribution {
    
    // Minimum candies to distribute based on ratings
    public int candy(int[] ratings) {
        int n = ratings.length;
        int[] candies = new int[n];
        Arrays.fill(candies, 1);
        
        // Left to right pass: ensure right neighbor gets more if rating is higher
        for (int i = 1; i < n; i++) {
            if (ratings[i] > ratings[i - 1]) {
                candies[i] = candies[i - 1] + 1;
            }
        }
        
        // Right to left pass: ensure left neighbor gets more if rating is higher
        for (int i = n - 2; i >= 0; i--) {
            if (ratings[i] > ratings[i + 1]) {
                candies[i] = Math.max(candies[i], candies[i + 1] + 1);
            }
        }
        
        return Arrays.stream(candies).sum();
    }
    
    // Single pass solution
    public int candyOptimized(int[] ratings) {
        int n = ratings.length;
        if (n <= 1) return n;
        
        int candies = 1;
        int up = 0, down = 0, peak = 0;
        
        for (int i = 1; i < n; i++) {
            if (ratings[i - 1] < ratings[i]) {
                up++;
                down = 0;
                peak = up;
                candies += 1 + up;
            } else if (ratings[i - 1] == ratings[i]) {
                up = down = peak = 0;
                candies += 1;
            } else {
                up = 0;
                down++;
                candies += 1 + down + (down > peak ? 1 : 0);
            }
        }
        
        return candies;
    }
    
    public static void main(String[] args) {
        CandyDistribution cd = new CandyDistribution();
        
        int[] ratings = {1, 0, 2};
        System.out.println("Minimum candies: " + cd.candy(ratings));
        System.out.println("Minimum candies (optimized): " + cd.candyOptimized(ratings));
    }
}
```

## Greedy vs Dynamic Programming

| Aspect | Greedy | Dynamic Programming |
|--------|--------|-------------------|
| Strategy | Local optimal choice | Global optimal solution |
| Backtracking | No | May require |
| Time Complexity | Usually faster | Often slower |
| Space Complexity | Usually O(1) | Often O(n) or O(n²) |
| When to Use | Greedy choice property holds | Optimal substructure + overlapping subproblems |

## Practice Problems

### Easy Level
1. **Assign Cookies** - Assign cookies to children greedily
2. **Lemonade Change** - Check if correct change can be given
3. **Best Time to Buy and Sell Stock II** - Multiple transactions allowed

### Medium Level
1. **Gas Station** - Find starting point for circular tour
2. **Jump Game** - Determine if last index is reachable
3. **Task Scheduler** - Schedule tasks with cooldown period
4. **Partition Labels** - Partition string into maximum parts
5. **Non-overlapping Intervals** - Remove minimum intervals

### Hard Level
1. **Candy** - Distribute candies based on ratings
2. **Minimum Number of Taps** - Water the garden efficiently
3. **Video Stitching** - Create video from clips
4. **Merge Intervals** - Merge overlapping intervals

## Key Patterns

1. **Sorting + Greedy**: Most greedy problems start with sorting
2. **Interval Problems**: Sort by start/end time and process greedily
3. **Two Pointers**: Often used with greedy approach
4. **Scheduling**: Greedy choice based on deadlines or profits
5. **Resource Allocation**: Distribute resources optimally

## Common Mistakes

1. **Assuming Greedy Works**: Not all optimization problems have greedy solutions
2. **Wrong Greedy Choice**: Choosing wrong criterion for greedy selection
3. **Not Proving Correctness**: Greedy algorithms need correctness proof
4. **Ignoring Edge Cases**: Empty inputs, single elements, etc.

## Next Steps
- Practice proving greedy algorithm correctness
- Solve classic greedy problems
- Learn to distinguish when greedy works vs when DP is needed
- Move to **[Module 19: Divide and Conquer](../19-divide-conquer/README.md)**
