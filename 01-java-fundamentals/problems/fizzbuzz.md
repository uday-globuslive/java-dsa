# FizzBuzz Challenge

## 🎯 Problem Statement

Write a program that prints the numbers from 1 to n. But for multiples of 3, print "Fizz" instead of the number, and for multiples of 5, print "Buzz". For numbers which are multiples of both 3 and 5, print "FizzBuzz".

**Example for n = 15:**
```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
```

## 🎓 Learning Objectives

- Practice conditional statements (if-else)
- Understand modulo operator (%) usage
- Learn logical operators and compound conditions
- Master loop structures and control flow
- Practice string output and formatting
- Explore different solution approaches
- Handle edge cases and input validation

## 🛠️ Java Implementation

### Classic FizzBuzz Solution

```java
public class FizzBuzz {
    
    /**
     * Classic FizzBuzz implementation
     * Time Complexity: O(n)
     * Space Complexity: O(1)
     */
    public static void classicFizzBuzz(int n) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            if (i % 3 == 0 && i % 5 == 0) {
                System.out.println("FizzBuzz");
            } else if (i % 3 == 0) {
                System.out.println("Fizz");
            } else if (i % 5 == 0) {
                System.out.println("Buzz");
            } else {
                System.out.println(i);
            }
        }
    }
    
    /**
     * Alternative implementation using 15 (LCM of 3 and 5)
     */
    public static void optimizedFizzBuzz(int n) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {          // Multiple of both 3 and 5
                System.out.println("FizzBuzz");
            } else if (i % 3 == 0) {    // Multiple of 3 only
                System.out.println("Fizz");
            } else if (i % 5 == 0) {    // Multiple of 5 only
                System.out.println("Buzz");
            } else {
                System.out.println(i);
            }
        }
    }
    
    /**
     * String concatenation approach
     */
    public static void stringConcatenationFizzBuzz(int n) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            String output = "";
            
            if (i % 3 == 0) {
                output += "Fizz";
            }
            if (i % 5 == 0) {
                output += "Buzz";
            }
            
            if (output.isEmpty()) {
                output = String.valueOf(i);
            }
            
            System.out.println(output);
        }
    }
    
    /**
     * StringBuilder approach for better performance
     */
    public static void stringBuilderFizzBuzz(int n) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            StringBuilder output = new StringBuilder();
            
            if (i % 3 == 0) {
                output.append("Fizz");
            }
            if (i % 5 == 0) {
                output.append("Buzz");
            }
            
            if (output.length() == 0) {
                output.append(i);
            }
            
            System.out.println(output);
        }
    }
}
```

### Extended FizzBuzz Variations

