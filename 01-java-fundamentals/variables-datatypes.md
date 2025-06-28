# Variables and Data Types

## Overview
Variables are containers that store data values. Understanding data types is fundamental to effective Java programming. This guide covers all primitive and reference types in Java.

## Variable Declaration and Initialization

### Basic Variable Declaration
```java
// Declaration
int number;
String name;
boolean isActive;

// Declaration with initialization
int age = 25;
String greeting = "Hello";
boolean isComplete = true;

// Multiple variables of same type
int x = 1, y = 2, z = 3;
String firstName = "John", lastName = "Doe";
```

### Variable Naming Rules
```java
// Valid variable names
int age;
String firstName;
boolean _isValid;
double $price;
int number1;
String camelCaseVariable;

// Invalid variable names (compilation errors)
// int 123number;     // Cannot start with digit
// String first-name; // Cannot contain hyphen
// boolean class;     // Cannot use reserved keywords
// double my var;     // Cannot contain spaces
```

## Primitive Data Types

### 1. Integer Types
```java
public class IntegerTypes {
    public static void main(String[] args) {
        // byte: 8-bit, range -128 to 127
        byte smallNumber = 100;
        byte maxByte = 127;
        byte minByte = -128;
        
        // short: 16-bit, range -32,768 to 32,767
        short shortNumber = 30000;
        short maxShort = 32767;
        short minShort = -32768;
        
        // int: 32-bit, range -2^31 to 2^31-1
        int regularNumber = 1000000;
        int maxInt = 2147483647;
        int minInt = -2147483648;
        
        // long: 64-bit, range -2^63 to 2^63-1
        long bigNumber = 9223372036854775807L; // Note the 'L' suffix
        long anotherLong = 1000000000000L;
        
        // Display values
        System.out.println("byte: " + smallNumber);
        System.out.println("short: " + shortNumber);
        System.out.println("int: " + regularNumber);
        System.out.println("long: " + bigNumber);
    }
}
```

### 2. Floating-Point Types
```java
public class FloatingTypes {
    public static void main(String[] args) {
        // float: 32-bit IEEE 754 floating point
        float temperature = 98.6f; // Note the 'f' suffix
        float pi = 3.14159f;
        
        // double: 64-bit IEEE 754 floating point (default for decimals)
        double preciseValue = 123.456789;
        double scientificNotation = 1.23e-4; // 0.000123
        double largeNumber = 1.7976931348623157e+308;
        
        // Special floating-point values
        double positiveInfinity = Double.POSITIVE_INFINITY;
        double negativeInfinity = Double.NEGATIVE_INFINITY;
        double notANumber = Double.NaN;
        
        System.out.println("float temperature: " + temperature);
        System.out.println("double precise: " + preciseValue);
        System.out.println("scientific notation: " + scientificNotation);
        System.out.println("Positive infinity: " + positiveInfinity);
        System.out.println("NaN: " + notANumber);
    }
}
```

### 3. Character Type
```java
public class CharacterType {
    public static void main(String[] args) {
        // char: 16-bit Unicode character
        char letter = 'A';
        char digit = '5';
        char symbol = '@';
        
        // Unicode characters
        char unicodeChar = '\u0041'; // 'A' in Unicode
        char newline = '\n';
        char tab = '\t';
        char backslash = '\\';
        char singleQuote = '\'';
        
        // Character as number (ASCII/Unicode value)
        char charA = 65; // ASCII value for 'A'
        
        System.out.println("Letter: " + letter);
        System.out.println("Unicode A: " + unicodeChar);
        System.out.println("Char from number: " + charA);
        System.out.println("Character arithmetic: " + (char)(letter + 1)); // 'B'
    }
}
```

### 4. Boolean Type
```java
public class BooleanType {
    public static void main(String[] args) {
        // boolean: true or false only
        boolean isJavaFun = true;
        boolean isComplete = false;
        
        // Boolean expressions
        boolean isPositive = 10 > 0;
        boolean isEqual = (5 == 5);
        boolean isNotEqual = (3 != 4);
        
        // Logical operations
        boolean andResult = true && false;  // false
        boolean orResult = true || false;   // true
        boolean notResult = !true;          // false
        
        System.out.println("Java is fun: " + isJavaFun);
        System.out.println("10 > 0: " + isPositive);
        System.out.println("true && false: " + andResult);
        System.out.println("true || false: " + orResult);
        System.out.println("!true: " + notResult);
    }
}
```

