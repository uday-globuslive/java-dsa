# One-Dimensional Arrays in Java

## 🎯 Overview

Arrays in Java are fundamental data structures that store multiple elements of the same type in a contiguous memory location. One-dimensional arrays, also known as linear arrays, are the simplest form of arrays where elements are arranged in a single row and accessed using a single index. Understanding arrays is crucial for efficient data storage, manipulation, and algorithm implementation.

## 📚 Array Fundamentals

### What is an Array?

An array is a collection of elements of the same data type stored in consecutive memory locations. Each element is identified by an index (position), starting from 0.

### Array Characteristics
- **Fixed Size:** Once created, array size cannot be changed
- **Homogeneous:** All elements must be of the same type
- **Indexed Access:** Elements accessed using zero-based indexing
- **Reference Type:** Arrays are objects in Java
- **Contiguous Memory:** Elements stored in adjacent memory locations

### Basic Array Syntax
```java
// Declaration
dataType[] arrayName;
// or
dataType arrayName[];

// Instantiation
arrayName = new dataType[size];

// Declaration and instantiation combined
dataType[] arrayName = new dataType[size];

// Declaration, instantiation, and initialization
dataType[] arrayName = {value1, value2, value3, ...};
```

## 🔧 Array Declaration and Initialization

### Different Ways to Create Arrays
```java
public class ArrayCreation {
    public static void main(String[] args) {
        // Method 1: Declaration then instantiation
        int[] numbers1;
        numbers1 = new int[5]; // Creates array of 5 integers (default values: 0)
        
        // Method 2: Declaration and instantiation combined
        int[] numbers2 = new int[5];
        
        // Method 3: Declaration and initialization with values
        int[] numbers3 = {1, 2, 3, 4, 5};
        
        // Method 4: Using new keyword with initialization
        int[] numbers4 = new int[]{10, 20, 30, 40, 50};
        
        // Method 5: Anonymous array
        printArray(new int[]{100, 200, 300});
        
        // Different data types
        double[] decimals = {3.14, 2.71, 1.41, 1.73};
        String[] names = {"Alice", "Bob", "Charlie", "Diana"};
        boolean[] flags = {true, false, true, true, false};
        char[] letters = {'A', 'B', 'C', 'D', 'E'};
        
        // Display arrays
        System.out.println("Numbers1: " + java.util.Arrays.toString(numbers1));
        System.out.println("Numbers3: " + java.util.Arrays.toString(numbers3));
        System.out.println("Decimals: " + java.util.Arrays.toString(decimals));
        System.out.println("Names: " + java.util.Arrays.toString(names));
        System.out.println("Flags: " + java.util.Arrays.toString(flags));
        System.out.println("Letters: " + java.util.Arrays.toString(letters));
    }
    
    public static void printArray(int[] arr) {
        System.out.println("Anonymous array: " + java.util.Arrays.toString(arr));
    }
}
```

### Array Properties and Default Values
```java
public class ArrayProperties {
    public static void main(String[] args) {
        // Array length property
        int[] numbers = new int[10];
        System.out.println("Array length: " + numbers.length);
        
        // Default values for different types
        int[] integers = new int[3];
        double[] doubles = new double[3];
        boolean[] booleans = new boolean[3];
        String[] strings = new String[3];
        char[] characters = new char[3];
        
        System.out.println("Default int values: " + 
                          java.util.Arrays.toString(integers));     // [0, 0, 0]
        System.out.println("Default double values: " + 
                          java.util.Arrays.toString(doubles));      // [0.0, 0.0, 0.0]
        System.out.println("Default boolean values: " + 
                          java.util.Arrays.toString(booleans));     // [false, false, false]
        System.out.println("Default String values: " + 
                          java.util.Arrays.toString(strings));      // [null, null, null]
        System.out.println("Default char values: " + 
                          java.util.Arrays.toString(characters));   // [\u0000, \u0000, \u0000]
        
        // Array bounds
        System.out.println("First index: 0");
        System.out.println("Last index: " + (numbers.length - 1));
    }
}
```

## 🔍 Accessing and Modifying Array Elements

