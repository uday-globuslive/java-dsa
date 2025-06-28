# Maximum Subarray (Brute Force)

## 🎯 Problem Statement

Given an integer array `nums`, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum. For this beginner version, we'll implement a brute force solution to understand the concept thoroughly.

**Example:**
```
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6
```

## 🎓 Learning Objectives

- Understand subarray concepts
- Practice nested loops and brute force approach
- Learn about maximum/minimum tracking
- Master array traversal patterns
- Introduction to optimization concepts
- Handle edge cases with negative numbers

## 🛠️ Java Implementation

### Brute Force Approach

```java
public class MaxSubarrayBruteForce {
    
    /**
     * Finds maximum sum of contiguous subarray using brute force
     * Time Complexity: O(n³)
     * Space Complexity: O(1)
     */
    public static int maxSubarrayBruteForce(int[] nums) {
        if (nums == null || nums.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        int maxSum = Integer.MIN_VALUE;
        int n = nums.length;
        
        // Try all possible subarrays
        for (int i = 0; i < n; i++) {           // Starting position
            for (int j = i; j < n; j++) {       // Ending position
                
                // Calculate sum of subarray from i to j
                int currentSum = 0;
                for (int k = i; k <= j; k++) {
                    currentSum += nums[k];
                }
                
                // Update maximum sum if current sum is larger
                maxSum = Math.max(maxSum, currentSum);
            }
        }
        
        return maxSum;
    }
    
    /**
     * Optimized brute force - O(n²) by avoiding recalculation
     */
    public static int maxSubarrayOptimized(int[] nums) {
        if (nums == null || nums.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        int maxSum = Integer.MIN_VALUE;
        int n = nums.length;
        
        for (int i = 0; i < n; i++) {
            int currentSum = 0;
            
            for (int j = i; j < n; j++) {
                currentSum += nums[j];  // Add next element to current sum
                maxSum = Math.max(maxSum, currentSum);
            }
        }
        
        return maxSum;
    }
    
    /**
     * Brute force with detailed tracking
     */
    public static MaxSubarrayResult maxSubarrayWithDetails(int[] nums) {
        if (nums == null || nums.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        int maxSum = Integer.MIN_VALUE;
        int bestStart = 0, bestEnd = 0;
        int n = nums.length;
        
        System.out.println("Finding maximum subarray in: " + java.util.Arrays.toString(nums));
        
        for (int i = 0; i < n; i++) {
            int currentSum = 0;
            
            for (int j = i; j < n; j++) {
                currentSum += nums[j];
                
                System.out.printf("Subarray [%d,%d]: %s = %d%n", 
                                i, j, getSubarrayString(nums, i, j), currentSum);
                
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                    bestStart = i;
                    bestEnd = j;
                    System.out.printf("*** New maximum found: %d ***%n", maxSum);
                }
            }
        }
        
        return new MaxSubarrayResult(maxSum, bestStart, bestEnd, nums);
    }
    
    private static String getSubarrayString(int[] nums, int start, int end) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = start; i <= end; i++) {
            sb.append(nums[i]);
            if (i < end) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
    
    /**
     * Result class to hold maximum subarray information
     */
    public static class MaxSubarrayResult {
        private final int maxSum;
        private final int startIndex;
        private final int endIndex;
        private final int[] originalArray;
        
        public MaxSubarrayResult(int maxSum, int startIndex, int endIndex, int[] originalArray) {
            this.maxSum = maxSum;
            this.startIndex = startIndex;
            this.endIndex = endIndex;
            this.originalArray = originalArray.clone();
        }
        
        public int getMaxSum() { return maxSum; }
        public int getStartIndex() { return startIndex; }
        public int getEndIndex() { return endIndex; }
        
        public int[] getMaxSubarray() {
            int[] result = new int[endIndex - startIndex + 1];
            System.arraycopy(originalArray, startIndex, result, 0, result.length);
            return result;
        }
        
        public void printResult() {
            System.out.println("\n=== Maximum Subarray Result ===");
            System.out.println("Original array: " + java.util.Arrays.toString(originalArray));
            System.out.println("Maximum sum: " + maxSum);
            System.out.println("Start index: " + startIndex);
            System.out.println("End index: " + endIndex);
            System.out.println("Maximum subarray: " + java.util.Arrays.toString(getMaxSubarray()));
        }
    }
}
```

### Extended Problem Variations

