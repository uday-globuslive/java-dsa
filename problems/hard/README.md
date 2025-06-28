# Hard Level Practice Problems

Welcome to the hard-level practice problems! These problems require advanced understanding of algorithms, complex optimizations, and the ability to combine multiple advanced concepts.

## Problem Categories

### Advanced Dynamic Programming
1. **Edit Distance** - String transformation with minimum operations
2. **Regular Expression Matching** - Pattern matching with . and *
3. **Wildcard Matching** - Pattern matching with ? and *
4. **Distinct Subsequences** - Count number of distinct subsequences
5. **Interleaving String** - Check if string is interleaving of two strings
6. **Scramble String** - Check if string is scrambled version
7. **Burst Balloons** - Matrix chain multiplication variant
8. **Palindrome Partitioning II** - Minimum cuts for palindromes

### Advanced Graph Algorithms
1. **Word Ladder II** - Find all shortest transformation sequences
2. **Alien Dictionary** - Topological sort with constraints
3. **Critical Connections in Network** - Find bridges in graph
4. **Minimum Cost to Make Valid Path** - Dijkstra with modifications
5. **Swim in Rising Water** - Binary search + DFS/Union-Find
6. **Shortest Path Visiting All Nodes** - TSP with bitmask DP

### Advanced Tree Problems
1. **Binary Tree Maximum Path Sum** - Tree DP with global maximum
2. **Serialize and Deserialize Binary Tree** - Tree encoding/decoding
3. **Recover Binary Search Tree** - Fix swapped nodes in BST
4. **Count of Smaller Numbers After Self** - Merge sort with counting
5. **Vertical Order Traversal** - Complex sorting with coordinates

### Advanced String Problems
1. **Minimum Window Substring** - Sliding window with complex conditions
2. **Substring with Concatenation of All Words** - Multiple pattern matching
3. **Text Justification** - String formatting with constraints
4. **Palindrome Pairs** - Find all palindrome pairs efficiently

### Advanced Array Problems
1. **Median of Two Sorted Arrays** - Binary search optimization
2. **Largest Rectangle in Histogram** - Stack with area calculation
3. **Maximal Rectangle** - Extend histogram to 2D
4. **Trapping Rain Water II** - 2D water trapping with heap
5. **Sliding Window Maximum** - Deque for range queries

### System Design Problems
1. **LRU Cache** - Design least recently used cache
2. **LFU Cache** - Design least frequently used cache
3. **Design Twitter** - Timeline generation with heap
4. **Design Search Autocomplete** - Trie with ranking

## Detailed Solutions

### Problem: Edit Distance (Levenshtein Distance)
```java
public int minDistance(String word1, String word2) {
    int m = word1.length(), n = word2.length();
    int[][] dp = new int[m + 1][n + 1];
    
    // Initialize base cases
    for (int i = 0; i <= m; i++) dp[i][0] = i;
    for (int j = 0; j <= n; j++) dp[0][j] = j;
    
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                dp[i][j] = dp[i - 1][j - 1];
            } else {
                dp[i][j] = 1 + Math.min(
                    Math.min(dp[i - 1][j], dp[i][j - 1]), 
                    dp[i - 1][j - 1]
                );
            }
        }
    }
    
    return dp[m][n];
}
```

### Problem: Median of Two Sorted Arrays
```java
public double findMedianSortedArrays(int[] nums1, int[] nums2) {
    if (nums1.length > nums2.length) {
        return findMedianSortedArrays(nums2, nums1);
    }
    
    int x = nums1.length;
    int y = nums2.length;
    int low = 0, high = x;
    
    while (low <= high) {
        int cutX = (low + high) / 2;
        int cutY = (x + y + 1) / 2 - cutX;
        
        int maxLeftX = (cutX == 0) ? Integer.MIN_VALUE : nums1[cutX - 1];
        int minRightX = (cutX == x) ? Integer.MAX_VALUE : nums1[cutX];
        
        int maxLeftY = (cutY == 0) ? Integer.MIN_VALUE : nums2[cutY - 1];
        int minRightY = (cutY == y) ? Integer.MAX_VALUE : nums2[cutY];
        
        if (maxLeftX <= minRightY && maxLeftY <= minRightX) {
            if ((x + y) % 2 == 0) {
                return (Math.max(maxLeftX, maxLeftY) + Math.min(minRightX, minRightY)) / 2.0;
            } else {
                return Math.max(maxLeftX, maxLeftY);
            }
        } else if (maxLeftX > minRightY) {
            high = cutX - 1;
        } else {
            low = cutX + 1;
        }
    }
    
    return -1;
}
```

