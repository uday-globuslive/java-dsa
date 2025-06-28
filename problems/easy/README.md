# Easy Level Practice Problems

## Problem 1: Two Sum
**Difficulty:** Easy  
**Topics:** Array, Hash Table  
**Companies:** Amazon, Apple, Facebook, Google, Microsoft

### Problem Statement
Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

### Examples
```
Example 1:
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:
Input: nums = [3,2,4], target = 6
Output: [1,2]

Example 3:
Input: nums = [3,3], target = 6
Output: [0,1]
```

### Constraints
- 2 ≤ nums.length ≤ 10⁴
- -10⁹ ≤ nums[i] ≤ 10⁹
- -10⁹ ≤ target ≤ 10⁹
- Only one valid answer exists.

### Solution Approaches

#### Approach 1: Brute Force
```java
public class Solution {
    public int[] twoSum(int[] nums, int target) {
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    return new int[]{i, j};
                }
            }
        }
        return new int[0]; // No solution found
    }
}

// Time Complexity: O(n²)
// Space Complexity: O(1)
```

#### Approach 2: Hash Map (Optimal)
```java
import java.util.*;

public class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            
            map.put(nums[i], i);
        }
        
        return new int[0]; // No solution found
    }
}

// Time Complexity: O(n)
// Space Complexity: O(n)
```

### Key Insights
1. **Hash Map Pattern:** Store seen values with their indices for O(1) lookups
2. **Complement Logic:** For each number, look for `target - current_number`
3. **Order Matters:** Check for complement before adding current element to avoid using same element twice

### Test Cases
```java
public class TwoSumTest {
    public static void main(String[] args) {
        Solution solution = new Solution();
        
        // Test Case 1: Normal case
        int[] nums1 = {2, 7, 11, 15};
        int[] result1 = solution.twoSum(nums1, 9);
        System.out.println(Arrays.toString(result1)); // [0, 1]
        
        // Test Case 2: Last two elements
        int[] nums2 = {3, 2, 4};
        int[] result2 = solution.twoSum(nums2, 6);
        System.out.println(Arrays.toString(result2)); // [1, 2]
        
        // Test Case 3: Same numbers
        int[] nums3 = {3, 3};
        int[] result3 = solution.twoSum(nums3, 6);
        System.out.println(Arrays.toString(result3)); // [0, 1]
        
        // Test Case 4: Negative numbers
        int[] nums4 = {-1, -2, -3, -4, -5};
        int[] result4 = solution.twoSum(nums4, -8);
        System.out.println(Arrays.toString(result4)); // [2, 4]
    }
}
```

---

## Problem 2: Valid Parentheses
**Difficulty:** Easy  
**Topics:** String, Stack  
**Companies:** Amazon, Facebook, Google, Microsoft

### Problem Statement
Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.

### Examples
```
Example 1:
Input: s = "()"
Output: true

Example 2:
Input: s = "()[]{}"
Output: true

Example 3:
Input: s = "(]"
Output: false

Example 4:
Input: s = "([)]"
Output: false

Example 5:
Input: s = "{[]}"
Output: true
```

### Solution
```java
import java.util.*;

public class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        
        for (char c : s.toCharArray()) {
            // Push opening brackets onto stack
            if (c == '(' || c == '{' || c == '[') {
                stack.push(c);
            } 
            // Check closing brackets
            else {
                if (stack.isEmpty()) {
                    return false; // No matching opening bracket
                }
                
                char top = stack.pop();
                if (!isMatchingPair(top, c)) {
                    return false;
                }
            }
        }
        
        return stack.isEmpty(); // All brackets should be matched
    }
    
    private boolean isMatchingPair(char open, char close) {
        return (open == '(' && close == ')') ||
               (open == '{' && close == '}') ||
               (open == '[' && close == ']');
    }
}

// Time Complexity: O(n)
// Space Complexity: O(n)
```

### Alternative Solution (Using Map)
```java
public class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        Map<Character, Character> mapping = new HashMap<>();
        mapping.put(')', '(');
        mapping.put('}', '{');
        mapping.put(']', '[');
        
        for (char c : s.toCharArray()) {
            if (mapping.containsKey(c)) { // Closing bracket
                char topElement = stack.isEmpty() ? '#' : stack.pop();
                if (topElement != mapping.get(c)) {
                    return false;
                }
            } else { // Opening bracket
                stack.push(c);
            }
        }
        
        return stack.isEmpty();
    }
}
```

---

## Problem 3: Best Time to Buy and Sell Stock
**Difficulty:** Easy  
**Topics:** Array, Dynamic Programming  
**Companies:** Amazon, Bloomberg, Facebook, Microsoft

### Problem Statement
You are given an array `prices` where `prices[i]` is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

### Examples
```
Example 1:
Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.

Example 2:
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.
```

