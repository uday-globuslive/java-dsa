# Two-Dimensional Arrays in Java

## 🎯 Overview

Two-dimensional arrays in Java represent data structures that organize elements in a grid-like format with rows and columns. Think of them as "arrays of arrays" or matrices. They are essential for representing tabular data, game boards, mathematical matrices, images, and many other real-world applications where data has a natural two-dimensional structure.

## 📚 Understanding 2D Arrays

### What is a Two-Dimensional Array?

A two-dimensional array is an array where each element is itself an array. It provides a way to store and organize data in a table format with rows and columns.

### Structure and Memory Layout
```
2D Array Visualization:
[0][0] [0][1] [0][2] [0][3]  <- Row 0
[1][0] [1][1] [1][2] [1][3]  <- Row 1  
[2][0] [2][1] [2][2] [2][3]  <- Row 2

Memory Layout:
array[row][column]
```

### Basic Syntax and Declaration
```java
// Declaration
dataType[][] arrayName;
// or
dataType arrayName[][];

// Instantiation  
arrayName = new dataType[rows][columns];

// Declaration and instantiation combined
dataType[][] arrayName = new dataType[rows][columns];

// Declaration, instantiation, and initialization
dataType[][] arrayName = {
    {value1, value2, value3},
    {value4, value5, value6},
    {value7, value8, value9}
};
```

## 🔧 Creating and Initializing 2D Arrays

### Different Ways to Create 2D Arrays
```java
public class Array2DCreation {
    public static void main(String[] args) {
        // Method 1: Declaration then instantiation
        int[][] matrix1;
        matrix1 = new int[3][4]; // 3 rows, 4 columns
        
        // Method 2: Declaration and instantiation combined
        int[][] matrix2 = new int[3][4];
        
        // Method 3: Declaration and initialization with values
        int[][] matrix3 = {
            {1, 2, 3, 4},
            {5, 6, 7, 8},
            {9, 10, 11, 12}
        };
        
        // Method 4: Using new keyword with initialization
        int[][] matrix4 = new int[][] {
            {10, 20, 30},
            {40, 50, 60},
            {70, 80, 90}
        };
        
        // Method 5: Jagged arrays (different row lengths)
        int[][] jaggedArray = new int[3][];
        jaggedArray[0] = new int[2]; // Row 0 has 2 columns
        jaggedArray[1] = new int[4]; // Row 1 has 4 columns  
        jaggedArray[2] = new int[3]; // Row 2 has 3 columns
        
        // Different data types
        double[][] grades = {
            {95.5, 87.2, 92.1},
            {78.9, 84.6, 90.3},
            {88.7, 91.4, 85.8}
        };
        
        String[][] names = {
            {"Alice", "Bob", "Charlie"},
            {"Diana", "Eve", "Frank"},
            {"Grace", "Henry", "Ivy"}
        };
        
        boolean[][] gameBoard = new boolean[8][8]; // Chess board
        
        // Display arrays
        System.out.println("Matrix3:");
        display2DArray(matrix3);
        
        System.out.println("\nGrades:");
        display2DArrayDouble(grades);
        
        System.out.println("\nNames:");
        display2DArrayString(names);
        
        System.out.println("\nJagged Array structure:");
        displayJaggedStructure(jaggedArray);
    }
    
    public static void display2DArray(int[][] array) {
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.printf("%4d ", array[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void display2DArrayDouble(double[][] array) {
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.printf("%6.1f ", array[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void display2DArrayString(String[][] array) {
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.printf("%-8s ", array[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void displayJaggedStructure(int[][] array) {
        for (int i = 0; i < array.length; i++) {
            System.out.println("Row " + i + " has " + array[i].length + " columns");
        }
    }
}
```

### Array Properties and Dimensions
```java
public class Array2DProperties {
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3, 4, 5},
            {6, 7, 8, 9, 10},
            {11, 12, 13, 14, 15}
        };
        
        // Array dimensions
        System.out.println("Number of rows: " + matrix.length);
        System.out.println("Number of columns in row 0: " + matrix[0].length);
        
        // For regular (rectangular) arrays, all rows have same length
        boolean isRectangular = true;
        for (int i = 1; i < matrix.length; i++) {
            if (matrix[i].length != matrix[0].length) {
                isRectangular = false;
                break;
            }
        }
        
        System.out.println("Is rectangular array: " + isRectangular);
        
        // Total elements
        int totalElements = 0;
        for (int i = 0; i < matrix.length; i++) {
            totalElements += matrix[i].length;
        }
        System.out.println("Total elements: " + totalElements);
        
        // Default values demonstration
        demonstrateDefaultValues();
    }
    
    public static void demonstrateDefaultValues() {
        System.out.println("\n=== Default Values ===");
        
        // Different types and their default values
        int[][] integers = new int[2][3];
        double[][] doubles = new double[2][3];
        boolean[][] booleans = new boolean[2][3];
        String[][] strings = new String[2][3];
        
        System.out.println("Default int values:");
        display2DArray(integers);
        
        System.out.println("\nDefault double values:");
        for (int i = 0; i < doubles.length; i++) {
            for (int j = 0; j < doubles[i].length; j++) {
                System.out.printf("%4.1f ", doubles[i][j]);
            }
            System.out.println();
        }
        
        System.out.println("\nDefault boolean values:");
        for (int i = 0; i < booleans.length; i++) {
            for (int j = 0; j < booleans[i].length; j++) {
                System.out.printf("%6s ", booleans[i][j]);
            }
            System.out.println();
        }
        
        System.out.println("\nDefault String values (null):");
        for (int i = 0; i < strings.length; i++) {
            for (int j = 0; j < strings[i].length; j++) {
                System.out.printf("%6s ", strings[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void display2DArray(int[][] array) {
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.printf("%4d ", array[i][j]);
            }
            System.out.println();
        }
    }
}
```