```java
public class FizzBuzzVariations {
    
    /**
     * Custom FizzBuzz with user-defined divisors and words
     */
    public static void customFizzBuzz(int n, int divisor1, String word1, int divisor2, String word2) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        if (divisor1 <= 0 || divisor2 <= 0) {
            System.out.println("Divisors must be positive");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            StringBuilder output = new StringBuilder();
            
            if (i % divisor1 == 0) {
                output.append(word1);
            }
            if (i % divisor2 == 0) {
                output.append(word2);
            }
            
            if (output.length() == 0) {
                output.append(i);
            }
            
            System.out.println(output);
        }
    }
    
    /**
     * Multi-divisor FizzBuzz with arrays
     */
    public static void multiFizzBuzz(int n, int[] divisors, String[] words) {
        if (n <= 0) {
            System.out.println("Please provide a positive number");
            return;
        }
        
        if (divisors == null || words == null || divisors.length != words.length) {
            System.out.println("Divisors and words arrays must be non-null and same length");
            return;
        }
        
        for (int i = 1; i <= n; i++) {
            StringBuilder output = new StringBuilder();
            
            for (int j = 0; j < divisors.length; j++) {
                if (i % divisors[j] == 0) {
                    output.append(words[j]);
                }
            }
            
            if (output.length() == 0) {
                output.append(i);
            }
            
            System.out.println(output);
        }
    }
    
    /**
     * FizzBuzz with counting statistics
     */
    public static FizzBuzzStats fizzBuzzWithStats(int n) {
        if (n <= 0) {
            return new FizzBuzzStats(0, 0, 0, 0);
        }
        
        int fizzCount = 0;
        int buzzCount = 0;
        int fizzBuzzCount = 0;
        int numberCount = 0;
        
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {
                System.out.println("FizzBuzz");
                fizzBuzzCount++;
            } else if (i % 3 == 0) {
                System.out.println("Fizz");
                fizzCount++;
            } else if (i % 5 == 0) {
                System.out.println("Buzz");
                buzzCount++;
            } else {
                System.out.println(i);
                numberCount++;
            }
        }
        
        return new FizzBuzzStats(fizzCount, buzzCount, fizzBuzzCount, numberCount);
    }
    
    /**
     * Reverse FizzBuzz: given output, find the original number
     */
    public static int reverseFizzBuzz(String[] output) {
        if (output == null || output.length == 0) {
            return 0;
        }
        
        // Find the first number in the output to determine the starting point
        for (int i = 0; i < output.length; i++) {
            try {
                int number = Integer.parseInt(output[i]);
                return number + output.length - 1 - i;
            } catch (NumberFormatException e) {
                // Continue looking for a number
            }
        }
        
        // If no numbers found, estimate based on pattern
        return output.length;
    }
    
    /**
     * FizzBuzz in range
     */
    public static void fizzBuzzRange(int start, int end) {
        if (start > end) {
            System.out.println("Start must be less than or equal to end");
            return;
        }
        
        for (int i = start; i <= end; i++) {
            if (i % 15 == 0) {
                System.out.println("FizzBuzz");
            } else if (i % 3 == 0) {
                System.out.println("Fizz");
            } else if (i % 5 == 0) {
                System.out.println("Buzz");
            } else {
                System.out.println(i);
            }
        }
    }
    
    /**
     * Statistics class for FizzBuzz analysis
     */
    public static class FizzBuzzStats {
        private final int fizzCount;
        private final int buzzCount;
        private final int fizzBuzzCount;
        private final int numberCount;
        
        public FizzBuzzStats(int fizzCount, int buzzCount, int fizzBuzzCount, int numberCount) {
            this.fizzCount = fizzCount;
            this.buzzCount = buzzCount;
            this.fizzBuzzCount = fizzBuzzCount;
            this.numberCount = numberCount;
        }
        
        public void printStats() {
            int total = fizzCount + buzzCount + fizzBuzzCount + numberCount;
            System.out.println("\n=== FizzBuzz Statistics ===");
            System.out.println("Total numbers processed: " + total);
            System.out.println("Fizz count: " + fizzCount);
            System.out.println("Buzz count: " + buzzCount);
            System.out.println("FizzBuzz count: " + fizzBuzzCount);
            System.out.println("Regular numbers: " + numberCount);
            
            if (total > 0) {
                System.out.printf("Fizz percentage: %.2f%%%n", (fizzCount * 100.0) / total);
                System.out.printf("Buzz percentage: %.2f%%%n", (buzzCount * 100.0) / total);
                System.out.printf("FizzBuzz percentage: %.2f%%%n", (fizzBuzzCount * 100.0) / total);
            }
        }
        
        // Getters
        public int getFizzCount() { return fizzCount; }
        public int getBuzzCount() { return buzzCount; }
        public int getFizzBuzzCount() { return fizzBuzzCount; }
        public int getNumberCount() { return numberCount; }
    }
}
```

### Array-Based FizzBuzz Solutions

```java
import java.util.ArrayList;
import java.util.List;

public class FizzBuzzArraySolutions {
    
    /**
     * Returns FizzBuzz output as array of strings
     */
    public static String[] fizzBuzzArray(int n) {
        if (n <= 0) {
            return new String[0];
        }
        
        String[] result = new String[n];
        
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {
                result[i - 1] = "FizzBuzz";
            } else if (i % 3 == 0) {
                result[i - 1] = "Fizz";
            } else if (i % 5 == 0) {
                result[i - 1] = "Buzz";
            } else {
                result[i - 1] = String.valueOf(i);
            }
        }
        
        return result;
    }
    
    /**
     * Returns FizzBuzz output as List
     */
    public static List<String> fizzBuzzList(int n) {
        List<String> result = new ArrayList<>();
        
        if (n <= 0) {
            return result;
        }
        
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {
                result.add("FizzBuzz");
            } else if (i % 3 == 0) {
                result.add("Fizz");
            } else if (i % 5 == 0) {
                result.add("Buzz");
            } else {
                result.add(String.valueOf(i));
            }
        }
        
        return result;
    }
    
    /**
     * FizzBuzz with filtering - returns only Fizz, Buzz, FizzBuzz
     */
    public static List<String> fizzBuzzFilteredList(int n) {
        List<String> result = new ArrayList<>();
        
        if (n <= 0) {
            return result;
        }
        
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {
                result.add("FizzBuzz");
            } else if (i % 3 == 0) {
                result.add("Fizz");
            } else if (i % 5 == 0) {
                result.add("Buzz");
            }
            // Skip regular numbers
        }
        
        return result;
    }
    
    /**
     * FizzBuzz with indices - returns pairs of (index, value)
     */
    public static List<IndexValuePair> fizzBuzzWithIndices(int n) {
        List<IndexValuePair> result = new ArrayList<>();
        
        if (n <= 0) {
            return result;
        }
        
        for (int i = 1; i <= n; i++) {
            String value;
            if (i % 15 == 0) {
                value = "FizzBuzz";
            } else if (i % 3 == 0) {
                value = "Fizz";
            } else if (i % 5 == 0) {
                value = "Buzz";
            } else {
                value = String.valueOf(i);
            }
            
            result.add(new IndexValuePair(i, value));
        }
        
        return result;
    }
    
    /**
     * Helper class for index-value pairs
     */
    public static class IndexValuePair {
        private final int index;
        private final String value;
        
        public IndexValuePair(int index, String value) {
            this.index = index;
            this.value = value;
        }
        
        public int getIndex() { return index; }
        public String getValue() { return value; }
        
        @Override
        public String toString() {
            return "(" + index + ", " + value + ")";
        }
    }
}
```

