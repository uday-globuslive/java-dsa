# Array Sum Calculator

## 🎯 Problem Statement

Write a Java program that calculates the sum of all elements in an integer array. Additionally, implement variations to find the sum of even numbers, odd numbers, and elements at specific positions.

**Basic Example:**
```
Input: [1, 2, 3, 4, 5]
Output: 15 (1 + 2 + 3 + 4 + 5)
```

## 🎓 Learning Objectives

- Master array traversal techniques
- Practice different loop types (for, enhanced for, while)
- Learn accumulator pattern
- Handle edge cases and input validation
- Understand integer overflow considerations
- Practice method overloading and parameter validation

## 🛠️ Java Implementation

### Basic Array Sum

```java
public class ArraySumCalculator {
    
    /**
     * Calculates the sum of all elements in an array
     * Time Complexity: O(n)
     * Space Complexity: O(1)
     */
    public static int calculateSum(int[] array) {
        // Input validation
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        if (array.length == 0) {
            return 0; // Sum of empty array is 0
        }
        
        int sum = 0;
        for (int i = 0; i < array.length; i++) {
            sum += array[i];
        }
        
        return sum;
    }
    
    /**
     * Alternative implementation using enhanced for loop
     */
    public static int calculateSumEnhanced(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            sum += element;
        }
        
        return sum;
    }
    
    /**
     * Implementation with detailed logging
     */
    public static int calculateSumWithDetails(int[] array) {
        if (array == null) {
            System.out.println("Error: Array is null");
            return 0;
        }
        
        if (array.length == 0) {
            System.out.println("Array is empty, sum = 0");
            return 0;
        }
        
        System.out.println("Calculating sum of array: " + java.util.Arrays.toString(array));
        
        int sum = 0;
        for (int i = 0; i < array.length; i++) {
            sum += array[i];
            System.out.printf("Step %d: sum += %d, current sum = %d%n", 
                            i + 1, array[i], sum);
        }
        
        System.out.println("Final sum: " + sum);
        return sum;
    }
    
    /**
     * Safe implementation that handles integer overflow
     */
    public static long calculateSumSafe(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        long sum = 0L; // Use long to prevent overflow
        for (int element : array) {
            sum += element;
        }
        
        return sum;
    }
}
```

### Specialized Sum Calculations

```java
public class SpecializedSumCalculator {
    
    /**
     * Calculates sum of even numbers only
     */
    public static int sumEvenNumbers(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            if (element % 2 == 0) {
                sum += element;
            }
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of odd numbers only
     */
    public static int sumOddNumbers(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            if (element % 2 != 0) {
                sum += element;
            }
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of elements at even indices (0, 2, 4, ...)
     */
    public static int sumAtEvenIndices(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int i = 0; i < array.length; i += 2) {
            sum += array[i];
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of elements at odd indices (1, 3, 5, ...)
     */
    public static int sumAtOddIndices(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int i = 1; i < array.length; i += 2) {
            sum += array[i];
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of elements in a specific range [start, end]
     */
    public static int sumInRange(int[] array, int start, int end) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        if (start < 0 || end >= array.length || start > end) {
            throw new IllegalArgumentException("Invalid range: [" + start + ", " + end + "]");
        }
        
        int sum = 0;
        for (int i = start; i <= end; i++) {
            sum += array[i];
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of positive numbers only
     */
    public static int sumPositiveNumbers(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            if (element > 0) {
                sum += element;
            }
        }
        
        return sum;
    }
    
    /**
     * Calculates sum of negative numbers only
     */
    public static int sumNegativeNumbers(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            if (element < 0) {
                sum += element;
            }
        }
        
        return sum;
    }
}
```

### Advanced Sum Calculations

```java
public class AdvancedSumCalculator {
    
    /**
     * Calculates sum with condition based on predicate
     */
    public static int sumWithCondition(int[] array, java.util.function.Predicate<Integer> condition) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        if (condition == null) {
            throw new IllegalArgumentException("Condition cannot be null");
        }
        
        int sum = 0;
        for (int element : array) {
            if (condition.test(element)) {
                sum += element;
            }
        }
        
        return sum;
    }
    
    /**
     * Calculates cumulative sum (prefix sum) array
     */
    public static int[] calculateCumulativeSum(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        if (array.length == 0) {
            return new int[0];
        }
        
        int[] cumulativeSum = new int[array.length];
        cumulativeSum[0] = array[0];
        
        for (int i = 1; i < array.length; i++) {
            cumulativeSum[i] = cumulativeSum[i - 1] + array[i];
        }
        
        return cumulativeSum;
    }
    
    /**
     * Calculates sum of squares of elements
     */
    public static long sumOfSquares(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        long sum = 0L;
        for (int element : array) {
            sum += (long) element * element; // Cast to prevent overflow
        }
        
        return sum;
    }
    
    /**
     * Calculates alternating sum (+ - + - ...)
     */
    public static int alternatingSum(int[] array) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        
        if (array.length == 0) {
            return 0;
        }
        
        int sum = 0;
        for (int i = 0; i < array.length; i++) {
            if (i % 2 == 0) {
                sum += array[i];  // Add for even indices
            } else {
                sum -= array[i];  // Subtract for odd indices
            }
        }
        
        return sum;
    }
    
    /**
     * Finds maximum sum of contiguous subarray (Kadane's algorithm simplified)
     */
    public static int maxSubarraySum(int[] array) {
        if (array == null || array.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        int maxSum = array[0];
        int currentSum = array[0];
        
        for (int i = 1; i < array.length; i++) {
            currentSum = Math.max(array[i], currentSum + array[i]);
            maxSum = Math.max(maxSum, currentSum);
        }
        
        return maxSum;
    }
}
```

