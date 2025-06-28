# Module 13: Advanced Trees (Segment Trees & Fenwick Trees)

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master Segment Trees for range queries and updates
- ✅ Implement Fenwick Trees (Binary Indexed Trees) efficiently
- ✅ Solve complex range-based problems with optimal time complexity
- ✅ Understand when to use each advanced tree structure
- ✅ Apply lazy propagation for bulk updates

## 🎯 Module Overview
Advanced tree structures handle range operations efficiently - essential for:
- **Range queries** - Sum, min/max, count in ranges
- **Range updates** - Bulk modifications to ranges
- **Dynamic arrays** - Efficient updates and queries
- **Computational geometry** - 2D range queries

**Time Investment:** 8-10 hours
**Difficulty Level:** Advanced
**Prerequisites:** Trees, Recursion, Arrays

## 📖 Core Concepts

### 1. Segment Trees

#### Basic Segment Tree (Range Sum Query)
```java
class SegmentTree {
    private int[] tree;
    private int n;
    
    public SegmentTree(int[] arr) {
        n = arr.length;
        tree = new int[4 * n]; // Safe upper bound for tree size
        build(arr, 0, 0, n - 1);
    }
    
    // Build the segment tree
    private void build(int[] arr, int node, int start, int end) {
        if (start == end) {
            tree[node] = arr[start]; // Leaf node
        } else {
            int mid = (start + end) / 2;
            int leftChild = 2 * node + 1;
            int rightChild = 2 * node + 2;
            
            build(arr, leftChild, start, mid);
            build(arr, rightChild, mid + 1, end);
            
            tree[node] = tree[leftChild] + tree[rightChild]; // Internal node
        }
    }
    
    // Update single element
    public void update(int idx, int val) {
        update(0, 0, n - 1, idx, val);
    }
    
    private void update(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = val; // Update leaf
        } else {
            int mid = (start + end) / 2;
            int leftChild = 2 * node + 1;
            int rightChild = 2 * node + 2;
            
            if (idx <= mid) {
                update(leftChild, start, mid, idx, val);
            } else {
                update(rightChild, mid + 1, end, idx, val);
            }
            
            tree[node] = tree[leftChild] + tree[rightChild]; // Update internal node
        }
    }
    
    // Range sum query
    public int query(int l, int r) {
        return query(0, 0, n - 1, l, r);
    }
    
    private int query(int node, int start, int end, int l, int r) {
        if (r < start || end < l) {
            return 0; // No overlap
        }
        if (l <= start && end <= r) {
            return tree[node]; // Complete overlap
        }
        
        // Partial overlap
        int mid = (start + end) / 2;
        int leftChild = 2 * node + 1;
        int rightChild = 2 * node + 2;
        
        int leftSum = query(leftChild, start, mid, l, r);
        int rightSum = query(rightChild, mid + 1, end, l, r);
        
        return leftSum + rightSum;
    }
}
```

