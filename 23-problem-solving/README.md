# Module 23: Problem Solving Framework

## 🎯 Learning Objectives
- Master a systematic approach to solving coding problems
- Learn to analyze problem complexity and choose optimal solutions
- Develop pattern recognition skills for common problem types
- Build confidence in tackling unknown problems

## 🧠 The UMPIRE Method

### **U**nderstand the Problem
### **M**atch to Known Patterns  
### **P**lan the Solution
### **I**mplement the Code
### **R**eview and Test
### **E**valuate and Optimize

---

## 🔍 Step 1: UNDERSTAND the Problem

### 1.1 Read Carefully and Clarify
```java
/*
Example Problem: "Find two numbers in array that sum to target"

Questions to ask:
- What if no solution exists?
- Can I use the same element twice?
- Are there duplicate numbers?
- What's the array size range?
- What are the number ranges?
- Should I return indices or values?
*/
```

### 1.2 Identify Input/Output
```java
// Input: int[] nums = [2,7,11,15], int target = 9
// Output: int[] indices = [0,1] (because nums[0] + nums[1] = 9)

// Edge Cases:
// - Empty array: []
// - Single element: [5]
// - No solution: [1,2,3], target = 10
// - Multiple solutions: [3,3], target = 6
```

### 1.3 Work Through Examples
```java
public class ProblemUnderstanding {
    public static void demonstrateApproach() {
        // Example 1: Normal case
        int[] nums1 = {2, 7, 11, 15};
        int target1 = 9;
        // Expected: [0, 1] because 2 + 7 = 9
        
        // Example 2: Numbers at end
        int[] nums2 = {3, 2, 4};
        int target2 = 6;
        // Expected: [1, 2] because 2 + 4 = 6
        
        // Example 3: Same number twice
        int[] nums3 = {3, 3};
        int target3 = 6;
        // Expected: [0, 1] because 3 + 3 = 6
    }
}
```

---

## 🎯 Step 2: MATCH to Known Patterns

### 2.1 Common Problem Patterns

#### **Array/String Patterns**
```java
// Two Pointers
// - Two Sum in sorted array
// - Palindrome checking
// - Container with most water

// Sliding Window
// - Maximum sum subarray of size k
// - Longest substring without repeating chars
// - Minimum window substring

// Frequency Counting
// - Anagram detection
// - Character frequency problems
// - Majority element
```

#### **Tree Patterns**
```java
// Tree Traversal
// - Inorder, preorder, postorder
// - Level order traversal
// - Path sum problems

// Tree Construction
// - Build tree from traversals
// - Clone trees
// - Serialize/deserialize

// Tree Properties
// - Height, diameter
// - Balanced tree checking
// - Lowest common ancestor
```

#### **Graph Patterns**
```java
// Graph Traversal
// - DFS for connected components
// - BFS for shortest path
// - Cycle detection

// Shortest Path
// - Dijkstra's algorithm
// - Bellman-Ford
// - Floyd-Warshall

// Minimum Spanning Tree
// - Kruskal's algorithm
// - Prim's algorithm
```

### 2.2 Algorithmic Paradigms

#### **Dynamic Programming**
```java
// Indicators:
// - Optimal substructure
// - Overlapping subproblems
// - "Find maximum/minimum"
// - "Count number of ways"

// Common DP Patterns:
// 1. Linear DP: Fibonacci, Climbing Stairs
// 2. 2D Grid: Unique Paths, Edit Distance
// 3. Subsequence: LCS, LIS
// 4. Knapsack: 0/1, Unbounded
```

#### **Greedy Algorithm**
```java
// Indicators:
// - Local optimal choice leads to global optimum
// - Activity selection problems
// - Interval scheduling
// - Huffman coding

// When to use:
// - Can prove greedy choice property
// - Optimal substructure exists
```

#### **Divide and Conquer**
```java
// Indicators:
// - Problem can be broken into subproblems
// - Subproblems are similar to original
// - Combine solutions efficiently

// Examples:
// - Merge Sort
// - Quick Sort
// - Binary Search
// - Maximum Subarray (Kadane's variation)
```

---

