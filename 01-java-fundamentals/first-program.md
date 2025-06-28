# Your First Java Program

## 🎯 Learning Objectives
- Write and execute your first Java program
- Understand the basic structure of a Java application
- Learn about the main method and its significance
- Practice compilation and execution workflow

## 🚀 The Classic "Hello, World!" Program

### Step 1: Create Your First Java File

Create a file named `HelloWorld.java`:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### Step 2: Understanding Each Component

```java
// 1. Class Declaration
public class HelloWorld {
    //    ↑
    //    Class name must match filename
    
    // 2. Main Method - Entry point of the program
    public static void main(String[] args) {
        //  ↑      ↑    ↑      ↑
        //  |      |    |      Method parameters
        //  |      |    Return type (void = no return)
        //  |      Static keyword
        //  Access modifier
        
        // 3. Output Statement
        System.out.println("Hello, World!");
        //     ↑       ↑
        //     |       Method to print line
        //     Output stream
    }
}
```

### Step 3: Compile and Run

#### Using Command Line:
```bash
# Compile the Java file
javac HelloWorld.java

# This creates HelloWorld.class file

# Run the compiled program
java HelloWorld

# Output: Hello, World!
```

#### Using IDE:
- **IntelliJ IDEA:** Right-click → Run 'HelloWorld.main()'
- **VS Code:** Click Run button or Ctrl+F5
- **Eclipse:** Right-click → Run As → Java Application

## 📝 Program Variations

### 1. Multiple Output Statements
```java
public class MultipleOutputs {
    public static void main(String[] args) {
        System.out.println("Welcome to Java Programming!");
        System.out.println("This is my first program.");
        System.out.println("Learning is fun!");
        System.out.print("This doesn't add a new line. ");
        System.out.println("This continues on the same line.");
    }
}
```

**Output:**
```
Welcome to Java Programming!
This is my first program.
Learning is fun!
This doesn't add a new line. This continues on the same line.
```

### 2. Using Variables
```java
public class VariablesDemo {
    public static void main(String[] args) {
        String name = "Alice";
        int age = 25;
        double height = 5.6;
        
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Height: " + height + " feet");
    }
}
```

### 3. Taking User Input
```java
import java.util.Scanner;

public class UserInputDemo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter your name: ");
        String name = scanner.nextLine();
        
        System.out.print("Enter your age: ");
        int age = scanner.nextInt();
        
        System.out.println("Hello " + name + "!");
        System.out.println("You are " + age + " years old.");
        
        scanner.close(); // Important: Always close Scanner
    }
}
```

## 🔍 Understanding Program Structure

### 1. Package Declaration (Optional)
```java
package com.example.basics;  // Must be first line if present

public class HelloWorld {
    // ... rest of the code
}
```

### 2. Import Statements
```java
import java.util.Scanner;    // Import specific class
import java.util.*;          // Import all classes from package

public class ImportDemo {
    // ... rest of the code
}
```

### 3. Class Declaration
```java
// Access modifiers: public, private, protected, default
// public class - accessible from anywhere
public class HelloWorld {
    // Class body
}
```

### 4. Main Method Breakdown
```java
public static void main(String[] args) {
//  ↑      ↑     ↑    ↑
//  |      |     |    Parameter array for command line arguments
//  |      |     No return value
//  |      Method belongs to class, not instance
//  Accessible from anywhere
}
```

## 💡 Best Practices

### 1. Naming Conventions
```java
// Class names: PascalCase
public class StudentManager { }

// Method names: camelCase
public void calculateGrade() { }

// Variable names: camelCase
String firstName = "John";
int studentAge = 20;

// Constants: UPPER_SNAKE_CASE
final double PI = 3.14159;
```

### 2. Code Organization
```java
public class WellOrganizedClass {
    // 1. Constants first
    private static final String APP_NAME = "My App";
    
    // 2. Static variables
    private static int instanceCount = 0;
    
    // 3. Instance variables
    private String name;
    private int age;
    
    // 4. Main method (for executable classes)
    public static void main(String[] args) {
        // Program logic here
    }
    
    // 5. Other methods
    public void doSomething() {
        // Method implementation
    }
}
```