### Basic Array Operations
```java
public class ArrayAccess {
    public static void main(String[] args) {
        // Create and initialize array
        int[] scores = {85, 92, 78, 96, 88};
        
        // Accessing elements
        System.out.println("First score: " + scores[0]);
        System.out.println("Third score: " + scores[2]);
        System.out.println("Last score: " + scores[scores.length - 1]);
        
        // Modifying elements
        scores[1] = 95; // Change second score from 92 to 95
        scores[4] = 90; // Change last score from 88 to 90
        
        System.out.println("Modified scores: " + java.util.Arrays.toString(scores));
        
        // Reading user input into array
        java.util.Scanner scanner = new java.util.Scanner(System.in);
        int[] userNumbers = new int[3];
        
        System.out.println("Enter 3 numbers:");
        for (int i = 0; i < userNumbers.length; i++) {
            System.out.print("Number " + (i + 1) + ": ");
            userNumbers[i] = scanner.nextInt();
        }
        
        System.out.println("Your numbers: " + java.util.Arrays.toString(userNumbers));
        scanner.close();
    }
}
```

### Safe Array Access
```java
public class SafeArrayAccess {
    public static void main(String[] args) {
        int[] numbers = {10, 20, 30, 40, 50};
        
        // Safe element access with bounds checking
        int index = 7; // Invalid index
        
        if (isValidIndex(numbers, index)) {
            System.out.println("Element at index " + index + ": " + numbers[index]);
        } else {
            System.out.println("Index " + index + " is out of bounds!");
        }
        
        // Safe element retrieval with default value
        System.out.println("Safe get at index 2: " + safeGet(numbers, 2, -1));
        System.out.println("Safe get at index 10: " + safeGet(numbers, 10, -1));
        
        // Safe element setting
        safeSet(numbers, 3, 999);
        safeSet(numbers, 10, 888); // This won't modify the array
        
        System.out.println("Final array: " + java.util.Arrays.toString(numbers));
    }
    
    public static boolean isValidIndex(int[] array, int index) {
        return index >= 0 && index < array.length;
    }
    
    public static int safeGet(int[] array, int index, int defaultValue) {
        if (isValidIndex(array, index)) {
            return array[index];
        }
        return defaultValue;
    }
    
    public static boolean safeSet(int[] array, int index, int value) {
        if (isValidIndex(array, index)) {
            array[index] = value;
            return true;
        }
        System.out.println("Cannot set value at invalid index: " + index);
        return false;
    }
}
```

## 🔄 Array Iteration and Traversal

### Different Ways to Iterate Through Arrays
```java
public class ArrayIteration {
    public static void main(String[] args) {
        String[] fruits = {"Apple", "Banana", "Cherry", "Date", "Elderberry"};
        
        // Method 1: Traditional for loop
        System.out.println("Method 1 - Traditional for loop:");
        for (int i = 0; i < fruits.length; i++) {
            System.out.println("Index " + i + ": " + fruits[i]);
        }
        
        // Method 2: Enhanced for loop (for-each)
        System.out.println("\nMethod 2 - Enhanced for loop:");
        for (String fruit : fruits) {
            System.out.println("Fruit: " + fruit);
        }
        
        // Method 3: While loop
        System.out.println("\nMethod 3 - While loop:");
        int index = 0;
        while (index < fruits.length) {
            System.out.println("While - " + fruits[index]);
            index++;
        }
        
        // Method 4: Reverse iteration
        System.out.println("\nMethod 4 - Reverse iteration:");
        for (int i = fruits.length - 1; i >= 0; i--) {
            System.out.println("Reverse - " + fruits[i]);
        }
        
        // Method 5: Skip iteration (every other element)
        System.out.println("\nMethod 5 - Every other element:");
        for (int i = 0; i < fruits.length; i += 2) {
            System.out.println("Every 2nd - " + fruits[i]);
        }
    }
}
```

