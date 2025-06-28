# Java Program Structure

## Overview
Understanding the basic structure of a Java program is essential for writing clean, organized code. This guide covers the fundamental components and organization principles.

## Basic Java Program Structure

### Minimal Java Program
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### Complete Program Structure
```java
// 1. Package declaration (optional)
package com.example.myproject;

// 2. Import statements
import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

// 3. Comments and documentation
/**
 * This class demonstrates Java program structure
 * @author Your Name
 * @version 1.0
 */
public class ProgramStructure {
    
    // 4. Class-level variables (fields)
    private static final String PROGRAM_NAME = "Structure Demo";
    private int instanceVariable;
    
    // 5. Constructors
    public ProgramStructure() {
        this.instanceVariable = 0;
    }
    
    public ProgramStructure(int value) {
        this.instanceVariable = value;
    }
    
    // 6. Main method (entry point)
    public static void main(String[] args) {
        System.out.println("Starting " + PROGRAM_NAME);
        
        // Create instance and use methods
        ProgramStructure demo = new ProgramStructure(42);
        demo.demonstrateStructure();
    }
    
    // 7. Other methods
    public void demonstrateStructure() {
        System.out.println("Instance variable: " + instanceVariable);
    }
    
    // 8. Getters and setters
    public int getInstanceVariable() {
        return instanceVariable;
    }
    
    public void setInstanceVariable(int instanceVariable) {
        this.instanceVariable = instanceVariable;
    }
}
```

## Component Details

### 1. Package Declaration
```java
package com.company.project.module;
```
- **Purpose:** Organizes related classes
- **Convention:** Reverse domain name (com.company.project)
- **Must be:** First non-comment line
- **Optional:** Can be omitted for default package

### 2. Import Statements
```java
// Import specific class
import java.util.Scanner;

// Import all classes from package (not recommended)
import java.util.*;

// Import static methods
import static java.lang.Math.PI;
import static java.lang.Math.sqrt;
```

**Best Practices:**
- Import specific classes, not entire packages
- Use static imports sparingly
- Group imports logically

### 3. Class Declaration
```java
// Access modifier + class keyword + class name
public class MyClass {
    // Class body
}
```

**Access Modifiers:**
- `public`: Accessible from anywhere
- `default` (no modifier): Package-private
- `private`: Not applicable to top-level classes
- `protected`: Not applicable to top-level classes

### 4. Class Variables and Constants
```java
public class VariableDemo {
    // Static variables (class-level)
    public static final String CONSTANT = "FIXED_VALUE";
    private static int classVariable = 0;
    
    // Instance variables
    private String instanceVariable;
    private int number;
    
    // Local variables (inside methods)
    public void method() {
        int localVariable = 10;
        String localString = "Local";
    }
}
```

### 5. Methods
```java
// Method structure
[access_modifier] [static] return_type method_name(parameters) {
    // Method body
    return value; // if not void
}

// Examples
public static void staticMethod() {
    System.out.println("Static method");
}

private int calculateSum(int a, int b) {
    return a + b;
}

public void printInfo(String message) {
    System.out.println("Info: " + message);
}
```

## File Organization Rules

### 1. File Naming
- File name must match public class name
- Use `.java` extension
- Case-sensitive

```java
// File: Calculator.java
public class Calculator {
    // Class implementation
}
```

### 2. Multiple Classes in One File
```java
// File: MainClass.java
public class MainClass {
    public static void main(String[] args) {
        Helper helper = new Helper();
        helper.assist();
    }
}

// Helper class (package-private)
class Helper {
    public void assist() {
        System.out.println("Helping...");
    }
}
```

**Rules:**
- Only one public class per file
- Multiple package-private classes allowed
- File named after public class

## Main Method Variations

### Standard Main Method
```java
public static void main(String[] args) {
    // Program entry point
}
```

### Alternative Declarations
```java
// All equivalent to standard main method
public static void main(String... args) { }
public static void main(String []args) { }
public static void main(String args[]) { }
static public void main(String[] args) { }
```

### Command Line Arguments
```java
public class CommandLineDemo {
    public static void main(String[] args) {
        System.out.println("Number of arguments: " + args.length);
        
        for (int i = 0; i < args.length; i++) {
            System.out.println("Argument " + i + ": " + args[i]);
        }
        
        // Enhanced for loop
        for (String arg : args) {
            System.out.println("Argument: " + arg);
        }
    }
}
```

## Code Organization Best Practices

### 1. Logical Grouping
```java
public class WellOrganizedClass {
    // 1. Constants first
    private static final int MAX_SIZE = 100;
    
    // 2. Static variables
    private static int instanceCount = 0;
    
    // 3. Instance variables
    private String name;
    private int value;
    
    // 4. Constructors
    public WellOrganizedClass() {
        this("Default", 0);
    }
    
    public WellOrganizedClass(String name, int value) {
        this.name = name;
        this.value = value;
        instanceCount++;
    }
    
    // 5. Public methods
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    // 6. Private methods
    private void validateValue(int value) {
        if (value < 0) {
            throw new IllegalArgumentException("Value cannot be negative");
        }
    }
    
    // 7. Static methods
    public static int getInstanceCount() {
        return instanceCount;
    }
}
```