```java
public class MaxSubarrayVariations {
    
    /**
     * Find maximum sum with subarray indices
     */
    public static int[] maxSubarrayWithIndices(int[] nums) {
        if (nums == null || nums.length == 0) {
            return new int[0];
        }
        
        int maxSum = Integer.MIN_VALUE;
        int bestStart = 0, bestEnd = 0;
        
        for (int i = 0; i < nums.length; i++) {
            int currentSum = 0;
            
            for (int j = i; j < nums.length; j++) {
                currentSum += nums[j];
                
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                    bestStart = i;
                    bestEnd = j;
                }
            }
        }
        
        return new int[]{maxSum, bestStart, bestEnd};
    }
    
    /**
     * Find maximum subarray of specific length k
     */
    public static int maxSubarrayOfLengthK(int[] nums, int k) {
        if (nums == null || nums.length < k || k <= 0) {
            throw new IllegalArgumentException("Invalid input parameters");
        }
        
        int maxSum = Integer.MIN_VALUE;
        
        for (int i = 0; i <= nums.length - k; i++) {
            int currentSum = 0;
            
            for (int j = i; j < i + k; j++) {
                currentSum += nums[j];
            }
            
            maxSum = Math.max(maxSum, currentSum);
        }
        
        return maxSum;
    }
    
    /**
     * Find all subarrays with maximum sum
     */
    public static java.util.List<int[]> allMaxSubarrays(int[] nums) {
        java.util.List<int[]> result = new java.util.ArrayList<>();
        
        if (nums == null || nums.length == 0) {
            return result;
        }
        
        int maxSum = Integer.MIN_VALUE;
        
        // First pass: find maximum sum
        for (int i = 0; i < nums.length; i++) {
            int currentSum = 0;
            
            for (int j = i; j < nums.length; j++) {
                currentSum += nums[j];
                maxSum = Math.max(maxSum, currentSum);
            }
        }
        
        // Second pass: collect all subarrays with maximum sum
        for (int i = 0; i < nums.length; i++) {
            int currentSum = 0;
            
            for (int j = i; j < nums.length; j++) {
                currentSum += nums[j];
                
                if (currentSum == maxSum) {
                    int[] subarray = new int[j - i + 1];
                    System.arraycopy(nums, i, subarray, 0, subarray.length);
                    result.add(subarray);
                }
            }
        }
        
        return result;
    }
    
    /**
     * Maximum subarray with at most k negative numbers
     */
    public static int maxSubarrayWithKNegatives(int[] nums, int k) {
        if (nums == null || nums.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        int maxSum = Integer.MIN_VALUE;
        
        for (int i = 0; i < nums.length; i++) {
            int currentSum = 0;
            int negativeCount = 0;
            
            for (int j = i; j < nums.length; j++) {
                currentSum += nums[j];
                
                if (nums[j] < 0) {
                    negativeCount++;
                }
                
                if (negativeCount <= k) {
                    maxSum = Math.max(maxSum, currentSum);
                } else {
                    break; // Too many negative numbers
                }
            }
        }
        
        return maxSum;
    }
}
```

## 🎮 Interactive Demo

