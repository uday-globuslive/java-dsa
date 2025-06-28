# Break and Continue Statements in Java

## 🎯 Overview

The `break` and `continue` statements are powerful control flow tools in Java that allow you to alter the normal execution of loops. These statements provide fine-grained control over loop behavior, enabling you to skip iterations or exit loops prematurely based on specific conditions.

## 📚 Understanding Break Statement

### What is Break?

The `break` statement is used to terminate the execution of a loop or switch statement. When encountered, it immediately exits the current loop and transfers control to the statement following the loop.

### Syntax
```java
break;
```

### Break in Different Loop Types

#### 1. Break in For Loop
```java
public class BreakInForLoop {
    public static void main(String[] args) {
        System.out.println("Numbers from 1 to 10, but stop at 5:");
        
        for (int i = 1; i <= 10; i++) {
            if (i == 5) {
                break; // Exit the loop when i equals 5
            }
            System.out.print(i + " ");
        }
        
        System.out.println("\nLoop terminated!");
    }
}
```

**Output:**
```
Numbers from 1 to 10, but stop at 5:
1 2 3 4 
Loop terminated!
```

#### 2. Break in While Loop
```java
public class BreakInWhileLoop {
    public static void main(String[] args) {
        int count = 0;
        
        while (true) { // Infinite loop
            count++;
            System.out.println("Count: " + count);
            
            if (count == 5) {
                break; // Exit when count reaches 5
            }
        }
        
        System.out.println("While loop terminated!");
    }
}
```

#### 3. Break in Do-While Loop
```java
public class BreakInDoWhileLoop {
    public static void main(String[] args) {
        int number;
        Scanner scanner = new Scanner(System.in);
        
        do {
            System.out.print("Enter a number (0 to exit): ");
            number = scanner.nextInt();
            
            if (number == 0) {
                break; // Exit when user enters 0
            }
            
            System.out.println("You entered: " + number);
        } while (true);
        
        System.out.println("Program terminated!");
        scanner.close();
    }
}
```

## 📚 Understanding Continue Statement

### What is Continue?

The `continue` statement skips the current iteration of a loop and moves to the next iteration. Unlike `break`, it doesn't exit the loop entirely but jumps to the beginning of the loop for the next iteration.

### Syntax
```java
continue;
```

### Continue in Different Loop Types

#### 1. Continue in For Loop
```java
public class ContinueInForLoop {
    public static void main(String[] args) {
        System.out.println("Even numbers from 1 to 10:");
        
        for (int i = 1; i <= 10; i++) {
            if (i % 2 != 0) {
                continue; // Skip odd numbers
            }
            System.out.print(i + " ");
        }
        
        System.out.println("\nDone!");
    }
}
```

**Output:**
```
Even numbers from 1 to 10:
2 4 6 8 10 
Done!
```

#### 2. Continue in While Loop
```java
public class ContinueInWhileLoop {
    public static void main(String[] args) {
        int i = 0;
        
        while (i < 10) {
            i++;
            
            if (i % 3 == 0) {
                continue; // Skip multiples of 3
            }
            
            System.out.print(i + " ");
        }
        
        System.out.println("\nWhile loop completed!");
    }
}
```

## 🔧 Advanced Usage: Nested Loops

### Break in Nested Loops

#### Basic Break (Inner Loop Only)
```java
public class BreakInNestedLoops {
    public static void main(String[] args) {
        System.out.println("Break in nested loops (inner loop only):");
        
        for (int i = 1; i <= 3; i++) {
            System.out.println("Outer loop iteration: " + i);
            
            for (int j = 1; j <= 5; j++) {
                if (j == 3) {
                    break; // Only breaks inner loop
                }
                System.out.print("  Inner: " + j + " ");
            }
            System.out.println(); // New line after inner loop
        }
    }
}
```