#### Segment Tree with Lazy Propagation
```java
class LazySegmentTree {
    private int[] tree;
    private int[] lazy;
    private int n;
    
    public LazySegmentTree(int[] arr) {
        n = arr.length;
        tree = new int[4 * n];
        lazy = new int[4 * n];
        build(arr, 0, 0, n - 1);
    }
    
    private void build(int[] arr, int node, int start, int end) {
        if (start == end) {
            tree[node] = arr[start];
        } else {
            int mid = (start + end) / 2;
            build(arr, 2 * node + 1, start, mid);
            build(arr, 2 * node + 2, mid + 1, end);
            tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
        }
    }
    
    // Push lazy updates down
    private void updateLazy(int node, int start, int end) {
        if (lazy[node] != 0) {
            tree[node] += lazy[node] * (end - start + 1);
            
            if (start != end) { // Not a leaf
                lazy[2 * node + 1] += lazy[node];
                lazy[2 * node + 2] += lazy[node];
            }
            
            lazy[node] = 0;
        }
    }
    
    // Range update: add val to all elements in [l, r]
    public void updateRange(int l, int r, int val) {
        updateRange(0, 0, n - 1, l, r, val);
    }
    
    private void updateRange(int node, int start, int end, int l, int r, int val) {
        updateLazy(node, start, end);
        
        if (start > r || end < l) return; // No overlap
        
        if (start >= l && end <= r) { // Complete overlap
            lazy[node] += val;
            updateLazy(node, start, end);
            return;
        }
        
        // Partial overlap
        int mid = (start + end) / 2;
        updateRange(2 * node + 1, start, mid, l, r, val);
        updateRange(2 * node + 2, mid + 1, end, l, r, val);
        
        updateLazy(2 * node + 1, start, mid);
        updateLazy(2 * node + 2, mid + 1, end);
        
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2];
    }
    
    // Range sum query
    public int queryRange(int l, int r) {
        return queryRange(0, 0, n - 1, l, r);
    }
    
    private int queryRange(int node, int start, int end, int l, int r) {
        if (start > r || end < l) return 0; // No overlap
        
        updateLazy(node, start, end);
        
        if (start >= l && end <= r) { // Complete overlap
            return tree[node];
        }
        
        // Partial overlap
        int mid = (start + end) / 2;
        int leftSum = queryRange(2 * node + 1, start, mid, l, r);
        int rightSum = queryRange(2 * node + 2, mid + 1, end, l, r);
        
        return leftSum + rightSum;
    }
}
```

### 2. Fenwick Trees (Binary Indexed Trees)

#### Basic Fenwick Tree
```java
class FenwickTree {
    private int[] tree;
    private int n;
    
    public FenwickTree(int size) {
        n = size;
        tree = new int[n + 1]; // 1-indexed
    }
    
    public FenwickTree(int[] arr) {
        n = arr.length;
        tree = new int[n + 1];
        
        for (int i = 0; i < n; i++) {
            update(i + 1, arr[i]); // Convert to 1-indexed
        }
    }
    
    // Add val to position idx (1-indexed)
    public void update(int idx, int val) {
        for (int i = idx; i <= n; i += i & (-i)) {
            tree[i] += val;
        }
    }
    
    // Get prefix sum from 1 to idx (1-indexed)
    public int query(int idx) {
        int sum = 0;
        for (int i = idx; i > 0; i -= i & (-i)) {
            sum += tree[i];
        }
        return sum;
    }
    
    // Get range sum from l to r (1-indexed)
    public int rangeQuery(int l, int r) {
        return query(r) - query(l - 1);
    }
    
    // Point update: set arr[idx] = val (0-indexed input)
    public void pointUpdate(int idx, int val) {
        int oldVal = rangeQuery(idx + 1, idx + 1); // Get current value
        update(idx + 1, val - oldVal); // Update with difference
    }
}
```

#### 2D Fenwick Tree
```java
class FenwickTree2D {
    private int[][] tree;
    private int m, n;
    
    public FenwickTree2D(int rows, int cols) {
        m = rows;
        n = cols;
        tree = new int[m + 1][n + 1];
    }
    
    public void update(int row, int col, int val) {
        for (int i = row; i <= m; i += i & (-i)) {
            for (int j = col; j <= n; j += j & (-j)) {
                tree[i][j] += val;
            }
        }
    }
    
    public int query(int row, int col) {
        int sum = 0;
        for (int i = row; i > 0; i -= i & (-i)) {
            for (int j = col; j > 0; j -= j & (-j)) {
                sum += tree[i][j];
            }
        }
        return sum;
    }
    
    public int rangeQuery(int row1, int col1, int row2, int col2) {
        return query(row2, col2) - query(row1 - 1, col2) 
               - query(row2, col1 - 1) + query(row1 - 1, col1 - 1);
    }
}
```

### 3. Advanced Applications

