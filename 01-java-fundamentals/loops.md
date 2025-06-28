# Loops (for, while, do-while)

## Overview
Loops are fundamental control structures that allow you to execute a block of code repeatedly based on a condition. Java provides several types of loops, each suited for different scenarios. Understanding when and how to use each type is crucial for writing efficient and readable code.

## For Loops

### Basic For Loop
The traditional for loop is ideal when you know the number of iterations in advance.

```java
public class BasicForLoop {
    public static void main(String[] args) {
        // Basic for loop structure: for(initialization; condition; update)
        System.out.println("=== Basic For Loop Examples ===");
        
        // Counting from 1 to 10
        System.out.println("Counting 1 to 10:");
        for (int i = 1; i <= 10; i++) {
            System.out.print(i + " ");
        }
        System.out.println();
        
        // Counting backwards
        System.out.println("Counting backwards 10 to 1:");
        for (int i = 10; i >= 1; i--) {
            System.out.print(i + " ");
        }
        System.out.println();
        
        // Counting by 2s
        System.out.println("Even numbers 0 to 20:");
        for (int i = 0; i <= 20; i += 2) {
            System.out.print(i + " ");
        }
        System.out.println();
        
        // Multiple variables in for loop
        System.out.println("Multiple variables:");
        for (int i = 0, j = 10; i < 5; i++, j--) {
            System.out.println("i=" + i + ", j=" + j);
        }
        
        // Different data types
        System.out.println("Character loop:");
        for (char c = 'A'; c <= 'Z'; c++) {
            System.out.print(c + " ");
            if ((c - 'A' + 1) % 5 == 0) { // New line every 5 characters
                System.out.println();
            }
        }
    }
}
```

### Enhanced For Loop (For-Each)
The enhanced for loop simplifies iteration over arrays and collections.

```java
public class EnhancedForLoop {
    public static void main(String[] args) {
        System.out.println("=== Enhanced For Loop (For-Each) ===");
        
        // Array iteration
        int[] numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        
        System.out.println("Array elements:");
        for (int number : numbers) {
            System.out.print(number + " ");
        }
        System.out.println();
        
        // String array iteration
        String[] colors = {"Red", "Green", "Blue", "Yellow", "Purple"};
        
        System.out.println("Colors:");
        for (String color : colors) {
            System.out.println("- " + color);
        }
        
        // Character array (from string)
        String word = "JAVA";
        System.out.println("Letters in '" + word + "':");
        for (char letter : word.toCharArray()) {
            System.out.println("Letter: " + letter + " (ASCII: " + (int)letter + ")");
        }
        
        // Nested enhanced for loops
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        System.out.println("Matrix elements:");
        for (int[] row : matrix) {
            for (int element : row) {
                System.out.print(element + " ");
            }
            System.out.println();
        }
        
        // Limitations of enhanced for loop
        System.out.println("Demonstrating limitations:");
        int[] values = {10, 20, 30, 40, 50};
        
        // Cannot modify array elements (this won't change the original array)
        System.out.println("Original array:");
        for (int value : values) {
            System.out.print(value + " ");
        }
        System.out.println();
        
        // Attempting to modify (doesn't work)
        for (int value : values) {
            value = value * 2; // This changes the local copy, not the array
        }
        
        System.out.println("Array after 'modification' attempt:");
        for (int value : values) {
            System.out.print(value + " ");
        }
        System.out.println("(No change - enhanced for loop can't modify array elements)");
        
        // Correct way to modify array elements
        System.out.println("Correct modification using traditional for loop:");
        for (int i = 0; i < values.length; i++) {
            values[i] = values[i] * 2;
        }
        
        for (int value : values) {
            System.out.print(value + " ");
        }
        System.out.println();
    }
}
```

### Advanced For Loop Patterns
```java
public class AdvancedForLoops {
    public static void main(String[] args) {
        System.out.println("=== Advanced For Loop Patterns ===");
        
        // Infinite for loop (use with caution)
        System.out.println("Controlled infinite loop:");
        for (;;) { // No initialization, condition, or update
            System.out.println("This could run forever...");
            break; // Exit immediately for safety
        }
        
        // Complex conditions
        System.out.println("Complex condition example:");
        for (int i = 1, sum = 0; sum < 100; i++) {
            sum += i;
            System.out.println("i=" + i + ", sum=" + sum);
        }
        
        // Nested for loops - multiplication table
        System.out.println("Multiplication table (1-5):");
        for (int i = 1; i <= 5; i++) {
            for (int j = 1; j <= 5; j++) {
                System.out.printf("%3d", i * j);
            }
            System.out.println();
        }
        
        // Pattern printing
        System.out.println("Triangle pattern:");
        for (int i = 1; i <= 5; i++) {
            // Print spaces
            for (int j = 5; j > i; j--) {
                System.out.print(" ");
            }
            // Print stars
            for (int k = 1; k <= i; k++) {
                System.out.print("* ");
            }
            System.out.println();
        }
        
        // Prime number finder
        System.out.println("Prime numbers up to 30:");
        for (int num = 2; num <= 30; num++) {
            boolean isPrime = true;
            
            // Check if num is prime
            for (int divisor = 2; divisor <= Math.sqrt(num); divisor++) {
                if (num % divisor == 0) {
                    isPrime = false;
                    break; // Exit inner loop early
                }
            }
            
            if (isPrime) {
                System.out.print(num + " ");
            }
        }
        System.out.println();
    }
}
```

