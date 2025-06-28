# Method Parameters in Java

## 🎯 Overview

Method parameters are variables declared in a method's signature that allow methods to receive input values when called. Understanding parameters is crucial for creating flexible, reusable methods that can operate on different data. Java supports various types of parameters and parameter-passing mechanisms.

## 📚 Basic Parameter Concepts

### Method Signature and Parameters
```java
// Method signature components
public static returnType methodName(parameterType parameterName) {
    // Method body
}

// Example with multiple parameters
public static void greetUser(String name, int age, boolean isStudent) {
    System.out.println("Hello, " + name);
    System.out.println("Age: " + age);
    System.out.println("Student: " + (isStudent ? "Yes" : "No"));
}
```

### Simple Parameter Example
```java
public class BasicParameters {
    public static void main(String[] args) {
        // Calling methods with parameters
        displayMessage("Welcome to Java!");
        calculateArea(5.0, 3.0);
        int result = addNumbers(10, 20);
        System.out.println("Sum: " + result);
    }
    
    // Method with single parameter
    public static void displayMessage(String message) {
        System.out.println("Message: " + message);
    }
    
    // Method with multiple parameters
    public static void calculateArea(double length, double width) {
        double area = length * width;
        System.out.println("Area: " + area);
    }
    
    // Method with parameters and return value
    public static int addNumbers(int a, int b) {
        return a + b;
    }
}
```

## 🔄 Parameter Passing Mechanisms

### Pass by Value (Primitives)
```java
public class PassByValueExample {
    public static void main(String[] args) {
        int originalNumber = 10;
        System.out.println("Before method call: " + originalNumber);
        
        modifyPrimitive(originalNumber);
        System.out.println("After method call: " + originalNumber);
        // originalNumber is still 10 - unchanged!
    }
    
    public static void modifyPrimitive(int number) {
        number = 100; // This only changes the local copy
        System.out.println("Inside method: " + number);
    }
}
```

**Output:**
```
Before method call: 10
Inside method: 100
After method call: 10
```

### Pass by Reference (Objects)
```java
public class PassByReferenceExample {
    public static void main(String[] args) {
        int[] originalArray = {1, 2, 3, 4, 5};
        System.out.println("Before method call: " + 
                          java.util.Arrays.toString(originalArray));
        
        modifyArray(originalArray);
        System.out.println("After method call: " + 
                          java.util.Arrays.toString(originalArray));
        // Array contents have been modified!
        
        // But reassigning the reference doesn't affect original
        reassignArray(originalArray);
        System.out.println("After reassignment attempt: " + 
                          java.util.Arrays.toString(originalArray));
    }
    
    public static void modifyArray(int[] arr) {
        arr[0] = 100; // Modifies the original array
        System.out.println("Inside modify method: " + 
                          java.util.Arrays.toString(arr));
    }
    
    public static void reassignArray(int[] arr) {
        arr = new int[]{10, 20, 30}; // Only changes local reference
        System.out.println("Inside reassign method: " + 
                          java.util.Arrays.toString(arr));
    }
}
```

**Output:**
```
Before method call: [1, 2, 3, 4, 5]
Inside modify method: [100, 2, 3, 4, 5]
After method call: [100, 2, 3, 4, 5]
Inside reassign method: [10, 20, 30]
After reassignment attempt: [100, 2, 3, 4, 5]
```

## 🔢 Variable Arguments (Varargs)

### Basic Varargs Syntax
```java
public class VarargsExample {
    public static void main(String[] args) {
        // Can call with different number of arguments
        printNumbers(1);
        printNumbers(1, 2, 3);
        printNumbers(1, 2, 3, 4, 5);
        
        // Can also pass an array
        int[] numbers = {10, 20, 30};
        printNumbers(numbers);
        
        // Other varargs examples
        System.out.println("Sum of 2 numbers: " + sum(5, 10));
        System.out.println("Sum of 4 numbers: " + sum(1, 2, 3, 4));
        System.out.println("Sum of 6 numbers: " + sum(1, 2, 3, 4, 5, 6));
    }
    
    // Varargs method - accepts variable number of int arguments
    public static void printNumbers(int... numbers) {
        System.out.print("Numbers: ");
        for (int num : numbers) {
            System.out.print(num + " ");
        }
        System.out.println("(Total: " + numbers.length + ")");
    }
    
    // Varargs for calculating sum
    public static int sum(int... numbers) {
        int total = 0;
        for (int num : numbers) {
            total += num;
        }
        return total;
    }
}
```

