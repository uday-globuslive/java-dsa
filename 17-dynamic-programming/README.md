# Module 17: Dynamic Programming

## 🎯 Learning Objectives
- Master the fundamentals of dynamic programming
- Learn to identify DP problems and design solutions
- Understand memoization vs tabulation approaches
- Solve classic DP problems efficiently
- Optimize space complexity in DP solutions

## 📚 Dynamic Programming Fundamentals

### 17.1 Introduction to Dynamic Programming

#### What is Dynamic Programming?
Dynamic Programming (DP) is an algorithmic technique for solving optimization problems by breaking them down into simpler subproblems. It's applicable when the problem exhibits:

1. **Optimal Substructure:** Optimal solution contains optimal solutions to subproblems
2. **Overlapping Subproblems:** Same subproblems are solved multiple times

#### DP vs Divide and Conquer
```java
/*
Divide and Conquer:
- Subproblems are independent
- No overlapping subproblems
- Example: Merge Sort, Quick Sort

Dynamic Programming:
- Subproblems overlap
- Store solutions to avoid recomputation
- Example: Fibonacci, Longest Common Subsequence
*/

// Fibonacci: Divide and Conquer (Inefficient)
public int fibonacciRecursive(int n) {
    if (n <= 1) return n;
    return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
    // Time: O(2^n), Space: O(n)
}

// Fibonacci: Dynamic Programming (Efficient)
public int fibonacciDP(int n) {
    if (n <= 1) return n;
    
    int[] dp = new int[n + 1];
    dp[0] = 0;
    dp[1] = 1;
    
    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }
    
    return dp[n];
    // Time: O(n), Space: O(n)
}
```

### 17.2 Types of DP Approaches

#### Top-Down Approach (Memoization)
```java
public class TopDownDP {
    
    // Fibonacci with memoization
    public int fibonacci(int n) {
        Integer[] memo = new Integer[n + 1];
        return fibonacciHelper(n, memo);
    }
    
    private int fibonacciHelper(int n, Integer[] memo) {
        if (n <= 1) return n;
        
        if (memo[n] != null) {
            return memo[n]; // Return cached result
        }
        
        memo[n] = fibonacciHelper(n - 1, memo) + fibonacciHelper(n - 2, memo);
        return memo[n];
    }
    
    // Climbing Stairs with memoization
    public int climbStairs(int n) {
        Map<Integer, Integer> memo = new HashMap<>();
        return climbStairsHelper(n, memo);
    }
    
    private int climbStairsHelper(int n, Map<Integer, Integer> memo) {
        if (n <= 2) return n;
        
        if (memo.containsKey(n)) {
            return memo.get(n);
        }
        
        int result = climbStairsHelper(n - 1, memo) + climbStairsHelper(n - 2, memo);
        memo.put(n, result);
        return result;
    }
    
    // Longest Common Subsequence (LCS)
    public int longestCommonSubsequence(String text1, String text2) {
        int[][] memo = new int[text1.length()][text2.length()];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        return lcsHelper(text1, text2, 0, 0, memo);
    }
    
    private int lcsHelper(String s1, String s2, int i, int j, int[][] memo) {
        if (i == s1.length() || j == s2.length()) {
            return 0;
        }
        
        if (memo[i][j] != -1) {
            return memo[i][j];
        }
        
        if (s1.charAt(i) == s2.charAt(j)) {
            memo[i][j] = 1 + lcsHelper(s1, s2, i + 1, j + 1, memo);
        } else {
            memo[i][j] = Math.max(
                lcsHelper(s1, s2, i + 1, j, memo),
                lcsHelper(s1, s2, i, j + 1, memo)
            );
        }
        
        return memo[i][j];
    }
}
```