## While Loops

### Basic While Loop
While loops are ideal when you don't know the exact number of iterations beforehand.

```java
import java.util.Scanner;
import java.util.Random;

public class BasicWhileLoop {
    public static void main(String[] args) {
        System.out.println("=== Basic While Loop Examples ===");
        
        // Simple counting
        System.out.println("Counting with while loop:");
        int count = 1;
        while (count <= 5) {
            System.out.println("Count: " + count);
            count++;
        }
        
        // Sum calculation
        System.out.println("Sum of numbers 1 to 10:");
        int number = 1;
        int sum = 0;
        while (number <= 10) {
            sum += number;
            number++;
        }
        System.out.println("Sum: " + sum);
        
        // Factorial calculation
        System.out.println("Factorial of 5:");
        int n = 5;
        int factorial = 1;
        int i = 1;
        while (i <= n) {
            factorial *= i;
            i++;
        }
        System.out.println("5! = " + factorial);
        
        // Finding digits in a number
        int testNumber = 12345;
        int tempNumber = testNumber;
        int digitCount = 0;
        
        System.out.println("Counting digits in " + testNumber + ":");
        while (tempNumber > 0) {
            int digit = tempNumber % 10;
            System.out.println("Digit: " + digit);
            tempNumber /= 10;
            digitCount++;
        }
        System.out.println("Total digits: " + digitCount);
        
        // Reverse a number
        int originalNumber = 12345;
        int reversedNumber = 0;
        tempNumber = originalNumber;
        
        System.out.println("Reversing " + originalNumber + ":");
        while (tempNumber > 0) {
            int digit = tempNumber % 10;
            reversedNumber = reversedNumber * 10 + digit;
            tempNumber /= 10;
        }
        System.out.println("Reversed: " + reversedNumber);
    }
}
```

### Interactive While Loops
```java
import java.util.Scanner;

public class InteractiveWhileLoops {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Menu-driven program
        System.out.println("=== Calculator Menu ===");
        boolean continueProgram = true;
        
        while (continueProgram) {
            System.out.println("\nChoose an operation:");
            System.out.println("1. Addition");
            System.out.println("2. Subtraction");
            System.out.println("3. Multiplication");
            System.out.println("4. Division");
            System.out.println("5. Exit");
            System.out.print("Enter your choice (1-5): ");
            
            if (scanner.hasNextInt()) {
                int choice = scanner.nextInt();
                
                if (choice >= 1 && choice <= 4) {
                    System.out.print("Enter first number: ");
                    double num1 = scanner.nextDouble();
                    System.out.print("Enter second number: ");
                    double num2 = scanner.nextDouble();
                    
                    double result = 0;
                    String operation = "";
                    boolean validOperation = true;
                    
                    switch (choice) {
                        case 1:
                            result = num1 + num2;
                            operation = "+";
                            break;
                        case 2:
                            result = num1 - num2;
                            operation = "-";
                            break;
                        case 3:
                            result = num1 * num2;
                            operation = "*";
                            break;
                        case 4:
                            if (num2 != 0) {
                                result = num1 / num2;
                                operation = "/";
                            } else {
                                System.out.println("Error: Division by zero!");
                                validOperation = false;
                            }
                            break;
                    }
                    
                    if (validOperation) {
                        System.out.printf("%.2f %s %.2f = %.2f\n", num1, operation, num2, result);
                    }
                    
                } else if (choice == 5) {
                    continueProgram = false;
                    System.out.println("Thank you for using the calculator!");
                } else {
                    System.out.println("Invalid choice. Please enter 1-5.");
                }
            } else {
                System.out.println("Invalid input. Please enter a number.");
                scanner.next(); // Clear invalid input
            }
        }
        
        // Password validation loop
        System.out.println("\n=== Password Validation ===");
        String correctPassword = "java123";
        int maxAttempts = 3;
        int attempts = 0;
        boolean authenticated = false;
        
        while (attempts < maxAttempts && !authenticated) {
            System.out.print("Enter password: ");
            String password = scanner.next();
            attempts++;
            
            if (password.equals(correctPassword)) {
                authenticated = true;
                System.out.println("Access granted!");
            } else {
                int remainingAttempts = maxAttempts - attempts;
                if (remainingAttempts > 0) {
                    System.out.println("Incorrect password. " + remainingAttempts + " attempts remaining.");
                } else {
                    System.out.println("Access denied. Maximum attempts exceeded.");
                }
            }
        }
        
        // Number guessing game
        System.out.println("\n=== Number Guessing Game ===");
        Random random = new Random();
        int targetNumber = random.nextInt(100) + 1;
        int guessCount = 0;
        boolean hasWon = false;
        
        System.out.println("I'm thinking of a number between 1 and 100.");
        
        while (!hasWon) {
            System.out.print("Enter your guess: ");
            
            if (scanner.hasNextInt()) {
                int guess = scanner.nextInt();
                guessCount++;
                
                if (guess == targetNumber) {
                    hasWon = true;
                    System.out.println("Congratulations! You guessed it in " + guessCount + " attempts!");
                } else if (guess < targetNumber) {
                    System.out.println("Too low! Try again.");
                } else {
                    System.out.println("Too high! Try again.");
                }
            } else {
                System.out.println("Please enter a valid number.");
                scanner.next(); // Clear invalid input
            }
        }
        
        scanner.close();
    }
}
```