### Varargs with Other Parameters
```java
public class VarargsWithOtherParams {
    public static void main(String[] args) {
        formatMessage("Error", "File not found", "Check path", "Try again");
        formatMessage("Info", "Process completed successfully");
        formatMessage("Warning", "Low disk space");
    }
    
    // Varargs must be the last parameter
    public static void formatMessage(String level, String... messages) {
        System.out.println("=== " + level.toUpperCase() + " ===");
        for (int i = 0; i < messages.length; i++) {
            System.out.println((i + 1) + ". " + messages[i]);
        }
        System.out.println();
    }
}
```

### Varargs Best Practices
```java
public class VarargsBestPractices {
    
    // GOOD: Check for null and empty varargs
    public static String concatenateStrings(String separator, String... strings) {
        if (strings == null || strings.length == 0) {
            return "";
        }
        
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < strings.length; i++) {
            if (strings[i] != null) {
                result.append(strings[i]);
                if (i < strings.length - 1) {
                    result.append(separator);
                }
            }
        }
        return result.toString();
    }
    
    // GOOD: Provide overloaded methods for common cases
    public static int max(int a, int b) {
        return Math.max(a, b);
    }
    
    public static int max(int a, int b, int c) {
        return Math.max(Math.max(a, b), c);
    }
    
    public static int max(int... numbers) {
        if (numbers.length == 0) {
            throw new IllegalArgumentException("At least one number required");
        }
        
        int maximum = numbers[0];
        for (int i = 1; i < numbers.length; i++) {
            if (numbers[i] > maximum) {
                maximum = numbers[i];
            }
        }
        return maximum;
    }
    
    public static void main(String[] args) {
        System.out.println(concatenateStrings(", ", "Apple", "Banana", "Cherry"));
        System.out.println("Max of 2: " + max(5, 10));
        System.out.println("Max of 3: " + max(5, 10, 15));
        System.out.println("Max of many: " + max(3, 7, 2, 9, 1, 8));
    }
}
```

## 📋 Parameter Types and Examples

### 1. Primitive Parameters
```java
public class PrimitiveParameters {
    public static void main(String[] args) {
        processNumbers(42, 3.14, true, 'A');
        performCalculations(100, 50);
    }
    
    public static void processNumbers(int integer, double decimal, 
                                    boolean flag, char character) {
        System.out.println("Integer: " + integer);
        System.out.println("Decimal: " + decimal);
        System.out.println("Boolean: " + flag);
        System.out.println("Character: " + character);
    }
    
    public static void performCalculations(long num1, long num2) {
        System.out.println("Sum: " + (num1 + num2));
        System.out.println("Product: " + (num1 * num2));
        System.out.println("Difference: " + Math.abs(num1 - num2));
    }
}
```

