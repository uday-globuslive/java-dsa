# Module 1: Java Fundamentals

## 🎯 Learning Objectives
- Master Java syntax and basic programming concepts
- Understand primitive data types and operations
- Learn control structures and method creation
- Handle input/output operations
- Debug and troubleshoot Java programs

## 📚 Topics Covered

### 1.1 Java Environment Setup
- [Setting up JDK and IDE](./setup.md)
- [First Java Program](./first-program.md)
- [Understanding JVM, JRE, JDK](./java-platform.md)

### 1.2 Basic Syntax and Structure
- [Java Program Structure](./program-structure.md)
- [Variables and Data Types](./variables-datatypes.md)
- [Operators and Expressions](./operators.md)
- [Type Casting and Conversion](./type-casting.md)

### 1.3 Control Structures
- [Conditional Statements](./conditionals.md)
- [Loops (for, while, do-while)](./loops.md)
- [Break and Continue](./break-continue.md)
- [Switch Statements](./switch.md)

### 1.4 Methods and Functions
- [Method Declaration and Definition](./methods.md)
- [Parameter Passing](./parameters.md)
- [Return Types and Values](./return-types.md)
- [Method Overloading](./overloading.md)

### 1.5 Arrays and Strings
- [One-Dimensional Arrays](./arrays-1d.md)
- [Multi-Dimensional Arrays](./arrays-2d.md)
- [String Manipulation](./strings.md)
- [StringBuilder and StringBuffer](./string-builders.md)

### 1.6 Exception Handling
- [Try-Catch Blocks](./exception-handling.md)
- [Common Exceptions](./common-exceptions.md)
- [Finally Block](./finally.md)

## 💻 Programming Exercises

### Basic Level
1. **Hello World Variations** - Practice basic output
2. **Calculator Program** - Implement basic arithmetic
3. **Temperature Converter** - Practice input/output and calculations
4. **Grade Calculator** - Use conditional statements
5. **Pattern Printing** - Master nested loops

### Intermediate Level
6. **Prime Number Checker** - Combine loops and conditionals
7. **Factorial Calculator** - Practice recursion and iteration
8. **Palindrome Checker** - String manipulation
9. **Array Operations** - Search, sort, reverse
10. **Simple Text Processor** - Advanced string operations

## 🧪 Practice Problems

### Easy Problems (LeetCode Style)
1. [Two Sum (Simple Version)](./problems/two-sum-simple.md)
2. [Reverse Integer](./problems/reverse-integer.md)
3. [Palindrome Number](./problems/palindrome-number.md)
4. [Valid Parentheses (Simple)](./problems/valid-parentheses.md)
5. [Maximum Subarray (Brute Force)](./problems/max-subarray.md)

## 📝 Code Templates

### Basic Java Program Template
```java
import java.util.Scanner;

public class ProgramName {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Your code here
        
        scanner.close();
    }
}
```

### Method Template
```java
public static returnType methodName(parameters) {
    // Method implementation
    return value; // if not void
}
```

### Array Processing Template
```java
public static void processArray(int[] arr) {
    for (int i = 0; i < arr.length; i++) {
        // Process arr[i]
    }
}
```

## 🎯 Learning Path

### Week 1: Setup and Basics
- **Day 1-2:** Environment setup, first program
- **Day 3-4:** Variables, data types, operators
- **Day 5-7:** Practice exercises 1-3

### Week 2: Control Structures
- **Day 1-2:** Conditional statements
- **Day 3-4:** Loops and iterations
- **Day 5-7:** Practice exercises 4-6

### Week 3: Methods and Arrays
- **Day 1-2:** Method creation and calling
- **Day 3-4:** Arrays and string basics
- **Day 5-7:** Practice exercises 7-10

## ✅ Self-Assessment Checklist

Mark each item as you master it:

### Basic Syntax
- [ ] Can write a complete Java program from scratch
- [ ] Understand and use all primitive data types
- [ ] Apply all operators correctly
- [ ] Handle user input and output

### Control Structures
- [ ] Write complex conditional logic
- [ ] Use all loop types appropriately
- [ ] Implement nested loops confidently
- [ ] Handle edge cases in control flow

### Methods
- [ ] Create methods with various signatures
- [ ] Understand parameter passing mechanisms
- [ ] Use method overloading effectively
- [ ] Handle return values properly

### Data Handling
- [ ] Manipulate arrays efficiently
- [ ] Perform string operations confidently
- [ ] Choose appropriate data structures
- [ ] Handle null and empty cases

## 🔧 Common Mistakes and Solutions

### 1. Off-by-One Errors
**Problem:** Array index out of bounds
**Solution:** Always check loop conditions carefully

### 2. Null Pointer Exceptions
**Problem:** Accessing null references
**Solution:** Always validate objects before use

### 3. Integer Overflow
**Problem:** Results exceed data type limits
**Solution:** Use appropriate data types and validation

### 4. Infinite Loops
**Problem:** Loop conditions never become false
**Solution:** Trace through loop logic carefully

## 🎯 Next Steps

Once you've mastered this module:
1. Complete the self-assessment with 100% confidence
2. Solve all practice problems independently
3. Move to [Module 2: Object-Oriented Programming](../02-oop-concepts/)

## 📖 Additional Resources

- [Oracle Java Tutorials](https://docs.oracle.com/javase/tutorial/)
- [Java Documentation](https://docs.oracle.com/en/java/)
- [Practice Platform: CodingBat](https://codingbat.com/java)

---

**Estimated Time:** 3 weeks (15-20 hours)  
**Difficulty:** Beginner  
**Prerequisites:** None