### Advanced Traversal Patterns
```java
public class AdvancedTraversal {
    public static void main(String[] args) {
        int[] numbers = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};
        
        // Find specific elements
        findAndPrint(numbers, 5);
        
        // Process with conditions
        processConditionally(numbers);
        
        // Parallel array processing
        String[] names = {"Alice", "Bob", "Charlie", "Diana", "Eve"};
        int[] ages = {25, 30, 35, 28, 32};
        processParallelArrays(names, ages);
    }
    
    public static void findAndPrint(int[] array, int target) {
        System.out.println("Finding all occurrences of " + target + ":");
        boolean found = false;
        
        for (int i = 0; i < array.length; i++) {
            if (array[i] == target) {
                System.out.println("Found " + target + " at index " + i);
                found = true;
            }
        }
        
        if (!found) {
            System.out.println(target + " not found in array");
        }
        System.out.println();
    }
    
    public static void processConditionally(int[] array) {
        System.out.println("Processing even numbers:");
        
        for (int i = 0; i < array.length; i++) {
            if (array[i] % 2 == 0) {
                System.out.println("Even number at index " + i + ": " + array[i]);
            }
        }
        System.out.println();
    }
    
    public static void processParallelArrays(String[] names, int[] ages) {
        System.out.println("Processing parallel arrays:");
        
        int minLength = Math.min(names.length, ages.length);
        for (int i = 0; i < minLength; i++) {
            System.out.println(names[i] + " is " + ages[i] + " years old");
        }
        System.out.println();
    }
}
```

## 🧮 Common Array Operations