### 2. Object Parameters
```java
import java.util.ArrayList;
import java.util.List;

public class ObjectParameters {
    public static void main(String[] args) {
        // String parameter
        processText("Hello, World!");
        
        // Array parameter
        int[] numbers = {1, 2, 3, 4, 5};
        processArray(numbers);
        
        // List parameter
        List<String> names = new ArrayList<>();
        names.add("Alice");
        names.add("Bob");
        names.add("Charlie");
        processNameList(names);
        
        // Custom object parameter
        Student student = new Student("John Doe", 20, "Computer Science");
        processStudent(student);
    }
    
    public static void processText(String text) {
        System.out.println("Text length: " + text.length());
        System.out.println("Uppercase: " + text.toUpperCase());
    }
    
    public static void processArray(int[] arr) {
        System.out.print("Array elements: ");
        for (int num : arr) {
            System.out.print(num + " ");
        }
        System.out.println();
        
        // Calculate average
        double sum = 0;
        for (int num : arr) {
            sum += num;
        }
        System.out.println("Average: " + (sum / arr.length));
    }
    
    public static void processNameList(List<String> names) {
        System.out.println("Processing " + names.size() + " names:");
        for (int i = 0; i < names.size(); i++) {
            System.out.println((i + 1) + ". " + names.get(i));
        }
    }
    
    public static void processStudent(Student student) {
        System.out.println("Student Information:");
        System.out.println("Name: " + student.getName());
        System.out.println("Age: " + student.getAge());
        System.out.println("Major: " + student.getMajor());
    }
    
    // Simple Student class for demonstration
    static class Student {
        private String name;
        private int age;
        private String major;
        
        public Student(String name, int age, String major) {
            this.name = name;
            this.age = age;
            this.major = major;
        }
        
        public String getName() { return name; }
        public int getAge() { return age; }
        public String getMajor() { return major; }
    }
}
```

### 3. Array Parameters
```java
public class ArrayParameters {
    public static void main(String[] args) {
        // 1D Array
        int[] numbers = {5, 2, 8, 1, 9, 3};
        System.out.println("Original array: " + java.util.Arrays.toString(numbers));
        
        bubbleSort(numbers);
        System.out.println("Sorted array: " + java.util.Arrays.toString(numbers));
        
        // 2D Array
        int[][] matrix = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        
        System.out.println("Matrix sum: " + calculateMatrixSum(matrix));
        printMatrix(matrix);
        
        // String array
        String[] words = {"Java", "Python", "JavaScript", "C++"};
        findLongestWord(words);
    }
    
    public static void bubbleSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    // Swap elements
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }
    
    public static int calculateMatrixSum(int[][] matrix) {
        int sum = 0;
        for (int[] row : matrix) {
            for (int element : row) {
                sum += element;
            }
        }
        return sum;
    }
    
    public static void printMatrix(int[][] matrix) {
        System.out.println("Matrix:");
        for (int[] row : matrix) {
            for (int element : row) {
                System.out.printf("%3d ", element);
            }
            System.out.println();
        }
    }
    
    public static void findLongestWord(String[] words) {
        String longest = "";
        for (String word : words) {
            if (word.length() > longest.length()) {
                longest = word;
            }
        }
        System.out.println("Longest word: " + longest + 
                          " (length: " + longest.length() + ")");
    }
}
```

## 🎯 Parameter Validation and Error Handling

### Input Validation Examples
```java
public class ParameterValidation {
    public static void main(String[] args) {
        // Test valid inputs
        System.out.println("Square root of 16: " + safeSqrt(16));
        System.out.println("Division 10/2: " + safeDivide(10, 2));
        
        // Test invalid inputs
        try {
            System.out.println("Square root of -4: " + safeSqrt(-4));
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        }
        
        try {
            System.out.println("Division 10/0: " + safeDivide(10, 0));
        } catch (IllegalArgumentException e) {
            System.out.println("Error: " + e.getMessage());
        }
        
        // Test null handling
        String result = processString(null);
        System.out.println("Processing null: " + result);
        
        result = processString("Hello");
        System.out.println("Processing 'Hello': " + result);
    }
    
    public static double safeSqrt(double number) {
        if (number < 0) {
            throw new IllegalArgumentException(
                "Cannot calculate square root of negative number: " + number);
        }
        return Math.sqrt(number);
    }
    
    public static double safeDivide(double dividend, double divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("Division by zero is not allowed");
        }
        return dividend / divisor;
    }
    
    public static String processString(String input) {
        // Handle null input
        if (input == null) {
            return "NULL_INPUT";
        }
        
        // Handle empty string
        if (input.trim().isEmpty()) {
            return "EMPTY_INPUT";
        }
        
        // Process valid input
        return input.toUpperCase().trim();
    }
    
    // Comprehensive validation example
    public static void createUser(String name, int age, String email) {
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }
        
        if (name.length() < 2 || name.length() > 50) {
            throw new IllegalArgumentException("Name must be between 2 and 50 characters");
        }
        
        // Validate age
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("Age must be between 0 and 150");
        }
        
        // Validate email
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Invalid email format");
        }
        
        System.out.println("User created successfully:");
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Email: " + email);
    }
}
```