### Problem: Largest Rectangle in Histogram
```java
public int largestRectangleArea(int[] heights) {
    Stack<Integer> stack = new Stack<>();
    int maxArea = 0;
    int index = 0;
    
    while (index < heights.length) {
        if (stack.isEmpty() || heights[index] >= heights[stack.peek()]) {
            stack.push(index++);
        } else {
            int top = stack.pop();
            int area = heights[top] * (stack.isEmpty() ? index : index - stack.peek() - 1);
            maxArea = Math.max(maxArea, area);
        }
    }
    
    while (!stack.isEmpty()) {
        int top = stack.pop();
        int area = heights[top] * (stack.isEmpty() ? index : index - stack.peek() - 1);
        maxArea = Math.max(maxArea, area);
    }
    
    return maxArea;
}
```

### Problem: Word Ladder II
```java
public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
    Set<String> wordSet = new HashSet<>(wordList);
    List<List<String>> result = new ArrayList<>();
    
    if (!wordSet.contains(endWord)) return result;
    
    Map<String, List<String>> neighbors = new HashMap<>();
    Map<String, Integer> distance = new HashMap<>();
    
    bfs(beginWord, endWord, wordSet, neighbors, distance);
    dfs(beginWord, endWord, neighbors, distance, new ArrayList<>(), result);
    
    return result;
}

private void bfs(String beginWord, String endWord, Set<String> wordSet, 
                Map<String, List<String>> neighbors, Map<String, Integer> distance) {
    for (String word : wordSet) {
        neighbors.put(word, new ArrayList<>());
    }
    
    Queue<String> queue = new LinkedList<>();
    queue.offer(beginWord);
    distance.put(beginWord, 0);
    
    while (!queue.isEmpty()) {
        boolean found = false;
        int size = queue.size();
        
        for (int i = 0; i < size; i++) {
            String word = queue.poll();
            int curDistance = distance.get(word);
            
            for (String neighbor : getNeighbors(word, wordSet)) {
                neighbors.get(word).add(neighbor);
                
                if (!distance.containsKey(neighbor)) {
                    distance.put(neighbor, curDistance + 1);
                    if (neighbor.equals(endWord)) {
                        found = true;
                    } else {
                        queue.offer(neighbor);
                    }
                }
            }
        }
        
        if (found) break;
    }
}

private List<String> getNeighbors(String word, Set<String> wordSet) {
    List<String> neighbors = new ArrayList<>();
    char[] chars = word.toCharArray();
    
    for (int i = 0; i < chars.length; i++) {
        char originalChar = chars[i];
        for (char c = 'a'; c <= 'z'; c++) {
            if (c != originalChar) {
                chars[i] = c;
                String newWord = new String(chars);
                if (wordSet.contains(newWord)) {
                    neighbors.add(newWord);
                }
            }
        }
        chars[i] = originalChar;
    }
    
    return neighbors;
}

private void dfs(String word, String endWord, Map<String, List<String>> neighbors,
                Map<String, Integer> distance, List<String> path, List<List<String>> result) {
    path.add(word);
    
    if (word.equals(endWord)) {
        result.add(new ArrayList<>(path));
    } else {
        for (String neighbor : neighbors.get(word)) {
            if (distance.get(neighbor) == distance.get(word) + 1) {
                dfs(neighbor, endWord, neighbors, distance, path, result);
            }
        }
    }
    
    path.remove(path.size() - 1);
}
```

### Problem: Regular Expression Matching
```java
public boolean isMatch(String s, String p) {
    int m = s.length(), n = p.length();
    boolean[][] dp = new boolean[m + 1][n + 1];
    
    dp[0][0] = true;
    
    // Handle patterns like a*, a*b*, a*b*c*
    for (int j = 1; j <= n; j++) {
        if (p.charAt(j - 1) == '*') {
            dp[0][j] = dp[0][j - 2];
        }
    }
    
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            char sc = s.charAt(i - 1);
            char pc = p.charAt(j - 1);
            
            if (pc == '*') {
                // Check pattern before *
                char prevPc = p.charAt(j - 2);
                
                // Case 1: Use * as empty (0 occurrences)
                dp[i][j] = dp[i][j - 2];
                
                // Case 2: Use * for one or more occurrences
                if (prevPc == '.' || prevPc == sc) {
                    dp[i][j] = dp[i][j] || dp[i - 1][j];
                }
            } else if (pc == '.' || pc == sc) {
                dp[i][j] = dp[i - 1][j - 1];
            }
        }
    }
    
    return dp[m][n];
}
```