## 🔍 Accessing and Modifying 2D Array Elements

### Basic Element Access
```java
public class Array2DAccess {
    public static void main(String[] args) {
        int[][] matrix = {
            {10, 20, 30},
            {40, 50, 60},
            {70, 80, 90}
        };
        
        System.out.println("Original matrix:");
        displayMatrix(matrix);
        
        // Accessing specific elements
        System.out.println("\n=== Element Access ===");
        System.out.println("Element at [0][0]: " + matrix[0][0]); // 10
        System.out.println("Element at [1][2]: " + matrix[1][2]); // 60
        System.out.println("Element at [2][1]: " + matrix[2][1]); // 80
        
        // First element of each row
        System.out.println("\nFirst element of each row:");
        for (int i = 0; i < matrix.length; i++) {
            System.out.println("Row " + i + ": " + matrix[i][0]);
        }
        
        // Last element of each row
        System.out.println("\nLast element of each row:");
        for (int i = 0; i < matrix.length; i++) {
            System.out.println("Row " + i + ": " + matrix[i][matrix[i].length - 1]);
        }
        
        // Modifying elements
        System.out.println("\n=== Modifying Elements ===");
        matrix[0][0] = 100;
        matrix[1][1] = 500;
        matrix[2][2] = 900;
        
        System.out.println("After modifications:");
        displayMatrix(matrix);
        
        // Reading input into 2D array
        readUserInput();
    }
    
    public static void displayMatrix(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%4d ", matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void readUserInput() {
        java.util.Scanner scanner = new java.util.Scanner(System.in);
        
        System.out.print("\nEnter rows and columns for new matrix: ");
        int rows = scanner.nextInt();
        int cols = scanner.nextInt();
        
        int[][] userMatrix = new int[rows][cols];
        
        System.out.println("Enter matrix elements:");
        for (int i = 0; i < rows; i++) {
            System.out.println("Enter elements for row " + (i + 1) + ":");
            for (int j = 0; j < cols; j++) {
                System.out.print("Element [" + i + "][" + j + "]: ");
                userMatrix[i][j] = scanner.nextInt();
            }
        }
        
        System.out.println("\nYour matrix:");
        displayMatrix(userMatrix);
        
        scanner.close();
    }
}
```

### Safe Access with Bounds Checking
```java
public class Safe2DArrayAccess {
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6, 7}, // Jagged - different length
            {8, 9}
        };
        
        System.out.println("Matrix structure:");
        displayMatrixWithIndices(matrix);
        
        // Test safe access
        System.out.println("\n=== Safe Access Tests ===");
        testSafeAccess(matrix, 0, 0);
        testSafeAccess(matrix, 1, 3);
        testSafeAccess(matrix, 2, 1);
        testSafeAccess(matrix, 3, 0); // Invalid row
        testSafeAccess(matrix, 1, 5); // Invalid column
        
        // Safe modification
        System.out.println("\n=== Safe Modification ===");
        safeSet(matrix, 0, 0, 999);
        safeSet(matrix, 5, 5, 777); // Invalid indices
        
        System.out.println("Matrix after safe modifications:");
        displayMatrixWithIndices(matrix);
    }
    
    public static void displayMatrixWithIndices(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            System.out.print("Row " + i + ": ");
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("[%d][%d]=%d ", i, j, matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static boolean isValidIndex(int[][] matrix, int row, int col) {
        return row >= 0 && row < matrix.length && 
               col >= 0 && col < matrix[row].length;
    }
    
    public static int safeGet(int[][] matrix, int row, int col, int defaultValue) {
        if (isValidIndex(matrix, row, col)) {
            return matrix[row][col];
        }
        System.out.println("Invalid index [" + row + "][" + col + "], returning default: " + defaultValue);
        return defaultValue;
    }
    
    public static boolean safeSet(int[][] matrix, int row, int col, int value) {
        if (isValidIndex(matrix, row, col)) {
            matrix[row][col] = value;
            System.out.println("Successfully set [" + row + "][" + col + "] = " + value);
            return true;
        }
        System.out.println("Cannot set value at invalid index [" + row + "][" + col + "]");
        return false;
    }
    
    public static void testSafeAccess(int[][] matrix, int row, int col) {
        int value = safeGet(matrix, row, col, -1);
        System.out.println("Accessing [" + row + "][" + col + "]: " + value);
    }
}
```

## 🔄 Iterating Through 2D Arrays

