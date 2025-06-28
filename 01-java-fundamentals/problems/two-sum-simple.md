# Two Sum - Simple Version

## 🎯 Problem Statement

Given an array of integers `nums` and an integer `target`, return the **indices** of two numbers in the array such that they add up to the target. You may assume that each input would have **exactly one solution**, and you may not use the same element twice.

**Example:**
```
Input: nums = [2, 7, 11, 15], target = 9
Output: [0, 1]
Explanation: nums[0] + nums[1] = 2 + 7 = 9
```

## 🎓 Learning Objectives

- Practice array traversal and indexing
- Understand nested loop patterns
- Learn about time and space complexity analysis
- Introduction to the two-pointer technique concept
- Practice with Java arrays and basic I/O

## 🛠️ Java Implementation

### Approach 1: Brute Force (Nested Loops)

```java
public class TwoSumSimple {
    
    /**
     * Finds two indices where the elements sum to target
     * Time Complexity: O(n²)
     * Space Complexity: O(1)
     */
    public static int[] twoSumBruteForce(int[] nums, int target) {
        // Input validation
        if (nums == null || nums.length < 2) {
            throw new IllegalArgumentException("Array must have at least 2 elements");
        }
        
        // Check every pair of elements
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    return new int[]{i, j};
                }
            }
        }
        
        // No solution found
        throw new IllegalArgumentException("No two sum solution exists");
    }
    
    /**
     * Alternative implementation with enhanced readability
     */
    public static int[] twoSumWithDetails(int[] nums, int target) {
        System.out.println("Searching for two numbers that sum to: " + target);
        System.out.println("Array: " + java.util.Arrays.toString(nums));
        
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                int sum = nums[i] + nums[j];
                System.out.printf("Checking: nums[%d]=%d + nums[%d]=%d = %d%n", 
                                i, nums[i], j, nums[j], sum);
                
                if (sum == target) {
                    System.out.printf("Found solution: indices [%d, %d]%n", i, j);
                    return new int[]{i, j};
                }
            }
        }
        
        throw new IllegalArgumentException("No solution found");
    }
    
    // Test the implementation
    public static void main(String[] args) {
        // Test cases
        int[][] testArrays = {
            {2, 7, 11, 15},
            {3, 2, 4},
            {3, 3},
            {1, 5, 3, 8, 2},
            {-1, -2, -3, -4, -5}
        };
        
        int[] targets = {9, 6, 6, 10, -8};
        
        for (int i = 0; i < testArrays.length; i++) {
            try {
                System.out.println("\n--- Test Case " + (i + 1) + " ---");
                int[] result = twoSumWithDetails(testArrays[i], targets[i]);
                System.out.println("Result: " + java.util.Arrays.toString(result));
            } catch (IllegalArgumentException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }
}
```

### Approach 2: Optimized with Early Exit Conditions

```java
public class TwoSumOptimized {
    
    /**
     * Optimized brute force with early termination
     */
    public static int[] twoSumOptimized(int[] nums, int target) {
        if (nums == null || nums.length < 2) {
            return new int[0]; // Return empty array instead of exception
        }
        
        for (int i = 0; i < nums.length - 1; i++) {
            int complement = target - nums[i];
            
            // Look for the complement in remaining elements
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[j] == complement) {
                    return new int[]{i, j};
                }
            }
        }
        
        return new int[0]; // No solution found
    }
    
    /**
     * Method to check if solution exists without returning indices
     */
    public static boolean hasTwoSum(int[] nums, int target) {
        if (nums == null || nums.length < 2) {
            return false;
        }
        
        for (int i = 0; i < nums.length - 1; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    return true;
                }
            }
        }
        return false;
    }
    
    /**
     * Method to find all pairs that sum to target
     */
    public static java.util.List<int[]> findAllTwoSumPairs(int[] nums, int target) {
        java.util.List<int[]> pairs = new java.util.ArrayList<>();
        
        if (nums == null || nums.length < 2) {
            return pairs;
        }
        
        for (int i = 0; i < nums.length - 1; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    pairs.add(new int[]{i, j});
                }
            }
        }
        
        return pairs;
    }
}
```

## 🧪 Interactive Testing

