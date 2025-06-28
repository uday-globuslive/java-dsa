# Module 19: Divide and Conquer

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master the divide and conquer algorithmic paradigm
- ✅ Implement classic divide and conquer algorithms efficiently
- ✅ Apply divide and conquer to solve complex optimization problems
- ✅ Analyze time complexity using the Master Theorem
- ✅ Recognize when divide and conquer provides optimal solutions

## 🎯 Module Overview
Divide and conquer is a fundamental algorithmic paradigm that solves problems by:
1. **Dividing** the problem into smaller subproblems
2. **Conquering** the subproblems recursively
3. **Combining** the solutions to solve the original problem

Essential for:
- **Sorting algorithms** - Merge sort, quick sort
- **Searching** - Binary search variants
- **Mathematical computations** - Fast exponentiation, matrix multiplication
- **Optimization problems** - Maximum subarray, closest pair

**Time Investment:** 6-8 hours
**Difficulty Level:** Intermediate to Advanced
**Prerequisites:** Recursion, Arrays, Basic Math

## 📖 Core Concepts

### 1. Divide and Conquer Framework

#### Basic Template
```java
public ReturnType divideAndConquer(Input input) {
    // Base case - problem small enough to solve directly
    if (isBaseCase(input)) {
        return solveDirectly(input);
    }
    
    // Divide - split problem into subproblems
    List<SubInput> subproblems = divide(input);
    
    // Conquer - solve subproblems recursively
    List<SubResult> subresults = new ArrayList<>();
    for (SubInput subproblem : subproblems) {
        subresults.add(divideAndConquer(subproblem));
    }
    
    // Combine - merge subproblem solutions
    return combine(subresults);
}
```

### 2. Classic Sorting Algorithms

#### Merge Sort
```java
public class MergeSort {
    public void mergeSort(int[] arr) {
        if (arr.length <= 1) return;
        mergeSort(arr, 0, arr.length - 1);
    }
    
    private void mergeSort(int[] arr, int left, int right) {
        if (left >= right) return; // Base case
        
        // Divide
        int mid = left + (right - left) / 2;
        
        // Conquer
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);
        
        // Combine
        merge(arr, left, mid, right);
    }
    
    private void merge(int[] arr, int left, int mid, int right) {
        // Create temporary arrays
        int[] leftArr = new int[mid - left + 1];
        int[] rightArr = new int[right - mid];
        
        // Copy data to temporary arrays
        for (int i = 0; i < leftArr.length; i++) {
            leftArr[i] = arr[left + i];
        }
        for (int i = 0; i < rightArr.length; i++) {
            rightArr[i] = arr[mid + 1 + i];
        }
        
        // Merge the arrays back
        int i = 0, j = 0, k = left;
        
        while (i < leftArr.length && j < rightArr.length) {
            if (leftArr[i] <= rightArr[j]) {
                arr[k++] = leftArr[i++];
            } else {
                arr[k++] = rightArr[j++];
            }
        }
        
        // Copy remaining elements
        while (i < leftArr.length) arr[k++] = leftArr[i++];
        while (j < rightArr.length) arr[k++] = rightArr[j++];
    }
}
```

#### Quick Sort
```java
public class QuickSort {
    public void quickSort(int[] arr) {
        if (arr.length <= 1) return;
        quickSort(arr, 0, arr.length - 1);
    }
    
    private void quickSort(int[] arr, int low, int high) {
        if (low < high) {
            // Divide - partition around pivot
            int pivotIndex = partition(arr, low, high);
            
            // Conquer - recursively sort partitions
            quickSort(arr, low, pivotIndex - 1);
            quickSort(arr, pivotIndex + 1, high);
        }
    }
    
    private int partition(int[] arr, int low, int high) {
        int pivot = arr[high]; // Choose last element as pivot
        int i = low - 1; // Index of smaller element
        
        for (int j = low; j < high; j++) {
            if (arr[j] <= pivot) {
                i++;
                swap(arr, i, j);
            }
        }
        
        swap(arr, i + 1, high);
        return i + 1;
    }
    
    private void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    
    // Randomized quicksort for better average case
    private int randomizedPartition(int[] arr, int low, int high) {
        Random rand = new Random();
        int randomIndex = low + rand.nextInt(high - low + 1);
        swap(arr, randomIndex, high);
        return partition(arr, low, high);
    }
}
```

### 3. Searching Algorithms