### Different Iteration Patterns
```java
public class Array2DIteration {
    public static void main(String[] args) {
        int[][] matrix = {
            {1, 2, 3, 4},
            {5, 6, 7, 8},
            {9, 10, 11, 12},
            {13, 14, 15, 16}
        };
        
        System.out.println("Original Matrix:");
        displayMatrix(matrix);
        
        // Method 1: Nested traditional for loops
        System.out.println("\n=== Method 1: Traditional For Loops ===");
        rowMajorTraversal(matrix);
        
        // Method 2: Enhanced for loops (for-each)
        System.out.println("\n=== Method 2: Enhanced For Loops ===");
        enhancedForTraversal(matrix);
        
        // Method 3: Column-major traversal
        System.out.println("\n=== Method 3: Column-Major Traversal ===");
        columnMajorTraversal(matrix);
        
        // Method 4: Diagonal traversals
        System.out.println("\n=== Method 4: Diagonal Traversals ===");
        diagonalTraversals(matrix);
        
        // Method 5: Spiral traversal
        System.out.println("\n=== Method 5: Spiral Traversal ===");
        spiralTraversal(matrix);
        
        // Method 6: Border traversal
        System.out.println("\n=== Method 6: Border Traversal ===");
        borderTraversal(matrix);
    }
    
    public static void displayMatrix(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%4d ", matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void rowMajorTraversal(int[][] matrix) {
        System.out.print("Row-major order: ");
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
        }
        System.out.println();
    }
    
    public static void enhancedForTraversal(int[][] matrix) {
        System.out.print("Enhanced for-each: ");
        for (int[] row : matrix) {
            for (int element : row) {
                System.out.print(element + " ");
            }
        }
        System.out.println();
    }
    
    public static void columnMajorTraversal(int[][] matrix) {
        System.out.print("Column-major order: ");
        for (int j = 0; j < matrix[0].length; j++) {
            for (int i = 0; i < matrix.length; i++) {
                System.out.print(matrix[i][j] + " ");
            }
        }
        System.out.println();
    }
    
    public static void diagonalTraversals(int[][] matrix) {
        // Main diagonal (top-left to bottom-right)
        System.out.print("Main diagonal: ");
        for (int i = 0; i < Math.min(matrix.length, matrix[0].length); i++) {
            System.out.print(matrix[i][i] + " ");
        }
        System.out.println();
        
        // Anti-diagonal (top-right to bottom-left)
        System.out.print("Anti-diagonal: ");
        for (int i = 0; i < Math.min(matrix.length, matrix[0].length); i++) {
            System.out.print(matrix[i][matrix[0].length - 1 - i] + " ");
        }
        System.out.println();
    }
    
    public static void spiralTraversal(int[][] matrix) {
        System.out.print("Spiral order: ");
        
        int top = 0, bottom = matrix.length - 1;
        int left = 0, right = matrix[0].length - 1;
        
        while (top <= bottom && left <= right) {
            // Traverse right
            for (int j = left; j <= right; j++) {
                System.out.print(matrix[top][j] + " ");
            }
            top++;
            
            // Traverse down
            for (int i = top; i <= bottom; i++) {
                System.out.print(matrix[i][right] + " ");
            }
            right--;
            
            // Traverse left (if still valid)
            if (top <= bottom) {
                for (int j = right; j >= left; j--) {
                    System.out.print(matrix[bottom][j] + " ");
                }
                bottom--;
            }
            
            // Traverse up (if still valid)
            if (left <= right) {
                for (int i = bottom; i >= top; i--) {
                    System.out.print(matrix[i][left] + " ");
                }
                left++;
            }
        }
        System.out.println();
    }
    
    public static void borderTraversal(int[][] matrix) {
        System.out.print("Border elements: ");
        
        for (int j = 0; j < matrix[0].length; j++) {
            System.out.print(matrix[0][j] + " "); // Top row
        }
        
        for (int i = 1; i < matrix.length - 1; i++) {
            System.out.print(matrix[i][matrix[i].length - 1] + " "); // Right column
        }
        
        if (matrix.length > 1) {
            for (int j = matrix[0].length - 1; j >= 0; j--) {
                System.out.print(matrix[matrix.length - 1][j] + " "); // Bottom row
            }
        }
        
        if (matrix[0].length > 1) {
            for (int i = matrix.length - 2; i > 0; i--) {
                System.out.print(matrix[i][0] + " "); // Left column
            }
        }
        
        System.out.println();
    }
}
```