### 2. Naming Conventions
```java
public class NamingConventions {
    // Constants: UPPER_SNAKE_CASE
    private static final int MAX_CONNECTIONS = 100;
    
    // Variables: camelCase
    private String firstName;
    private int accountNumber;
    
    // Methods: camelCase, verbs
    public void calculateTotal() { }
    public boolean isValid() { }
    public String getName() { }
    public void setName(String name) { }
    
    // Classes: PascalCase, nouns
    // Interface: PascalCase, often adjectives ending in -able
}
```

## Comments and Documentation

### 1. Single-line Comments
```java
// This is a single-line comment
int x = 5; // Comment at end of line
```

### 2. Multi-line Comments
```java
/*
 * This is a multi-line comment
 * spanning several lines
 */
```

### 3. Javadoc Comments
```java
/**
 * Calculates the area of a rectangle.
 * 
 * @param length the length of the rectangle
 * @param width the width of the rectangle
 * @return the area of the rectangle
 * @throws IllegalArgumentException if length or width is negative
 */
public double calculateArea(double length, double width) {
    if (length < 0 || width < 0) {
        throw new IllegalArgumentException("Dimensions cannot be negative");
    }
    return length * width;
}
```

## Complete Example: Student Management System

```java
package com.school.management;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * A simple student management system demonstrating Java program structure.
 * 
 * @author Programming Student
 * @version 1.0
 * @since 2025-06-28
 */
public class StudentManager {
    
    // Class constants
    private static final int MAX_STUDENTS = 50;
    private static final String SCHOOL_NAME = "Java Academy";
    
    // Class variables
    private static int totalStudents = 0;
    
    // Instance variables
    private List<Student> students;
    private String managerName;
    
    // Constructor
    public StudentManager(String managerName) {
        this.managerName = managerName;
        this.students = new ArrayList<>();
        System.out.println("Student Manager initialized for: " + managerName);
    }
    
    // Main method - program entry point
    public static void main(String[] args) {
        System.out.println("Welcome to " + SCHOOL_NAME + " Student Management System");
        
        // Create manager instance
        StudentManager manager = new StudentManager("John Doe");
        
        // Demonstrate functionality
        manager.addStudent("Alice", 20, "CS");
        manager.addStudent("Bob", 19, "Math");
        manager.displayAllStudents();
        
        System.out.println("Total students in system: " + getTotalStudents());
    }
    
    // Public methods
    public void addStudent(String name, int age, String major) {
        if (students.size() >= MAX_STUDENTS) {
            System.out.println("Cannot add more students. Maximum capacity reached.");
            return;
        }
        
        Student student = new Student(name, age, major);
        students.add(student);
        totalStudents++;
        
        System.out.println("Added student: " + name);
    }
    
    public void displayAllStudents() {
        System.out.println("\n--- Student List ---");
        if (students.isEmpty()) {
            System.out.println("No students registered.");
            return;
        }
        
        for (int i = 0; i < students.size(); i++) {
            System.out.println((i + 1) + ". " + students.get(i));
        }
        System.out.println("-------------------\n");
    }
    
    // Getter methods
    public String getManagerName() {
        return managerName;
    }
    
    public int getStudentCount() {
        return students.size();
    }
    
    // Static method
    public static int getTotalStudents() {
        return totalStudents;
    }
    
    // Private helper method
    private boolean validateStudentData(String name, int age, String major) {
        return name != null && !name.trim().isEmpty() && 
               age > 0 && age < 150 && 
               major != null && !major.trim().isEmpty();
    }
}

// Supporting class (package-private)
class Student {
    private String name;
    private int age;
    private String major;
    
    public Student(String name, int age, String major) {
        this.name = name;
        this.age = age;
        this.major = major;
    }
    
    @Override
    public String toString() {
        return name + " (Age: " + age + ", Major: " + major + ")";
    }
    
    // Getters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getMajor() { return major; }
}
```

## Common Structure Mistakes

### 1. Wrong File Name
```java
// File: WrongName.java - ERROR!
public class CorrectClassName {
    // This will cause compilation error
}
```

### 2. Missing Main Method
```java
public class NoMainMethod {
    // No main method - cannot run as application
    public void someMethod() {
        System.out.println("This won't run directly");
    }
}
```

### 3. Incorrect Package Structure
```java
// File in wrong directory for package
package com.example.wrong; // But file is in com/example/right/
```

## Key Takeaways

1. **Class name must match filename** for public classes
2. **Package declaration comes first** (if present)
3. **Imports come after package** declaration
4. **Main method is the entry point** for applications
5. **Organize code logically** with constants, variables, constructors, methods
6. **Use proper naming conventions** for readability
7. **Document your code** with meaningful comments
8. **One public class per file** is the standard practice

## Next Steps

Now that you understand Java program structure:
1. Practice creating well-structured programs
2. Experiment with different class organizations
3. Learn about [Variables and Data Types](./variables-datatypes.md)
4. Study [Method Declaration and Definition](./methods.md)