```java
import java.util.Scanner;

public class InteractiveMaxSubarray {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Maximum Subarray Interactive Demo ===");
        
        while (true) {
            System.out.println("\nChoose an option:");
            System.out.println("1. Find maximum subarray (with details)");
            System.out.println("2. Compare different approaches");
            System.out.println("3. Maximum subarray of length k");
            System.out.println("4. Visualize all subarrays");
            System.out.println("0. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = getIntInput(scanner);
            
            switch (choice) {
                case 0:
                    System.out.println("Thank you for using the demo!");
                    scanner.close();
                    return;
                    
                case 1:
                    runMaxSubarrayDemo(scanner);
                    break;
                    
                case 2:
                    compareApproaches(scanner);
                    break;
                    
                case 3:
                    maxSubarrayLengthK(scanner);
                    break;
                    
                case 4:
                    visualizeAllSubarrays(scanner);
                    break;
                    
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    
    private static void runMaxSubarrayDemo(Scanner scanner) {
        int[] array = getArrayInput(scanner);
        
        System.out.println("\nFinding maximum subarray...");
        MaxSubarrayBruteForce.MaxSubarrayResult result = 
            MaxSubarrayBruteForce.maxSubarrayWithDetails(array);
        
        result.printResult();
    }
    
    private static void compareApproaches(Scanner scanner) {
        int[] array = getArrayInput(scanner);
        
        System.out.println("\nComparing different approaches:");
        
        // Brute force O(n³)
        long startTime = System.nanoTime();
        int result1 = MaxSubarrayBruteForce.maxSubarrayBruteForce(array);
        long time1 = System.nanoTime() - startTime;
        
        // Optimized O(n²)
        startTime = System.nanoTime();
        int result2 = MaxSubarrayBruteForce.maxSubarrayOptimized(array);
        long time2 = System.nanoTime() - startTime;
        
        System.out.printf("Brute Force O(n³): %d (Time: %d ns)%n", result1, time1);
        System.out.printf("Optimized O(n²): %d (Time: %d ns)%n", result2, time2);
        System.out.printf("Speedup: %.2fx%n", (double) time1 / time2);
    }
    
    private static void maxSubarrayLengthK(Scanner scanner) {
        int[] array = getArrayInput(scanner);
        
        System.out.print("Enter subarray length k: ");
        int k = getIntInput(scanner);
        
        try {
            int result = MaxSubarrayVariations.maxSubarrayOfLengthK(array, k);
            System.out.printf("Maximum sum of subarray of length %d: %d%n", k, result);
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    private static void visualizeAllSubarrays(Scanner scanner) {
        int[] array = getArrayInput(scanner);
        
        if (array.length > 6) {
            System.out.println("Array too large for visualization. Showing first 6 elements only.");
            array = java.util.Arrays.copyOf(array, 6);
        }
        
        System.out.println("\nAll possible subarrays:");
        System.out.println("Array: " + java.util.Arrays.toString(array));
        
        int maxSum = Integer.MIN_VALUE;
        
        for (int i = 0; i < array.length; i++) {
            for (int j = i; j < array.length; j++) {
                int sum = 0;
                StringBuilder subarray = new StringBuilder("[");
                
                for (int k = i; k <= j; k++) {
                    sum += array[k];
                    subarray.append(array[k]);
                    if (k < j) subarray.append(",");
                }
                subarray.append("]");
                
                String marker = (sum > maxSum) ? " *** NEW MAX ***" : "";
                if (sum > maxSum) maxSum = sum;
                
                System.out.printf("Subarray [%d,%d]: %s = %d%s%n", 
                                i, j, subarray.toString(), sum, marker);
            }
        }
        
        System.out.printf("\nMaximum sum found: %d%n", maxSum);
    }
    
    private static int[] getArrayInput(Scanner scanner) {
        System.out.print("Enter array elements separated by spaces: ");
        String input = scanner.nextLine().trim();
        
        String[] parts = input.split("\\s+");
        int[] array = new int[parts.length];
        
        try {
            for (int i = 0; i < parts.length; i++) {
                array[i] = Integer.parseInt(parts[i]);
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid input. Using default array: [-2,1,-3,4,-1,2,1,-5,4]");
            return new int[]{-2, 1, -3, 4, -1, 2, 1, -5, 4};
        }
        
        return array;
    }
    
    private static int getIntInput(Scanner scanner) {
        while (true) {
            try {
                return Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.print("Please enter a valid integer: ");
            }
        }
    }
}
```

## 🧪 Comprehensive Testing