## 💡 Advanced Parameter Patterns

### Method Chaining with Parameters
```java
public class MethodChaining {
    public static void main(String[] args) {
        StringBuilder message = new StringBuilder();
        
        // Method chaining
        String result = buildMessage(message)
            .addText("Hello")
            .addText(" ")
            .addText("World")
            .addText("!")
            .toString();
            
        System.out.println("Result: " + result);
    }
    
    public static StringBuilder buildMessage(StringBuilder sb) {
        return sb;
    }
}

// Better example with custom class
class MessageBuilder {
    private StringBuilder content;
    
    public MessageBuilder() {
        this.content = new StringBuilder();
    }
    
    public MessageBuilder addText(String text) {
        content.append(text);
        return this; // Return this for chaining
    }
    
    public MessageBuilder addLine(String line) {
        content.append(line).append("\n");
        return this;
    }
    
    public MessageBuilder addNumber(int number) {
        content.append(number);
        return this;
    }
    
    @Override
    public String toString() {
        return content.toString();
    }
    
    public static void main(String[] args) {
        String message = new MessageBuilder()
            .addLine("Welcome to Java!")
            .addText("Today is day number: ")
            .addNumber(365)
            .addLine("")
            .addText("Have a great day!")
            .toString();
            
        System.out.println(message);
    }
}
```

### Builder Pattern with Parameters
```java
class Pizza {
    private String size;
    private boolean cheese;
    private boolean pepperoni;
    private boolean mushrooms;
    private boolean olives;
    
    private Pizza(Builder builder) {
        this.size = builder.size;
        this.cheese = builder.cheese;
        this.pepperoni = builder.pepperoni;
        this.mushrooms = builder.mushrooms;
        this.olives = builder.olives;
    }
    
    public static class Builder {
        private String size = "Medium"; // Default
        private boolean cheese = true;  // Default
        private boolean pepperoni = false;
        private boolean mushrooms = false;
        private boolean olives = false;
        
        public Builder size(String size) {
            this.size = size;
            return this;
        }
        
        public Builder cheese(boolean cheese) {
            this.cheese = cheese;
            return this;
        }
        
        public Builder pepperoni(boolean pepperoni) {
            this.pepperoni = pepperoni;
            return this;
        }
        
        public Builder mushrooms(boolean mushrooms) {
            this.mushrooms = mushrooms;
            return this;
        }
        
        public Builder olives(boolean olives) {
            this.olives = olives;
            return this;
        }
        
        public Pizza build() {
            return new Pizza(this);
        }
    }
    
    @Override
    public String toString() {
        return String.format("Pizza[size=%s, cheese=%s, pepperoni=%s, mushrooms=%s, olives=%s]",
                           size, cheese, pepperoni, mushrooms, olives);
    }
    
    public static void main(String[] args) {
        // Build pizza with method chaining
        Pizza pizza1 = new Pizza.Builder()
            .size("Large")
            .pepperoni(true)
            .mushrooms(true)
            .build();
            
        Pizza pizza2 = new Pizza.Builder()
            .size("Small")
            .cheese(false)
            .olives(true)
            .build();
            
        System.out.println("Pizza 1: " + pizza1);
        System.out.println("Pizza 2: " + pizza2);
    }
}
```

## ⚠️ Common Pitfalls and Best Practices