## Do-While Loops

### Basic Do-While Loop
Do-while loops guarantee that the code block executes at least once, as the condition is checked after execution.

```java
import java.util.Scanner;

public class BasicDoWhileLoop {
    public static void main(String[] args) {
        System.out.println("=== Basic Do-While Loop Examples ===");
        
        // Basic structure demonstration
        System.out.println("Do-while vs while comparison:");
        
        int whileCounter = 5;
        System.out.println("While loop with counter starting at 5:");
        while (whileCounter < 5) {
            System.out.println("This won't execute");
            whileCounter++;
        }
        System.out.println("While loop completed (no output expected)");
        
        int doWhileCounter = 5;
        System.out.println("Do-while loop with counter starting at 5:");
        do {
            System.out.println("This executes at least once: " + doWhileCounter);
            doWhileCounter++;
        } while (doWhileCounter < 5);
        System.out.println("Do-while loop completed");
        
        // Practical example: input validation
        Scanner scanner = new Scanner(System.in);
        
        int age;
        do {
            System.out.print("Enter your age (must be between 1 and 120): ");
            while (!scanner.hasNextInt()) {
                System.out.print("Invalid input. Please enter a number: ");
                scanner.next(); // Clear invalid input
            }
            age = scanner.nextInt();
            
            if (age < 1 || age > 120) {
                System.out.println("Age must be between 1 and 120. Please try again.");
            }
        } while (age < 1 || age > 120);
        
        System.out.println("Valid age entered: " + age);
        
        // Menu system with do-while
        char choice;
        do {
            System.out.println("\n=== Simple Menu ===");
            System.out.println("A. Display message");
            System.out.println("B. Calculate square");
            System.out.println("C. Show current time");
            System.out.println("Q. Quit");
            System.out.print("Enter your choice: ");
            
            choice = scanner.next().toUpperCase().charAt(0);
            
            switch (choice) {
                case 'A':
                    System.out.println("Hello from the menu system!");
                    break;
                case 'B':
                    System.out.print("Enter a number to square: ");
                    if (scanner.hasNextDouble()) {
                        double number = scanner.nextDouble();
                        System.out.println(number + " squared is " + (number * number));
                    } else {
                        System.out.println("Invalid number.");
                        scanner.next(); // Clear invalid input
                    }
                    break;
                case 'C':
                    System.out.println("Current time: " + new java.util.Date());
                    break;
                case 'Q':
                    System.out.println("Goodbye!");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        } while (choice != 'Q');
        
        scanner.close();
    }
}
```