## 📋 Step 3: PLAN the Solution

### 3.1 Choose the Right Approach

```java
public class SolutionPlanning {
    
    // Problem: Two Sum
    // Given: int[] nums, int target
    // Return: indices of two numbers that sum to target
    
    // Approach 1: Brute Force - O(n²)
    public int[] twoSumBruteForce(int[] nums, int target) {
        /*
        Plan:
        1. For each element at index i
        2. Check all elements after i
        3. If nums[i] + nums[j] == target, return [i,j]
        
        Time: O(n²), Space: O(1)
        */
        return new int[0]; // Implementation follows
    }
    
    // Approach 2: Hash Map - O(n)
    public int[] twoSumOptimal(int[] nums, int target) {
        /*
        Plan:
        1. Create HashMap to store value -> index mapping
        2. For each element, calculate complement = target - current
        3. If complement exists in map, return indices
        4. Otherwise, add current element to map
        
        Time: O(n), Space: O(n)
        */
        return new int[0]; // Implementation follows
    }
}
```

### 3.2 Pseudocode First
```java
/*
Two Sum Optimal Solution Pseudocode:

FUNCTION twoSum(nums, target):
    CREATE empty hash map
    
    FOR i = 0 to nums.length - 1:
        complement = target - nums[i]
        
        IF complement exists in map:
            RETURN [map.get(complement), i]
        
        map.put(nums[i], i)
    
    RETURN empty array (no solution)
*/
```

### 3.3 Consider Edge Cases
```java
public class EdgeCaseConsideration {
    
    public int[] twoSum(int[] nums, int target) {
        // Edge cases to handle:
        
        // 1. Null or empty array
        if (nums == null || nums.length < 2) {
            return new int[0];
        }
        
        // 2. No solution exists
        // (handled by returning empty array at end)
        
        // 3. Same element used twice
        // (handled by checking map before adding current element)
        
        // 4. Multiple valid solutions
        // (return first one found)
        
        // Implementation here...
        return new int[0];
    }
}
```

---

## 💻 Step 4: IMPLEMENT the Code

### 4.1 Start with Clean Structure
```java
import java.util.*;

public class Solution {
    
    public int[] twoSum(int[] nums, int target) {
        // Input validation
        if (nums == null || nums.length < 2) {
            return new int[0];
        }
        
        // Main algorithm
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            
            map.put(nums[i], i);
        }
        
        // No solution found
        return new int[0];
    }
}
```

### 4.2 Add Debugging Support
```java
public class DebugableSolution {
    
    public int[] twoSum(int[] nums, int target) {
        System.out.println("Input: " + Arrays.toString(nums) + ", target: " + target);
        
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            System.out.println("Checking nums[" + i + "]=" + nums[i] + 
                             ", complement=" + complement);
            
            if (map.containsKey(complement)) {
                int[] result = new int[]{map.get(complement), i};
                System.out.println("Found solution: " + Arrays.toString(result));
                return result;
            }
            
            map.put(nums[i], i);
            System.out.println("Added to map: " + nums[i] + " -> " + i);
        }
        
        System.out.println("No solution found");
        return new int[0];
    }
}
```

---

## 🧪 Step 5: REVIEW and Test

### 5.1 Test with Examples
```java
public class SolutionTester {
    
    public static void main(String[] args) {
        Solution solution = new Solution();
        
        // Test Case 1: Normal case
        testCase(solution, new int[]{2, 7, 11, 15}, 9, 
                new int[]{0, 1}, "Normal case");
        
        // Test Case 2: Numbers at end
        testCase(solution, new int[]{3, 2, 4}, 6, 
                new int[]{1, 2}, "Numbers at end");
        
        // Test Case 3: Same number twice
        testCase(solution, new int[]{3, 3}, 6, 
                new int[]{0, 1}, "Same number twice");
        
        // Test Case 4: No solution
        testCase(solution, new int[]{1, 2, 3}, 10, 
                new int[0], "No solution");
        
        // Test Case 5: Edge case - minimum input
        testCase(solution, new int[]{1, 2}, 3, 
                new int[]{0, 1}, "Minimum input");
    }
    
    private static void testCase(Solution solution, int[] nums, int target, 
                               int[] expected, String description) {
        int[] result = solution.twoSum(nums, target);
        boolean passed = Arrays.equals(result, expected);
        
        System.out.println(description + ": " + (passed ? "PASS" : "FAIL"));
        if (!passed) {
            System.out.println("  Expected: " + Arrays.toString(expected));
            System.out.println("  Got: " + Arrays.toString(result));
        }
    }
}
```