### Conditional and Filtered Iteration
```java
public class ConditionalIteration {
    public static void main(String[] args) {
        int[][] matrix = {
            {12, 7, 3, 8},
            {5, 14, 9, 2},
            {11, 6, 15, 4},
            {1, 10, 13, 16}
        };
        
        System.out.println("Matrix:");
        displayMatrix(matrix);
        
        // Find and process specific elements
        findEvenNumbers(matrix);
        findElementsInRange(matrix, 5, 12);
        findMaxInEachRow(matrix);
        findMinInEachColumn(matrix);
        
        // Search operations
        searchAndReplace(matrix, 7, 77);
        countElementsWithCondition(matrix);
    }
    
    public static void displayMatrix(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%4d ", matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void findEvenNumbers(int[][] matrix) {
        System.out.println("\n=== Even Numbers ===");
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] % 2 == 0) {
                    System.out.println("Even number " + matrix[i][j] + 
                                     " found at [" + i + "][" + j + "]");
                }
            }
        }
    }
    
    public static void findElementsInRange(int[][] matrix, int min, int max) {
        System.out.println("\n=== Elements between " + min + " and " + max + " ===");
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] >= min && matrix[i][j] <= max) {
                    System.out.println("Element " + matrix[i][j] + 
                                     " at [" + i + "][" + j + "] is in range");
                }
            }
        }
    }
    
    public static void findMaxInEachRow(int[][] matrix) {
        System.out.println("\n=== Maximum in Each Row ===");
        for (int i = 0; i < matrix.length; i++) {
            int maxInRow = matrix[i][0];
            int maxCol = 0;
            
            for (int j = 1; j < matrix[i].length; j++) {
                if (matrix[i][j] > maxInRow) {
                    maxInRow = matrix[i][j];
                    maxCol = j;
                }
            }
            
            System.out.println("Row " + i + " max: " + maxInRow + 
                             " at column " + maxCol);
        }
    }
    
    public static void findMinInEachColumn(int[][] matrix) {
        System.out.println("\n=== Minimum in Each Column ===");
        for (int j = 0; j < matrix[0].length; j++) {
            int minInCol = matrix[0][j];
            int minRow = 0;
            
            for (int i = 1; i < matrix.length; i++) {
                if (matrix[i][j] < minInCol) {
                    minInCol = matrix[i][j];
                    minRow = i;
                }
            }
            
            System.out.println("Column " + j + " min: " + minInCol + 
                             " at row " + minRow);
        }
    }
    
    public static void searchAndReplace(int[][] matrix, int target, int replacement) {
        System.out.println("\n=== Search and Replace ===");
        System.out.println("Replacing " + target + " with " + replacement);
        
        boolean found = false;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] == target) {
                    matrix[i][j] = replacement;
                    System.out.println("Replaced at [" + i + "][" + j + "]");
                    found = true;
                }
            }
        }
        
        if (!found) {
            System.out.println("Target " + target + " not found");
        } else {
            System.out.println("Matrix after replacement:");
            displayMatrix(matrix);
        }
    }
    
    public static void countElementsWithCondition(int[][] matrix) {
        System.out.println("\n=== Element Counting ===");
        
        int evenCount = 0;
        int oddCount = 0;
        int greaterThan10 = 0;
        
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] % 2 == 0) {
                    evenCount++;
                } else {
                    oddCount++;
                }
                
                if (matrix[i][j] > 10) {
                    greaterThan10++;
                }
            }
        }
        
        System.out.println("Even numbers: " + evenCount);
        System.out.println("Odd numbers: " + oddCount);
        System.out.println("Numbers > 10: " + greaterThan10);
    }
}
```

## 📊 Common 2D Array Operations

