# Module 24: LeetCode Patterns and Problem Categories

## Learning Objectives
By the end of this module, you will:
- Master the most common LeetCode problem patterns
- Quickly identify which pattern to apply to new problems
- Understand the template approach for solving similar problems
- Build intuition for problem classification and solution strategies

## Module Content

### 24.1 Pattern-Based Problem Solving

#### Why Pattern Recognition Matters
```java
/*
Benefits of Pattern Recognition:
1. Faster Problem Solving: Recognize patterns instantly
2. Interview Confidence: Apply known templates
3. Code Quality: Use proven approaches
4. Time Management: Skip trial and error
5. Problem Classification: Organize learning effectively

Common Interview Patterns:
- Two Pointers (15% of problems)
- Sliding Window (10% of problems)
- Tree Traversal (20% of problems)
- Dynamic Programming (15% of problems)
- Backtracking (10% of problems)
- Graph Algorithms (15% of problems)
- Binary Search (10% of problems)
- Others (5% of problems)
*/
```

### 24.2 Two Pointers Pattern

#### When to Use Two Pointers
- Array is sorted or can be sorted
- Need to find pair/triplet with specific sum
- Need to process array from both ends
- Palindrome checking
- Merging sorted arrays

#### Template and Examples
```java
public class TwoPointersPattern {
    
    // Template 1: Opposite directional
    public boolean twoSumSorted(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        
        while (left < right) {
            int sum = arr[left] + arr[right];
            if (sum == target) {
                return true;
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        return false;
    }
    
    // Template 2: Same direction (fast/slow)
    public ListNode findMiddle(ListNode head) {
        ListNode slow = head, fast = head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        
        return slow;
    }
    
    // Example: 3Sum problem
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 2; i++) {
            if (i > 0 && nums[i] == nums[i-1]) continue; // Skip duplicates
            
            int left = i + 1, right = nums.length - 1;
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                if (sum == 0) {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    while (left < right && nums[left] == nums[left+1]) left++;
                    while (left < right && nums[right] == nums[right-1]) right--;
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
    
    // Example: Remove duplicates from sorted array
    public int removeDuplicates(int[] nums) {
        if (nums.length == 0) return 0;
        
        int i = 0;
        for (int j = 1; j < nums.length; j++) {
            if (nums[j] != nums[i]) {
                i++;
                nums[i] = nums[j];
            }
        }
        return i + 1;
    }
}
```

#### Two Pointers Problem List
1. **Two Sum II** - Input array is sorted
2. **3Sum** - Find triplets that sum to zero
3. **Container With Most Water** - Maximum area between lines
4. **Remove Duplicates** - From sorted array
5. **Valid Palindrome** - Check if string is palindrome
6. **Linked List Cycle** - Detect cycle using fast/slow pointers
7. **Trapping Rain Water** - Calculate trapped water

### 24.3 Sliding Window Pattern

#### When to Use Sliding Window
- Subarray/substring problems
- Fixed or variable window size
- Optimization problems (min/max)
- K-sized window problems