### Advanced Do-While Patterns
```java
import java.util.Scanner;
import java.util.Random;

public class AdvancedDoWhilePatterns {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();
        
        // Dice rolling simulator
        System.out.println("=== Dice Rolling Simulator ===");
        String rollAgain;
        int rollCount = 0;
        int totalSum = 0;
        
        do {
            int die1 = random.nextInt(6) + 1;
            int die2 = random.nextInt(6) + 1;
            int sum = die1 + die2;
            
            rollCount++;
            totalSum += sum;
            
            System.out.println("Roll " + rollCount + ": Die 1 = " + die1 + ", Die 2 = " + die2 + ", Sum = " + sum);
            
            // Special combinations
            if (die1 == die2) {
                System.out.println("  Double " + die1 + "s!");
            }
            if (sum == 7) {
                System.out.println("  Lucky seven!");
            }
            if (sum == 2 || sum == 12) {
                System.out.println("  Snake eyes or boxcars!");
            }
            
            System.out.print("Roll again? (y/n): ");
            rollAgain = scanner.next().toLowerCase();
            
        } while (rollAgain.equals("y") || rollAgain.equals("yes"));
        
        if (rollCount > 0) {
            double average = (double) totalSum / rollCount;
            System.out.printf("Statistics: %d rolls, total sum: %d, average: %.2f\n", 
                            rollCount, totalSum, average);
        }
        
        // Bank account simulation
        System.out.println("\n=== Simple Bank Account ===");
        double balance = 1000.00;
        String transaction;
        
        do {
            System.out.printf("Current balance: $%.2f\n", balance);
            System.out.println("D - Deposit");
            System.out.println("W - Withdraw");
            System.out.println("B - Check Balance");
            System.out.println("Q - Quit");
            System.out.print("Choose transaction: ");
            
            transaction = scanner.next().toUpperCase();
            
            switch (transaction) {
                case "D":
                    System.out.print("Enter deposit amount: $");
                    if (scanner.hasNextDouble()) {
                        double deposit = scanner.nextDouble();
                        if (deposit > 0) {
                            balance += deposit;
                            System.out.printf("Deposited $%.2f. New balance: $%.2f\n", deposit, balance);
                        } else {
                            System.out.println("Deposit amount must be positive.");
                        }
                    } else {
                        System.out.println("Invalid amount.");
                        scanner.next();
                    }
                    break;
                    
                case "W":
                    System.out.print("Enter withdrawal amount: $");
                    if (scanner.hasNextDouble()) {
                        double withdrawal = scanner.nextDouble();
                        if (withdrawal > 0) {
                            if (withdrawal <= balance) {
                                balance -= withdrawal;
                                System.out.printf("Withdrew $%.2f. New balance: $%.2f\n", withdrawal, balance);
                            } else {
                                System.out.println("Insufficient funds. Cannot withdraw more than current balance.");
                            }
                        } else {
                            System.out.println("Withdrawal amount must be positive.");
                        }
                    } else {
                        System.out.println("Invalid amount.");
                        scanner.next();
                    }
                    break;
                    
                case "B":
                    System.out.printf("Current balance: $%.2f\n", balance);
                    break;
                    
                case "Q":
                    System.out.println("Thank you for banking with us!");
                    break;
                    
                default:
                    System.out.println("Invalid transaction. Please try again.");
            }
            
        } while (!transaction.equals("Q"));
        
        scanner.close();
    }
}
```

## Loop Control Statements

### Break and Continue
```java
public class LoopControlStatements {
    public static void main(String[] args) {
        System.out.println("=== Break Statement Examples ===");
        
        // Break in for loop
        System.out.println("Find first number divisible by 7:");
        for (int i = 1; i <= 100; i++) {
            if (i % 7 == 0) {
                System.out.println("Found: " + i);
                break; // Exit the loop immediately
            }
        }
        
        // Break in while loop
        System.out.println("Break in while loop:");
        int count = 0;
        while (true) { // Infinite loop
            count++;
            System.out.println("Count: " + count);
            
            if (count >= 5) {
                System.out.println("Breaking out of loop");
                break;
            }
        }
        
        // Labeled break (for nested loops)
        System.out.println("Labeled break in nested loops:");
        outerLoop: // Label for outer loop
        for (int i = 1; i <= 3; i++) {
            for (int j = 1; j <= 3; j++) {
                System.out.println("i=" + i + ", j=" + j);
                if (i == 2 && j == 2) {
                    System.out.println("Breaking out of both loops");
                    break outerLoop; // Break out of outer loop
                }
            }
        }
        
        System.out.println("\n=== Continue Statement Examples ===");
        
        // Continue in for loop
        System.out.println("Odd numbers from 1 to 10:");
        for (int i = 1; i <= 10; i++) {
            if (i % 2 == 0) {
                continue; // Skip even numbers
            }
            System.out.print(i + " ");
        }
        System.out.println();
        
        // Continue in while loop
        System.out.println("Numbers 1-10 except multiples of 3:");
        int number = 0;
        while (number < 10) {
            number++;
            if (number % 3 == 0) {
                continue; // Skip multiples of 3
            }
            System.out.print(number + " ");
        }
        System.out.println();
        
        // Labeled continue
        System.out.println("Labeled continue example:");
        outerLoop2:
        for (int i = 1; i <= 3; i++) {
            System.out.println("Outer loop i = " + i);
            for (int j = 1; j <= 3; j++) {
                if (j == 2) {
                    System.out.println("  Continuing outer loop");
                    continue outerLoop2; // Continue with next iteration of outer loop
                }
                System.out.println("  Inner loop j = " + j);
            }
        }
    }
}
```