#### Bottom-Up Approach (Tabulation)
```java
public class BottomUpDP {
    
    // Fibonacci tabulation
    public int fibonacci(int n) {
        if (n <= 1) return n;
        
        int[] dp = new int[n + 1];
        dp[0] = 0;
        dp[1] = 1;
        
        for (int i = 2; i <= n; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        
        return dp[n];
    }
    
    // Space optimized Fibonacci
    public int fibonacciOptimized(int n) {
        if (n <= 1) return n;
        
        int prev2 = 0, prev1 = 1;
        
        for (int i = 2; i <= n; i++) {
            int current = prev1 + prev2;
            prev2 = prev1;
            prev1 = current;
        }
        
        return prev1;
    }
    
    // Climbing Stairs tabulation
    public int climbStairs(int n) {
        if (n <= 2) return n;
        
        int[] dp = new int[n + 1];
        dp[1] = 1;
        dp[2] = 2;
        
        for (int i = 3; i <= n; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        
        return dp[n];
    }
    
    // LCS tabulation
    public int longestCommonSubsequence(String text1, String text2) {
        int m = text1.length(), n = text2.length();
        int[][] dp = new int[m + 1][n + 1];
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (text1.charAt(i - 1) == text2.charAt(j - 1)) {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }
        
        return dp[m][n];
    }
}
```

### 17.3 Classic DP Problem Patterns

#### Pattern 1: Linear DP
```java
public class LinearDP {
    
    // House Robber - Can't rob adjacent houses
    public int rob(int[] nums) {
        if (nums.length == 0) return 0;
        if (nums.length == 1) return nums[0];
        
        int[] dp = new int[nums.length];
        dp[0] = nums[0];
        dp[1] = Math.max(nums[0], nums[1]);
        
        for (int i = 2; i < nums.length; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + nums[i]);
        }
        
        return dp[nums.length - 1];
    }
    
    // Space optimized version
    public int robOptimized(int[] nums) {
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
    
    // Maximum Subarray (Kadane's Algorithm)
    public int maxSubArray(int[] nums) {
        int maxSoFar = nums[0];
        int maxEndingHere = nums[0];
        
        for (int i = 1; i < nums.length; i++) {
            maxEndingHere = Math.max(nums[i], maxEndingHere + nums[i]);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }
        
        return maxSoFar;
    }
    
    // Decode Ways
    public int numDecodings(String s) {
        if (s.length() == 0 || s.charAt(0) == '0') return 0;
        
        int n = s.length();
        int[] dp = new int[n + 1];
        dp[0] = 1; // Empty string
        dp[1] = 1; // First character
        
        for (int i = 2; i <= n; i++) {
            int oneDigit = Integer.parseInt(s.substring(i - 1, i));
            int twoDigits = Integer.parseInt(s.substring(i - 2, i));
            
            if (oneDigit >= 1 && oneDigit <= 9) {
                dp[i] += dp[i - 1];
            }
            
            if (twoDigits >= 10 && twoDigits <= 26) {
                dp[i] += dp[i - 2];
            }
        }
        
        return dp[n];
    }
}
```

#### Pattern 2: Grid DP
```java
public class GridDP {
    
    // Unique Paths - Robot moving right or down
    public int uniquePaths(int m, int n) {
        int[][] dp = new int[m][n];
        
        // Initialize first row and column
        for (int i = 0; i < m; i++) dp[i][0] = 1;
        for (int j = 0; j < n; j++) dp[0][j] = 1;
        
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
            }
        }
        
        return dp[m - 1][n - 1];
    }
    
    // Space optimized version
    public int uniquePathsOptimized(int m, int n) {
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[j] += dp[j - 1];
            }
        }
        
        return dp[n - 1];
    }
    
    // Unique Paths II - With obstacles
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        int m = obstacleGrid.length, n = obstacleGrid[0].length;
        
        if (obstacleGrid[0][0] == 1 || obstacleGrid[m - 1][n - 1] == 1) {
            return 0;
        }
        
        int[][] dp = new int[m][n];
        dp[0][0] = 1;
        
        // Fill first row
        for (int j = 1; j < n; j++) {
            dp[0][j] = (obstacleGrid[0][j] == 1) ? 0 : dp[0][j - 1];
        }
        
        // Fill first column
        for (int i = 1; i < m; i++) {
            dp[i][0] = (obstacleGrid[i][0] == 1) ? 0 : dp[i - 1][0];
        }
        
        // Fill rest of the grid
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                if (obstacleGrid[i][j] == 1) {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
                }
            }
        }
        
        return dp[m - 1][n - 1];
    }
    
    // Minimum Path Sum
    public int minPathSum(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        
        dp[0][0] = grid[0][0];
        
        // Fill first row
        for (int j = 1; j < n; j++) {
            dp[0][j] = dp[0][j - 1] + grid[0][j];
        }
        
        // Fill first column
        for (int i = 1; i < m; i++) {
            dp[i][0] = dp[i - 1][0] + grid[i][0];
        }
        
        // Fill rest of the grid
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[i][j] = Math.min(dp[i - 1][j], dp[i][j - 1]) + grid[i][j];
            }
        }
        
        return dp[m - 1][n - 1];
    }
}
```