### 5.2 Code Review Checklist
```java
/*
✅ Functionality Checklist:
□ Handles all given examples correctly
□ Handles edge cases (empty, null, no solution)
□ Returns correct data type and format
□ No infinite loops or stack overflow risk

✅ Code Quality Checklist:
□ Variable names are descriptive
□ Code is readable and well-structured
□ No magic numbers or hardcoded values
□ Appropriate comments for complex logic

✅ Performance Checklist:
□ Time complexity is optimal for the problem
□ Space complexity is reasonable
□ No unnecessary operations in loops
□ Efficient data structure choices
*/
```

---

## ⚡ Step 6: EVALUATE and Optimize

### 6.1 Complexity Analysis
```java
public class ComplexityAnalysis {
    
    // Brute Force Solution
    public int[] twoSumBruteForce(int[] nums, int target) {
        // Time Complexity: O(n²)
        // - Outer loop: n iterations
        // - Inner loop: n-1, n-2, ..., 1 iterations
        // - Total: n(n-1)/2 ≈ O(n²)
        
        // Space Complexity: O(1)
        // - Only using constant extra space
        
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    return new int[]{i, j};
                }
            }
        }
        return new int[0];
    }
    
    // Optimized Solution
    public int[] twoSumOptimal(int[] nums, int target) {
        // Time Complexity: O(n)
        // - Single loop through array: n iterations
        // - HashMap operations (get, put): O(1) average
        // - Total: O(n)
        
        // Space Complexity: O(n)
        // - HashMap can store up to n elements
        // - In worst case: O(n) extra space
        
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            map.put(nums[i], i);
        }
        return new int[0];
    }
}
```

### 6.2 Alternative Approaches
```java
public class AlternativeApproaches {
    
    // If array is sorted, we can use two pointers
    public int[] twoSumSorted(int[] nums, int target) {
        // Time: O(n), Space: O(1)
        // But requires sorted array
        
        int left = 0, right = nums.length - 1;
        while (left < right) {
            int sum = nums[left] + nums[right];
            if (sum == target) {
                return new int[]{left, right};
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        return new int[0];
    }
    
    // If we can modify the input and don't need exact indices
    public boolean twoSumExists(int[] nums, int target) {
        // Time: O(n log n), Space: O(1)
        Arrays.sort(nums);
        
        int left = 0, right = nums.length - 1;
        while (left < right) {
            int sum = nums[left] + nums[right];
            if (sum == target) return true;
            else if (sum < target) left++;
            else right--;
        }
        return false;
    }
}
```

### 6.3 When to Optimize Further
```java
/*
Consider further optimization when:

1. Time Limit Exceeded (TLE):
   - Current solution is too slow
   - Need better algorithm or data structure
   - Example: O(n²) → O(n log n) → O(n)

2. Memory Limit Exceeded (MLE):
   - Using too much extra space
   - Need space-efficient approach
   - Example: O(n) space → O(1) space

3. Special Constraints:
   - Very large input sizes
   - Real-time requirements
   - Memory-constrained environments

4. Multiple Query Optimization:
   - If same operation repeated many times
   - Preprocessing might help
   - Example: Build index once, query many times
*/
```

---

## 📊 Problem-Solving Templates

### Template 1: Array/String Problems
```java
public class ArrayStringTemplate {
    
    public ReturnType solveProblem(InputType input) {
        // 1. Input validation
        if (input == null || input.length == 0) {
            return defaultResult;
        }
        
        // 2. Initialize variables
        // Common patterns: two pointers, sliding window, hash map
        
        // 3. Main algorithm
        // Iterate through input and apply logic
        
        // 4. Return result
        return result;
    }
}
```