#### Template and Examples
```java
public class SlidingWindowPattern {
    
    // Template 1: Fixed window size
    public double findMaxAverage(int[] nums, int k) {
        int sum = 0;
        for (int i = 0; i < k; i++) {
            sum += nums[i];
        }
        
        int maxSum = sum;
        for (int i = k; i < nums.length; i++) {
            sum += nums[i] - nums[i - k];
            maxSum = Math.max(maxSum, sum);
        }
        
        return (double) maxSum / k;
    }
    
    // Template 2: Variable window size
    public int lengthOfLongestSubstring(String s) {
        Map<Character, Integer> map = new HashMap<>();
        int left = 0, maxLen = 0;
        
        for (int right = 0; right < s.length(); right++) {
            char c = s.charAt(right);
            
            if (map.containsKey(c) && map.get(c) >= left) {
                left = map.get(c) + 1;
            }
            
            map.put(c, right);
            maxLen = Math.max(maxLen, right - left + 1);
        }
        
        return maxLen;
    }
    
    // Template 3: At most K distinct
    public int lengthOfLongestSubstringKDistinct(String s, int k) {
        Map<Character, Integer> map = new HashMap<>();
        int left = 0, maxLen = 0;
        
        for (int right = 0; right < s.length(); right++) {
            char c = s.charAt(right);
            map.put(c, map.getOrDefault(c, 0) + 1);
            
            while (map.size() > k) {
                char leftChar = s.charAt(left);
                map.put(leftChar, map.get(leftChar) - 1);
                if (map.get(leftChar) == 0) {
                    map.remove(leftChar);
                }
                left++;
            }
            
            maxLen = Math.max(maxLen, right - left + 1);
        }
        
        return maxLen;
    }
    
    // Template 4: Exactly K
    public int subarraysWithKDistinct(int[] A, int K) {
        return atMostK(A, K) - atMostK(A, K - 1);
    }
    
    private int atMostK(int[] A, int K) {
        Map<Integer, Integer> count = new HashMap<>();
        int left = 0, result = 0;
        
        for (int right = 0; right < A.length; right++) {
            if (count.getOrDefault(A[right], 0) == 0) K--;
            count.put(A[right], count.getOrDefault(A[right], 0) + 1);
            
            while (K < 0) {
                count.put(A[left], count.get(A[left]) - 1);
                if (count.get(A[left]) == 0) K++;
                left++;
            }
            
            result += right - left + 1;
        }
        
        return result;
    }
}
```

#### Sliding Window Problem List
1. **Maximum Average Subarray** - Fixed window size
2. **Longest Substring Without Repeating Characters** - Variable window
3. **Minimum Window Substring** - Contains all characters
4. **Sliding Window Maximum** - Deque optimization
5. **Permutation in String** - String permutation matching
6. **Fruits Into Baskets** - At most 2 types
7. **Subarrays with K Different Integers** - Exactly K distinct

### 24.4 Tree Patterns

#### DFS Traversal Patterns
```java
public class TreePatterns {
    
    // Pattern 1: Simple DFS
    public int maxDepth(TreeNode root) {
        if (root == null) return 0;
        return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
    }
    
    // Pattern 2: Path sum
    public boolean hasPathSum(TreeNode root, int targetSum) {
        if (root == null) return false;
        
        if (root.left == null && root.right == null) {
            return root.val == targetSum;
        }
        
        return hasPathSum(root.left, targetSum - root.val) ||
               hasPathSum(root.right, targetSum - root.val);
    }
    
    // Pattern 3: Path collection
    public List<List<Integer>> pathSum(TreeNode root, int targetSum) {
        List<List<Integer>> result = new ArrayList<>();
        dfs(root, targetSum, new ArrayList<>(), result);
        return result;
    }
    
    private void dfs(TreeNode node, int targetSum, List<Integer> path, List<List<Integer>> result) {
        if (node == null) return;
        
        path.add(node.val);
        
        if (node.left == null && node.right == null && node.val == targetSum) {
            result.add(new ArrayList<>(path));
        } else {
            dfs(node.left, targetSum - node.val, path, result);
            dfs(node.right, targetSum - node.val, path, result);
        }
        
        path.remove(path.size() - 1); // backtrack
    }
    
    // Pattern 4: Bottom-up (postorder)
    private int maxPathSum = Integer.MIN_VALUE;
    
    public int maxPathSum(TreeNode root) {
        maxPathSum = Integer.MIN_VALUE;
        maxPathSumHelper(root);
        return maxPathSum;
    }
    
    private int maxPathSumHelper(TreeNode node) {
        if (node == null) return 0;
        
        int left = Math.max(0, maxPathSumHelper(node.left));
        int right = Math.max(0, maxPathSumHelper(node.right));
        
        maxPathSum = Math.max(maxPathSum, node.val + left + right);
        
        return node.val + Math.max(left, right);
    }
}
```