## Reference Types

### 1. String Type
```java
public class StringType {
    public static void main(String[] args) {
        // String declaration and initialization
        String greeting = "Hello, World!";
        String name = "Java";
        String empty = "";
        String nullString = null;
        
        // String concatenation
        String fullMessage = greeting + " Welcome to " + name;
        String numberConcatenation = "Age: " + 25;
        
        // String methods
        int length = greeting.length();
        String uppercase = greeting.toUpperCase();
        String lowercase = greeting.toLowerCase();
        boolean startsWith = greeting.startsWith("Hello");
        
        System.out.println("Original: " + greeting);
        System.out.println("Length: " + length);
        System.out.println("Uppercase: " + uppercase);
        System.out.println("Lowercase: " + lowercase);
        System.out.println("Starts with 'Hello': " + startsWith);
        System.out.println("Full message: " + fullMessage);
    }
}
```

### 2. Arrays
```java
public class ArrayTypes {
    public static void main(String[] args) {
        // Array declaration and initialization
        int[] numbers = {1, 2, 3, 4, 5};
        String[] names = {"Alice", "Bob", "Charlie"};
        
        // Alternative declaration syntax
        int grades[] = new int[5]; // Creates array of 5 integers (default value 0)
        boolean[] flags = new boolean[3]; // default value false
        
        // Accessing array elements
        int firstNumber = numbers[0];
        String firstName = names[0];
        
        // Modifying array elements
        grades[0] = 95;
        grades[1] = 87;
        names[0] = "Alice Johnson";
        
        // Array properties
        int arrayLength = numbers.length;
        
        System.out.println("First number: " + firstNumber);
        System.out.println("First name: " + firstName);
        System.out.println("Array length: " + arrayLength);
        System.out.println("Modified name: " + names[0]);
        System.out.println("First grade: " + grades[0]);
    }
}
```

## Variable Scope and Lifetime

### 1. Local Variables
```java
public class LocalVariables {
    public static void main(String[] args) {
        // Local variables - declared inside method
        int localVar = 10;
        
        if (localVar > 5) {
            // Block scope variable
            String message = "Greater than 5";
            System.out.println(message);
            // message is only accessible within this block
        }
        
        // System.out.println(message); // ERROR: message not accessible here
        
        for (int i = 0; i < 3; i++) {
            // Loop variable 'i' is local to the for loop
            System.out.println("Loop iteration: " + i);
        }
        
        // System.out.println(i); // ERROR: i not accessible here
    }
}
```

### 2. Instance Variables (Fields)
```java
public class InstanceVariables {
    // Instance variables - belong to object instance
    private String name;
    private int age;
    private boolean isActive = true; // default value
    
    // Constructor
    public InstanceVariables(String name, int age) {
        this.name = name; // 'this' refers to current object
        this.age = age;
    }
    
    public void displayInfo() {
        // Instance variables accessible throughout the class
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Active: " + isActive);
    }
    
    public static void main(String[] args) {
        InstanceVariables person = new InstanceVariables("John", 25);
        person.displayInfo();
    }
}
```

### 3. Class Variables (Static Variables)
```java
public class ClassVariables {
    // Class variables - shared among all instances
    private static int totalPersons = 0;
    private static final String SPECIES = "Homo sapiens"; // constant
    
    // Instance variables
    private String name;
    
    public ClassVariables(String name) {
        this.name = name;
        totalPersons++; // Increment shared counter
    }
    
    public static int getTotalPersons() {
        return totalPersons;
    }
    
    public static void main(String[] args) {
        System.out.println("Initial count: " + ClassVariables.getTotalPersons());
        
        ClassVariables person1 = new ClassVariables("Alice");
        ClassVariables person2 = new ClassVariables("Bob");
        
        System.out.println("After creating 2 persons: " + ClassVariables.getTotalPersons());
        System.out.println("Species: " + SPECIES);
    }
}
```