### Array Utilities and Operations
```java
import java.util.Arrays;

public class ArrayOperations {
    public static void main(String[] args) {
        int[] numbers = {64, 34, 25, 12, 22, 11, 90};
        
        // Display original array
        System.out.println("Original array: " + Arrays.toString(numbers));
        
        // Basic statistics
        printStatistics(numbers);
        
        // Search operations
        performSearches(numbers);
        
        // Array transformations
        demonstrateTransformations(numbers);
        
        // Array comparison
        demonstrateComparisons();
    }
    
    public static void printStatistics(int[] array) {
        System.out.println("\n=== Array Statistics ===");
        System.out.println("Length: " + array.length);
        System.out.println("Sum: " + calculateSum(array));
        System.out.println("Average: " + calculateAverage(array));
        System.out.println("Minimum: " + findMin(array));
        System.out.println("Maximum: " + findMax(array));
    }
    
    public static int calculateSum(int[] array) {
        int sum = 0;
        for (int num : array) {
            sum += num;
        }
        return sum;
    }
    
    public static double calculateAverage(int[] array) {
        return array.length > 0 ? (double) calculateSum(array) / array.length : 0;
    }
    
    public static int findMin(int[] array) {
        if (array.length == 0) return Integer.MAX_VALUE;
        
        int min = array[0];
        for (int i = 1; i < array.length; i++) {
            if (array[i] < min) {
                min = array[i];
            }
        }
        return min;
    }
    
    public static int findMax(int[] array) {
        if (array.length == 0) return Integer.MIN_VALUE;
        
        int max = array[0];
        for (int i = 1; i < array.length; i++) {
            if (array[i] > max) {
                max = array[i];
            }
        }
        return max;
    }
    
    public static void performSearches(int[] array) {
        System.out.println("\n=== Search Operations ===");
        
        // Linear search
        int target = 25;
        int index = linearSearch(array, target);
        if (index != -1) {
            System.out.println("Found " + target + " at index " + index);
        } else {
            System.out.println(target + " not found");
        }
        
        // Count occurrences
        int count = countOccurrences(array, 12);
        System.out.println("Number 12 appears " + count + " times");
        
        // Find all indices
        int[] indices = findAllIndices(array, 22);
        System.out.println("Number 22 found at indices: " + Arrays.toString(indices));
    }
    
    public static int linearSearch(int[] array, int target) {
        for (int i = 0; i < array.length; i++) {
            if (array[i] == target) {
                return i;
            }
        }
        return -1;
    }
    
    public static int countOccurrences(int[] array, int target) {
        int count = 0;
        for (int num : array) {
            if (num == target) {
                count++;
            }
        }
        return count;
    }
    
    public static int[] findAllIndices(int[] array, int target) {
        // First pass: count occurrences
        int count = countOccurrences(array, target);
        int[] indices = new int[count];
        
        // Second pass: collect indices
        int indexPos = 0;
        for (int i = 0; i < array.length; i++) {
            if (array[i] == target) {
                indices[indexPos++] = i;
            }
        }
        
        return indices;
    }
    
    public static void demonstrateTransformations(int[] originalArray) {
        System.out.println("\n=== Array Transformations ===");
        
        // Copy array
        int[] copy = copyArray(originalArray);
        System.out.println("Copied array: " + Arrays.toString(copy));
        
        // Reverse array
        int[] reversed = reverseArray(originalArray);
        System.out.println("Reversed array: " + Arrays.toString(reversed));
        
        // Double all values
        int[] doubled = transformArray(originalArray, x -> x * 2);
        System.out.println("Doubled array: " + Arrays.toString(doubled));
        
        // Filter even numbers
        int[] evens = filterArray(originalArray, x -> x % 2 == 0);
        System.out.println("Even numbers: " + Arrays.toString(evens));
    }
    
    public static int[] copyArray(int[] original) {
        int[] copy = new int[original.length];
        for (int i = 0; i < original.length; i++) {
            copy[i] = original[i];
        }
        return copy;
    }
    
    public static int[] reverseArray(int[] original) {
        int[] reversed = new int[original.length];
        for (int i = 0; i < original.length; i++) {
            reversed[i] = original[original.length - 1 - i];
        }
        return reversed;
    }
    
    // Using functional interface for transformation
    @FunctionalInterface
    interface IntTransformer {
        int transform(int value);
    }
    
    public static int[] transformArray(int[] original, IntTransformer transformer) {
        int[] result = new int[original.length];
        for (int i = 0; i < original.length; i++) {
            result[i] = transformer.transform(original[i]);
        }
        return result;
    }
    
    @FunctionalInterface
    interface IntPredicate {
        boolean test(int value);
    }
    
    public static int[] filterArray(int[] original, IntPredicate predicate) {
        // Count matching elements
        int count = 0;
        for (int num : original) {
            if (predicate.test(num)) {
                count++;
            }
        }
        
        // Create filtered array
        int[] filtered = new int[count];
        int index = 0;
        for (int num : original) {
            if (predicate.test(num)) {
                filtered[index++] = num;
            }
        }
        
        return filtered;
    }
    
    public static void demonstrateComparisons() {
        System.out.println("\n=== Array Comparisons ===");
        
        int[] array1 = {1, 2, 3, 4, 5};
        int[] array2 = {1, 2, 3, 4, 5};
        int[] array3 = {5, 4, 3, 2, 1};
        
        System.out.println("Array1: " + Arrays.toString(array1));
        System.out.println("Array2: " + Arrays.toString(array2));
        System.out.println("Array3: " + Arrays.toString(array3));
        
        System.out.println("Array1 equals Array2: " + Arrays.equals(array1, array2));
        System.out.println("Array1 equals Array3: " + Arrays.equals(array1, array3));
        System.out.println("Custom comparison (array1 vs array3): " + 
                          customEquals(array1, array3));
    }
    
    public static boolean customEquals(int[] arr1, int[] arr2) {
        if (arr1.length != arr2.length) {
            return false;
        }
        
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] != arr2[i]) {
                return false;
            }
        }
        
        return true;
    }
}
```

## 📊 Array Sorting and Searching