### 3. Comments and Documentation
```java
/**
 * This is a JavaDoc comment for the class
 * Describes what the class does
 */
public class DocumentedClass {
    
    /**
     * Main method - entry point of the application
     * @param args command line arguments
     */
    public static void main(String[] args) {
        // Single line comment
        System.out.println("Hello!");
        
        /*
         * Multi-line comment
         * for longer explanations
         */
        int result = calculate(5, 3);
        System.out.println("Result: " + result);
    }
    
    /**
     * Calculates the sum of two numbers
     * @param a first number
     * @param b second number
     * @return sum of a and b
     */
    public static int calculate(int a, int b) {
        return a + b;
    }
}
```

## 🧪 Practice Exercises

### Exercise 1: Personal Information
Create a program that displays your personal information:
```java
// Expected Output:
// Name: [Your Name]
// Age: [Your Age]
// City: [Your City]
// Favorite Programming Language: Java
```

### Exercise 2: Simple Calculator
```java
// Create a program that:
// 1. Asks user for two numbers
// 2. Performs addition, subtraction, multiplication, division
// 3. Displays all results
```

### Exercise 3: ASCII Art
```java
// Create a program that displays ASCII art
// Example:
//    *
//   ***
//  *****
// *******
//  *****
//   ***
//    *
```

### Exercise 4: Command Line Arguments
```java
// Create a program that uses command line arguments
// Run with: java MyProgram arg1 arg2 arg3
// Display each argument with its position
```

## 🚨 Common Errors and Solutions

### 1. Compilation Errors

**Error:** `public class HelloWorld must be defined in a file named HelloWorld.java`
```java
// Problem: Filename doesn't match class name
public class HelloWorld { } // File should be HelloWorld.java
```

**Error:** `';' expected`
```java
// Problem: Missing semicolon
System.out.println("Hello")  // Missing ;
// Solution:
System.out.println("Hello");
```

### 2. Runtime Errors

**Error:** `Exception in thread "main" java.lang.NoSuchMethodError: main`
```java
// Problem: Incorrect main method signature
public static void main(String args) { } // Missing []
// Solution:
public static void main(String[] args) { }
```

**Error:** `java.util.NoSuchElementException`
```java
// Problem: Scanner trying to read when no input available
Scanner scanner = new Scanner(System.in);
int number = scanner.nextInt(); // Error if no input
// Solution: Always validate input availability
```

## 🎯 Code Templates for Quick Start

### Basic Program Template
```java
public class ClassName {
    public static void main(String[] args) {
        // Your code here
        
    }
}
```

### Interactive Program Template
```java
import java.util.Scanner;

public class InteractiveProgram {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Get user input
        System.out.print("Enter something: ");
        String input = scanner.nextLine();
        
        // Process and display
        System.out.println("You entered: " + input);
        
        scanner.close();
    }
}
```

### Calculation Program Template
```java
public class Calculator {
    public static void main(String[] args) {
        // Variables
        double num1 = 10.0;
        double num2 = 5.0;
        
        // Calculations
        double sum = num1 + num2;
        double difference = num1 - num2;
        double product = num1 * num2;
        double quotient = num1 / num2;
        
        // Display results
        System.out.println("Sum: " + sum);
        System.out.println("Difference: " + difference);
        System.out.println("Product: " + product);
        System.out.println("Quotient: " + quotient);
    }
}
```

## ✅ Checklist: Master Your First Program

- [ ] Successfully compile and run HelloWorld program
- [ ] Understand each component of the basic program structure
- [ ] Can create programs with user input
- [ ] Know how to use print vs println
- [ ] Understand the role of the main method
- [ ] Can handle basic compilation and runtime errors
- [ ] Follow Java naming conventions
- [ ] Add appropriate comments to code

## 🎯 Next Steps

Once you've mastered creating and running basic Java programs:
1. Complete all practice exercises
2. Experiment with different output formats
3. Move to [Java Program Structure](./program-structure.md)

---

**Time Required:** 2-3 hours  
**Difficulty:** Beginner  
**Key Concepts:** Class structure, main method, compilation, execution