#### BFS Traversal Patterns
```java
public class TreeBFSPatterns {
    
    // Pattern 1: Level order traversal
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
    
    // Pattern 2: Right side view
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) return result;
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                
                if (i == levelSize - 1) { // Last node in level
                    result.add(node.val);
                }
                
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
        }
        
        return result;
    }
    
    // Pattern 3: Minimum depth
    public int minDepth(TreeNode root) {
        if (root == null) return 0;
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int depth = 1;
        
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                
                if (node.left == null && node.right == null) {
                    return depth;
                }
                
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            
            depth++;
        }
        
        return depth;
    }
}
```

### 24.5 Dynamic Programming Patterns

#### Linear DP Patterns
```java
public class DPPatterns {
    
    // Pattern 1: House Robber
    public int rob(int[] nums) {
        if (nums.length == 0) return 0;
        if (nums.length == 1) return nums[0];
        
        int prev2 = nums[0];
        int prev1 = Math.max(nums[0], nums[1]);
        
        for (int i = 2; i < nums.length; i++) {
            int current = Math.max(prev1, prev2 + nums[i]);
            prev2 = prev1;
            prev1 = current;
        }
        
        return prev1;
    }
    
    // Pattern 2: Coin Change
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
    
    // Pattern 3: Longest Increasing Subsequence
    public int lengthOfLIS(int[] nums) {
        int[] dp = new int[nums.length];
        Arrays.fill(dp, 1);
        
        for (int i = 1; i < nums.length; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[i] > nums[j]) {
                    dp[i] = Math.max(dp[i], dp[j] + 1);
                }
            }
        }
        
        return Arrays.stream(dp).max().orElse(0);
    }
    
    // Pattern 4: Palindrome (2D DP)
    public String longestPalindrome(String s) {
        int n = s.length();
        boolean[][] dp = new boolean[n][n];
        String result = "";
        
        // Every single character is palindrome
        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
            result = s.substring(i, i + 1);
        }
        
        // Check for length 2
        for (int i = 0; i < n - 1; i++) {
            if (s.charAt(i) == s.charAt(i + 1)) {
                dp[i][i + 1] = true;
                result = s.substring(i, i + 2);
            }
        }
        
        // Check for length 3 and more
        for (int len = 3; len <= n; len++) {
            for (int i = 0; i < n - len + 1; i++) {
                int j = i + len - 1;
                
                if (s.charAt(i) == s.charAt(j) && dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                    result = s.substring(i, j + 1);
                }
            }
        }
        
        return result;
    }
}
```

### 24.6 Backtracking Patterns

#### Template and Examples
```java
public class BacktrackingPatterns {
    
    // Template
    public void backtrack(List<List<Integer>> result, List<Integer> current, 
                         int[] nums, boolean[] used) {
        // Base case
        if (current.size() == nums.length) {
            result.add(new ArrayList<>(current));
            return;
        }
        
        for (int i = 0; i < nums.length; i++) {
            if (used[i]) continue;
            
            // Choose
            current.add(nums[i]);
            used[i] = true;
            
            // Explore
            backtrack(result, current, nums, used);
            
            // Unchoose
            current.remove(current.size() - 1);
            used[i] = false;
        }
    }
    
    // Pattern 1: Permutations
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        backtrack(result, new ArrayList<>(), nums, new boolean[nums.length]);
        return result;
    }
    
    // Pattern 2: Combinations
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();
        combineHelper(result, new ArrayList<>(), 1, n, k);
        return result;
    }
    
    private void combineHelper(List<List<Integer>> result, List<Integer> current, 
                              int start, int n, int k) {
        if (current.size() == k) {
            result.add(new ArrayList<>(current));
            return;
        }
        
        for (int i = start; i <= n; i++) {
            current.add(i);
            combineHelper(result, current, i + 1, n, k);
            current.remove(current.size() - 1);
        }
    }
    
    // Pattern 3: Subsets
    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        subsetsHelper(result, new ArrayList<>(), nums, 0);
        return result;
    }
    
    private void subsetsHelper(List<List<Integer>> result, List<Integer> current, 
                              int[] nums, int start) {
        result.add(new ArrayList<>(current));
        
        for (int i = start; i < nums.length; i++) {
            current.add(nums[i]);
            subsetsHelper(result, current, nums, i + 1);
            current.remove(current.size() - 1);
        }
    }
}
```