### Matrix Mathematics
```java
public class MatrixOperations {
    public static void main(String[] args) {
        int[][] matrix1 = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        int[][] matrix2 = {
            {9, 8, 7},
            {6, 5, 4},
            {3, 2, 1}
        };
        
        System.out.println("Matrix 1:");
        displayMatrix(matrix1);
        
        System.out.println("\nMatrix 2:");
        displayMatrix(matrix2);
        
        // Matrix addition
        int[][] sum = addMatrices(matrix1, matrix2);
        System.out.println("\nMatrix Addition:");
        displayMatrix(sum);
        
        // Matrix subtraction
        int[][] difference = subtractMatrices(matrix1, matrix2);
        System.out.println("\nMatrix Subtraction:");
        displayMatrix(difference);
        
        // Matrix multiplication
        int[][] product = multiplyMatrices(matrix1, matrix2);
        System.out.println("\nMatrix Multiplication:");
        displayMatrix(product);
        
        // Matrix transpose
        int[][] transpose = transposeMatrix(matrix1);
        System.out.println("\nMatrix Transpose:");
        displayMatrix(transpose);
        
        // Matrix properties
        analyzeMatrix(matrix1);
        
        // Special matrices
        demonstrateSpecialMatrices();
    }
    
    public static void displayMatrix(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%4d ", matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static int[][] addMatrices(int[][] a, int[][] b) {
        if (a.length != b.length || a[0].length != b[0].length) {
            throw new IllegalArgumentException("Matrices must have same dimensions");
        }
        
        int[][] result = new int[a.length][a[0].length];
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < a[i].length; j++) {
                result[i][j] = a[i][j] + b[i][j];
            }
        }
        return result;
    }
    
    public static int[][] subtractMatrices(int[][] a, int[][] b) {
        if (a.length != b.length || a[0].length != b[0].length) {
            throw new IllegalArgumentException("Matrices must have same dimensions");
        }
        
        int[][] result = new int[a.length][a[0].length];
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < a[i].length; j++) {
                result[i][j] = a[i][j] - b[i][j];
            }
        }
        return result;
    }
    
    public static int[][] multiplyMatrices(int[][] a, int[][] b) {
        if (a[0].length != b.length) {
            throw new IllegalArgumentException("Matrix A columns must equal Matrix B rows");
        }
        
        int[][] result = new int[a.length][b[0].length];
        
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < b[0].length; j++) {
                for (int k = 0; k < a[0].length; k++) {
                    result[i][j] += a[i][k] * b[k][j];
                }
            }
        }
        
        return result;
    }
    
    public static int[][] transposeMatrix(int[][] matrix) {
        int[][] transpose = new int[matrix[0].length][matrix.length];
        
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                transpose[j][i] = matrix[i][j];
            }
        }
        
        return transpose;
    }
    
    public static void analyzeMatrix(int[][] matrix) {
        System.out.println("\n=== Matrix Analysis ===");
        
        // Check if square matrix
        boolean isSquare = matrix.length == matrix[0].length;
        System.out.println("Is square matrix: " + isSquare);
        
        if (isSquare) {
            // Check if symmetric
            boolean isSymmetric = true;
            for (int i = 0; i < matrix.length && isSymmetric; i++) {
                for (int j = 0; j < matrix[i].length && isSymmetric; j++) {
                    if (matrix[i][j] != matrix[j][i]) {
                        isSymmetric = false;
                    }
                }
            }
            System.out.println("Is symmetric: " + isSymmetric);
            
            // Check if identity matrix
            boolean isIdentity = true;
            for (int i = 0; i < matrix.length && isIdentity; i++) {
                for (int j = 0; j < matrix[i].length && isIdentity; j++) {
                    if (i == j && matrix[i][j] != 1) {
                        isIdentity = false;
                    } else if (i != j && matrix[i][j] != 0) {
                        isIdentity = false;
                    }
                }
            }
            System.out.println("Is identity matrix: " + isIdentity);
        }
        
        // Calculate sum of all elements
        int totalSum = 0;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                totalSum += matrix[i][j];
            }
        }
        System.out.println("Sum of all elements: " + totalSum);
        
        // Calculate diagonal sum (for square matrices)
        if (isSquare) {
            int diagonalSum = 0;
            for (int i = 0; i < matrix.length; i++) {
                diagonalSum += matrix[i][i];
            }
            System.out.println("Main diagonal sum: " + diagonalSum);
        }
    }
    
    public static void demonstrateSpecialMatrices() {
        System.out.println("\n=== Special Matrices ===");
        
        // Identity matrix
        int[][] identity = createIdentityMatrix(4);
        System.out.println("4x4 Identity Matrix:");
        displayMatrix(identity);
        
        // Zero matrix
        int[][] zero = new int[3][3]; // Already initialized to zeros
        System.out.println("\n3x3 Zero Matrix:");
        displayMatrix(zero);
        
        // Random matrix
        int[][] random = createRandomMatrix(3, 3, 1, 20);
        System.out.println("\n3x3 Random Matrix (1-20):");
        displayMatrix(random);
    }
    
    public static int[][] createIdentityMatrix(int size) {
        int[][] identity = new int[size][size];
        for (int i = 0; i < size; i++) {
            identity[i][i] = 1;
        }
        return identity;
    }
    
    public static int[][] createRandomMatrix(int rows, int cols, int min, int max) {
        int[][] matrix = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                matrix[i][j] = min + (int) (Math.random() * (max - min + 1));
            }
        }
        return matrix;
    }
}
```