## Constants and Final Variables

### 1. Constants
```java
public class Constants {
    // Class constants (static final)
    public static final double PI = 3.14159265359;
    public static final int MAX_SIZE = 100;
    public static final String COMPANY_NAME = "Tech Corp";
    
    // Instance constants (final)
    private final String id;
    private final long creationTime;
    
    public Constants(String id) {
        this.id = id; // Can only be set once
        this.creationTime = System.currentTimeMillis();
    }
    
    public void demonstrateConstants() {
        // Local final variable
        final int localConstant = 50;
        
        System.out.println("PI: " + PI);
        System.out.println("Max size: " + MAX_SIZE);
        System.out.println("Company: " + COMPANY_NAME);
        System.out.println("ID: " + id);
        System.out.println("Creation time: " + creationTime);
        System.out.println("Local constant: " + localConstant);
        
        // localConstant = 60; // ERROR: Cannot modify final variable
    }
    
    public static void main(String[] args) {
        Constants demo = new Constants("CONST_001");
        demo.demonstrateConstants();
    }
}
```

## Default Values

### Default Values Table
```java
public class DefaultValues {
    // Instance variables get default values automatically
    private byte defaultByte;        // 0
    private short defaultShort;      // 0
    private int defaultInt;          // 0
    private long defaultLong;        // 0L
    private float defaultFloat;      // 0.0f
    private double defaultDouble;    // 0.0d
    private char defaultChar;        // '\u0000' (null character)
    private boolean defaultBoolean;  // false
    private String defaultString;    // null
    private int[] defaultArray;      // null
    
    public void printDefaults() {
        System.out.println("Default byte: " + defaultByte);
        System.out.println("Default short: " + defaultShort);
        System.out.println("Default int: " + defaultInt);
        System.out.println("Default long: " + defaultLong);
        System.out.println("Default float: " + defaultFloat);
        System.out.println("Default double: " + defaultDouble);
        System.out.println("Default char: '" + defaultChar + "'");
        System.out.println("Default boolean: " + defaultBoolean);
        System.out.println("Default String: " + defaultString);
        System.out.println("Default array: " + defaultArray);
    }
    
    public static void main(String[] args) {
        DefaultValues demo = new DefaultValues();
        demo.printDefaults();
        
        // Local variables must be initialized before use
        int localVar; // No default value
        // System.out.println(localVar); // ERROR: Variable might not be initialized
        
        localVar = 10; // Must initialize before use
        System.out.println("Initialized local var: " + localVar);
    }
}
```

## Practical Examples

### 1. Variable Usage in Calculations
```java
public class VariableCalculations {
    public static void main(String[] args) {
        // Simple calculator using different data types
        int num1 = 10;
        int num2 = 3;
        
        int sum = num1 + num2;
        int difference = num1 - num2;
        int product = num1 * num2;
        double quotient = (double) num1 / num2; // Type casting for decimal result
        int remainder = num1 % num2;
        
        System.out.println("Numbers: " + num1 + " and " + num2);
        System.out.println("Sum: " + sum);
        System.out.println("Difference: " + difference);
        System.out.println("Product: " + product);
        System.out.println("Quotient: " + quotient);
        System.out.println("Remainder: " + remainder);
        
        // Working with different types
        double price = 19.99;
        int quantity = 3;
        double total = price * quantity;
        
        System.out.println("\nShopping calculation:");
        System.out.println("Price: $" + price);
        System.out.println("Quantity: " + quantity);
        System.out.println("Total: $" + total);
    }
}
```

### 2. String Operations
```java
public class StringOperations {
    public static void main(String[] args) {
        String firstName = "John";
        String lastName = "Doe";
        int age = 30;
        boolean isEmployee = true;
        
        // String concatenation
        String fullName = firstName + " " + lastName;
        String info = fullName + " is " + age + " years old";
        String status = "Employee status: " + isEmployee;
        
        // String formatting
        String formatted = String.format("Name: %s, Age: %d, Employee: %b", 
                                        fullName, age, isEmployee);
        
        System.out.println("Full name: " + fullName);
        System.out.println("Info: " + info);
        System.out.println("Status: " + status);
        System.out.println("Formatted: " + formatted);
        
        // String methods
        System.out.println("Name length: " + fullName.length());
        System.out.println("Uppercase: " + fullName.toUpperCase());
        System.out.println("Contains 'John': " + fullName.contains("John"));
    }
}
```

