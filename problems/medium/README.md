# Medium Level Practice Problems

Welcome to the medium-level practice problems! These problems require a solid understanding of data structures and algorithms, along with the ability to combine multiple concepts.

## Problem Categories

### Arrays and Strings (Medium)
1. **3Sum** - Find all unique triplets that sum to zero
2. **Longest Substring Without Repeating Characters** - Sliding window technique
3. **Container With Most Water** - Two pointers approach
4. **Product of Array Except Self** - Array manipulation without division
5. **Spiral Matrix** - 2D array traversal pattern
6. **Rotate Image** - In-place matrix rotation
7. **Group Anagrams** - Hash map with sorted strings as keys
8. **Longest Palindromic Substring** - Expand around centers

### Linked Lists (Medium)
1. **Add Two Numbers** - Simulate addition with carry
2. **Remove Nth Node From End** - Two pointers technique
3. **Swap Nodes in Pairs** - Iterative and recursive approaches
4. **Rotate List** - Find cycle and break at correct position
5. **Copy List with Random Pointer** - Hash map for node mapping

### Trees (Medium)
1. **Binary Tree Level Order Traversal** - BFS implementation
2. **Binary Tree Zigzag Level Order Traversal** - Alternating direction BFS
3. **Construct Binary Tree from Preorder and Inorder** - Recursive construction
4. **Path Sum II** - DFS with backtracking
5. **Binary Tree Right Side View** - Level order with rightmost selection
6. **Kth Smallest Element in BST** - Inorder traversal or Morris traversal

### Dynamic Programming (Medium)
1. **House Robber** - Simple 1D DP
2. **Coin Change** - Classic DP problem
3. **Longest Increasing Subsequence** - DP with binary search optimization
4. **Word Break** - DP with string manipulation
5. **Unique Paths** - 2D DP or combinatorics
6. **Maximum Subarray** - Kadane's algorithm

### Graphs (Medium)
1. **Number of Islands** - DFS/BFS on 2D grid
2. **Clone Graph** - DFS/BFS with hash map
3. **Course Schedule** - Topological sorting
4. **Pacific Atlantic Water Flow** - DFS from boundaries
5. **Word Ladder** - BFS with word transformations

### Backtracking (Medium)
1. **Letter Combinations of Phone Number** - Generate all combinations
2. **Generate Parentheses** - Valid parentheses generation
3. **Permutations** - Generate all permutations
4. **Subsets** - Generate all subsets
5. **Word Search** - 2D grid DFS with backtracking

### Sorting and Searching (Medium)
1. **Search in Rotated Sorted Array** - Modified binary search
2. **Find First and Last Position** - Binary search variants
3. **Search a 2D Matrix** - Treat as 1D sorted array
4. **Kth Largest Element in Array** - QuickSelect or heap
5. **Top K Frequent Elements** - Hash map + heap

### Stack and Queue (Medium)
1. **Evaluate Reverse Polish Notation** - Stack for postfix evaluation
2. **Daily Temperatures** - Monotonic stack
3. **Next Greater Element II** - Circular array with stack
4. **Decode String** - Stack for nested structures

## Detailed Solutions

### Problem: 3Sum
```java
public List<List<Integer>> threeSum(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    Arrays.sort(nums);
    
    for (int i = 0; i < nums.length - 2; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue; // Skip duplicates
        
        int left = i + 1, right = nums.length - 1;
        while (left < right) {
            int sum = nums[i] + nums[left] + nums[right];
            if (sum == 0) {
                result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                
                while (left < right && nums[left] == nums[left + 1]) left++;
                while (left < right && nums[right] == nums[right - 1]) right--;
                
                left++;
                right--;
            } else if (sum < 0) {
                left++;
            } else {
                right--;
            }
        }
    }
    
    return result;
}
```

### Problem: Longest Substring Without Repeating Characters
```java
public int lengthOfLongestSubstring(String s) {
    Map<Character, Integer> seen = new HashMap<>();
    int left = 0, maxLength = 0;
    
    for (int right = 0; right < s.length(); right++) {
        char c = s.charAt(right);
        
        if (seen.containsKey(c) && seen.get(c) >= left) {
            left = seen.get(c) + 1;
        }
        
        seen.put(c, right);
        maxLength = Math.max(maxLength, right - left + 1);
    }
    
    return maxLength;
}
```