### Array Searching and Sorting
```java
import java.util.Arrays;

public class Array2DSearchSort {
    public static void main(String[] args) {
        int[][] matrix = {
            {64, 34, 25, 12},
            {22, 11, 90, 5},
            {77, 30, 40, 50},
            {15, 35, 80, 60}
        };
        
        System.out.println("Original Matrix:");
        displayMatrix(matrix);
        
        // Linear search
        performLinearSearch(matrix, 40);
        performLinearSearch(matrix, 99);
        
        // Binary search (requires sorted array)
        demonstrateBinarySearch();
        
        // Sorting operations
        demonstrateSorting(matrix);
    }
    
    public static void displayMatrix(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.printf("%4d ", matrix[i][j]);
            }
            System.out.println();
        }
    }
    
    public static void performLinearSearch(int[][] matrix, int target) {
        System.out.println("\n=== Linear Search for " + target + " ===");
        
        boolean found = false;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                if (matrix[i][j] == target) {
                    System.out.println("Found " + target + " at position [" + i + "][" + j + "]");
                    found = true;
                }
            }
        }
        
        if (!found) {
            System.out.println(target + " not found in matrix");
        }
    }
    
    public static void demonstrateBinarySearch() {
        // Binary search works on sorted arrays
        int[][] sortedMatrix = {
            {1, 4, 7, 11},
            {2, 5, 8, 12},
            {3, 6, 9, 16}
        };
        
        System.out.println("\n=== Binary Search (on sorted matrix) ===");
        System.out.println("Sorted Matrix:");
        displayMatrix(sortedMatrix);
        
        // Search in each sorted row
        for (int i = 0; i < sortedMatrix.length; i++) {
            int target = 8;
            int result = Arrays.binarySearch(sortedMatrix[i], target);
            if (result >= 0) {
                System.out.println("Found " + target + " in row " + i + " at column " + result);
            }
        }
        
        // Custom binary search for sorted 2D array (each row sorted)
        int target = 9;
        int[] position = binarySearch2D(sortedMatrix, target);
        if (position[0] != -1) {
            System.out.println("Found " + target + " at [" + position[0] + "][" + position[1] + "]");
        } else {
            System.out.println(target + " not found");
        }
    }
    
    public static int[] binarySearch2D(int[][] matrix, int target) {
        for (int i = 0; i < matrix.length; i++) {
            int col = Arrays.binarySearch(matrix[i], target);
            if (col >= 0) {
                return new int[]{i, col};
            }
        }
        return new int[]{-1, -1}; // Not found
    }
    
    public static void demonstrateSorting(int[][] matrix) {
        System.out.println("\n=== Sorting Operations ===");
        
        // Sort each row
        int[][] rowSorted = copyMatrix(matrix);
        sortEachRow(rowSorted);
        System.out.println("Matrix with each row sorted:");
        displayMatrix(rowSorted);
        
        // Sort each column
        int[][] colSorted = copyMatrix(matrix);
        sortEachColumn(colSorted);
        System.out.println("\nMatrix with each column sorted:");
        displayMatrix(colSorted);
        
        // Sort entire matrix as 1D array
        int[][] flatSorted = copyMatrix(matrix);
        sortEntireMatrix(flatSorted);
        System.out.println("\nMatrix sorted as flat array:");
        displayMatrix(flatSorted);
    }
    
    public static int[][] copyMatrix(int[][] original) {
        int[][] copy = new int[original.length][];
        for (int i = 0; i < original.length; i++) {
            copy[i] = original[i].clone();
        }
        return copy;
    }
    
    public static void sortEachRow(int[][] matrix) {
        for (int i = 0; i < matrix.length; i++) {
            Arrays.sort(matrix[i]);
        }
    }
    
    public static void sortEachColumn(int[][] matrix) {
        for (int j = 0; j < matrix[0].length; j++) {
            // Extract column
            int[] column = new int[matrix.length];
            for (int i = 0; i < matrix.length; i++) {
                column[i] = matrix[i][j];
            }
            
            // Sort column
            Arrays.sort(column);
            
            // Put back sorted column
            for (int i = 0; i < matrix.length; i++) {
                matrix[i][j] = column[i];
            }
        }
    }
    
    public static void sortEntireMatrix(int[][] matrix) {
        // Convert to 1D array
        int totalElements = matrix.length * matrix[0].length;
        int[] flatArray = new int[totalElements];
        
        int index = 0;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                flatArray[index++] = matrix[i][j];
            }
        }
        
        // Sort 1D array
        Arrays.sort(flatArray);
        
        // Convert back to 2D
        index = 0;
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                matrix[i][j] = flatArray[index++];
            }
        }
    }
}
```

## 💡 Practical Applications

### Tic-Tac-Toe Game Board
```java
import java.util.Scanner;

public class TicTacToeGame {
    private static final int SIZE = 3;
    private static char[][] board = new char[SIZE][SIZE];
    private static char currentPlayer = 'X';
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        initializeBoard();
        
        System.out.println("Welcome to Tic-Tac-Toe!");
        System.out.println("Players: X and O");
        System.out.println("Enter row and column (0-2) to make a move");
        
        while (true) {
            displayBoard();
            
            if (makeMove()) {
                if (checkWinner()) {
                    displayBoard();
                    System.out.println("Player " + currentPlayer + " wins!");
                    break;
                } else if (isBoardFull()) {
                    displayBoard();
                    System.out.println("It's a tie!");
                    break;
                }
                
                switchPlayer();
            }
        }
        
        scanner.close();
    }
    
    public static void initializeBoard() {
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                board[i][j] = '-';
            }
        }
    }
    
    public static void displayBoard() {
        System.out.println("\nCurrent Board:");
        System.out.println("  0 1 2");
        
        for (int i = 0; i < SIZE; i++) {
            System.out.print(i + " ");
            for (int j = 0; j < SIZE; j++) {
                System.out.print(board[i][j] + " ");
            }
            System.out.println();
        }
        System.out.println();
    }
    
    public static boolean makeMove() {
        System.out.print("Player " + currentPlayer + ", enter row: ");
        int row = scanner.nextInt();
        System.out.print("Player " + currentPlayer + ", enter column: ");
        int col = scanner.nextInt();
        
        if (isValidMove(row, col)) {
            board[row][col] = currentPlayer;
            return true;
        } else {
            System.out.println("Invalid move! Try again.");
            return false;
        }
    }
    
    public static boolean isValidMove(int row, int col) {
        return row >= 0 && row < SIZE && 
               col >= 0 && col < SIZE && 
               board[row][col] == '-';
    }
    
    public static boolean checkWinner() {
        // Check rows
        for (int i = 0; i < SIZE; i++) {
            if (board[i][0] == currentPlayer && 
                board[i][1] == currentPlayer && 
                board[i][2] == currentPlayer) {
                return true;
            }
        }
        
        // Check columns
        for (int j = 0; j < SIZE; j++) {
            if (board[0][j] == currentPlayer && 
                board[1][j] == currentPlayer && 
                board[2][j] == currentPlayer) {
                return true;
            }
        }
        
        // Check main diagonal
        if (board[0][0] == currentPlayer && 
            board[1][1] == currentPlayer && 
            board[2][2] == currentPlayer) {
            return true;
        }
        
        // Check anti-diagonal
        if (board[0][2] == currentPlayer && 
            board[1][1] == currentPlayer && 
            board[2][0] == currentPlayer) {
            return true;
        }
        
        return false;
    }
    
    public static boolean isBoardFull() {
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                if (board[i][j] == '-') {
                    return false;
                }
            }
        }
        return true;
    }
    
    public static void switchPlayer() {
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    }
}
```