#### Labeled Break (Breaking Outer Loop)
```java
public class LabeledBreak {
    public static void main(String[] args) {
        System.out.println("Labeled break example:");
        
        outerLoop: // Label for outer loop
        for (int i = 1; i <= 3; i++) {
            System.out.println("Outer loop iteration: " + i);
            
            for (int j = 1; j <= 5; j++) {
                if (j == 3 && i == 2) {
                    break outerLoop; // Breaks outer loop
                }
                System.out.print("  Inner: " + j + " ");
            }
            System.out.println();
        }
        
        System.out.println("Both loops terminated!");
    }
}
```

### Continue in Nested Loops

#### Basic Continue (Inner Loop Only)
```java
public class ContinueInNestedLoops {
    public static void main(String[] args) {
        System.out.println("Continue in nested loops:");
        
        for (int i = 1; i <= 3; i++) {
            System.out.println("Outer loop iteration: " + i);
            
            for (int j = 1; j <= 5; j++) {
                if (j == 3) {
                    continue; // Skip j=3 in inner loop
                }
                System.out.print("  Inner: " + j + " ");
            }
            System.out.println();
        }
    }
}
```

#### Labeled Continue (Continue Outer Loop)
```java
public class LabeledContinue {
    public static void main(String[] args) {
        System.out.println("Labeled continue example:");
        
        outerLoop: // Label for outer loop
        for (int i = 1; i <= 4; i++) {
            System.out.println("Outer loop iteration: " + i);
            
            for (int j = 1; j <= 3; j++) {
                if (i == 2 && j == 2) {
                    continue outerLoop; // Continue outer loop
                }
                System.out.print("  Inner: " + j + " ");
            }
            System.out.println(" (Inner loop completed)");
        }
    }
}
```

## 💡 Practical Examples

### Example 1: Finding Prime Numbers
```java
public class PrimeNumberFinder {
    public static void main(String[] args) {
        System.out.println("Prime numbers between 2 and 30:");
        
        for (int num = 2; num <= 30; num++) {
            boolean isPrime = true;
            
            // Check if number is prime
            for (int i = 2; i <= Math.sqrt(num); i++) {
                if (num % i == 0) {
                    isPrime = false;
                    break; // No need to check further
                }
            }
            
            if (!isPrime) {
                continue; // Skip non-prime numbers
            }
            
            System.out.print(num + " ");
        }
        System.out.println();
    }
}
```

### Example 2: Menu-Driven Program
```java
import java.util.Scanner;

public class MenuDrivenCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        while (true) {
            System.out.println("\n=== Calculator Menu ===");
            System.out.println("1. Addition");
            System.out.println("2. Subtraction");
            System.out.println("3. Multiplication");
            System.out.println("4. Division");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = scanner.nextInt();
            
            if (choice == 5) {
                break; // Exit the program
            }
            
            if (choice < 1 || choice > 5) {
                System.out.println("Invalid choice! Please try again.");
                continue; // Skip to next iteration
            }
            
            System.out.print("Enter first number: ");
            double num1 = scanner.nextDouble();
            System.out.print("Enter second number: ");
            double num2 = scanner.nextDouble();
            
            double result = 0;
            String operation = "";
            
            switch (choice) {
                case 1:
                    result = num1 + num2;
                    operation = "Addition";
                    break;
                case 2:
                    result = num1 - num2;
                    operation = "Subtraction";
                    break;
                case 3:
                    result = num1 * num2;
                    operation = "Multiplication";
                    break;
                case 4:
                    if (num2 != 0) {
                        result = num1 / num2;
                        operation = "Division";
                    } else {
                        System.out.println("Error: Division by zero!");
                        continue; // Skip result display
                    }
                    break;
            }
            
            System.out.println(operation + " result: " + result);
        }
        
        System.out.println("Calculator terminated. Goodbye!");
        scanner.close();
    }
}
```

### Example 3: Input Validation
```java
import java.util.Scanner;

public class InputValidation {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int validNumber = 0;
        boolean gotValidInput = false;
        
        System.out.println("Enter a number between 1 and 100:");
        
        while (!gotValidInput) {
            System.out.print("Your input: ");
            
            if (!scanner.hasNextInt()) {
                System.out.println("Invalid input! Please enter a number.");
                scanner.next(); // Clear invalid input
                continue; // Ask for input again
            }
            
            int input = scanner.nextInt();
            
            if (input < 1 || input > 100) {
                System.out.println("Number must be between 1 and 100!");
                continue; // Ask for input again
            }
            
            validNumber = input;
            gotValidInput = true;
            break; // Exit the loop with valid input
        }
        
        System.out.println("Valid number entered: " + validNumber);
        scanner.close();
    }
}
```