### Template 2: Tree Problems
```java
public class TreeTemplate {
    
    public ReturnType solveProblem(TreeNode root) {
        // 1. Base case
        if (root == null) {
            return defaultResult;
        }
        
        // 2. Recursive case
        // Process current node
        // Recurse on children
        // Combine results
        
        return result;
    }
    
    // Iterative template using stack/queue
    public ReturnType solveIterative(TreeNode root) {
        if (root == null) return defaultResult;
        
        Deque<TreeNode> stack = new ArrayDeque<>();
        stack.push(root);
        
        while (!stack.isEmpty()) {
            TreeNode current = stack.pop();
            // Process current node
            
            // Add children to stack
            if (current.right != null) stack.push(current.right);
            if (current.left != null) stack.push(current.left);
        }
        
        return result;
    }
}
```

### Template 3: Dynamic Programming
```java
public class DPTemplate {
    
    public ReturnType solveProblem(InputType input) {
        // 1. Identify state variables
        // What parameters uniquely define a subproblem?
        
        // 2. Define recurrence relation
        // How does dp[i] relate to previous states?
        
        // 3. Base cases
        // What are the simplest subproblems?
        
        // 4. Order of computation
        // Bottom-up or top-down?
        
        // 5. Optimize space if possible
        // Do we need full DP table?
        
        return result;
    }
}
```

---

## 🎯 Practice Framework Application

### Exercise 1: Apply UMPIRE to Valid Parentheses
```java
/*
Problem: Given a string containing just the characters '(', ')', '{', '}', '[' and ']', 
determine if the input string is valid.

Apply UMPIRE method:

U - Understand:
  - Valid means properly closed and nested
  - Examples: "()" is valid, "([)]" is not valid

M - Match:
  - Stack pattern for matching pairs
  - Last-in-first-out principle

P - Plan:
  - Use stack to track opening brackets
  - For each closing bracket, check if matches top of stack

I - Implement:
  - [Your implementation here]

R - Review:
  - Test with examples
  - Check edge cases

E - Evaluate:
  - Time: O(n), Space: O(n)
  - Can we do better?
*/
```

### Exercise 2: Apply UMPIRE to Binary Tree Level Order Traversal
```java
/*
Problem: Given a binary tree, return the level order traversal of its nodes' values.

Your turn to apply UMPIRE method:

U - Understand:
  [Fill in your understanding]

M - Match:
  [Identify the pattern]

P - Plan:
  [Write your approach]

I - Implement:
  [Code the solution]

R - Review:
  [Test your solution]

E - Evaluate:
  [Analyze complexity]
*/
```

---

## ✅ Problem-Solving Mastery Checklist

### Foundation Skills
- [ ] Can systematically break down any problem
- [ ] Recognize common patterns quickly
- [ ] Write clean, readable code consistently
- [ ] Handle edge cases proactively
- [ ] Test solutions thoroughly

### Pattern Recognition
- [ ] Identify two pointers problems
- [ ] Recognize sliding window opportunities
- [ ] Spot dynamic programming indicators
- [ ] Choose appropriate data structures
- [ ] Select optimal algorithms

### Implementation Skills
- [ ] Code without syntax errors
- [ ] Implement complex algorithms correctly
- [ ] Debug efficiently when issues arise
- [ ] Optimize for time and space
- [ ] Write production-quality code

### Problem-Solving Speed
- [ ] Understand problems quickly (2-3 minutes)
- [ ] Identify patterns rapidly (1-2 minutes)
- [ ] Plan solutions efficiently (3-5 minutes)
- [ ] Implement cleanly (10-15 minutes for medium)
- [ ] Test and debug fast (2-3 minutes)

---

## 🎯 Next Steps

Once you've mastered this framework:
1. Apply it to 20+ diverse problems
2. Time yourself on each step
3. Build your pattern recognition library
4. Move to [LeetCode Pattern Recognition](../24-leetcode-patterns/)

---

**Time to Master:** 2-3 weeks with consistent practice  
**Success Metric:** Solve unfamiliar medium problems in 20 minutes  
**Practice Problems:** 50+ problems using this framework