## 🧪 Comprehensive Testing

```java
public class ArraySumTester {
    
    public static void main(String[] args) {
        // Test cases
        int[][] testArrays = {
            {},                           // Empty array
            {1},                         // Single element
            {1, 2, 3, 4, 5},            // Basic positive numbers
            {-1, -2, -3, -4, -5},       // Negative numbers
            {-2, -1, 0, 1, 2},          // Mixed numbers
            {10, 20, 30},               // Larger numbers
            {Integer.MAX_VALUE, 1},      // Overflow test
            {1, 2, 3, 4, 5, 6, 7, 8, 9, 10} // Longer array
        };
        
        for (int i = 0; i < testArrays.length; i++) {
            System.out.println("\n=== Test Case " + (i + 1) + " ===");
            int[] array = testArrays[i];
            System.out.println("Array: " + java.util.Arrays.toString(array));
            
            try {
                // Test basic sum
                int totalSum = ArraySumCalculator.calculateSum(array);
                System.out.println("Total Sum: " + totalSum);
                
                // Test safe sum (for overflow)
                long safeSum = ArraySumCalculator.calculateSumSafe(array);
                System.out.println("Safe Sum (long): " + safeSum);
                
                if (array.length > 0) {
                    // Test specialized sums
                    int evenSum = SpecializedSumCalculator.sumEvenNumbers(array);
                    int oddSum = SpecializedSumCalculator.sumOddNumbers(array);
                    int positiveSum = SpecializedSumCalculator.sumPositiveNumbers(array);
                    int negativeSum = SpecializedSumCalculator.sumNegativeNumbers(array);
                    
                    System.out.println("Even Numbers Sum: " + evenSum);
                    System.out.println("Odd Numbers Sum: " + oddSum);
                    System.out.println("Positive Numbers Sum: " + positiveSum);
                    System.out.println("Negative Numbers Sum: " + negativeSum);
                    
                    // Test cumulative sum
                    int[] cumulativeSum = AdvancedSumCalculator.calculateCumulativeSum(array);
                    System.out.println("Cumulative Sum: " + java.util.Arrays.toString(cumulativeSum));
                    
                    // Test sum of squares
                    long sumOfSquares = AdvancedSumCalculator.sumOfSquares(array);
                    System.out.println("Sum of Squares: " + sumOfSquares);
                    
                    // Test alternating sum
                    int alternatingSum = AdvancedSumCalculator.alternatingSum(array);
                    System.out.println("Alternating Sum: " + alternatingSum);
                }
                
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
        
        // Test null array
        System.out.println("\n=== Null Array Test ===");
        try {
            ArraySumCalculator.calculateSum(null);
        } catch (IllegalArgumentException e) {
            System.out.println("Correctly caught exception for null array: " + e.getMessage());
        }
        
        // Test range sum
        System.out.println("\n=== Range Sum Test ===");
        int[] rangeArray = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        try {
            int rangeSum = SpecializedSumCalculator.sumInRange(rangeArray, 2, 5);
            System.out.println("Sum from index 2 to 5: " + rangeSum); // 3+4+5+6 = 18
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
```

## 🎮 Interactive Program