## 🎮 Interactive FizzBuzz Program

```java
import java.util.Scanner;

public class InteractiveFizzBuzz {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Interactive FizzBuzz Challenge ===");
        
        while (true) {
            System.out.println("\nChoose an option:");
            System.out.println("1. Classic FizzBuzz");
            System.out.println("2. Custom FizzBuzz");
            System.out.println("3. Multi-divisor FizzBuzz");
            System.out.println("4. FizzBuzz with Statistics");
            System.out.println("5. FizzBuzz Range");
            System.out.println("6. Test Your FizzBuzz Knowledge");
            System.out.println("0. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = getIntInput(scanner);
            
            switch (choice) {
                case 0:
                    System.out.println("Thanks for playing FizzBuzz!");
                    scanner.close();
                    return;
                    
                case 1:
                    runClassicFizzBuzz(scanner);
                    break;
                    
                case 2:
                    runCustomFizzBuzz(scanner);
                    break;
                    
                case 3:
                    runMultiFizzBuzz(scanner);
                    break;
                    
                case 4:
                    runFizzBuzzWithStats(scanner);
                    break;
                    
                case 5:
                    runFizzBuzzRange(scanner);
                    break;
                    
                case 6:
                    runFizzBuzzQuiz(scanner);
                    break;
                    
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    
    private static void runClassicFizzBuzz(Scanner scanner) {
        System.out.print("Enter the number to count up to: ");
        int n = getIntInput(scanner);
        
        System.out.println("\nClassic FizzBuzz from 1 to " + n + ":");
        FizzBuzz.classicFizzBuzz(n);
    }
    
    private static void runCustomFizzBuzz(Scanner scanner) {
        System.out.print("Enter the number to count up to: ");
        int n = getIntInput(scanner);
        
        System.out.print("Enter first divisor: ");
        int divisor1 = getIntInput(scanner);
        
        System.out.print("Enter first word: ");
        String word1 = scanner.nextLine();
        
        System.out.print("Enter second divisor: ");
        int divisor2 = getIntInput(scanner);
        
        System.out.print("Enter second word: ");
        String word2 = scanner.nextLine();
        
        System.out.println("\nCustom FizzBuzz:");
        FizzBuzzVariations.customFizzBuzz(n, divisor1, word1, divisor2, word2);
    }
    
    private static void runMultiFizzBuzz(Scanner scanner) {
        System.out.print("Enter the number to count up to: ");
        int n = getIntInput(scanner);
        
        System.out.print("How many divisor-word pairs do you want? ");
        int pairs = getIntInput(scanner);
        
        if (pairs <= 0) {
            System.out.println("Number of pairs must be positive.");
            return;
        }
        
        int[] divisors = new int[pairs];
        String[] words = new String[pairs];
        
        for (int i = 0; i < pairs; i++) {
            System.out.print("Enter divisor " + (i + 1) + ": ");
            divisors[i] = getIntInput(scanner);
            
            System.out.print("Enter word " + (i + 1) + ": ");
            words[i] = scanner.nextLine();
        }
        
        System.out.println("\nMulti-divisor FizzBuzz:");
        FizzBuzzVariations.multiFizzBuzz(n, divisors, words);
    }
    
    private static void runFizzBuzzWithStats(Scanner scanner) {
        System.out.print("Enter the number to count up to: ");
        int n = getIntInput(scanner);
        
        System.out.println("\nFizzBuzz with Statistics:");
        FizzBuzzVariations.FizzBuzzStats stats = FizzBuzzVariations.fizzBuzzWithStats(n);
        stats.printStats();
    }
    
    private static void runFizzBuzzRange(Scanner scanner) {
        System.out.print("Enter start number: ");
        int start = getIntInput(scanner);
        
        System.out.print("Enter end number: ");
        int end = getIntInput(scanner);
        
        System.out.println("\nFizzBuzz from " + start + " to " + end + ":");
        FizzBuzzVariations.fizzBuzzRange(start, end);
    }
    
    private static void runFizzBuzzQuiz(Scanner scanner) {
        System.out.println("\n=== FizzBuzz Knowledge Quiz ===");
        
        int[] testNumbers = {9, 10, 15, 21, 25, 30};
        int correct = 0;
        
        for (int number : testNumbers) {
            System.out.printf("What should be output for number %d? ", number);
            String userAnswer = scanner.nextLine().trim();
            String correctAnswer = getFizzBuzzValue(number);
            
            if (userAnswer.equals(correctAnswer)) {
                System.out.println("Correct!");
                correct++;
            } else {
                System.out.println("Wrong! Correct answer is: " + correctAnswer);
            }
        }
        
        System.out.printf("\nYou got %d out of %d correct!%n", correct, testNumbers.length);
        
        double percentage = (correct * 100.0) / testNumbers.length;
        if (percentage >= 80) {
            System.out.println("Excellent! You're a FizzBuzz master!");
        } else if (percentage >= 60) {
            System.out.println("Good job! Keep practicing!");
        } else {
            System.out.println("Keep studying the FizzBuzz rules!");
        }
    }
    
    private static String getFizzBuzzValue(int number) {
        if (number % 15 == 0) {
            return "FizzBuzz";
        } else if (number % 3 == 0) {
            return "Fizz";
        } else if (number % 5 == 0) {
            return "Buzz";
        } else {
            return String.valueOf(number);
        }
    }
    
    private static int getIntInput(Scanner scanner) {
        while (true) {
            try {
                int value = Integer.parseInt(scanner.nextLine().trim());
                return value;
            } catch (NumberFormatException e) {
                System.out.print("Please enter a valid integer: ");
            }
        }
    }
}
```