### Problem: Binary Tree Level Order Traversal
```java
public List<List<Integer>> levelOrder(TreeNode root) {
    List<List<Integer>> result = new ArrayList<>();
    if (root == null) return result;
    
    Queue<TreeNode> queue = new LinkedList<>();
    queue.offer(root);
    
    while (!queue.isEmpty()) {
        int levelSize = queue.size();
        List<Integer> currentLevel = new ArrayList<>();
        
        for (int i = 0; i < levelSize; i++) {
            TreeNode node = queue.poll();
            currentLevel.add(node.val);
            
            if (node.left != null) queue.offer(node.left);
            if (node.right != null) queue.offer(node.right);
        }
        
        result.add(currentLevel);
    }
    
    return result;
}
```

### Problem: Coin Change
```java
public int coinChange(int[] coins, int amount) {
    int[] dp = new int[amount + 1];
    Arrays.fill(dp, amount + 1);
    dp[0] = 0;
    
    for (int i = 1; i <= amount; i++) {
        for (int coin : coins) {
            if (coin <= i) {
                dp[i] = Math.min(dp[i], dp[i - coin] + 1);
            }
        }
    }
    
    return dp[amount] > amount ? -1 : dp[amount];
}
```

### Problem: Number of Islands
```java
public int numIslands(char[][] grid) {
    if (grid == null || grid.length == 0) return 0;
    
    int islands = 0;
    for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[0].length; j++) {
            if (grid[i][j] == '1') {
                islands++;
                dfs(grid, i, j);
            }
        }
    }
    
    return islands;
}

private void dfs(char[][] grid, int i, int j) {
    if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != '1') {
        return;
    }
    
    grid[i][j] = '0'; // Mark as visited
    
    dfs(grid, i + 1, j);
    dfs(grid, i - 1, j);
    dfs(grid, i, j + 1);
    dfs(grid, i, j - 1);
}
```

### Problem: Generate Parentheses
```java
public List<String> generateParenthesis(int n) {
    List<String> result = new ArrayList<>();
    backtrack(result, "", 0, 0, n);
    return result;
}

private void backtrack(List<String> result, String current, int open, int close, int max) {
    if (current.length() == max * 2) {
        result.add(current);
        return;
    }
    
    if (open < max) {
        backtrack(result, current + "(", open + 1, close, max);
    }
    
    if (close < open) {
        backtrack(result, current + ")", open, close + 1, max);
    }
}
```

## Study Strategy for Medium Problems

### 1. Pattern Recognition
- Learn to identify which algorithm pattern applies
- Practice categorizing problems by type
- Understand when to use each data structure

### 2. Time/Space Complexity Analysis
- Always analyze complexity before coding
- Consider trade-offs between time and space
- Know when optimizations are necessary

### 3. Edge Cases
- Empty inputs
- Single element arrays
- Negative numbers
- Duplicate values
- Null pointers

### 4. Multiple Solutions
- Often there are multiple approaches
- Start with brute force, then optimize
- Consider different data structures

### 5. Code Quality
- Write clean, readable code
- Use meaningful variable names
- Add comments for complex logic
- Handle edge cases gracefully

## Common Patterns in Medium Problems

1. **Two Pointers**: 3Sum, Container With Most Water
2. **Sliding Window**: Longest Substring problems
3. **DFS/BFS**: Tree and graph problems
4. **Dynamic Programming**: Optimization problems
5. **Backtracking**: Generate all possibilities
6. **Binary Search**: Search in sorted/rotated arrays
7. **Hash Maps**: Fast lookups and counting
8. **Stack/Queue**: Expression evaluation, level traversal

## Tips for Success

1. **Practice Regularly**: Solve 2-3 medium problems daily
2. **Time Yourself**: Aim for 20-30 minutes per problem
3. **Review Solutions**: Study multiple approaches
4. **Implement from Scratch**: Don't just read solutions
5. **Discuss with Others**: Join study groups or forums
6. **Mock Interviews**: Practice explaining your approach

## Next Steps
- Master these medium problems before moving to hard
- Focus on patterns that appear frequently
- Practice coding without IDE assistance
- Time yourself to simulate interview conditions
- Move to **[Hard Level Problems](../hard/README.md)** when ready