### Solution
```java
public class Solution {
    public int maxProfit(int[] prices) {
        if (prices.length == 0) return 0;
        
        int minPrice = prices[0];
        int maxProfit = 0;
        
        for (int i = 1; i < prices.length; i++) {
            // Update minimum price seen so far
            if (prices[i] < minPrice) {
                minPrice = prices[i];
            }
            // Calculate profit if we sell today
            else if (prices[i] - minPrice > maxProfit) {
                maxProfit = prices[i] - minPrice;
            }
        }
        
        return maxProfit;
    }
}

// Time Complexity: O(n)
// Space Complexity: O(1)
```

### Key Insights
1. **Track minimum price:** Keep track of the lowest price seen so far
2. **Calculate profit at each step:** For each price, calculate profit if we sell at current price
3. **One pass solution:** We only need to go through the array once

---

## Problem 4: Palindrome Number
**Difficulty:** Easy  
**Topics:** Math  
**Companies:** Amazon, Facebook, Google

### Problem Statement
Given an integer `x`, return `true` if `x` is palindrome integer.

An integer is a palindrome when it reads the same backward as forward.

### Examples
```
Example 1:
Input: x = 121
Output: true

Example 2:
Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.

Example 3:
Input: x = 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
```

### Solution Approaches

#### Approach 1: Convert to String
```java
public class Solution {
    public boolean isPalindrome(int x) {
        String str = String.valueOf(x);
        int left = 0, right = str.length() - 1;
        
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
}
```

#### Approach 2: Mathematical Approach (Optimal)
```java
public class Solution {
    public boolean isPalindrome(int x) {
        // Negative numbers are not palindromes
        if (x < 0) return false;
        
        // Numbers ending in 0 (except 0 itself) are not palindromes
        if (x % 10 == 0 && x != 0) return false;
        
        int reversedHalf = 0;
        
        // Reverse only half of the number
        while (x > reversedHalf) {
            reversedHalf = reversedHalf * 10 + x % 10;
            x /= 10;
        }
        
        // For even number of digits: x == reversedHalf
        // For odd number of digits: x == reversedHalf / 10
        return x == reversedHalf || x == reversedHalf / 10;
    }
}

// Time Complexity: O(log n)
// Space Complexity: O(1)
```

---

## Problem 5: Merge Two Sorted Lists
**Difficulty:** Easy  
**Topics:** Linked List, Recursion  
**Companies:** Amazon, Apple, Facebook, Google, Microsoft

### Problem Statement
You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists in a sorted order. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

### Definition
```java
public class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}
```

### Solution Approaches

#### Approach 1: Iterative
```java
public class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (list1 != null && list2 != null) {
            if (list1.val <= list2.val) {
                current.next = list1;
                list1 = list1.next;
            } else {
                current.next = list2;
                list2 = list2.next;
            }
            current = current.next;
        }
        
        // Attach remaining nodes
        current.next = (list1 != null) ? list1 : list2;
        
        return dummy.next;
    }
}

// Time Complexity: O(m + n)
// Space Complexity: O(1)
```

#### Approach 2: Recursive
```java
public class Solution {
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        // Base cases
        if (list1 == null) return list2;
        if (list2 == null) return list1;
        
        if (list1.val <= list2.val) {
            list1.next = mergeTwoLists(list1.next, list2);
            return list1;
        } else {
            list2.next = mergeTwoLists(list1, list2.next);
            return list2;
        }
    }
}

// Time Complexity: O(m + n)
// Space Complexity: O(m + n) due to recursion stack
```

---

## 📝 Practice Schedule

### Week 1: Foundation Problems
- Day 1-2: Two Sum variations
- Day 3-4: Valid Parentheses and variations
- Day 5-6: Best Time to Buy and Sell Stock
- Day 7: Review and practice similar problems

### Week 2: String and Math Problems
- Day 1-2: Palindrome problems
- Day 3-4: Anagram and string manipulation
- Day 5-6: Basic math problems
- Day 7: Mixed practice

### Week 3: Data Structure Basics
- Day 1-2: Linked List problems
- Day 3-4: Array manipulation
- Day 5-6: Stack and queue basics
- Day 7: Comprehensive review

## 🎯 Key Learning Points

### Common Patterns in Easy Problems
1. **Hash Map for lookups:** O(1) access for finding complements or tracking frequency
2. **Two pointers:** Efficient for palindromes and sorted arrays
3. **Stack for matching:** Parentheses, brackets, nested structures
4. **Dummy nodes:** Simplify linked list operations
5. **Edge case handling:** Empty inputs, single elements, negative numbers

### Problem-Solving Strategy
1. **Read carefully:** Understand all constraints and examples
2. **Think of brute force first:** Get a working solution
3. **Optimize step by step:** Identify bottlenecks and improve
4. **Test thoroughly:** Edge cases, normal cases, large inputs
5. **Practice similar problems:** Pattern recognition improves with practice

---

**Total Problems:** 5 core problems with variations  
**Estimated Time:** 1-2 weeks  
**Success Metric:** Solve each problem in under 15 minutes