#### Binary Search Variants
```java
public class BinarySearchVariants {
    // Standard binary search
    public int binarySearch(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return -1; // Not found
    }
    
    // Find first occurrence
    public int findFirst(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        int result = -1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] == target) {
                result = mid;
                right = mid - 1; // Continue searching left
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return result;
    }
    
    // Find last occurrence
    public int findLast(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        int result = -1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] == target) {
                result = mid;
                left = mid + 1; // Continue searching right
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return result;
    }
    
    // Search in rotated sorted array
    public int searchRotated(int[] nums, int target) {
        int left = 0, right = nums.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (nums[mid] == target) return mid;
            
            // Left half is sorted
            if (nums[left] <= nums[mid]) {
                if (target >= nums[left] && target < nums[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            // Right half is sorted
            else {
                if (target > nums[mid] && target <= nums[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        
        return -1;
    }
}
```

### 4. Mathematical Applications

#### Fast Exponentiation
```java
public class FastExponentiation {
    // Calculate x^n efficiently
    public double power(double x, int n) {
        if (n == 0) return 1.0;
        
        if (n < 0) {
            return 1.0 / power(x, -n);
        }
        
        // Divide and conquer
        if (n % 2 == 0) {
            double half = power(x, n / 2);
            return half * half;
        } else {
            return x * power(x, n - 1);
        }
    }
    
    // Iterative version
    public double powerIterative(double x, int n) {
        if (n == 0) return 1.0;
        
        long absN = Math.abs((long)n);
        double result = 1.0;
        double currentPower = x;
        
        while (absN > 0) {
            if (absN % 2 == 1) {
                result *= currentPower;
            }
            currentPower *= currentPower;
            absN /= 2;
        }
        
        return n < 0 ? 1.0 / result : result;
    }
    
    // Matrix exponentiation
    public long fibonacci(int n) {
        if (n <= 1) return n;
        
        long[][] matrix = {{1, 1}, {1, 0}};
        long[][] result = matrixPower(matrix, n - 1);
        
        return result[0][0];
    }
    
    private long[][] matrixPower(long[][] matrix, int n) {
        if (n == 1) return matrix;
        
        if (n % 2 == 0) {
            long[][] half = matrixPower(matrix, n / 2);
            return matrixMultiply(half, half);
        } else {
            return matrixMultiply(matrix, matrixPower(matrix, n - 1));
        }
    }
    
    private long[][] matrixMultiply(long[][] a, long[][] b) {
        long[][] result = new long[2][2];
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                for (int k = 0; k < 2; k++) {
                    result[i][j] += a[i][k] * b[k][j];
                }
            }
        }
        return result;
    }
}
```

### 5. Advanced Divide and Conquer

#### Maximum Subarray (Kadane's Algorithm using D&C)
```java
public class MaximumSubarray {
    public int maxSubarray(int[] nums) {
        return maxSubarrayHelper(nums, 0, nums.length - 1);
    }
    
    private int maxSubarrayHelper(int[] nums, int left, int right) {
        if (left == right) {
            return nums[left]; // Base case
        }
        
        int mid = left + (right - left) / 2;
        
        // Conquer
        int leftMax = maxSubarrayHelper(nums, left, mid);
        int rightMax = maxSubarrayHelper(nums, mid + 1, right);
        
        // Combine - find max crossing subarray
        int crossMax = maxCrossingSubarray(nums, left, mid, right);
        
        return Math.max(Math.max(leftMax, rightMax), crossMax);
    }
    
    private int maxCrossingSubarray(int[] nums, int left, int mid, int right) {
        // Find max sum in left half
        int leftSum = Integer.MIN_VALUE;
        int sum = 0;
        for (int i = mid; i >= left; i--) {
            sum += nums[i];
            leftSum = Math.max(leftSum, sum);
        }
        
        // Find max sum in right half
        int rightSum = Integer.MIN_VALUE;
        sum = 0;
        for (int i = mid + 1; i <= right; i++) {
            sum += nums[i];
            rightSum = Math.max(rightSum, sum);
        }
        
        return leftSum + rightSum;
    }
}
```