#### Pattern 3: Subsequence DP
```java
public class SubsequenceDP {
    
    // Longest Increasing Subsequence (LIS)
    public int lengthOfLIS(int[] nums) {
        if (nums.length == 0) return 0;
        
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
    
    // LIS with binary search optimization - O(n log n)
    public int lengthOfLISOptimized(int[] nums) {
        List<Integer> tails = new ArrayList<>();
        
        for (int num : nums) {
            int pos = Collections.binarySearch(tails, num);
            if (pos < 0) {
                pos = -(pos + 1);
            }
            
            if (pos == tails.size()) {
                tails.add(num);
            } else {
                tails.set(pos, num);
            }
        }
        
        return tails.size();
    }
    
    // Edit Distance (Levenshtein Distance)
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
                        Math.min(dp[i - 1][j], dp[i][j - 1]), // Insert/Delete
                        dp[i - 1][j - 1] // Replace
                    );
                }
            }
        }
        
        return dp[m][n];
    }
    
    // Palindromic Subsequences
    public int longestPalindromeSubseq(String s) {
        int n = s.length();
        int[][] dp = new int[n][n];
        
        // Every single character is a palindrome of length 1
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }
        
        // Fill for lengths 2 to n
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = 2 + dp[i + 1][j - 1];
                } else {
                    dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }
        
        return dp[0][n - 1];
    }
}
```

### 17.4 Knapsack Problems

#### 0/1 Knapsack
```java
public class KnapsackProblems {
    
    // Classic 0/1 Knapsack
    public int knapsack(int[] weights, int[] values, int capacity) {
        int n = weights.length;
        int[][] dp = new int[n + 1][capacity + 1];
        
        for (int i = 1; i <= n; i++) {
            for (int w = 1; w <= capacity; w++) {
                if (weights[i - 1] <= w) {
                    dp[i][w] = Math.max(
                        dp[i - 1][w], // Don't take item i
                        values[i - 1] + dp[i - 1][w - weights[i - 1]] // Take item i
                    );
                } else {
                    dp[i][w] = dp[i - 1][w];
                }
            }
        }
        
        return dp[n][capacity];
    }
    
    // Space optimized 0/1 Knapsack
    public int knapsackOptimized(int[] weights, int[] values, int capacity) {
        int[] dp = new int[capacity + 1];
        
        for (int i = 0; i < weights.length; i++) {
            // Traverse backwards to avoid using updated values
            for (int w = capacity; w >= weights[i]; w--) {
                dp[w] = Math.max(dp[w], values[i] + dp[w - weights[i]]);
            }
        }
        
        return dp[capacity];
    }
    
    // Subset Sum Problem
    public boolean canPartition(int[] nums) {
        int sum = Arrays.stream(nums).sum();
        if (sum % 2 != 0) return false;
        
        int target = sum / 2;
        boolean[] dp = new boolean[target + 1];
        dp[0] = true;
        
        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = dp[j] || dp[j - num];
            }
        }
        
        return dp[target];
    }
    
    // Target Sum (with +/- signs)
    public int findTargetSumWays(int[] nums, int target) {
        int sum = Arrays.stream(nums).sum();
        if (sum < Math.abs(target) || (sum + target) % 2 != 0) {
            return 0;
        }
        
        int positiveSum = (sum + target) / 2;
        return countSubsetSum(nums, positiveSum);
    }
    
    private int countSubsetSum(int[] nums, int target) {
        int[] dp = new int[target + 1];
        dp[0] = 1;
        
        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] += dp[j - num];
            }
        }
        
        return dp[target];
    }
}
```