## Practical Loop Applications

### Array Processing with Loops
```java
public class ArrayLoopProcessing {
    public static void main(String[] args) {
        System.out.println("=== Array Processing with Loops ===");
        
        int[] numbers = {45, 23, 67, 12, 89, 34, 56, 78, 90, 11};
        
        // Find maximum and minimum
        int max = numbers[0];
        int min = numbers[0];
        int maxIndex = 0;
        int minIndex = 0;
        
        for (int i = 1; i < numbers.length; i++) {
            if (numbers[i] > max) {
                max = numbers[i];
                maxIndex = i;
            }
            if (numbers[i] < min) {
                min = numbers[i];
                minIndex = i;
            }
        }
        
        System.out.println("Array: " + java.util.Arrays.toString(numbers));
        System.out.println("Maximum: " + max + " at index " + maxIndex);
        System.out.println("Minimum: " + min + " at index " + minIndex);
        
        // Calculate sum and average
        int sum = 0;
        for (int number : numbers) {
            sum += number;
        }
        double average = (double) sum / numbers.length;
        System.out.println("Sum: " + sum);
        System.out.printf("Average: %.2f\n", average);
        
        // Count elements above average
        int aboveAverage = 0;
        for (int number : numbers) {
            if (number > average) {
                aboveAverage++;
            }
        }
        System.out.println("Elements above average: " + aboveAverage);
        
        // Bubble sort implementation
        int[] sortArray = numbers.clone(); // Create a copy
        System.out.println("Original array: " + java.util.Arrays.toString(sortArray));
        
        for (int i = 0; i < sortArray.length - 1; i++) {
            for (int j = 0; j < sortArray.length - i - 1; j++) {
                if (sortArray[j] > sortArray[j + 1]) {
                    // Swap elements
                    int temp = sortArray[j];
                    sortArray[j] = sortArray[j + 1];
                    sortArray[j + 1] = temp;
                }
            }
        }
        System.out.println("Sorted array: " + java.util.Arrays.toString(sortArray));
        
        // Search for element
        int searchTarget = 67;
        int foundIndex = -1;
        
        for (int i = 0; i < numbers.length; i++) {
            if (numbers[i] == searchTarget) {
                foundIndex = i;
                break; // Stop searching once found
            }
        }
        
        if (foundIndex != -1) {
            System.out.println("Found " + searchTarget + " at index " + foundIndex);
        } else {
            System.out.println(searchTarget + " not found in array");
        }
    }
}
```

### String Processing with Loops
```java
public class StringLoopProcessing {
    public static void main(String[] args) {
        System.out.println("=== String Processing with Loops ===");
        
        String text = "Hello World! This is Java Programming.";
        System.out.println("Original text: " + text);
        
        // Count characters, vowels, consonants, spaces
        int charCount = 0;
        int vowelCount = 0;
        int consonantCount = 0;
        int spaceCount = 0;
        int digitCount = 0;
        int specialCharCount = 0;
        
        String vowels = "aeiouAEIOU";
        
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            charCount++;
            
            if (Character.isLetter(ch)) {
                if (vowels.indexOf(ch) != -1) {
                    vowelCount++;
                } else {
                    consonantCount++;
                }
            } else if (Character.isWhitespace(ch)) {
                spaceCount++;
            } else if (Character.isDigit(ch)) {
                digitCount++;
            } else {
                specialCharCount++;
            }
        }
        
        System.out.println("Character analysis:");
        System.out.println("Total characters: " + charCount);
        System.out.println("Vowels: " + vowelCount);
        System.out.println("Consonants: " + consonantCount);
        System.out.println("Spaces: " + spaceCount);
        System.out.println("Digits: " + digitCount);
        System.out.println("Special characters: " + specialCharCount);
        
        // Reverse string
        String reversed = "";
        for (int i = text.length() - 1; i >= 0; i--) {
            reversed += text.charAt(i);
        }
        System.out.println("Reversed: " + reversed);
        
        // Check if palindrome (ignoring case and spaces)
        String cleanText = "";
        for (int i = 0; i < text.length(); i++) {
            char ch = text.charAt(i);
            if (Character.isLetterOrDigit(ch)) {
                cleanText += Character.toLowerCase(ch);
            }
        }
        
        boolean isPalindrome = true;
        for (int i = 0; i < cleanText.length() / 2; i++) {
            if (cleanText.charAt(i) != cleanText.charAt(cleanText.length() - 1 - i)) {
                isPalindrome = false;
                break;
            }
        }
        
        System.out.println("Clean text: " + cleanText);
        System.out.println("Is palindrome: " + isPalindrome);
        
        // Word count
        String[] words = text.split("\\s+");
        System.out.println("Word count: " + words.length);
        
        // Find longest word
        String longestWord = "";
        for (String word : words) {
            // Remove punctuation
            String cleanWord = word.replaceAll("[^a-zA-Z]", "");
            if (cleanWord.length() > longestWord.length()) {
                longestWord = cleanWord;
            }
        }
        System.out.println("Longest word: " + longestWord + " (" + longestWord.length() + " letters)");
        
        // Character frequency
        System.out.println("Character frequency (letters only):");
        for (char c = 'A'; c <= 'Z'; c++) {
            int frequency = 0;
            for (int i = 0; i < text.length(); i++) {
                if (Character.toUpperCase(text.charAt(i)) == c) {
                    frequency++;
                }
            }
            if (frequency > 0) {
                System.out.println(c + ": " + frequency);
            }
        }
    }
}
```