#### Range Minimum Query (RMQ) with Segment Tree
```java
class RMQSegmentTree {
    private int[] tree;
    private int n;
    private static final int INF = Integer.MAX_VALUE;
    
    public RMQSegmentTree(int[] arr) {
        n = arr.length;
        tree = new int[4 * n];
        build(arr, 0, 0, n - 1);
    }
    
    private void build(int[] arr, int node, int start, int end) {
        if (start == end) {
            tree[node] = arr[start];
        } else {
            int mid = (start + end) / 2;
            build(arr, 2 * node + 1, start, mid);
            build(arr, 2 * node + 2, mid + 1, end);
            tree[node] = Math.min(tree[2 * node + 1], tree[2 * node + 2]);
        }
    }
    
    public int queryMin(int l, int r) {
        return queryMin(0, 0, n - 1, l, r);
    }
    
    private int queryMin(int node, int start, int end, int l, int r) {
        if (r < start || end < l) return INF;
        if (l <= start && end <= r) return tree[node];
        
        int mid = (start + end) / 2;
        int leftMin = queryMin(2 * node + 1, start, mid, l, r);
        int rightMin = queryMin(2 * node + 2, mid + 1, end, l, r);
        
        return Math.min(leftMin, rightMin);
    }
    
    public void update(int idx, int val) {
        update(0, 0, n - 1, idx, val);
    }
    
    private void update(int node, int start, int end, int idx, int val) {
        if (start == end) {
            tree[node] = val;
        } else {
            int mid = (start + end) / 2;
            if (idx <= mid) {
                update(2 * node + 1, start, mid, idx, val);
            } else {
                update(2 * node + 2, mid + 1, end, idx, val);
            }
            tree[node] = Math.min(tree[2 * node + 1], tree[2 * node + 2]);
        }
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Range Sum Queries
- **Use Case:** Dynamic array with range sum queries
- **Key Insight:** Fenwick tree optimal for point updates + range queries
- **Example Problems:** Range Sum Query - Mutable, Count of Smaller Numbers

### Pattern 2: Range Updates with Range Queries
- **Use Case:** Bulk updates to ranges with range queries
- **Key Insight:** Segment tree with lazy propagation
- **Example Problems:** Range Addition, Range Sum Query 2D

### Pattern 3: Range Minimum/Maximum Queries
- **Use Case:** Find min/max in any range with updates
- **Key Insight:** Segment tree with min/max instead of sum
- **Example Problems:** Range Minimum Query, Sliding Window Maximum

### Pattern 4: Coordinate Compression
- **Use Case:** Large coordinate space with sparse data
- **Key Insight:** Map coordinates to smaller space
- **Example Problems:** Count of Range Sum, Rectangle Area

## 💻 Practice Problems

### Easy Level
1. **Range Sum Query - Mutable (LeetCode 307)**
   - Point updates and range sum queries
   - Perfect for Fenwick tree introduction

2. **Range Sum Query 2D - Mutable (LeetCode 308)**
   - 2D version with matrix updates
   - Use 2D Fenwick tree

### Medium Level
3. **Count of Smaller Numbers After Self (LeetCode 315)**
   - Use Fenwick tree with coordinate compression
   - Process elements from right to left

4. **Range Addition (LeetCode 370)**
   - Multiple range updates followed by queries
   - Difference array or lazy propagation

5. **The Skyline Problem (LeetCode 218)**
   - Complex coordinate compression + segment tree
   - Track maximum height changes

### Hard Level
6. **Count of Range Sum (LeetCode 327)**
   - Count subarrays with sum in given range
   - Coordinate compression + Fenwick tree

7. **Falling Squares (LeetCode 699)**
   - Dynamic maximum height queries
   - Coordinate compression + segment tree

## 🧠 Problem-Solving Templates

### Template 1: Basic Range Sum with Updates
```java
public class NumArray {
    private FenwickTree ft;
    private int[] nums;
    
    public NumArray(int[] nums) {
        this.nums = nums.clone();
        ft = new FenwickTree(nums);
    }
    
