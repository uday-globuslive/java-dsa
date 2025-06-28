# Module 14: Sorting and Searching Algorithms

## Learning Objectives
By the end of this module, you will:
- Master all major sorting algorithms with their trade-offs
- Understand searching techniques for different data structures
- Implement custom comparators and stable sorting
- Optimize sorting/searching for specific use cases
- Solve advanced problems using sorting/searching patterns

## Module Content

### 14.1 Basic Sorting Algorithms

#### Bubble Sort
```java
public class BubbleSort {
    
    public static void bubbleSort(int[] arr) {
        int n = arr.length;
        boolean swapped;
        
        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    swap(arr, j, j + 1);
                    swapped = true;
                }
            }
            
            // If no swapping occurred, array is sorted
            if (!swapped) break;
        }
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    
    public static void main(String[] args) {
        int[] arr = {64, 34, 25, 12, 22, 11, 90};
        System.out.println("Original: " + Arrays.toString(arr));
        bubbleSort(arr);
        System.out.println("Sorted: " + Arrays.toString(arr));
    }
}
```

#### Selection Sort
```java
public class SelectionSort {
    
    public static void selectionSort(int[] arr) {
        int n = arr.length;
        
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            
            // Find minimum element in remaining unsorted array
            for (int j = i + 1; j < n; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }
            
            // Swap minimum element with first element
            if (minIndex != i) {
                swap(arr, i, minIndex);
            }
        }
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```

#### Insertion Sort
```java
public class InsertionSort {
    
    public static void insertionSort(int[] arr) {
        int n = arr.length;
        
        for (int i = 1; i < n; i++) {
            int key = arr[i];
            int j = i - 1;
            
            // Move elements greater than key one position ahead
            while (j >= 0 && arr[j] > key) {
                arr[j + 1] = arr[j];
                j--;
            }
            
            arr[j + 1] = key;
        }
    }
    
    // Binary insertion sort (optimization)
    public static void binaryInsertionSort(int[] arr) {
        int n = arr.length;
        
        for (int i = 1; i < n; i++) {
            int key = arr[i];
            int insertPos = binarySearch(arr, 0, i - 1, key);
            
            // Shift elements to make space
            for (int j = i - 1; j >= insertPos; j--) {
                arr[j + 1] = arr[j];
            }
            
            arr[insertPos] = key;
        }
    }
    
    private static int binarySearch(int[] arr, int left, int right, int key) {
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] <= key) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return left;
    }
}
```

### 14.2 Efficient Sorting Algorithms

#### Merge Sort
```java
public class MergeSort {
    
    public static void mergeSort(int[] arr) {
        if (arr.length <= 1) return;
        
        int[] temp = new int[arr.length];
        mergeSortHelper(arr, temp, 0, arr.length - 1);
    }
    
    private static void mergeSortHelper(int[] arr, int[] temp, int left, int right) {
        if (left >= right) return;
        
        int mid = left + (right - left) / 2;
        
        mergeSortHelper(arr, temp, left, mid);
        mergeSortHelper(arr, temp, mid + 1, right);
        merge(arr, temp, left, mid, right);
    }
    
    private static void merge(int[] arr, int[] temp, int left, int mid, int right) {
        // Copy elements to temp array
        for (int i = left; i <= right; i++) {
            temp[i] = arr[i];
        }
        
        int i = left, j = mid + 1, k = left;
        
        // Merge back to original array
        while (i <= mid && j <= right) {
            if (temp[i] <= temp[j]) {
                arr[k++] = temp[i++];
            } else {
                arr[k++] = temp[j++];
            }
        }
        
        // Copy remaining elements
        while (i <= mid) {
            arr[k++] = temp[i++];
        }
        while (j <= right) {
            arr[k++] = temp[j++];
        }
    }
    
    // Bottom-up merge sort (iterative)
    public static void mergeSortBottomUp(int[] arr) {
        int n = arr.length;
        int[] temp = new int[n];
        
        for (int size = 1; size < n; size *= 2) {
            for (int left = 0; left < n - size; left += 2 * size) {
                int mid = left + size - 1;
                int right = Math.min(left + 2 * size - 1, n - 1);
                merge(arr, temp, left, mid, right);
            }
        }
    }
}
```