### 1. Parameter Order and Clarity
```java
public class ParameterBestPractices {
    
    // BAD: Unclear parameter order
    public static void transferMoney(double amount, String fromAccount, String toAccount) {
        System.out.println("Transferring $" + amount + " from " + fromAccount + " to " + toAccount);
    }
    
    // BETTER: Clear parameter order and naming
    public static void transferFunds(String fromAccount, String toAccount, double amount) {
        System.out.println("Transferring $" + amount + " from " + fromAccount + " to " + toAccount);
    }
    
    // BEST: Use parameter objects for complex operations
    public static void transferFunds(TransferRequest request) {
        System.out.println("Transferring $" + request.getAmount() + 
                          " from " + request.getFromAccount() + 
                          " to " + request.getToAccount());
    }
    
    static class TransferRequest {
        private String fromAccount;
        private String toAccount;
        private double amount;
        
        public TransferRequest(String fromAccount, String toAccount, double amount) {
            this.fromAccount = fromAccount;
            this.toAccount = toAccount;
            this.amount = amount;
        }
        
        // Getters
        public String getFromAccount() { return fromAccount; }
        public String getToAccount() { return toAccount; }
        public double getAmount() { return amount; }
    }
}
```

### 2. Defensive Programming
```java
public class DefensiveProgramming {
    
    // GOOD: Defensive copying for mutable objects
    public static void processNumbers(int[] numbers) {
        if (numbers == null) {
            throw new IllegalArgumentException("Numbers array cannot be null");
        }
        
        // Create defensive copy to avoid external modification
        int[] copy = numbers.clone();
        
        // Process the copy
        for (int i = 0; i < copy.length; i++) {
            copy[i] *= 2;
        }
        
        System.out.println("Processed: " + java.util.Arrays.toString(copy));
        // Original array remains unchanged
    }
    
    // GOOD: Immutable parameter objects
    public static void processDate(java.time.LocalDate date) {
        if (date == null) {
            throw new IllegalArgumentException("Date cannot be null");
        }
        
        // LocalDate is immutable, so no defensive copying needed
        java.time.LocalDate nextWeek = date.plusWeeks(1);
        System.out.println("Next week: " + nextWeek);
    }
}
```

### 3. Parameter Count Management
```java
public class ParameterCountManagement {
    
    // BAD: Too many parameters
    public static void createEmployee(String firstName, String lastName, 
                                    String email, String phone, String address,
                                    String city, String state, String zip,
                                    String department, String position,
                                    double salary, java.time.LocalDate startDate) {
        // Implementation...
    }
    
    // BETTER: Use parameter object
    public static void createEmployee(EmployeeData employeeData) {
        // Implementation...
    }
    
    static class EmployeeData {
        private String firstName;
        private String lastName;
        private String email;
        private String phone;
        private Address address;
        private JobInfo jobInfo;
        
        // Constructor, getters, setters...
    }
    
    static class Address {
        private String street;
        private String city;
        private String state;
        private String zip;
        
        // Constructor, getters, setters...
    }
    
    static class JobInfo {
        private String department;
        private String position;
        private double salary;
        private java.time.LocalDate startDate;
        
        // Constructor, getters, setters...
    }
}
```

## 📋 Summary

- **Parameters:** Variables that accept input values when methods are called
- **Pass by Value:** Primitives are copied; changes don't affect original
- **Pass by Reference:** Objects can be modified; reference reassignment doesn't affect original
- **Varargs:** Accept variable number of arguments using `...` syntax
- **Validation:** Always validate parameters to ensure method reliability
- **Best Practices:** Use clear names, limit parameter count, implement defensive programming

## 🔗 Related Topics

- [Methods](./methods.md) - Method declaration and structure
- [Return Types](./return-types.md) - Method return values
- [Method Overloading](./overloading.md) - Multiple methods with same name
- [Variables and Data Types](./variables-datatypes.md) - Understanding data types

## 🎯 Practice Exercises

1. Create a method that validates email addresses with proper parameter validation
2. Implement a varargs method for calculating statistics (mean, median, mode)
3. Build a parameter object pattern for a complex configuration system
4. Create methods demonstrating the difference between pass-by-value and pass-by-reference
5. Implement a method chain pattern for building SQL queries