### 24.7 Graph Patterns

#### Common Graph Templates
```java
public class GraphPatterns {
    
    // Pattern 1: DFS on 2D grid
    public int numIslands(char[][] grid) {
        int count = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == '1') {
                    count++;
                    dfs(grid, i, j);
                }
            }
        }
        return count;
    }
    
    private void dfs(char[][] grid, int i, int j) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != '1') {
            return;
        }
        
        grid[i][j] = '0';
        dfs(grid, i + 1, j);
        dfs(grid, i - 1, j);
        dfs(grid, i, j + 1);
        dfs(grid, i, j - 1);
    }
    
    // Pattern 2: BFS shortest path
    public int shortestPath(char[][] grid, int[] start, int[] end) {
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[grid.length][grid[0].length];
        
        queue.offer(new int[]{start[0], start[1], 0});
        visited[start[0]][start[1]] = true;
        
        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int x = current[0], y = current[1], dist = current[2];
            
            if (x == end[0] && y == end[1]) {
                return dist;
            }
            
            for (int[] dir : directions) {
                int nx = x + dir[0], ny = y + dir[1];
                
                if (nx >= 0 && nx < grid.length && ny >= 0 && ny < grid[0].length && 
                    !visited[nx][ny] && grid[nx][ny] != '#') {
                    visited[nx][ny] = true;
                    queue.offer(new int[]{nx, ny, dist + 1});
                }
            }
        }
        
        return -1;
    }
    
    // Pattern 3: Topological Sort
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        List<List<Integer>> graph = new ArrayList<>();
        int[] indegree = new int[numCourses];
        
        for (int i = 0; i < numCourses; i++) {
            graph.add(new ArrayList<>());
        }
        
        for (int[] prereq : prerequisites) {
            graph.get(prereq[1]).add(prereq[0]);
            indegree[prereq[0]]++;
        }
        
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < numCourses; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
            }
        }
        
        int[] result = new int[numCourses];
        int index = 0;
        
        while (!queue.isEmpty()) {
            int course = queue.poll();
            result[index++] = course;
            
            for (int neighbor : graph.get(course)) {
                indegree[neighbor]--;
                if (indegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }
        
        return index == numCourses ? result : new int[0];
    }
}
```

## Pattern Recognition Cheat Sheet

| Pattern | Key Indicators | Time Complexity | Examples |
|---------|---------------|-----------------|----------|
| Two Pointers | Sorted array, pairs/triplets | O(n) | 3Sum, Container Water |
| Sliding Window | Subarray/substring | O(n) | Longest Substring |
| DFS | Tree/graph traversal | O(V+E) | Path Sum, Islands |
| BFS | Shortest path, level order | O(V+E) | Min Depth, Word Ladder |
| DP | Optimization, overlapping subproblems | O(n²) typically | Coin Change, LIS |
| Backtracking | Generate all possibilities | O(2^n) typically | Permutations, N-Queens |
| Binary Search | Sorted data, log time | O(log n) | Search Insert Position |
| Greedy | Local optimal choices | O(n log n) | Activity Selection |

## Problem Classification Strategy

1. **Read the problem carefully**
2. **Identify the data structure** (array, tree, graph, etc.)
3. **Look for keywords** (sorted, distinct, path, substring, etc.)
4. **Determine the pattern** using the cheat sheet
5. **Apply the template** for that pattern
6. **Optimize if needed**

## Practice Recommendations

1. **Start with Easy**: Master basic patterns
2. **Focus on One Pattern**: Practice 10-15 problems per pattern
3. **Time Yourself**: Build speed and confidence
4. **Review Multiple Solutions**: Learn different approaches
5. **Track Your Progress**: Maintain a problem log

## Next Steps
- Practice problems by pattern category
- Time yourself to build interview speed
- Learn to quickly identify patterns in new problems
- Move to **[Module 25: Interview Preparation](../25-interview-prep/README.md)**