#### Quick Sort
```java
import java.util.Random;

public class QuickSort {
    
    // Basic quicksort
    public static void quickSort(int[] arr) {
        quickSortHelper(arr, 0, arr.length - 1);
    }
    
    private static void quickSortHelper(int[] arr, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(arr, low, high);
            
            quickSortHelper(arr, low, pivotIndex - 1);
            quickSortHelper(arr, pivotIndex + 1, high);
        }
    }
    
    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[high]; // Last element as pivot
        int i = low - 1;
        
        for (int j = low; j < high; j++) {
            if (arr[j] <= pivot) {
                i++;
                swap(arr, i, j);
            }
        }
        
        swap(arr, i + 1, high);
        return i + 1;
    }
    
    // Randomized quicksort
    public static void quickSortRandomized(int[] arr) {
        quickSortRandomizedHelper(arr, 0, arr.length - 1);
    }
    
    private static void quickSortRandomizedHelper(int[] arr, int low, int high) {
        if (low < high) {
            // Random pivot selection
            Random rand = new Random();
            int randomIndex = low + rand.nextInt(high - low + 1);
            swap(arr, randomIndex, high);
            
            int pivotIndex = partition(arr, low, high);
            
            quickSortRandomizedHelper(arr, low, pivotIndex - 1);
            quickSortRandomizedHelper(arr, pivotIndex + 1, high);
        }
    }
    
    // 3-way quicksort (handles duplicates efficiently)
    public static void quickSort3Way(int[] arr) {
        quickSort3WayHelper(arr, 0, arr.length - 1);
    }
    
    private static void quickSort3WayHelper(int[] arr, int low, int high) {
        if (high <= low) return;
        
        int lt = low, gt = high;
        int pivot = arr[low];
        int i = low + 1;
        
        while (i <= gt) {
            if (arr[i] < pivot) {
                swap(arr, lt++, i++);
            } else if (arr[i] > pivot) {
                swap(arr, i, gt--);
            } else {
                i++;
            }
        }
        
        quickSort3WayHelper(arr, low, lt - 1);
        quickSort3WayHelper(arr, gt + 1, high);
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```

#### Heap Sort
```java
public class HeapSort {
    
    public static void heapSort(int[] arr) {
        int n = arr.length;
        
        // Build max heap
        for (int i = n / 2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }
        
        // Extract elements one by one
        for (int i = n - 1; i > 0; i--) {
            swap(arr, 0, i); // Move current root to end
            heapify(arr, i, 0); // Heapify reduced heap
        }
    }
    
    private static void heapify(int[] arr, int n, int i) {
        int largest = i;
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        
        if (left < n && arr[left] > arr[largest]) {
            largest = left;
        }
        
        if (right < n && arr[right] > arr[largest]) {
            largest = right;
        }
        
        if (largest != i) {
            swap(arr, i, largest);
            heapify(arr, n, largest);
        }
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```

### 14.3 Linear Time Sorting