## 🧪 Comprehensive Testing

```java
public class FizzBuzzTester {
    
    public static void main(String[] args) {
        testBasicFunctionality();
        testEdgeCases();
        testVariations();
        testArraySolutions();
        performanceTest();
    }
    
    private static void testBasicFunctionality() {
        System.out.println("=== Testing Basic Functionality ===");
        
        System.out.println("FizzBuzz for n=15:");
        FizzBuzz.classicFizzBuzz(15);
        
        System.out.println("\nFizzBuzz for n=20 (StringBuilder approach):");
        FizzBuzz.stringBuilderFizzBuzz(20);
    }
    
    private static void testEdgeCases() {
        System.out.println("\n=== Testing Edge Cases ===");
        
        System.out.println("FizzBuzz for n=0:");
        FizzBuzz.classicFizzBuzz(0);
        
        System.out.println("FizzBuzz for n=-5:");
        FizzBuzz.classicFizzBuzz(-5);
        
        System.out.println("FizzBuzz for n=1:");
        FizzBuzz.classicFizzBuzz(1);
    }
    
    private static void testVariations() {
        System.out.println("\n=== Testing Variations ===");
        
        System.out.println("Custom FizzBuzz (divisors: 2, 7; words: 'Foo', 'Bar'):");
        FizzBuzzVariations.customFizzBuzz(14, 2, "Foo", 7, "Bar");
        
        System.out.println("\nMulti-divisor FizzBuzz:");
        int[] divisors = {2, 3, 5};
        String[] words = {"Two", "Three", "Five"};
        FizzBuzzVariations.multiFizzBuzz(10, divisors, words);
        
        System.out.println("\nFizzBuzz Range (5 to 15):");
        FizzBuzzVariations.fizzBuzzRange(5, 15);
    }
    
    private static void testArraySolutions() {
        System.out.println("\n=== Testing Array Solutions ===");
        
        String[] result = FizzBuzzArraySolutions.fizzBuzzArray(10);
        System.out.println("Array result: " + java.util.Arrays.toString(result));
        
        java.util.List<String> listResult = FizzBuzzArraySolutions.fizzBuzzList(10);
        System.out.println("List result: " + listResult);
        
        java.util.List<String> filteredResult = FizzBuzzArraySolutions.fizzBuzzFilteredList(15);
        System.out.println("Filtered result (only Fizz/Buzz/FizzBuzz): " + filteredResult);
    }
    
    private static void performanceTest() {
        System.out.println("\n=== Performance Test ===");
        
        int n = 1000000;
        
        // Test classic approach
        long startTime = System.currentTimeMillis();
        String[] classicResult = new String[n];
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) {
                classicResult[i - 1] = "FizzBuzz";
            } else if (i % 3 == 0) {
                classicResult[i - 1] = "Fizz";
            } else if (i % 5 == 0) {
                classicResult[i - 1] = "Buzz";
            } else {
                classicResult[i - 1] = String.valueOf(i);
            }
        }
        long classicTime = System.currentTimeMillis() - startTime;
        
        // Test StringBuilder approach
        startTime = System.currentTimeMillis();
        String[] stringBuilderResult = new String[n];
        for (int i = 1; i <= n; i++) {
            StringBuilder sb = new StringBuilder();
            if (i % 3 == 0) sb.append("Fizz");
            if (i % 5 == 0) sb.append("Buzz");
            if (sb.length() == 0) sb.append(i);
            stringBuilderResult[i - 1] = sb.toString();
        }
        long stringBuilderTime = System.currentTimeMillis() - startTime;
        
        System.out.printf("Classic approach: %d ms%n", classicTime);
        System.out.printf("StringBuilder approach: %d ms%n", stringBuilderTime);
        System.out.printf("Performance difference: %.2fx%n", 
                         (double) Math.max(classicTime, stringBuilderTime) / 
                         Math.min(classicTime, stringBuilderTime));
    }
}
```