```java
public class MaxSubarrayTester {
    
    public static void main(String[] args) {
        testBasicFunctionality();
        testEdgeCases();
        testPerformance();
        testVariations();
    }
    
    private static void testBasicFunctionality() {
        System.out.println("=== Testing Basic Functionality ===");
        
        int[][] testCases = {
            {-2, 1, -3, 4, -1, 2, 1, -5, 4},  // Expected: 6
            {1},                               // Expected: 1
            {5, 4, -1, 7, 8},                 // Expected: 23
            {-1},                              // Expected: -1
            {-2, -1, -3},                     // Expected: -1
            {1, 2, 3, 4, 5},                  // Expected: 15
            {-5, -2, -8, -1}                  // Expected: -1
        };
        
        int[] expected = {6, 1, 23, -1, -1, 15, -1};
        
        for (int i = 0; i < testCases.length; i++) {
            int result1 = MaxSubarrayBruteForce.maxSubarrayBruteForce(testCases[i]);
            int result2 = MaxSubarrayBruteForce.maxSubarrayOptimized(testCases[i]);
            
            System.out.printf("Test %d: %s%n", i + 1, java.util.Arrays.toString(testCases[i]));
            System.out.printf("Brute Force: %d, Optimized: %d, Expected: %d%n", 
                            result1, result2, expected[i]);
            
            boolean passed = (result1 == expected[i] && result2 == expected[i]);
            System.out.println("Status: " + (passed ? "PASS" : "FAIL"));
            System.out.println();
        }
    }
    
    private static void testEdgeCases() {
        System.out.println("=== Testing Edge Cases ===");
        
        // Null array
        try {
            MaxSubarrayBruteForce.maxSubarrayBruteForce(null);
            System.out.println("FAIL: Should throw exception for null array");
        } catch (IllegalArgumentException e) {
            System.out.println("PASS: Correctly handled null array");
        }
        
        // Empty array
        try {
            MaxSubarrayBruteForce.maxSubarrayBruteForce(new int[0]);
            System.out.println("FAIL: Should throw exception for empty array");
        } catch (IllegalArgumentException e) {
            System.out.println("PASS: Correctly handled empty array");
        }
        
        // Large numbers
        int[] largeNumbers = {Integer.MAX_VALUE, Integer.MIN_VALUE, 1};
        try {
            int result = MaxSubarrayBruteForce.maxSubarrayOptimized(largeNumbers);
            System.out.println("Large numbers test result: " + result);
        } catch (Exception e) {
            System.out.println("Error with large numbers: " + e.getMessage());
        }
    }
    
    private static void testPerformance() {
        System.out.println("\n=== Performance Testing ===");
        
        // Test with different array sizes
        int[] sizes = {10, 50, 100, 500};
        
        for (int size : sizes) {
            int[] array = generateRandomArray(size, -100, 100);
            
            // Test brute force
            long startTime = System.nanoTime();
            int result1 = MaxSubarrayBruteForce.maxSubarrayBruteForce(array);
            long time1 = System.nanoTime() - startTime;
            
            // Test optimized
            startTime = System.nanoTime();
            int result2 = MaxSubarrayBruteForce.maxSubarrayOptimized(array);
            long time2 = System.nanoTime() - startTime;
            
            System.out.printf("Size %d: Brute Force %d ns, Optimized %d ns (%.2fx faster)%n", 
                            size, time1, time2, (double) time1 / time2);
            
            // Verify results match
            if (result1 != result2) {
                System.out.println("ERROR: Results don't match!");
            }
        }
    }
    
    private static void testVariations() {
        System.out.println("\n=== Testing Variations ===");
        
        int[] testArray = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
        
        // Test with indices
        int[] result = MaxSubarrayVariations.maxSubarrayWithIndices(testArray);
        System.out.printf("Max subarray with indices: sum=%d, start=%d, end=%d%n", 
                         result[0], result[1], result[2]);
        
        // Test fixed length
        int k = 3;
        int maxK = MaxSubarrayVariations.maxSubarrayOfLengthK(testArray, k);
        System.out.printf("Max subarray of length %d: %d%n", k, maxK);
        
        // Test all max subarrays
        java.util.List<int[]> allMax = MaxSubarrayVariations.allMaxSubarrays(testArray);
        System.out.println("All subarrays with maximum sum:");
        for (int[] subarray : allMax) {
            System.out.println("  " + java.util.Arrays.toString(subarray));
        }
    }
    
    private static int[] generateRandomArray(int size, int min, int max) {
        int[] array = new int[size];
        java.util.Random random = new java.util.Random();
        
        for (int i = 0; i < size; i++) {
            array[i] = random.nextInt(max - min + 1) + min;
        }
        
        return array;
    }
}
```

## ⚠️ Common Pitfalls

### 1. Integer Overflow
```java
// Problem: Sum might overflow
int sum = Integer.MAX_VALUE + 1; // Overflows to negative

// Solution: Use long for large sums or validate input
long sum = (long) Integer.MAX_VALUE + 1;
```

### 2. Empty Subarray Assumption
```java
// Problem: Some interpretations allow empty subarrays
// This implementation requires at least one element
```

### 3. All Negative Numbers
```java
// Make sure to handle arrays with all negative numbers
// The maximum should be the least negative number
```

## 📊 Complexity Analysis

| Approach | Time Complexity | Space Complexity |
|----------|----------------|------------------|
| Brute Force (3 loops) | O(n³) | O(1) |
| Optimized Brute Force | O(n²) | O(1) |
| Kadane's Algorithm* | O(n) | O(1) |

*Kadane's algorithm is the optimal solution but beyond beginner scope

## 🎯 Key Learning Points

1. **Subarray vs Subsequence**: Subarrays are contiguous, subsequences are not
2. **Brute Force Thinking**: Try all possibilities systematically
3. **Optimization**: Avoid redundant calculations
4. **Edge Cases**: Handle empty arrays, single elements, all negatives
5. **Algorithm Progression**: This leads to Kadane's algorithm (dynamic programming)

## 🔗 Related Concepts

- Dynamic Programming (Kadane's Algorithm)
- Sliding Window Technique
- Divide and Conquer
- Prefix Sums
- Two Pointers

This problem is excellent preparation for understanding dynamic programming concepts and optimization techniques!