### Mathematical Computations with Loops
```java
public class MathematicalLoops {
    public static void main(String[] args) {
        System.out.println("=== Mathematical Computations with Loops ===");
        
        // Fibonacci sequence
        System.out.println("Fibonacci sequence (first 15 terms):");
        int n = 15;
        long first = 0, second = 1;
        
        if (n >= 1) System.out.print(first + " ");
        if (n >= 2) System.out.print(second + " ");
        
        for (int i = 3; i <= n; i++) {
            long next = first + second;
            System.out.print(next + " ");
            first = second;
            second = next;
        }
        System.out.println();
        
        // Prime numbers using Sieve of Eratosthenes
        System.out.println("Prime numbers up to 50:");
        int limit = 50;
        boolean[] isPrime = new boolean[limit + 1];
        
        // Initialize all numbers as prime
        for (int i = 2; i <= limit; i++) {
            isPrime[i] = true;
        }
        
        // Sieve algorithm
        for (int i = 2; i * i <= limit; i++) {
            if (isPrime[i]) {
                // Mark multiples as composite
                for (int j = i * i; j <= limit; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        
        // Print prime numbers
        for (int i = 2; i <= limit; i++) {
            if (isPrime[i]) {
                System.out.print(i + " ");
            }
        }
        System.out.println();
        
        // Calculate pi using Monte Carlo method
        System.out.println("Estimating π using Monte Carlo method:");
        int totalPoints = 1000000;
        int pointsInCircle = 0;
        
        java.util.Random random = new java.util.Random();
        
        for (int i = 0; i < totalPoints; i++) {
            double x = random.nextDouble();
            double y = random.nextDouble();
            
            // Check if point is inside unit circle
            if (x * x + y * y <= 1.0) {
                pointsInCircle++;
            }
        }
        
        double piEstimate = 4.0 * pointsInCircle / totalPoints;
        System.out.printf("Estimated π: %.6f (actual: %.6f)\n", piEstimate, Math.PI);
        System.out.printf("Error: %.6f\n", Math.abs(piEstimate - Math.PI));
        
        // Perfect numbers
        System.out.println("Perfect numbers up to 10000:");
        for (int num = 6; num <= 10000; num++) {
            int sum = 1; // 1 is always a divisor
            
            for (int divisor = 2; divisor <= num / 2; divisor++) {
                if (num % divisor == 0) {
                    sum += divisor;
                }
            }
            
            if (sum == num) {
                System.out.print(num + " ");
            }
        }
        System.out.println();
        
        // Digital root calculation
        System.out.println("Digital roots of numbers 1-20:");
        for (int num = 1; num <= 20; num++) {
            int digitalRoot = num;
            
            while (digitalRoot >= 10) {
                int sum = 0;
                while (digitalRoot > 0) {
                    sum += digitalRoot % 10;
                    digitalRoot /= 10;
                }
                digitalRoot = sum;
            }
            
            System.out.println(num + " -> " + digitalRoot);
        }
    }
}
```

## Performance Considerations and Best Practices