#### Counting Sort
```java
public class CountingSort {
    
    public static void countingSort(int[] arr) {
        if (arr.length == 0) return;
        
        // Find range
        int max = Arrays.stream(arr).max().getAsInt();
        int min = Arrays.stream(arr).min().getAsInt();
        int range = max - min + 1;
        
        int[] count = new int[range];
        int[] output = new int[arr.length];
        
        // Count occurrences
        for (int num : arr) {
            count[num - min]++;
        }
        
        // Cumulative count
        for (int i = 1; i < range; i++) {
            count[i] += count[i - 1];
        }
        
        // Build output array
        for (int i = arr.length - 1; i >= 0; i--) {
            output[count[arr[i] - min] - 1] = arr[i];
            count[arr[i] - min]--;
        }
        
        // Copy back to original array
        System.arraycopy(output, 0, arr, 0, arr.length);
    }
    
    // Counting sort for strings (by character position)
    public static void countingSortStrings(String[] arr, int position) {
        int[] count = new int[256]; // ASCII characters
        String[] output = new String[arr.length];
        
        // Count occurrences
        for (String str : arr) {
            char ch = (position < str.length()) ? str.charAt(position) : 0;
            count[ch]++;
        }
        
        // Cumulative count
        for (int i = 1; i < 256; i++) {
            count[i] += count[i - 1];
        }
        
        // Build output array
        for (int i = arr.length - 1; i >= 0; i--) {
            char ch = (position < arr[i].length()) ? arr[i].charAt(position) : 0;
            output[count[ch] - 1] = arr[i];
            count[ch]--;
        }
        
        // Copy back
        System.arraycopy(output, 0, arr, 0, arr.length);
    }
}
```

#### Radix Sort
```java
public class RadixSort {
    
    public static void radixSort(int[] arr) {
        if (arr.length == 0) return;
        
        // Find maximum number to know number of digits
        int max = Arrays.stream(arr).max().getAsInt();
        
        // Do counting sort for every digit
        for (int exp = 1; max / exp > 0; exp *= 10) {
            countingSortByDigit(arr, exp);
        }
    }
    
    private static void countingSortByDigit(int[] arr, int exp) {
        int[] count = new int[10]; // 10 digits (0-9)
        int[] output = new int[arr.length];
        
        // Count occurrences of each digit
        for (int num : arr) {
            count[(num / exp) % 10]++;
        }
        
        // Cumulative count
        for (int i = 1; i < 10; i++) {
            count[i] += count[i - 1];
        }
        
        // Build output array
        for (int i = arr.length - 1; i >= 0; i--) {
            int digit = (arr[i] / exp) % 10;
            output[count[digit] - 1] = arr[i];
            count[digit]--;
        }
        
        // Copy back
        System.arraycopy(output, 0, arr, 0, arr.length);
    }
    
    // Radix sort for strings
    public static void radixSortStrings(String[] arr) {
        if (arr.length == 0) return;
        
        // Find maximum length
        int maxLength = Arrays.stream(arr).mapToInt(String::length).max().getAsInt();
        
        // Sort from least significant to most significant character
        for (int position = maxLength - 1; position >= 0; position--) {
            CountingSort.countingSortStrings(arr, position);
        }
    }
}
```

### 14.4 Searching Algorithms

#### Binary Search Variations
```java
public class BinarySearch {
    
    // Standard binary search
    public static int binarySearch(int[] arr, int target) {
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
    public static int findFirst(int[] arr, int target) {
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
    public static int findLast(int[] arr, int target) {
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
    
    // Lower bound: first element >= target
    public static int lowerBound(int[] arr, int target) {
        int left = 0, right = arr.length;
        
        while (left < right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        
        return left;
    }
    
    // Upper bound: first element > target
    public static int upperBound(int[] arr, int target) {
        int left = 0, right = arr.length;
        
        while (left < right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        
        return left;
    }
    
    // Search in rotated sorted array
    public static int searchRotated(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] == target) return mid;
            
            // Left half is sorted
            if (arr[left] <= arr[mid]) {
                if (target >= arr[left] && target < arr[mid]) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            // Right half is sorted
            else {
                if (target > arr[mid] && target <= arr[right]) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
        }
        
        return -1;
    }
    
    // Find peak element
    public static int findPeakElement(int[] arr) {
        int left = 0, right = arr.length - 1;
        
        while (left < right) {
            int mid = left + (right - left) / 2;
            
            if (arr[mid] > arr[mid + 1]) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        
        return left;
    }
}
```

### 14.5 Advanced Sorting Problems