### Sorting Algorithms
```java
import java.util.Arrays;

public class ArraySorting {
    public static void main(String[] args) {
        int[] numbers = {64, 34, 25, 12, 22, 11, 90, 5};
        
        System.out.println("Original array: " + Arrays.toString(numbers));
        
        // Bubble Sort
        int[] bubbleSorted = Arrays.copyOf(numbers, numbers.length);
        bubbleSort(bubbleSorted);
        System.out.println("Bubble sort: " + Arrays.toString(bubbleSorted));
        
        // Selection Sort
        int[] selectionSorted = Arrays.copyOf(numbers, numbers.length);
        selectionSort(selectionSorted);
        System.out.println("Selection sort: " + Arrays.toString(selectionSorted));
        
        // Insertion Sort
        int[] insertionSorted = Arrays.copyOf(numbers, numbers.length);
        insertionSort(insertionSorted);
        System.out.println("Insertion sort: " + Arrays.toString(insertionSorted));
        
        // Built-in sort
        int[] builtInSorted = Arrays.copyOf(numbers, numbers.length);
        Arrays.sort(builtInSorted);
        System.out.println("Built-in sort: " + Arrays.toString(builtInSorted));
        
        // Binary search (requires sorted array)
        demonstrateBinarySearch(builtInSorted);
    }
    
    public static void bubbleSort(int[] array) {
        int n = array.length;
        for (int i = 0; i < n - 1; i++) {
            boolean swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    // Swap elements
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                    swapped = true;
                }
            }
            // If no swapping occurred, array is sorted
            if (!swapped) {
                break;
            }
        }
    }
    
    public static void selectionSort(int[] array) {
        int n = array.length;
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (array[j] < array[minIndex]) {
                    minIndex = j;
                }
            }
            // Swap minimum element with first element
            int temp = array[minIndex];
            array[minIndex] = array[i];
            array[i] = temp;
        }
    }
    
    public static void insertionSort(int[] array) {
        for (int i = 1; i < array.length; i++) {
            int key = array[i];
            int j = i - 1;
            
            // Move elements greater than key one position ahead
            while (j >= 0 && array[j] > key) {
                array[j + 1] = array[j];
                j--;
            }
            array[j + 1] = key;
        }
    }
    
    public static void demonstrateBinarySearch(int[] sortedArray) {
        System.out.println("\n=== Binary Search ===");
        System.out.println("Sorted array: " + Arrays.toString(sortedArray));
        
        int target = 22;
        int index = binarySearch(sortedArray, target);
        if (index != -1) {
            System.out.println("Found " + target + " at index " + index);
        } else {
            System.out.println(target + " not found");
        }
        
        // Using built-in binary search
        int builtInIndex = Arrays.binarySearch(sortedArray, target);
        System.out.println("Built-in binary search result: " + builtInIndex);
    }
    
    public static int binarySearch(int[] array, int target) {
        int left = 0;
        int right = array.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            
            if (array[mid] == target) {
                return mid;
            } else if (array[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return -1; // Not found
    }
}
```

## 💡 Practical Array Applications