## 🎯 Challenge Variations

### 1. Mathematical Pattern Analysis
```java
public static void analyzeFizzBuzzPattern(int n) {
    System.out.println("=== FizzBuzz Pattern Analysis ===");
    System.out.printf("For n=%d:%n", n);
    System.out.printf("Multiples of 3: %d%n", n / 3);
    System.out.printf("Multiples of 5: %d%n", n / 5);
    System.out.printf("Multiples of 15: %d%n", n / 15);
    System.out.printf("Regular numbers: %d%n", n - (n/3) - (n/5) + (n/15));
}
```

### 2. Reverse Engineering
```java
public static boolean validateFizzBuzzSequence(String[] sequence) {
    for (int i = 0; i < sequence.length; i++) {
        int number = i + 1;
        String expected = getFizzBuzzValue(number);
        if (!sequence[i].equals(expected)) {
            return false;
        }
    }
    return true;
}
```

### 3. Memory Optimization
```java
public static void memoryEfficientFizzBuzz(int n) {
    // Don't store results, just compute and print
    for (int i = 1; i <= n; i++) {
        boolean fizz = (i % 3 == 0);
        boolean buzz = (i % 5 == 0);
        
        if (fizz) System.out.print("Fizz");
        if (buzz) System.out.print("Buzz");
        if (!fizz && !buzz) System.out.print(i);
        
        System.out.println();
    }
}
```

## ⚠️ Common Pitfalls and Solutions

### 1. Wrong Order of Conditions
```java
// WRONG: FizzBuzz will never be reached
if (i % 3 == 0) {
    System.out.println("Fizz");
} else if (i % 5 == 0) {
    System.out.println("Buzz");
} else if (i % 15 == 0) {  // This is unreachable!
    System.out.println("FizzBuzz");
}

// CORRECT: Check compound condition first
if (i % 15 == 0) {
    System.out.println("FizzBuzz");
} else if (i % 3 == 0) {
    System.out.println("Fizz");
} else if (i % 5 == 0) {
    System.out.println("Buzz");
}
```

### 2. Off-by-One Errors
```java
// WRONG: Starts from 0
for (int i = 0; i < n; i++) {

// CORRECT: Starts from 1
for (int i = 1; i <= n; i++) {
```

### 3. Integer Division Issues
```java
// Be careful with large numbers
// For very large n, consider using long instead of int
```

## 📊 Complexity Analysis

- **Time Complexity**: O(n) - We process each number once
- **Space Complexity**: 
  - Printing approach: O(1)
  - Array storage: O(n)
- **Mathematical Properties**:
  - Numbers divisible by 3: ⌊n/3⌋
  - Numbers divisible by 5: ⌊n/5⌋
  - Numbers divisible by 15: ⌊n/15⌋

## 🔗 Related Concepts

- Modulo arithmetic
- Conditional logic
- Loop structures
- String manipulation
- Mathematical patterns
- Algorithm optimization
- Code readability vs performance

FizzBuzz is an excellent stepping stone to more complex programming challenges and helps solidify fundamental programming concepts!