#### Unbounded Knapsack
```java
public class UnboundedKnapsack {
    
    // Coin Change - Minimum coins
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
    
    // Coin Change II - Number of ways
    public int change(int amount, int[] coins) {
        int[] dp = new int[amount + 1];
        dp[0] = 1;
        
        for (int coin : coins) {
            for (int i = coin; i <= amount; i++) {
                dp[i] += dp[i - coin];
            }
        }
        
        return dp[amount];
    }
    
    // Perfect Squares
    public int numSquares(int n) {
        int[] dp = new int[n + 1];
        Arrays.fill(dp, n);
        dp[0] = 0;
        
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j * j <= i; j++) {
                dp[i] = Math.min(dp[i], dp[i - j * j] + 1);
            }
        }
        
        return dp[n];
    }
}
```

### 17.5 Advanced DP Patterns

#### State Machine DP
```java
public class StateMachineDP {
    
    // Best Time to Buy and Sell Stock with Transaction Fee
    public int maxProfit(int[] prices, int fee) {
        int hold = -prices[0]; // Holding stock
        int sold = 0;          // Not holding stock
        
        for (int i = 1; i < prices.length; i++) {
            int newHold = Math.max(hold, sold - prices[i]);
            int newSold = Math.max(sold, hold + prices[i] - fee);
            
            hold = newHold;
            sold = newSold;
        }
        
        return sold;
    }
    
    // Best Time to Buy and Sell Stock with Cooldown
    public int maxProfitWithCooldown(int[] prices) {
        if (prices.length <= 1) return 0;
        
        int sold = 0;     // Just sold, in cooldown
        int held = -prices[0]; // Holding stock
        int rest = 0;     // Not holding, can buy
        
        for (int i = 1; i < prices.length; i++) {
            int prevSold = sold;
            int prevHeld = held;
            int prevRest = rest;
            
            sold = prevHeld + prices[i];
            held = Math.max(prevHeld, prevRest - prices[i]);
            rest = Math.max(prevRest, prevSold);
        }
        
        return Math.max(sold, rest);
    }
}
```

#### Interval DP
```java
public class IntervalDP {
    
    // Matrix Chain Multiplication
    public int matrixChainOrder(int[] p) {
        int n = p.length - 1; // Number of matrices
        int[][] dp = new int[n][n];
        
        // Length of chain
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                dp[i][j] = Integer.MAX_VALUE;
                
                for (int k = i; k < j; k++) {
                    int cost = dp[i][k] + dp[k + 1][j] + p[i] * p[k + 1] * p[j + 1];
                    dp[i][j] = Math.min(dp[i][j], cost);
                }
            }
        }
        
        return dp[0][n - 1];
    }
    
    // Palindrome Partitioning II
    public int minCut(String s) {
        int n = s.length();
        boolean[][] isPalindrome = new boolean[n][n];
        
        // Build palindrome table
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (len == 1) {
                    isPalindrome[i][j] = true;
                } else if (len == 2) {
                    isPalindrome[i][j] = (s.charAt(i) == s.charAt(j));
                } else {
                    isPalindrome[i][j] = (s.charAt(i) == s.charAt(j)) && isPalindrome[i + 1][j - 1];
                }
            }
        }
        
        // DP for minimum cuts
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            if (isPalindrome[0][i]) {
                dp[i] = 0;
            } else {
                dp[i] = i; // Worst case: i cuts
                for (int j = 1; j <= i; j++) {
                    if (isPalindrome[j][i]) {
                        dp[i] = Math.min(dp[i], dp[j - 1] + 1);
                    }
                }
            }
        }
        
        return dp[n - 1];
    }
}
```

## 🧪 Practice Problems

### Easy Level DP Problems
```java
public class EasyDPProblems {
    
    // 1. Climbing Stairs
    public int climbStairs(int n) {
        if (n <= 2) return n;
        
        int prev2 = 1, prev1 = 2;
        for (int i = 3; i <= n; i++) {
            int current = prev1 + prev2;
            prev2 = prev1;
            prev1 = current;
        }
        return prev1;
    }
    
    // 2. Min Cost Climbing Stairs
    public int minCostClimbingStairs(int[] cost) {
        int n = cost.length;
        int prev2 = cost[0], prev1 = cost[1];
        
        for (int i = 2; i < n; i++) {
            int current = cost[i] + Math.min(prev1, prev2);
            prev2 = prev1;
            prev1 = current;
        }
        
        return Math.min(prev1, prev2);
    }
    
    // 3. House Robber
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
}
```