## ⚠️ Best Practices and Guidelines

### 1. Use Break and Continue Judiciously
- **Good Practice:** Use them to make code more readable and efficient
- **Avoid:** Overusing them as it can make code harder to follow

### 2. Prefer Structured Alternatives When Possible
```java
// Instead of this:
for (int i = 0; i < array.length; i++) {
    if (array[i] < 0) {
        continue;
    }
    // Process positive numbers
    processPositiveNumber(array[i]);
}

// Consider this:
for (int i = 0; i < array.length; i++) {
    if (array[i] >= 0) {
        processPositiveNumber(array[i]);
    }
}
```

### 3. Use Labeled Breaks/Continues Sparingly
- Only use labels when absolutely necessary
- They can make code harder to understand
- Consider refactoring into separate methods instead

### 4. Always Consider Loop Invariants
```java
// Ensure loop variables are properly updated
int i = 0;
while (i < 10) {
    if (someCondition) {
        i++; // Don't forget to update before continue!
        continue;
    }
    // Process
    i++;
}
```

## 🚫 Common Pitfalls and How to Avoid Them

### 1. Infinite Loops with Continue
```java
// WRONG - Creates infinite loop
int i = 0;
while (i < 10) {
    if (i % 2 == 0) {
        continue; // i never gets incremented!
    }
    System.out.println(i);
    i++;
}

// CORRECT
int i = 0;
while (i < 10) {
    if (i % 2 == 0) {
        i++; // Increment before continue
        continue;
    }
    System.out.println(i);
    i++;
}
```

### 2. Misunderstanding Scope of Break
```java
// Break only affects the immediate loop
for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
        if (j == 2) {
            break; // Only breaks inner loop, not outer
        }
        System.out.print(j + " ");
    }
    System.out.println();
}
```

### 3. Using Break in Switch vs Loops
```java
// Break in switch - prevents fall-through
switch (choice) {
    case 1:
        System.out.println("One");
        break; // Prevents executing case 2
    case 2:
        System.out.println("Two");
        break;
}

// Break in loop - exits loop entirely
for (int i = 0; i < 10; i++) {
    if (i == 5) {
        break; // Exits the for loop
    }
}
```

## 🎯 Performance Considerations

### 1. Early Exit for Efficiency
```java
// Efficient: Break when target is found
public static boolean searchArray(int[] arr, int target) {
    for (int i = 0; i < arr.length; i++) {
        if (arr[i] == target) {
            return true; // Early exit - more efficient than break
        }
    }
    return false;
}
```

### 2. Skip Unnecessary Processing
```java
// Efficient: Skip invalid data early
for (int i = 0; i < data.length; i++) {
    if (data[i] == null || data[i].isEmpty()) {
        continue; // Skip processing invalid data
    }
    
    // Expensive operations only on valid data
    processData(data[i]);
}
```

## 📋 Summary

- **Break Statement:** Immediately exits the current loop or switch statement
- **Continue Statement:** Skips the current iteration and continues with the next
- **Labeled Break/Continue:** Can control outer loops in nested structures
- **Best Practices:** Use judiciously, maintain readability, consider alternatives
- **Common Uses:** Input validation, early exit conditions, filtering data

## 🔗 Related Topics

- [Conditional Statements](./conditionals.md) - If-else logic
- [Loops](./loops.md) - For, while, do-while loops
- [Switch Statements](./switch.md) - Multi-way branching
- [Methods](./methods.md) - Using return statements for early exit

## 🎯 Practice Exercises

1. Write a program that finds the first occurrence of a target number in an array
2. Create a program that calculates the sum of positive numbers until a negative number is encountered
3. Implement a number guessing game using break and continue
4. Write a program that prints a multiplication table but skips multiples of 5
5. Create a nested loop pattern printer with user-controlled termination