### Loop Optimization
```java
public class LoopOptimization {
    public static void main(String[] args) {
        System.out.println("=== Loop Optimization Examples ===");
        
        // Avoiding repeated calculations in loop condition
        String text = "This is a sample text for optimization demonstration";
        
        // Inefficient: calculates length each iteration
        long startTime = System.nanoTime();
        int count1 = 0;
        for (int i = 0; i < text.length(); i++) { // length() called every iteration
            if (text.charAt(i) == 'a') {
                count1++;
            }
        }
        long inefficientTime = System.nanoTime() - startTime;
        
        // Efficient: calculate length once
        startTime = System.nanoTime();
        int count2 = 0;
        int length = text.length(); // Calculate once
        for (int i = 0; i < length; i++) {
            if (text.charAt(i) == 'a') {
                count2++;
            }
        }
        long efficientTime = System.nanoTime() - startTime;
        
        System.out.println("Character 'a' count: " + count1 + " = " + count2);
        System.out.println("Inefficient time: " + inefficientTime + " ns");
        System.out.println("Efficient time: " + efficientTime + " ns");
        
        // Loop unrolling for better performance (small arrays)
        int[] numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
        
        // Standard loop
        startTime = System.nanoTime();
        int sum1 = 0;
        for (int i = 0; i < numbers.length; i++) {
            sum1 += numbers[i];
        }
        long standardTime = System.nanoTime() - startTime;
        
        // Unrolled loop (process multiple elements per iteration)
        startTime = System.nanoTime();
        int sum2 = 0;
        int i = 0;
        for (; i < numbers.length - 3; i += 4) {
            sum2 += numbers[i] + numbers[i+1] + numbers[i+2] + numbers[i+3];
        }
        // Handle remaining elements
        for (; i < numbers.length; i++) {
            sum2 += numbers[i];
        }
        long unrolledTime = System.nanoTime() - startTime;
        
        System.out.println("Sum: " + sum1 + " = " + sum2);
        System.out.println("Standard loop time: " + standardTime + " ns");
        System.out.println("Unrolled loop time: " + unrolledTime + " ns");
        
        // Enhanced for loop vs traditional for loop
        startTime = System.nanoTime();
        int sum3 = 0;
        for (int num : numbers) {
            sum3 += num;
        }
        long enhancedTime = System.nanoTime() - startTime;
        
        System.out.println("Enhanced for loop time: " + enhancedTime + " ns");
        
        // Using StringBuilder for string concatenation in loops
        System.out.println("\nString concatenation comparison:");
        
        // Inefficient: String concatenation in loop
        startTime = System.nanoTime();
        String result1 = "";
        for (int j = 0; j < 1000; j++) {
            result1 += "a"; // Creates new String object each time
        }
        long stringConcatTime = System.nanoTime() - startTime;
        
        // Efficient: StringBuilder
        startTime = System.nanoTime();
        StringBuilder sb = new StringBuilder();
        for (int j = 0; j < 1000; j++) {
            sb.append("a"); // Modifies existing buffer
        }
        String result2 = sb.toString();
        long stringBuilderTime = System.nanoTime() - startTime;
        
        System.out.println("Results equal: " + result1.equals(result2));
        System.out.println("String concatenation time: " + stringConcatTime + " ns");
        System.out.println("StringBuilder time: " + stringBuilderTime + " ns");
        System.out.println("StringBuilder is " + (stringConcatTime / stringBuilderTime) + "x faster");
    }
}
```

## Common Loop Pitfalls and Solutions