### Medium Level DP Problems
```java
public class MediumDPProblems {
    
    // 1. Unique Paths
    public int uniquePaths(int m, int n) {
        int[] dp = new int[n];
        Arrays.fill(dp, 1);
        
        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[j] += dp[j - 1];
            }
        }
        
        return dp[n - 1];
    }
    
    // 2. Word Break
    public boolean wordBreak(String s, List<String> wordDict) {
        Set<String> wordSet = new HashSet<>(wordDict);
        boolean[] dp = new boolean[s.length() + 1];
        dp[0] = true;
        
        for (int i = 1; i <= s.length(); i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] && wordSet.contains(s.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        
        return dp[s.length()];
    }
    
    // 3. Partition Equal Subset Sum
    public boolean canPartition(int[] nums) {
        int sum = Arrays.stream(nums).sum();
        if (sum % 2 != 0) return false;
        
        int target = sum / 2;
        boolean[] dp = new boolean[target + 1];
        dp[0] = true;
        
        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = dp[j] || dp[j - num];
            }
        }
        
        return dp[target];
    }
}
```

## 📊 DP Problem Recognition Guide

### When to Use Dynamic Programming
```java
/*
DP Indicators:
1. Optimization problems (min/max/count)
2. "Number of ways" problems
3. Can be broken into similar subproblems
4. Optimal substructure exists
5. Overlapping subproblems

Common DP Keywords:
- "Minimum/Maximum"
- "Count number of ways"
- "Is it possible to"
- "Longest/Shortest"
- "Optimal"

Problem Types:
- Path counting
- Optimization
- String problems
- Subsequence problems
- Game theory
- Interval problems
*/
```

### DP Design Process
```java
/*
Step 1: Identify the Problem Type
- Linear DP (1D array)
- Grid DP (2D array)
- Subsequence DP
- Knapsack variants
- Interval DP

Step 2: Define the State
- What variables define a subproblem?
- What does dp[i] or dp[i][j] represent?

Step 3: Find the Recurrence Relation
- How does current state relate to previous states?
- What are the transitions?

Step 4: Determine Base Cases
- What are the simplest subproblems?
- Initialize boundary conditions

Step 5: Decide Order of Computation
- Bottom-up (tabulation) vs Top-down (memoization)
- What order to fill the DP table?

Step 6: Optimize Space (if possible)
- Can we reduce space complexity?
- Rolling array technique?
*/
```

## ✅ Dynamic Programming Mastery Checklist

### Fundamental Understanding
- [ ] Understand optimal substructure and overlapping subproblems
- [ ] Distinguish between DP and divide-and-conquer
- [ ] Know when to apply memoization vs tabulation
- [ ] Can identify DP problems from problem statements
- [ ] Understand time and space complexity analysis

### Implementation Skills
- [ ] Implement memoization correctly
- [ ] Write clean tabulation solutions
- [ ] Handle base cases and boundary conditions
- [ ] Optimize space complexity when possible
- [ ] Debug DP solutions effectively

### Problem-Solving Patterns
- [ ] Master linear DP problems
- [ ] Solve grid DP problems confidently
- [ ] Handle subsequence DP variations
- [ ] Understand knapsack problem variants
- [ ] Apply DP to string problems

### Advanced Techniques
- [ ] Implement state machine DP
- [ ] Solve interval DP problems
- [ ] Apply DP to tree problems
- [ ] Use bitmask DP for subset problems
- [ ] Optimize with mathematical insights

## 🎯 Next Steps

After mastering Dynamic Programming:
1. Practice 30+ DP problems of varying difficulty
2. Focus on recognizing patterns quickly
3. Learn to optimize solutions
4. Move to [Module 18: Greedy Algorithms](../18-greedy/)

---

**Estimated Time:** 3-4 weeks  
**Practice Problems:** 50+ problems  
**Key Skills:** Pattern recognition, optimization, state design