### 3. Array Operations
```java
public class ArrayOperations {
    public static void main(String[] args) {
        // Grade calculator using arrays
        int[] grades = {85, 92, 78, 96, 88};
        String[] subjects = {"Math", "Science", "English", "History", "Art"};
        
        // Calculate average
        int sum = 0;
        for (int grade : grades) {
            sum += grade;
        }
        double average = (double) sum / grades.length;
        
        // Find highest grade
        int highest = grades[0];
        String bestSubject = subjects[0];
        for (int i = 1; i < grades.length; i++) {
            if (grades[i] > highest) {
                highest = grades[i];
                bestSubject = subjects[i];
            }
        }
        
        // Display results
        System.out.println("Grade Report:");
        for (int i = 0; i < subjects.length; i++) {
            System.out.println(subjects[i] + ": " + grades[i]);
        }
        System.out.println("\nAverage grade: " + average);
        System.out.println("Highest grade: " + highest + " in " + bestSubject);
    }
}
```

## Common Mistakes and Best Practices

### 1. Common Mistakes
```java
public class CommonMistakes {
    public static void main(String[] args) {
        // Mistake 1: Using uninitialized local variables
        int uninitializedVar;
        // System.out.println(uninitializedVar); // ERROR
        
        // Mistake 2: Integer division losing precision
        int a = 5, b = 2;
        double wrongResult = a / b; // This gives 2.0, not 2.5
        double correctResult = (double) a / b; // This gives 2.5
        
        // Mistake 3: Comparing floating-point numbers directly
        double d1 = 0.1 + 0.2;
        double d2 = 0.3;
        boolean wrongComparison = (d1 == d2); // Often false due to precision
        boolean correctComparison = Math.abs(d1 - d2) < 0.000001;
        
        System.out.println("Wrong division result: " + wrongResult);
        System.out.println("Correct division result: " + correctResult);
        System.out.println("Wrong float comparison: " + wrongComparison);
        System.out.println("Correct float comparison: " + correctComparison);
    }
}
```

### 2. Best Practices
```java
public class BestPractices {
    // Use meaningful names
    private static final int MAX_RETRY_ATTEMPTS = 3;
    private static final double SALES_TAX_RATE = 0.08;
    
    private String customerName;
    private double accountBalance;
    
    public void demonstrateBestPractices() {
        // Initialize variables when declaring
        int itemCount = 0;
        double totalPrice = 0.0;
        boolean isValidTransaction = false;
        
        // Use final for values that won't change
        final String transactionId = "TXN_" + System.currentTimeMillis();
        
        // Choose appropriate data types
        byte smallCounter = 0;     // For small ranges
        int regularCounter = 0;    // For normal integers
        long largeNumber = 0L;     // For large numbers
        double preciseValue = 0.0; // For decimal calculations
        
        System.out.println("Transaction ID: " + transactionId);
        System.out.println("Max retries: " + MAX_RETRY_ATTEMPTS);
        System.out.println("Sales tax rate: " + (SALES_TAX_RATE * 100) + "%");
    }
    
    public static void main(String[] args) {
        BestPractices demo = new BestPractices();
        demo.demonstrateBestPractices();
    }
}
```

## Key Takeaways

1. **Choose the right data type** for your needs (memory and range)
2. **Initialize variables** before using them
3. **Use meaningful names** for variables
4. **Understand scope** - where variables can be accessed
5. **Use final** for constants and immutable values
6. **Be careful with floating-point precision** when comparing
7. **Understand default values** for instance variables
8. **Local variables must be initialized** before use

## Next Steps

Now that you understand variables and data types:
1. Practice with different data types and operations
2. Experiment with variable scope in different contexts
3. Learn about [Operators and Expressions](./operators.md)
4. Study [Type Casting and Conversion](./type-casting.md)