### Avoiding Common Mistakes
```java
public class LoopPitfalls {
    public static void main(String[] args) {
        System.out.println("=== Common Loop Pitfalls and Solutions ===");
        
        // Pitfall 1: Off-by-one errors
        System.out.println("1. Off-by-one errors:");
        int[] array = {10, 20, 30, 40, 50};
        
        // WRONG: This will throw ArrayIndexOutOfBoundsException
        try {
            for (int i = 0; i <= array.length; i++) { // Should be i < array.length
                System.out.println(array[i]);
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error caught: " + e.getMessage());
        }
        
        // CORRECT: Proper loop bounds
        System.out.println("Correct version:");
        for (int i = 0; i < array.length; i++) {
            System.out.println("array[" + i + "] = " + array[i]);
        }
        
        // Pitfall 2: Infinite loops
        System.out.println("\n2. Infinite loop prevention:");
        int counter = 0;
        int maxIterations = 10; // Safety valve
        
        while (counter < 5) {
            System.out.println("Counter: " + counter);
            // counter++; // FORGOT TO INCREMENT - would cause infinite loop
            
            // Safety check to prevent infinite loop
            if (++maxIterations <= 0) {
                System.out.println("Breaking to prevent infinite loop");
                break;
            }
            counter++; // Proper increment
        }
        
        // Pitfall 3: Modifying collection while iterating
        System.out.println("\n3. Modifying collection during iteration:");
        java.util.List<Integer> numbers = new java.util.ArrayList<>();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        numbers.add(4);
        numbers.add(5);
        
        // WRONG: This can cause ConcurrentModificationException
        System.out.println("Original list: " + numbers);
        try {
            for (Integer num : numbers) {
                if (num % 2 == 0) {
                    numbers.remove(num); // Modifying while iterating - BAD!
                }
            }
        } catch (java.util.ConcurrentModificationException e) {
            System.out.println("Error caught: " + e.getMessage());
        }
        
        // CORRECT: Use iterator for safe removal
        numbers.clear();
        numbers.add(1);
        numbers.add(2);
        numbers.add(3);
        numbers.add(4);
        numbers.add(5);
        
        java.util.Iterator<Integer> iterator = numbers.iterator();
        while (iterator.hasNext()) {
            Integer num = iterator.next();
            if (num % 2 == 0) {
                iterator.remove(); // Safe removal
            }
        }
        System.out.println("After safe removal: " + numbers);
        
        // Pitfall 4: Floating point loop variables
        System.out.println("\n4. Floating point precision issues:");
        
        // PROBLEMATIC: Using floating point as loop variable
        System.out.println("Problematic floating point loop:");
        double d = 0.0;
        int count = 0;
        while (d != 1.0 && count < 20) { // May never reach exactly 1.0
            d += 0.1;
            count++;
            System.out.printf("d = %.15f\n", d);
        }
        System.out.println("Loop ended with d = " + d + " (should be 1.0)");
        
        // BETTER: Use integer loop variable
        System.out.println("Better approach with integer loop:");
        for (int i = 0; i <= 10; i++) {
            double value = i * 0.1;
            System.out.printf("value = %.1f\n", value);
        }
        
        // Pitfall 5: Variable scope confusion
        System.out.println("\n5. Variable scope in loops:");
        
        // This is fine - loop variable has proper scope
        for (int i = 0; i < 3; i++) {
            System.out.println("Loop variable i: " + i);
        }
        // System.out.println(i); // ERROR: i is not accessible here
        
        // Using variables declared outside loop
        int j; // Declared outside
        for (j = 0; j < 3; j++) {
            System.out.println("External variable j: " + j);
        }
        System.out.println("After loop, j = " + j); // j is still accessible
        
        // Pitfall 6: Nested loop label confusion
        System.out.println("\n6. Nested loop control:");
        
        // Without labels - only breaks inner loop
        System.out.println("Breaking inner loop only:");
        for (int outer = 1; outer <= 3; outer++) {
            for (int inner = 1; inner <= 3; inner++) {
                if (outer == 2 && inner == 2) {
                    break; // Only breaks inner loop
                }
                System.out.println("outer=" + outer + ", inner=" + inner);
            }
        }
        
        // With labels - can break outer loop
        System.out.println("Breaking outer loop with label:");
        outerLoop:
        for (int outer = 1; outer <= 3; outer++) {
            for (int inner = 1; inner <= 3; inner++) {
                if (outer == 2 && inner == 2) {
                    break outerLoop; // Breaks outer loop
                }
                System.out.println("outer=" + outer + ", inner=" + inner);
            }
        }
    }
}
```

## Key Takeaways

1. **Choose the right loop type**:
   - **For loop**: When you know the number of iterations
   - **Enhanced for loop**: For iterating over arrays/collections
   - **While loop**: When condition is checked before execution
   - **Do-while loop**: When you need at least one execution

2. **Avoid common pitfalls**:
   - Off-by-one errors in array bounds
   - Infinite loops due to incorrect conditions
   - Modifying collections while iterating
   - Floating-point precision issues in loop conditions

3. **Optimize for performance**:
   - Avoid repeated calculations in loop conditions
   - Use StringBuilder for string concatenation in loops
   - Consider loop unrolling for small, performance-critical loops
   - Choose enhanced for loops for readability when you don't need indices

4. **Use proper control flow**:
   - Break and continue statements for early loop exit
   - Labeled breaks for nested loop control
   - Input validation with do-while loops

5. **Best practices**:
   - Keep loop bodies focused and readable
   - Use meaningful variable names
   - Add safety checks for potentially infinite loops
   - Initialize loop variables properly
   - Consider the scope of loop variables

## Next Steps

Now that you understand loops:
1. Practice with different loop types and patterns
2. Implement various algorithms using loops (sorting, searching, etc.)
3. Learn about [Break and Continue](./break-continue.md) statements in detail
4. Study [Switch Statements](./switch.md) as an alternative to multiple if-else conditions
5. Explore [Arrays](./arrays-1d.md) and how loops are essential for array processing