### Image Processing Simulation
```java
public class ImageProcessing {
    public static void main(String[] args) {
        // Simulate grayscale image as 2D array (0-255 values)
        int[][] image = {
            {120, 130, 140, 150, 160},
            {110, 125, 135, 145, 155},
            {100, 115, 130, 140, 150},
            {90,  105, 120, 135, 145},
            {80,  95,  110, 125, 140}
        };
        
        System.out.println("Original Image:");
        displayImage(image);
        
        // Apply various filters
        applyBrightnessFilter(image, 30);
        applyContrastFilter(image, 1.2);
        applyBlurFilter(image);
        applyEdgeDetection(image);
    }
    
    public static void displayImage(int[][] image) {
        for (int i = 0; i < image.length; i++) {
            for (int j = 0; j < image[i].length; j++) {
                System.out.printf("%4d ", image[i][j]);
            }
            System.out.println();
        }
        System.out.println();
    }
    
    public static void applyBrightnessFilter(int[][] image, int brightness) {
        System.out.println("After Brightness Filter (+" + brightness + "):");
        
        int[][] brightened = new int[image.length][image[0].length];
        for (int i = 0; i < image.length; i++) {
            for (int j = 0; j < image[i].length; j++) {
                brightened[i][j] = Math.min(255, Math.max(0, image[i][j] + brightness));
            }
        }
        
        displayImage(brightened);
    }
    
    public static void applyContrastFilter(int[][] image, double contrast) {
        System.out.println("After Contrast Filter (x" + contrast + "):");
        
        int[][] contrasted = new int[image.length][image[0].length];
        for (int i = 0; i < image.length; i++) {
            for (int j = 0; j < image[i].length; j++) {
                int newValue = (int) (image[i][j] * contrast);
                contrasted[i][j] = Math.min(255, Math.max(0, newValue));
            }
        }
        
        displayImage(contrasted);
    }
    
    public static void applyBlurFilter(int[][] image) {
        System.out.println("After Blur Filter (3x3 average):");
        
        int[][] blurred = new int[image.length][image[0].length];
        
        for (int i = 0; i < image.length; i++) {
            for (int j = 0; j < image[i].length; j++) {
                int sum = 0;
                int count = 0;
                
                // Average of 3x3 neighborhood
                for (int di = -1; di <= 1; di++) {
                    for (int dj = -1; dj <= 1; dj++) {
                        int ni = i + di;
                        int nj = j + dj;
                        
                        if (ni >= 0 && ni < image.length && 
                            nj >= 0 && nj < image[0].length) {
                            sum += image[ni][nj];
                            count++;
                        }
                    }
                }
                
                blurred[i][j] = sum / count;
            }
        }
        
        displayImage(blurred);
    }
    
    public static void applyEdgeDetection(int[][] image) {
        System.out.println("After Edge Detection (Sobel operator):");
        
        int[][] edges = new int[image.length][image[0].length];
        
        // Sobel kernels
        int[][] sobelX = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
        int[][] sobelY = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
        
        for (int i = 1; i < image.length - 1; i++) {
            for (int j = 1; j < image[i].length - 1; j++) {
                int gx = 0, gy = 0;
                
                // Apply Sobel kernels
                for (int di = -1; di <= 1; di++) {
                    for (int dj = -1; dj <= 1; dj++) {
                        int pixel = image[i + di][j + dj];
                        gx += pixel * sobelX[di + 1][dj + 1];
                        gy += pixel * sobelY[di + 1][dj + 1];
                    }
                }
                
                // Calculate magnitude
                int magnitude = (int) Math.sqrt(gx * gx + gy * gy);
                edges[i][j] = Math.min(255, magnitude);
            }
        }
        
        displayImage(edges);
    }
}
```

## ⚠️ Common Pitfalls and Best Practices