#### Custom Sorting with Comparators
```java
import java.util.*;

public class CustomSorting {
    
    static class Student {
        String name;
        int grade;
        int age;
        
        Student(String name, int grade, int age) {
            this.name = name;
            this.grade = grade;
            this.age = age;
        }
        
        @Override
        public String toString() {
            return name + "(" + grade + "," + age + ")";
        }
    }
    
    public static void demonstrateCustomSorting() {
        List<Student> students = Arrays.asList(
            new Student("Alice", 85, 20),
            new Student("Bob", 92, 19),
            new Student("Charlie", 85, 21),
            new Student("David", 92, 20)
        );
        
        // Sort by grade descending, then by age ascending
        students.sort((s1, s2) -> {
            if (s1.grade != s2.grade) {
                return s2.grade - s1.grade; // Descending
            }
            return s1.age - s2.age; // Ascending
        });
        
        System.out.println("Sorted by grade desc, age asc: " + students);
        
        // Using Comparator.comparing
        students.sort(Comparator.comparingInt((Student s) -> s.grade).reversed()
                     .thenComparingInt(s -> s.age));
        
        // Multi-level sorting
        students.sort(Comparator.comparing((Student s) -> s.name)
                     .thenComparingInt(s -> s.grade)
                     .thenComparingInt(s -> s.age));
    }
    
    // Sort array by frequency
    public static int[] sortByFrequency(int[] arr) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : arr) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        
        return Arrays.stream(arr)
                     .boxed()
                     .sorted((a, b) -> {
                         int freqCompare = freq.get(b) - freq.get(a);
                         return freqCompare != 0 ? freqCompare : a - b;
                     })
                     .mapToInt(i -> i)
                     .toArray();
    }
    
    // Sort colors (Dutch National Flag)
    public static void sortColors(int[] nums) {
        int low = 0, mid = 0, high = nums.length - 1;
        
        while (mid <= high) {
            if (nums[mid] == 0) {
                swap(nums, low++, mid++);
            } else if (nums[mid] == 1) {
                mid++;
            } else {
                swap(nums, mid, high--);
            }
        }
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```

## Algorithm Comparison

| Algorithm | Best | Average | Worst | Space | Stable | In-place |
|-----------|------|---------|-------|-------|--------|----------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Yes | Yes |
| Selection Sort | O(n²) | O(n²) | O(n²) | O(1) | No | Yes |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes | Yes |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes | No |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No | Yes |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No | Yes |
| Counting Sort | O(n+k) | O(n+k) | O(n+k) | O(k) | Yes | No |
| Radix Sort | O(d(n+k)) | O(d(n+k)) | O(d(n+k)) | O(n+k) | Yes | No |

## Practice Problems

### Easy Level
1. **Merge Sorted Array** - Merge two sorted arrays in-place
2. **Squares of Sorted Array** - Sort squares of sorted array
3. **Sort Array by Parity** - Sort by even/odd numbers
4. **Find First Bad Version** - Binary search application

### Medium Level
1. **Kth Largest Element** - QuickSelect or heap approach
2. **Sort Characters by Frequency** - Custom sorting with frequency
3. **Search in Rotated Sorted Array** - Binary search variant
4. **Find Peak Element** - Binary search on unsorted array
5. **Wiggle Sort** - Arrange elements in wiggle pattern

### Hard Level
1. **Median of Two Sorted Arrays** - Binary search optimization
2. **Count of Smaller Numbers After Self** - Merge sort with counting
3. **Reverse Pairs** - Modified merge sort
4. **Maximum Gap** - Bucket sort application

## Key Patterns

1. **Two Pointers**: For merge operations and partitioning
2. **Divide and Conquer**: Merge sort, quick sort approach
3. **Binary Search**: For searching and optimization problems
4. **Custom Comparators**: For complex sorting requirements
5. **Stable vs Unstable**: When order of equal elements matters

## Next Steps
- Implement all sorting algorithms from scratch
- Practice binary search variations
- Solve custom sorting problems
- Move to **[Module 15: Two Pointers Technique](../15-two-pointers/README.md)**