    public void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        ft.update(index + 1, diff); // Convert to 1-indexed
    }
    
    public int sumRange(int left, int right) {
        return ft.rangeQuery(left + 1, right + 1); // Convert to 1-indexed
    }
}
```

### Template 2: Coordinate Compression
```java
public List<Integer> countSmaller(int[] nums) {
    // Step 1: Get all unique values and sort
    Set<Integer> set = new HashSet<>();
    for (int num : nums) set.add(num);
    
    List<Integer> sorted = new ArrayList<>(set);
    Collections.sort(sorted);
    
    // Step 2: Create mapping
    Map<Integer, Integer> map = new HashMap<>();
    for (int i = 0; i < sorted.size(); i++) {
        map.put(sorted.get(i), i + 1); // 1-indexed for Fenwick tree
    }
    
    // Step 3: Process with Fenwick tree
    FenwickTree ft = new FenwickTree(sorted.size());
    List<Integer> result = new ArrayList<>();
    
    for (int i = nums.length - 1; i >= 0; i--) {
        int rank = map.get(nums[i]);
        result.add(ft.query(rank - 1)); // Count smaller
        ft.update(rank, 1); // Add current number
    }
    
    Collections.reverse(result);
    return result;
}
```

### Template 3: 2D Range Queries
```java
public class NumMatrix {
    private FenwickTree2D ft;
    private int[][] matrix;
    
    public NumMatrix(int[][] matrix) {
        if (matrix.length == 0 || matrix[0].length == 0) return;
        
        this.matrix = new int[matrix.length][matrix[0].length];
        ft = new FenwickTree2D(matrix.length, matrix[0].length);
        
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                update(i, j, matrix[i][j]);
            }
        }
    }
    
    public void update(int row, int col, int val) {
        int diff = val - matrix[row][col];
        matrix[row][col] = val;
        ft.update(row + 1, col + 1, diff);
    }
    
    public int sumRegion(int row1, int col1, int row2, int col2) {
        return ft.rangeQuery(row1 + 1, col1 + 1, row2 + 1, col2 + 1);
    }
}
```

## ⚡ Optimization Techniques

### 1. Memory Optimization
- **Fenwick Trees:** More memory efficient than segment trees
- **Implicit Trees:** Avoid storing tree structure explicitly
- **Bit Manipulation:** Use bit operations for parent/child navigation

### 2. Lazy Propagation
- **Range Updates:** Defer updates until necessary
- **Batch Processing:** Combine multiple updates
- **Memory Usage:** Extra array for lazy values

### 3. Coordinate Compression
- **Large Ranges:** Map to smaller coordinate space
- **Sparse Data:** Only store relevant coordinates
- **Preprocessing:** Sort and map coordinates efficiently

## 📈 Complexity Analysis

### Segment Trees
- **Build:** O(n)
- **Query:** O(log n)
- **Update:** O(log n)
- **Space:** O(n)
- **With Lazy Propagation:** Same complexities, better constants

### Fenwick Trees
- **Build:** O(n log n) or O(n) with careful construction
- **Query:** O(log n)
- **Update:** O(log n)
- **Space:** O(n)
- **Simpler implementation than segment trees**

### Comparison
| Operation | Segment Tree | Fenwick Tree |
|-----------|--------------|--------------|
| Range Query | O(log n) | O(log n) |
| Point Update | O(log n) | O(log n) |
| Range Update | O(log n) with lazy | O(n) |
| Space | O(4n) | O(n) |
| Implementation | Complex | Simple |

## 🎯 Key Takeaways

1. **When to Use Segment Trees:**
   - Range updates with range queries
   - Non-associative operations (min/max)
   - Complex queries requiring flexibility

2. **When to Use Fenwick Trees:**
   - Point updates with range queries
   - Associative operations (sum, XOR)
   - Memory efficiency is important

3. **Common Pitfalls:**
   - Off-by-one errors in indexing
   - Forgetting to handle edge cases
   - Not considering coordinate compression for large ranges
   - Lazy propagation implementation errors

4. **Best Practices:**
   - Use 1-indexed arrays for Fenwick trees
   - Consider iterative implementation for better constants
   - Apply coordinate compression for sparse data
   - Test with small examples first

## 🚀 Next Steps
- Practice implementing both structures from scratch
- Master coordinate compression technique
- Study applications in computational geometry
- Move to **Module 14: Sorting and Searching** for algorithmic techniques

---
*Advanced trees unlock powerful range query capabilities. Master these structures to handle complex range-based problems efficiently in competitive programming and system design.*