```java
import java.util.Scanner;

public class InteractiveArraySum {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Array Sum Calculator ===");
        
        // Get array size
        System.out.print("Enter the size of the array: ");
        int size = scanner.nextInt();
        
        if (size <= 0) {
            System.out.println("Array size must be positive!");
            return;
        }
        
        // Get array elements
        int[] array = new int[size];
        System.out.println("Enter " + size + " integers:");
        for (int i = 0; i < size; i++) {
            System.out.print("Element " + (i + 1) + ": ");
            array[i] = scanner.nextInt();
        }
        
        // Display menu
        while (true) {
            System.out.println("\n=== Choose an operation ===");
            System.out.println("1. Total Sum");
            System.out.println("2. Sum of Even Numbers");
            System.out.println("3. Sum of Odd Numbers");
            System.out.println("4. Sum of Positive Numbers");
            System.out.println("5. Sum of Negative Numbers");
            System.out.println("6. Sum at Even Indices");
            System.out.println("7. Sum at Odd Indices");
            System.out.println("8. Sum in Range");
            System.out.println("9. Cumulative Sum");
            System.out.println("10. Alternating Sum");
            System.out.println("0. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = scanner.nextInt();
            
            switch (choice) {
                case 0:
                    System.out.println("Goodbye!");
                    scanner.close();
                    return;
                    
                case 1:
                    int totalSum = ArraySumCalculator.calculateSum(array);
                    System.out.println("Total Sum: " + totalSum);
                    break;
                    
                case 2:
                    int evenSum = SpecializedSumCalculator.sumEvenNumbers(array);
                    System.out.println("Sum of Even Numbers: " + evenSum);
                    break;
                    
                case 3:
                    int oddSum = SpecializedSumCalculator.sumOddNumbers(array);
                    System.out.println("Sum of Odd Numbers: " + oddSum);
                    break;
                    
                case 4:
                    int positiveSum = SpecializedSumCalculator.sumPositiveNumbers(array);
                    System.out.println("Sum of Positive Numbers: " + positiveSum);
                    break;
                    
                case 5:
                    int negativeSum = SpecializedSumCalculator.sumNegativeNumbers(array);
                    System.out.println("Sum of Negative Numbers: " + negativeSum);
                    break;
                    
                case 6:
                    int evenIndexSum = SpecializedSumCalculator.sumAtEvenIndices(array);
                    System.out.println("Sum at Even Indices: " + evenIndexSum);
                    break;
                    
                case 7:
                    int oddIndexSum = SpecializedSumCalculator.sumAtOddIndices(array);
                    System.out.println("Sum at Odd Indices: " + oddIndexSum);
                    break;
                    
                case 8:
                    System.out.print("Enter start index: ");
                    int start = scanner.nextInt();
                    System.out.print("Enter end index: ");
                    int end = scanner.nextInt();
                    try {
                        int rangeSum = SpecializedSumCalculator.sumInRange(array, start, end);
                        System.out.println("Sum from index " + start + " to " + end + ": " + rangeSum);
                    } catch (IllegalArgumentException e) {
                        System.out.println("Error: " + e.getMessage());
                    }
                    break;
                    
                case 9:
                    int[] cumulativeSum = AdvancedSumCalculator.calculateCumulativeSum(array);
                    System.out.println("Cumulative Sum: " + java.util.Arrays.toString(cumulativeSum));
                    break;
                    
                case 10:
                    int alternatingSum = AdvancedSumCalculator.alternatingSum(array);
                    System.out.println("Alternating Sum: " + alternatingSum);
                    break;
                    
                default:
                    System.out.println("Invalid choice! Please try again.");
            }
        }
    }
}
```

## ⚠️ Common Pitfalls and Solutions

### 1. Integer Overflow
```java
// Problem: Large numbers can cause overflow
int[] largeNumbers = {Integer.MAX_VALUE, 1};
int sum = 0;
for (int num : largeNumbers) {
    sum += num; // Overflow! Result becomes negative
}

// Solution: Use long for accumulation
long safeSum = 0L;
for (int num : largeNumbers) {
    safeSum += num; // Safe from overflow
}
```

### 2. Null Pointer Exception
```java
// Problem: Not checking for null
public static int calculateSum(int[] array) {
    int sum = 0;
    for (int element : array) { // NPE if array is null
        sum += element;
    }
    return sum;
}

// Solution: Input validation
public static int calculateSum(int[] array) {
    if (array == null) {
        throw new IllegalArgumentException("Array cannot be null");
    }
    // ... rest of the method
}
```

### 3. Empty Array Handling
```java
// Consider what should happen with empty arrays
public static int calculateSum(int[] array) {
    if (array.length == 0) {
        return 0; // or throw exception, depending on requirements
    }
    // ... rest of the method
}
```

## 📊 Complexity Analysis

- **Time Complexity**: O(n) - We visit each element exactly once
- **Space Complexity**: O(1) - We use only a constant amount of extra space
- **Input Size**: n (length of the array)

## 🎯 Practice Variations

1. **Sum of elements divisible by 3**
2. **Sum of elements greater than average**
3. **Sum excluding maximum and minimum elements**
4. **Weighted sum with custom weights**
5. **Sum with early termination on condition**

## 🔗 Related Concepts

- Array traversal patterns
- Accumulator variables
- Input validation
- Exception handling
- Integer overflow considerations
- Method overloading
- Predicate functions

This fundamental problem builds the foundation for more complex array operations and algorithms!