### Student Grade Management System
```java
import java.util.Arrays;
import java.util.Scanner;

public class GradeManager {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter number of students: ");
        int numStudents = scanner.nextInt();
        
        double[] grades = new double[numStudents];
        String[] studentNames = new String[numStudents];
        
        // Input student data
        inputStudentData(scanner, studentNames, grades);
        
        // Display menu and process user choices
        while (true) {
            displayMenu();
            int choice = scanner.nextInt();
            
            switch (choice) {
                case 1:
                    displayAllGrades(studentNames, grades);
                    break;
                case 2:
                    displayStatistics(grades);
                    break;
                case 3:
                    findTopPerformers(studentNames, grades);
                    break;
                case 4:
                    searchStudent(scanner, studentNames, grades);
                    break;
                case 5:
                    sortStudentsByGrade(studentNames, grades);
                    break;
                case 6:
                    System.out.println("Goodbye!");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice!");
            }
        }
    }
    
    public static void inputStudentData(Scanner scanner, String[] names, double[] grades) {
        scanner.nextLine(); // Consume newline
        
        for (int i = 0; i < names.length; i++) {
            System.out.print("Enter name for student " + (i + 1) + ": ");
            names[i] = scanner.nextLine();
            
            System.out.print("Enter grade for " + names[i] + ": ");
            grades[i] = scanner.nextDouble();
            scanner.nextLine(); // Consume newline
        }
    }
    
    public static void displayMenu() {
        System.out.println("\n=== Grade Management System ===");
        System.out.println("1. Display all grades");
        System.out.println("2. Show statistics");
        System.out.println("3. Find top performers");
        System.out.println("4. Search student");
        System.out.println("5. Sort by grade");
        System.out.println("6. Exit");
        System.out.print("Enter your choice: ");
    }
    
    public static void displayAllGrades(String[] names, double[] grades) {
        System.out.println("\n=== All Student Grades ===");
        for (int i = 0; i < names.length; i++) {
            System.out.printf("%-20s: %.2f (%s)%n", 
                            names[i], grades[i], getLetterGrade(grades[i]));
        }
    }
    
    public static void displayStatistics(double[] grades) {
        System.out.println("\n=== Grade Statistics ===");
        
        double sum = 0;
        double min = grades[0];
        double max = grades[0];
        
        for (double grade : grades) {
            sum += grade;
            if (grade < min) min = grade;
            if (grade > max) max = grade;
        }
        
        double average = sum / grades.length;
        
        System.out.printf("Average: %.2f%n", average);
        System.out.printf("Minimum: %.2f%n", min);
        System.out.printf("Maximum: %.2f%n", max);
        System.out.printf("Total Students: %d%n", grades.length);
        
        // Grade distribution
        int[] gradeCounts = new int[5]; // A, B, C, D, F
        for (double grade : grades) {
            if (grade >= 90) gradeCounts[0]++;
            else if (grade >= 80) gradeCounts[1]++;
            else if (grade >= 70) gradeCounts[2]++;
            else if (grade >= 60) gradeCounts[3]++;
            else gradeCounts[4]++;
        }
        
        System.out.println("\nGrade Distribution:");
        String[] letters = {"A", "B", "C", "D", "F"};
        for (int i = 0; i < letters.length; i++) {
            System.out.printf("%s: %d students%n", letters[i], gradeCounts[i]);
        }
    }
    
    public static void findTopPerformers(String[] names, double[] grades) {
        System.out.println("\n=== Top Performers (Grade >= 90) ===");
        
        boolean found = false;
        for (int i = 0; i < grades.length; i++) {
            if (grades[i] >= 90) {
                System.out.printf("%-20s: %.2f%n", names[i], grades[i]);
                found = true;
            }
        }
        
        if (!found) {
            System.out.println("No students with grade >= 90");
        }
    }
    
    public static void searchStudent(Scanner scanner, String[] names, double[] grades) {
        System.out.print("Enter student name to search: ");
        String searchName = scanner.nextLine();
        
        for (int i = 0; i < names.length; i++) {
            if (names[i].equalsIgnoreCase(searchName)) {
                System.out.printf("Found: %s - Grade: %.2f (%s)%n", 
                                names[i], grades[i], getLetterGrade(grades[i]));
                return;
            }
        }
        
        System.out.println("Student not found!");
    }
    
    public static void sortStudentsByGrade(String[] names, double[] grades) {
        // Bubble sort with parallel array sorting
        for (int i = 0; i < grades.length - 1; i++) {
            for (int j = 0; j < grades.length - i - 1; j++) {
                if (grades[j] < grades[j + 1]) { // Sort in descending order
                    // Swap grades
                    double tempGrade = grades[j];
                    grades[j] = grades[j + 1];
                    grades[j + 1] = tempGrade;
                    
                    // Swap corresponding names
                    String tempName = names[j];
                    names[j] = names[j + 1];
                    names[j + 1] = tempName;
                }
            }
        }
        
        System.out.println("\nStudents sorted by grade (highest to lowest):");
        displayAllGrades(names, grades);
    }
    
    public static String getLetterGrade(double grade) {
        if (grade >= 90) return "A";
        else if (grade >= 80) return "B";
        else if (grade >= 70) return "C";
        else if (grade >= 60) return "D";
        else return "F";
    }
}
```

## ⚠️ Common Pitfalls and Best Practices