#### Closest Pair of Points
```java
public class ClosestPair {
    static class Point {
        double x, y;
        Point(double x, double y) {
            this.x = x;
            this.y = y;
        }
    }
    
    public double closestPair(Point[] points) {
        Point[] px = points.clone();
        Point[] py = points.clone();
        
        Arrays.sort(px, (a, b) -> Double.compare(a.x, b.x));
        Arrays.sort(py, (a, b) -> Double.compare(a.y, b.y));
        
        return closestPairRec(px, py);
    }
    
    private double closestPairRec(Point[] px, Point[] py) {
        int n = px.length;
        
        // Base case - brute force for small arrays
        if (n <= 3) {
            return bruteForce(px);
        }
        
        // Divide
        int mid = n / 2;
        Point midPoint = px[mid];
        
        Point[] pyl = new Point[mid];
        Point[] pyr = new Point[n - mid];
        
        int li = 0, ri = 0;
        for (Point point : py) {
            if (point.x <= midPoint.x && li < mid) {
                pyl[li++] = point;
            } else {
                pyr[ri++] = point;
            }
        }
        
        // Conquer
        double dl = closestPairRec(Arrays.copyOfRange(px, 0, mid), pyl);
        double dr = closestPairRec(Arrays.copyOfRange(px, mid, n), pyr);
        
        double d = Math.min(dl, dr);
        
        // Combine - check points near the dividing line
        List<Point> strip = new ArrayList<>();
        for (Point point : py) {
            if (Math.abs(point.x - midPoint.x) < d) {
                strip.add(point);
            }
        }
        
        return Math.min(d, stripClosest(strip, d));
    }
    
    private double bruteForce(Point[] points) {
        double min = Double.MAX_VALUE;
        for (int i = 0; i < points.length; i++) {
            for (int j = i + 1; j < points.length; j++) {
                min = Math.min(min, distance(points[i], points[j]));
            }
        }
        return min;
    }
    
    private double stripClosest(List<Point> strip, double d) {
        double min = d;
        
        for (int i = 0; i < strip.size(); i++) {
            for (int j = i + 1; j < strip.size() && 
                 (strip.get(j).y - strip.get(i).y) < min; j++) {
                min = Math.min(min, distance(strip.get(i), strip.get(j)));
            }
        }
        
        return min;
    }
    
    private double distance(Point p1, Point p2) {
        return Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + 
                        (p1.y - p2.y) * (p1.y - p2.y));
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Array Division
- **Use Case:** Problems that can split arrays into halves
- **Key Insight:** Process halves independently, then combine
- **Example Problems:** Merge Sort, Maximum Subarray, Inversion Count

### Pattern 2: Binary Search Variants
- **Use Case:** Search problems in sorted or partially sorted data
- **Key Insight:** Eliminate half of search space each iteration
- **Example Problems:** Search in Rotated Array, Find Peak Element

### Pattern 3: Mathematical Computations
- **Use Case:** Calculations that can use exponentiation or recursion
- **Key Insight:** Reduce problem size by half each step
- **Example Problems:** Power Function, Fibonacci, Matrix Multiplication

### Pattern 4: Geometric Problems
- **Use Case:** 2D/3D problems with spatial division
- **Key Insight:** Divide space and process separately
- **Example Problems:** Closest Pair, Convex Hull

## 💻 Practice Problems

### Easy Level
1. **Pow(x, n) (LeetCode 50)**
   - Implement fast exponentiation
   - Handle negative exponents and edge cases

2. **Merge Two Sorted Lists (LeetCode 21)**
   - Foundation for merge sort combine step
   - Simple divide and conquer application

### Medium Level
3. **Search in Rotated Sorted Array (LeetCode 33)**
   - Binary search with rotation handling
   - Identify which half is sorted

4. **Maximum Subarray (LeetCode 53)**
   - Can solve with Kadane's or divide and conquer
   - Good for understanding combine step

5. **Merge k Sorted Lists (LeetCode 23)**
   - Extend merge sort to multiple lists
   - Divide pairs and merge recursively

6. **Find Peak Element (LeetCode 162)**
   - Binary search on non-sorted array
   - Use gradient to guide search

### Hard Level
7. **Count of Smaller Numbers After Self (LeetCode 315)**
   - Merge sort with inversion counting
   - Complex combine step with additional logic

8. **Median of Two Sorted Arrays (LeetCode 4)**
   - Binary search on two arrays
   - Advanced partitioning logic

## 🧠 Problem-Solving Templates

### Template 1: Array Divide and Conquer
```java
public ResultType arrayDivideConquer(int[] arr, int left, int right) {
    // Base case
    if (left >= right) {
        return handleBaseCase(arr, left, right);
    }
    
    // Divide
    int mid = left + (right - left) / 2;
    
    // Conquer
    ResultType leftResult = arrayDivideConquer(arr, left, mid);
    ResultType rightResult = arrayDivideConquer(arr, mid + 1, right);
    
    // Combine
    return combineResults(leftResult, rightResult, arr, left, mid, right);
}
```

### Template 2: Binary Search Template
```java
public int binarySearchTemplate(int[] arr, int target) {
    int left = 0, right = arr.length - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (isTarget(arr[mid], target)) {
            return mid;
        } else if (shouldSearchLeft(arr[mid], target)) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    
    return -1; // Not found
}
```

### Template 3: Mathematical Divide and Conquer
```java
public double mathematicalDC(double base, int exponent) {
    // Base case
    if (exponent == 0) return 1.0;
    if (exponent == 1) return base;
    
    // Handle negative exponents
    if (exponent < 0) {
        return 1.0 / mathematicalDC(base, -exponent);
    }
    
    // Divide and conquer
    if (exponent % 2 == 0) {
        double half = mathematicalDC(base, exponent / 2);
        return half * half;
    } else {
        return base * mathematicalDC(base, exponent - 1);
    }
}
```

## ⚡ Optimization Techniques

### 1. Master Theorem Analysis
For recurrences of form T(n) = aT(n/b) + f(n):
- **Case 1:** f(n) = O(n^(log_b(a) - ε)) → T(n) = Θ(n^log_b(a))
- **Case 2:** f(n) = Θ(n^log_b(a)) → T(n) = Θ(n^log_b(a) * log n)
- **Case 3:** f(n) = Ω(n^(log_b(a) + ε)) → T(n) = Θ(f(n))

### 2. Choosing Optimal Pivot
```java
// Median-of-three pivot selection
private int medianOfThree(int[] arr, int low, int high) {
    int mid = low + (high - low) / 2;
    
    if (arr[low] > arr[mid]) swap(arr, low, mid);
    if (arr[mid] > arr[high]) swap(arr, mid, high);
    if (arr[low] > arr[mid]) swap(arr, low, mid);
    
    return mid;
}
```

### 3. Iterative Conversion
```java
// Convert recursive merge sort to iterative
public void mergeSortIterative(int[] arr) {
    int n = arr.length;
    
    for (int size = 1; size < n; size *= 2) {
        for (int left = 0; left < n - size; left += 2 * size) {
            int mid = left + size - 1;
            int right = Math.min(left + 2 * size - 1, n - 1);
            merge(arr, left, mid, right);
        }
    }
}
```

## 📈 Complexity Analysis

### Time Complexity Examples
- **Merge Sort:** T(n) = 2T(n/2) + O(n) = O(n log n)
- **Quick Sort:** Average O(n log n), Worst O(n²)
- **Binary Search:** T(n) = T(n/2) + O(1) = O(log n)
- **Fast Exponentiation:** T(n) = T(n/2) + O(1) = O(log n)

### Space Complexity
- **In-place algorithms:** O(log n) for recursion stack
- **External space:** O(n) for auxiliary arrays (merge sort)
- **Tail recursion:** Can be optimized to O(1)

### Practical Considerations
- **Cache efficiency:** Merge sort has better cache performance
- **Stability:** Merge sort is stable, quick sort is not
- **Worst-case guarantees:** Merge sort vs quick sort

## 🎯 Key Takeaways

1. **When to Use Divide and Conquer:**
   - Problem can be broken into similar subproblems
   - Subproblems are independent
   - Combining solutions is efficient

2. **Design Principles:**
   - Identify base cases clearly
   - Ensure subproblems are smaller
   - Combine step should be efficient

3. **Common Pitfalls:**
   - Not handling base cases properly
   - Inefficient combine step
   - Overlapping subproblems (use DP instead)
   - Stack overflow from deep recursion

4. **Best Practices:**
   - Use Master Theorem for complexity analysis
   - Consider iterative alternatives for deep recursion
   - Optimize pivot selection in quicksort
   - Handle edge cases in binary search

## 🚀 Next Steps
- Master the complexity analysis using Master Theorem
- Practice implementing algorithms from scratch
- Study advanced applications like FFT and convex hull
- Move to **Module 20: Graph Algorithms** for graph-based divide and conquer

---
*Divide and conquer is a powerful paradigm that provides optimal solutions to many fundamental problems. Master these techniques to solve complex problems by breaking them into manageable pieces.*