```java
import java.util.Scanner;

public class TwoSumInteractive {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Two Sum Interactive Solver ===");
        
        // Get array size
        System.out.print("Enter the size of the array: ");
        int size = scanner.nextInt();
        
        if (size < 2) {
            System.out.println("Array must have at least 2 elements!");
            return;
        }
        
        // Get array elements
        int[] nums = new int[size];
        System.out.println("Enter " + size + " integers:");
        for (int i = 0; i < size; i++) {
            System.out.print("Element " + (i + 1) + ": ");
            nums[i] = scanner.nextInt();
        }
        
        // Get target
        System.out.print("Enter the target sum: ");
        int target = scanner.nextInt();
        
        // Display the problem
        System.out.println("\nProblem:");
        System.out.println("Array: " + java.util.Arrays.toString(nums));
        System.out.println("Target: " + target);
        
        // Solve
        try {
            int[] result = TwoSumSimple.twoSumBruteForce(nums, target);
            System.out.println("\nSolution found!");
            System.out.printf("Indices: [%d, %d]%n", result[0], result[1]);
            System.out.printf("Values: nums[%d] = %d, nums[%d] = %d%n", 
                            result[0], nums[result[0]], result[1], nums[result[1]]);
            System.out.printf("Sum: %d + %d = %d%n", 
                            nums[result[0]], nums[result[1]], 
                            nums[result[0]] + nums[result[1]]);
        } catch (IllegalArgumentException e) {
            System.out.println("\nNo solution exists for this input.");
        }
        
        scanner.close();
    }
}
```

## 📊 Complexity Analysis

### Time Complexity: O(n²)
- **Outer loop**: Runs n-1 times
- **Inner loop**: Runs (n-1) + (n-2) + ... + 1 = n(n-1)/2 times
- **Total operations**: Approximately n²/2, which is O(n²)

### Space Complexity: O(1)
- Only using a constant amount of extra space
- Not counting the input array and output array

## 🎯 Practice Variations

### Variation 1: Return Values Instead of Indices
```java
public static int[] twoSumValues(int[] nums, int target) {
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return new int[]{nums[i], nums[j]};
            }
        }
    }
    return new int[0];
}
```

### Variation 2: Count All Valid Pairs
```java
public static int countTwoSumPairs(int[] nums, int target) {
    int count = 0;
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                count++;
            }
        }
    }
    return count;
}
```

### Variation 3: Handle Duplicates
```java
public static boolean canFormTarget(int[] nums, int target) {
    // Check if any two distinct elements sum to target
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return true;
            }
        }
    }
    return false;
}
```

## 🐛 Common Mistakes and How to Avoid Them

### 1. Index Out of Bounds
```java
// WRONG: Can cause IndexOutOfBoundsException
for (int i = 0; i < nums.length; i++) {
    for (int j = i; j < nums.length; j++) {  // j starts at i, includes same element
        if (nums[i] + nums[j] == target) {
            return new int[]{i, j};
        }
    }
}

// CORRECT: Start j at i+1 to avoid using same element
for (int i = 0; i < nums.length; i++) {
    for (int j = i + 1; j < nums.length; j++) {
        if (nums[i] + nums[j] == target) {
            return new int[]{i, j};
        }
    }
}
```

### 2. Null Input Handling
```java
// WRONG: No null check
public static int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length; i++) {  // NullPointerException if nums is null
        // ...
    }
}

// CORRECT: Check for null input
public static int[] twoSum(int[] nums, int target) {
    if (nums == null || nums.length < 2) {
        throw new IllegalArgumentException("Invalid input array");
    }
    // ...
}
```

### 3. Not Handling "No Solution" Case
```java
// WRONG: Method might not return anything
public static int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return new int[]{i, j};
            }
        }
    }
    // Missing return statement or exception
}

// CORRECT: Handle no solution case
public static int[] twoSum(int[] nums, int target) {
    for (int i = 0; i < nums.length - 1; i++) {
        for (int j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] == target) {
                return new int[]{i, j};
            }
        }
    }
    throw new IllegalArgumentException("No two sum solution exists");
}
```

## 🧠 Thinking Process

When approaching this problem:

1. **Understand the requirement**: Find indices of two numbers that sum to target
2. **Consider constraints**: Each element can only be used once
3. **Think about approach**: Check every possible pair
4. **Implement systematically**: Outer loop for first element, inner loop for second
5. **Handle edge cases**: null arrays, arrays with less than 2 elements, no solution
6. **Test thoroughly**: Various test cases including edge cases

## 🔗 Related Concepts

- **Array traversal patterns**
- **Nested loops**
- **Index manipulation**
- **Basic algorithm complexity**
- **Exception handling**
- **Input validation**

## 📈 Next Steps

After mastering this simple version:
1. Learn the HashMap optimization (O(n) solution)
2. Try the sorted array + two pointers approach
3. Explore variations like Three Sum
4. Practice with similar array problems

This problem introduces fundamental concepts that appear in many coding interview questions!