### Array Pitfalls to Avoid
```java
public class ArrayPitfalls {
    public static void main(String[] args) {
        demonstrateCommonErrors();
        showBestPractices();
    }
    
    public static void demonstrateCommonErrors() {
        System.out.println("=== Common Array Pitfalls ===");
        
        // Pitfall 1: Array Index Out of Bounds
        int[] numbers = {1, 2, 3, 4, 5};
        
        try {
            // WRONG: Accessing invalid index
            System.out.println(numbers[5]); // Will throw ArrayIndexOutOfBoundsException
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: " + e.getMessage());
        }
        
        // Pitfall 2: Null Pointer Exception
        int[] nullArray = null;
        
        try {
            // WRONG: Accessing length of null array
            System.out.println(nullArray.length);
        } catch (NullPointerException e) {
            System.out.println("Error: Cannot access null array");
        }
        
        // Pitfall 3: Modifying array during iteration (not applicable to basic arrays,
        // but important concept for collections)
        
        // Pitfall 4: Shallow copy confusion
        int[] original = {1, 2, 3};
        int[] reference = original; // This is NOT a copy!
        reference[0] = 999;
        System.out.println("Original after 'reference' modification: " + 
                          java.util.Arrays.toString(original));
    }
    
    public static void showBestPractices() {
        System.out.println("\n=== Best Practices ===");
        
        // Best Practice 1: Always validate array bounds
        int[] numbers = {1, 2, 3, 4, 5};
        int index = 10;
        
        if (index >= 0 && index < numbers.length) {
            System.out.println("Safe access: " + numbers[index]);
        } else {
            System.out.println("Index " + index + " is out of bounds");
        }
        
        // Best Practice 2: Null checks
        int[] possiblyNull = null;
        
        if (possiblyNull != null && possiblyNull.length > 0) {
            System.out.println("Array length: " + possiblyNull.length);
        } else {
            System.out.println("Array is null or empty");
        }
        
        // Best Practice 3: Proper array copying
        int[] original = {1, 2, 3, 4, 5};
        
        // Method 1: Using Arrays.copyOf()
        int[] copy1 = java.util.Arrays.copyOf(original, original.length);
        
        // Method 2: Using clone()
        int[] copy2 = original.clone();
        
        // Method 3: Manual copying
        int[] copy3 = new int[original.length];
        for (int i = 0; i < original.length; i++) {
            copy3[i] = original[i];
        }
        
        // Verify independence
        copy1[0] = 999;
        System.out.println("Original unchanged: " + java.util.Arrays.toString(original));
        System.out.println("Copy modified: " + java.util.Arrays.toString(copy1));
        
        // Best Practice 4: Use enhanced for loop when index not needed
        System.out.println("Using enhanced for loop:");
        for (int num : original) {
            System.out.print(num + " ");
        }
        System.out.println();
        
        // Best Practice 5: Initialize arrays appropriately
        // For numbers, default initialization to 0 is often fine
        int[] defaultNumbers = new int[5];
        
        // For objects, explicit initialization might be needed
        String[] names = new String[3];
        for (int i = 0; i < names.length; i++) {
            names[i] = ""; // Initialize to empty string instead of null
        }
        
        System.out.println("Initialized string array: " + 
                          java.util.Arrays.toString(names));
    }
}
```

## 📋 Summary

- **One-Dimensional Arrays:** Linear collections of elements of the same type
- **Zero-Based Indexing:** Array indices start from 0 and go up to length-1
- **Fixed Size:** Array size is determined at creation and cannot be changed
- **Memory Efficient:** Elements stored in contiguous memory locations
- **Common Operations:** Access, modify, iterate, search, sort, and transform
- **Best Practices:** Validate bounds, handle nulls, use proper copying, choose appropriate iteration methods

## 🔗 Related Topics

- [Two-Dimensional Arrays](./arrays-2d.md) - Multi-dimensional array structures
- [Variables and Data Types](./variables-datatypes.md) - Understanding data types
- [Loops](./loops.md) - Iterating through arrays
- [Methods](./methods.md) - Passing arrays to methods

## 🎯 Practice Exercises

1. Implement a temperature converter that stores daily temperatures in an array
2. Create a word frequency counter using parallel arrays
3. Build a simple inventory management system using arrays
4. Implement various sorting algorithms and compare their performance
5. Create a polynomial calculator that stores coefficients in an array