### Array Pitfalls and Solutions
```java
public class Array2DPitfalls {
    public static void main(String[] args) {
        demonstrateCommonErrors();
        showBestPractices();
    }
    
    public static void demonstrateCommonErrors() {
        System.out.println("=== Common 2D Array Pitfalls ===");
        
        // Pitfall 1: Confusing row and column indices
        int[][] matrix = {{1, 2, 3}, {4, 5, 6}};
        
        try {
            // WRONG: Assuming square matrix
            System.out.println(matrix[2][1]); // ArrayIndexOutOfBoundsException
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Tried to access non-existent row");
        }
        
        // Pitfall 2: Jagged array assumptions
        int[][] jagged = {{1, 2}, {3, 4, 5, 6}, {7}};
        
        try {
            // WRONG: Assuming all rows have same length
            for (int i = 0; i < jagged.length; i++) {
                for (int j = 0; j < jagged[0].length; j++) { // Bug here!
                    System.out.print(jagged[i][j] + " ");
                }
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Jagged array accessed incorrectly");
        }
        
        // Pitfall 3: Shallow vs Deep copy
        int[][] original = {{1, 2}, {3, 4}};
        int[][] shallowCopy = original; // This is NOT a copy!
        int[][] deepCopy = new int[original.length][];
        
        // Proper deep copy
        for (int i = 0; i < original.length; i++) {
            deepCopy[i] = original[i].clone();
        }
        
        shallowCopy[0][0] = 999;
        System.out.println("Original after shallow copy modification: " + original[0][0]); // 999
        System.out.println("Deep copy value: " + deepCopy[0][0]); // 1
        
        // Pitfall 4: Null pointer exceptions
        int[][] nullArray = null;
        int[][] partiallyNull = new int[3][];
        
        try {
            System.out.println(nullArray.length); // NullPointerException
        } catch (NullPointerException e) {
            System.out.println("Error: Null array access");
        }
        
        try {
            System.out.println(partiallyNull[0].length); // NullPointerException
        } catch (NullPointerException e) {
            System.out.println("Error: Null row access");
        }
    }
    
    public static void showBestPractices() {
        System.out.println("\n=== Best Practices ===");
        
        // Best Practice 1: Always validate bounds
        int[][] matrix = {{1, 2, 3}, {4, 5, 6}};
        
        int row = 1, col = 2;
        if (isValidIndex(matrix, row, col)) {
            System.out.println("Safe access: " + matrix[row][col]);
        }
        
        // Best Practice 2: Handle jagged arrays properly
        int[][] jagged = {{1, 2}, {3, 4, 5, 6}, {7}};
        
        System.out.println("Proper jagged array iteration:");
        for (int i = 0; i < jagged.length; i++) {
            for (int j = 0; j < jagged[i].length; j++) { // Use jagged[i].length
                System.out.print(jagged[i][j] + " ");
            }
            System.out.println();
        }
        
        // Best Practice 3: Null safety
        int[][] possiblyNull = null;
        processMatrixSafely(possiblyNull);
        
        // Best Practice 4: Use enhanced for loops when possible
        System.out.println("Enhanced for loop iteration:");
        for (int[] row : matrix) {
            for (int element : row) {
                System.out.print(element + " ");
            }
            System.out.println();
        }
        
        // Best Practice 5: Proper copying
        int[][] original = {{1, 2, 3}, {4, 5, 6}};
        int[][] copy = deepCopyMatrix(original);
        
        copy[0][0] = 999;
        System.out.println("Original preserved: " + original[0][0]); // Still 1
    }
    
    public static boolean isValidIndex(int[][] matrix, int row, int col) {
        return matrix != null && 
               row >= 0 && row < matrix.length && 
               matrix[row] != null &&
               col >= 0 && col < matrix[row].length;
    }
    
    public static void processMatrixSafely(int[][] matrix) {
        if (matrix == null) {
            System.out.println("Matrix is null, cannot process");
            return;
        }
        
        for (int i = 0; i < matrix.length; i++) {
            if (matrix[i] == null) {
                System.out.println("Row " + i + " is null, skipping");
                continue;
            }
            
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println();
        }
    }
    
    public static int[][] deepCopyMatrix(int[][] original) {
        if (original == null) {
            return null;
        }
        
        int[][] copy = new int[original.length][];
        for (int i = 0; i < original.length; i++) {
            if (original[i] != null) {
                copy[i] = original[i].clone();
            }
        }
        
        return copy;
    }
}
```

## 📋 Summary

- **Two-Dimensional Arrays:** Arrays of arrays that store data in a grid format
- **Declaration and Initialization:** Multiple syntax options including jagged arrays
- **Access Pattern:** Use `array[row][column]` notation for element access
- **Iteration Methods:** Nested loops, enhanced for loops, and various traversal patterns
- **Common Operations:** Matrix mathematics, searching, sorting, and transformations
- **Best Practices:** Validate bounds, handle jagged arrays properly, implement null safety

## 🔗 Related Topics

- [One-Dimensional Arrays](./arrays-1d.md) - Foundation for understanding 2D arrays
- [Loops](./loops.md) - Essential for iterating through 2D arrays
- [Methods](./methods.md) - Passing 2D arrays to methods
- [Exception Handling](./exception-handling.md) - Handling array access errors

## 🎯 Practice Exercises

1. Implement Conway's Game of Life using a 2D boolean array
2. Create a matrix calculator with addition, subtraction, and multiplication
3. Build a Sudoku solver using a 9x9 integer array
4. Implement image rotation and reflection algorithms
5. Create a pathfinding algorithm on a 2D grid (like A* or Dijkstra's algorithm)