### Problem: LRU Cache
```java
class LRUCache {
    class Node {
        int key, value;
        Node prev, next;
        
        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }
    
    private Map<Integer, Node> cache;
    private Node head, tail;
    private int capacity;
    
    public LRUCache(int capacity) {
        this.capacity = capacity;
        this.cache = new HashMap<>();
        
        head = new Node(0, 0);
        tail = new Node(0, 0);
        head.next = tail;
        tail.prev = head;
    }
    
    public int get(int key) {
        Node node = cache.get(key);
        if (node == null) return -1;
        
        moveToHead(node);
        return node.value;
    }
    
    public void put(int key, int value) {
        Node node = cache.get(key);
        
        if (node == null) {
            Node newNode = new Node(key, value);
            cache.put(key, newNode);
            addToHead(newNode);
            
            if (cache.size() > capacity) {
                Node tail = removeTail();
                cache.remove(tail.key);
            }
        } else {
            node.value = value;
            moveToHead(node);
        }
    }
    
    private void addToHead(Node node) {
        node.prev = head;
        node.next = head.next;
        head.next.prev = node;
        head.next = node;
    }
    
    private void removeNode(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
    
    private void moveToHead(Node node) {
        removeNode(node);
        addToHead(node);
    }
    
    private Node removeTail() {
        Node lastNode = tail.prev;
        removeNode(lastNode);
        return lastNode;
    }
}
```

### Problem: Minimum Window Substring
```java
public String minWindow(String s, String t) {
    if (s.length() < t.length()) return "";
    
    Map<Character, Integer> target = new HashMap<>();
    for (char c : t.toCharArray()) {
        target.put(c, target.getOrDefault(c, 0) + 1);
    }
    
    int left = 0, right = 0;
    int minLen = Integer.MAX_VALUE;
    int minStart = 0;
    int required = target.size();
    int formed = 0;
    
    Map<Character, Integer> window = new HashMap<>();
    
    while (right < s.length()) {
        char c = s.charAt(right);
        window.put(c, window.getOrDefault(c, 0) + 1);
        
        if (target.containsKey(c) && window.get(c).intValue() == target.get(c).intValue()) {
            formed++;
        }
        
        while (left <= right && formed == required) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                minStart = left;
            }
            
            char leftChar = s.charAt(left);
            window.put(leftChar, window.get(leftChar) - 1);
            
            if (target.containsKey(leftChar) && window.get(leftChar) < target.get(leftChar)) {
                formed--;
            }
            
            left++;
        }
        
        right++;
    }
    
    return minLen == Integer.MAX_VALUE ? "" : s.substring(minStart, minStart + minLen);
}
```

## Advanced Problem-Solving Strategies

### 1. Multi-Dimensional Thinking
- Consider state space beyond simple variables
- Use multiple data structures simultaneously
- Think about invariants and relationships

### 2. Optimization Techniques
- **Space-Time Tradeoffs**: Use extra space to reduce time
- **Preprocessing**: Compute auxiliary information
- **Amortized Analysis**: Consider average case over sequence of operations

### 3. Advanced Data Structures
- **Segment Trees**: Range queries and updates
- **Fenwick Trees**: Efficient prefix sums
- **Disjoint Set Union**: Connected components
- **Suffix Arrays/Trees**: String processing

### 4. Mathematical Insights
- **Number Theory**: GCD, modular arithmetic
- **Combinatorics**: Counting principles
- **Probability**: Expected value calculations
- **Game Theory**: Optimal strategies

## Common Hard Problem Patterns

1. **Complex DP States**: Multi-dimensional DP with complex transitions
2. **Graph + DP**: Shortest paths with additional constraints
3. **String Algorithms**: KMP, Z-algorithm, suffix arrays
4. **Geometric Algorithms**: Computational geometry problems
5. **Bit Manipulation**: Advanced bitmask techniques
6. **Two-Pointer Variants**: Multiple pointers with complex conditions

## Time Management for Hard Problems

1. **Read Carefully** (5 minutes): Understand all constraints and examples
2. **Plan Approach** (10 minutes): Think through multiple solutions
3. **Implement** (30-40 minutes): Code the solution
4. **Test and Debug** (10-15 minutes): Verify with examples
5. **Optimize** (5 minutes): Consider improvements

## Common Mistakes in Hard Problems

1. **Incomplete Analysis**: Missing edge cases or constraints
2. **Premature Optimization**: Optimizing before getting correct solution
3. **Poor Time Management**: Spending too long on one approach
4. **Ignoring Examples**: Not using provided test cases effectively
5. **Complex Implementation**: Choosing overly complex approach

## Interview Strategy for Hard Problems

1. **Start Simple**: Begin with brute force approach
2. **Communicate**: Explain your thought process
3. **Ask Questions**: Clarify ambiguous requirements
4. **Test Early**: Use examples to verify logic
5. **Stay Calm**: Hard problems are meant to be challenging

## Next Steps
- Master medium problems before attempting hard
- Practice one hard problem daily
- Study editorial solutions for different approaches
- Join competitive programming contests
- Focus on patterns that appear in your target companies
