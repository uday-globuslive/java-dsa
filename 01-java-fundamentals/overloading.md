# Method Overloading in Java

## 🎯 Overview

Method overloading is a powerful feature in Java that allows you to define multiple methods with the same name but different parameter lists within the same class. This enables you to create more flexible and intuitive APIs by providing multiple ways to call the same logical operation with different types or numbers of parameters.

## 📚 Basic Overloading Concepts

### What is Method Overloading?

Method overloading occurs when multiple methods share the same name but have different:
- Number of parameters
- Types of parameters  
- Order of parameter types

The return type alone cannot be used to distinguish overloaded methods.

### Simple Overloading Example
```java
public class BasicOverloading {
    public static void main(String[] args) {
        // Different ways to call the same logical operation
        printInfo("Hello World");                    // String version
        printInfo(42);                              // int version
        printInfo(3.14);                           // double version
        printInfo("Java", 2024);                   // String + int version
        printInfo(100, 200, 300);                  // multiple int version
    }
    
    // Overloaded methods with same name but different parameters
    public static void printInfo(String message) {
        System.out.println("String message: " + message);
    }
    
    public static void printInfo(int number) {
        System.out.println("Integer number: " + number);
    }
    
    public static void printInfo(double number) {
        System.out.println("Double number: " + number);
    }
    
    public static void printInfo(String message, int number) {
        System.out.println("Message: " + message + ", Number: " + number);
    }
    
    public static void printInfo(int a, int b, int c) {
        System.out.println("Three integers: " + a + ", " + b + ", " + c);
    }
}
```

**Output:**
```
String message: Hello World
Integer number: 42
Double number: 3.14
Message: Java, Number: 2024
Three integers: 100, 200, 300
```

## 🔢 Overloading by Number of Parameters

### Calculator Example
```java
public class CalculatorOverloading {
    public static void main(String[] args) {
        // Adding different numbers of values
        System.out.println("Add 2 numbers: " + add(5, 10));
        System.out.println("Add 3 numbers: " + add(5, 10, 15));
        System.out.println("Add 4 numbers: " + add(5, 10, 15, 20));
        
        // Multiplying different numbers of values
        System.out.println("Multiply 2 numbers: " + multiply(3, 4));
        System.out.println("Multiply 3 numbers: " + multiply(3, 4, 5));
        System.out.println("Multiply 4 numbers: " + multiply(2, 3, 4, 5));
    }
    
    // Overloaded add methods with different parameter counts
    public static int add(int a, int b) {
        return a + b;
    }
    
    public static int add(int a, int b, int c) {
        return a + b + c;
    }
    
    public static int add(int a, int b, int c, int d) {
        return a + b + c + d;
    }
    
    // Overloaded multiply methods
    public static int multiply(int a, int b) {
        return a * b;
    }
    
    public static int multiply(int a, int b, int c) {
        return a * b * c;
    }
    
    public static long multiply(int a, int b, int c, int d) {
        return (long) a * b * c * d; // Return long to handle larger results
    }
}
```

## 🎭 Overloading by Parameter Types

### Data Type Variations
```java
public class TypeOverloading {
    public static void main(String[] args) {
        // Same operation on different data types
        System.out.println("Max of ints: " + max(10, 20));
        System.out.println("Max of doubles: " + max(3.14, 2.71));
        System.out.println("Max of longs: " + max(1000L, 2000L));
        System.out.println("Max of floats: " + max(1.5f, 2.5f));
        
        // Different formatting for different types
        display(42);
        display(3.14159);
        display("Hello World");
        display(true);
        display('A');
    }
    
    // Overloaded max methods for different numeric types
    public static int max(int a, int b) {
        System.out.println("Comparing integers");
        return (a > b) ? a : b;
    }
    
    public static double max(double a, double b) {
        System.out.println("Comparing doubles");
        return (a > b) ? a : b;
    }
    
    public static long max(long a, long b) {
        System.out.println("Comparing longs");
        return (a > b) ? a : b;
    }
    
    public static float max(float a, float b) {
        System.out.println("Comparing floats");
        return (a > b) ? a : b;
    }
    
    // Overloaded display methods for different types
    public static void display(int value) {
        System.out.println("Integer: " + value + " (binary: " + 
                          Integer.toBinaryString(value) + ")");
    }
    
    public static void display(double value) {
        System.out.printf("Double: %.4f (scientific: %.2e)%n", value, value);
    }
    
    public static void display(String value) {
        System.out.println("String: \"" + value + "\" (length: " + 
                          value.length() + ")");
    }
    
    public static void display(boolean value) {
        System.out.println("Boolean: " + value + " (opposite: " + !value + ")");
    }
    
    public static void display(char value) {
        System.out.println("Character: '" + value + "' (ASCII: " + 
                          (int) value + ")");
    }
}
```

## 🔄 Overloading by Parameter Order

### Order-Based Overloading
```java
public class OrderOverloading {
    public static void main(String[] args) {
        // Different parameter orders create different methods
        createUser("John Doe", 25);                    // String, int
        createUser(30, "Jane Smith");                  // int, String
        
        formatMessage("Error", 404);                   // String, int
        formatMessage(500, "Internal Server Error");   // int, String
        
        // Mixed type combinations
        processData("DataSet1", 3.14, true);          // String, double, boolean
        processData(42, "Process", false);             // int, String, boolean
        processData(2.71, true, "Result");             // double, boolean, String
    }
    
    // Overloaded by parameter order: String first vs int first
    public static void createUser(String name, int age) {
        System.out.println("Creating user by name first: " + name + 
                          " (age: " + age + ")");
    }
    
    public static void createUser(int age, String name) {
        System.out.println("Creating user by age first: " + age + 
                          " (name: " + name + ")");
    }
    
    // Different parameter orders for message formatting
    public static void formatMessage(String type, int code) {
        System.out.println("[" + type.toUpperCase() + "] Code: " + code);
    }
    
    public static void formatMessage(int code, String description) {
        System.out.println("HTTP " + code + ": " + description);
    }
    
    // Complex parameter order variations
    public static void processData(String name, double value, boolean flag) {
        System.out.println("Processing: " + name + ", Value: " + value + 
                          ", Flag: " + flag);
    }
    
    public static void processData(int id, String description, boolean active) {
        System.out.println("ID: " + id + ", Description: " + description + 
                          ", Active: " + active);
    }
    
    public static void processData(double metric, boolean valid, String label) {
        System.out.println("Metric: " + metric + ", Valid: " + valid + 
                          ", Label: " + label);
    }
}
```

## 💡 Practical Overloading Examples

### String Processing Utilities
```java
public class StringUtilities {
    public static void main(String[] args) {
        // Different ways to truncate strings
        System.out.println("Truncate with length: " + 
                          truncate("Hello World", 5));
        System.out.println("Truncate with suffix: " + 
                          truncate("Hello World", 5, "..."));
        System.out.println("Truncate with custom suffix: " + 
                          truncate("Hello World", 8, " (more)"));
        
        // Different padding options
        System.out.println("Left pad: '" + pad("Hi", 10) + "'");
        System.out.println("Left pad with char: '" + pad("Hi", 10, '*') + "'");
        System.out.println("Right pad: '" + pad("Hi", 10, '*', false) + "'");
        
        // Different ways to clean strings
        System.out.println("Basic clean: '" + clean("  Hello World  ") + "'");
        System.out.println("Clean with replacement: '" + 
                          clean("  Hello--World  ", "--", " ") + "'");
    }
    
    // Overloaded truncate methods
    public static String truncate(String text, int maxLength) {
        return truncate(text, maxLength, "");
    }
    
    public static String truncate(String text, int maxLength, String suffix) {
        if (text == null || text.length() <= maxLength) {
            return text;
        }
        
        int truncateAt = maxLength - suffix.length();
        if (truncateAt < 0) {
            truncateAt = 0;
        }
        
        return text.substring(0, truncateAt) + suffix;
    }
    
    // Overloaded padding methods
    public static String pad(String text, int totalLength) {
        return pad(text, totalLength, ' ', true);
    }
    
    public static String pad(String text, int totalLength, char padChar) {
        return pad(text, totalLength, padChar, true);
    }
    
    public static String pad(String text, int totalLength, char padChar, 
                           boolean leftPad) {
        if (text == null) {
            text = "";
        }
        
        if (text.length() >= totalLength) {
            return text;
        }
        
        StringBuilder padding = new StringBuilder();
        int paddingLength = totalLength - text.length();
        
        for (int i = 0; i < paddingLength; i++) {
            padding.append(padChar);
        }
        
        return leftPad ? padding.toString() + text : text + padding.toString();
    }
    
    // Overloaded string cleaning methods
    public static String clean(String text) {
        return text == null ? "" : text.trim();
    }
    
    public static String clean(String text, String target, String replacement) {
        if (text == null) {
            return "";
        }
        
        return text.replace(target, replacement).trim();
    }
}
```

### Array Processing Utilities
```java
import java.util.Arrays;

public class ArrayUtilities {
    public static void main(String[] args) {
        // Different ways to find elements
        int[] numbers = {1, 5, 3, 9, 2, 7, 4};
        System.out.println("Find 5: " + find(numbers, 5));
        System.out.println("Find from index 3: " + find(numbers, 9, 3));
        System.out.println("Find in range: " + find(numbers, 2, 2, 6));
        
        String[] words = {"apple", "banana", "cherry", "date"};
        System.out.println("Find 'cherry': " + find(words, "cherry"));
        System.out.println("Find from index 1: " + find(words, "date", 1));
        
        // Different ways to create arrays
        int[] array1 = createArray(5);
        int[] array2 = createArray(5, 10);
        int[] array3 = createArray(3, 1, 10);
        
        System.out.println("Default array: " + Arrays.toString(array1));
        System.out.println("Filled array: " + Arrays.toString(array2));
        System.out.println("Random array: " + Arrays.toString(array3));
    }
    
    // Overloaded find methods for int arrays
    public static int find(int[] array, int target) {
        return find(array, target, 0);
    }
    
    public static int find(int[] array, int target, int startIndex) {
        return find(array, target, startIndex, array.length - 1);
    }
    
    public static int find(int[] array, int target, int startIndex, int endIndex) {
        if (array == null || startIndex < 0 || endIndex >= array.length || 
            startIndex > endIndex) {
            return -1;
        }
        
        for (int i = startIndex; i <= endIndex; i++) {
            if (array[i] == target) {
                return i;
            }
        }
        return -1;
    }
    
    // Overloaded find methods for String arrays
    public static int find(String[] array, String target) {
        return find(array, target, 0);
    }
    
    public static int find(String[] array, String target, int startIndex) {
        if (array == null || target == null || startIndex < 0 || 
            startIndex >= array.length) {
            return -1;
        }
        
        for (int i = startIndex; i < array.length; i++) {
            if (target.equals(array[i])) {
                return i;
            }
        }
        return -1;
    }
    
    // Overloaded array creation methods
    public static int[] createArray(int size) {
        return new int[size]; // Default values (0)
    }
    
    public static int[] createArray(int size, int fillValue) {
        int[] array = new int[size];
        Arrays.fill(array, fillValue);
        return array;
    }
    
    public static int[] createArray(int size, int minValue, int maxValue) {
        int[] array = new int[size];
        for (int i = 0; i < size; i++) {
            array[i] = minValue + (int) (Math.random() * (maxValue - minValue + 1));
        }
        return array;
    }
}
```

### Date and Time Utilities
```java
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeUtilities {
    public static void main(String[] args) {
        // Different ways to format dates
        LocalDate today = LocalDate.now();
        LocalDateTime now = LocalDateTime.now();
        
        System.out.println("Default format: " + format(today));
        System.out.println("Custom format: " + format(today, "MM/dd/yyyy"));
        System.out.println("Verbose format: " + format(today, true));
        
        System.out.println("DateTime default: " + format(now));
        System.out.println("DateTime custom: " + format(now, "yyyy-MM-dd HH:mm"));
        
        // Different ways to calculate age
        LocalDate birthDate = LocalDate.of(1990, 5, 15);
        System.out.println("Age in years: " + calculateAge(birthDate));
        System.out.println("Age in months: " + calculateAge(birthDate, "months"));
        System.out.println("Age in days: " + calculateAge(birthDate, "days"));
    }
    
    // Overloaded format methods for LocalDate
    public static String format(LocalDate date) {
        return format(date, "yyyy-MM-dd");
    }
    
    public static String format(LocalDate date, String pattern) {
        if (date == null) {
            return "";
        }
        
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
            return date.format(formatter);
        } catch (Exception e) {
            return date.toString(); // Fallback to default format
        }
    }
    
    public static String format(LocalDate date, boolean verbose) {
        if (date == null) {
            return "";
        }
        
        if (verbose) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
                "EEEE, MMMM d, yyyy");
            return date.format(formatter);
        } else {
            return format(date); // Use default format
        }
    }
    
    // Overloaded format methods for LocalDateTime
    public static String format(LocalDateTime dateTime) {
        return format(dateTime, "yyyy-MM-dd HH:mm:ss");
    }
    
    public static String format(LocalDateTime dateTime, String pattern) {
        if (dateTime == null) {
            return "";
        }
        
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);
            return dateTime.format(formatter);
        } catch (Exception e) {
            return dateTime.toString(); // Fallback to default format
        }
    }
    
    // Overloaded age calculation methods
    public static long calculateAge(LocalDate birthDate) {
        return calculateAge(birthDate, "years");
    }
    
    public static long calculateAge(LocalDate birthDate, String unit) {
        if (birthDate == null) {
            return 0;
        }
        
        LocalDate today = LocalDate.now();
        
        switch (unit.toLowerCase()) {
            case "years":
                return java.time.Period.between(birthDate, today).getYears();
            case "months":
                return java.time.Period.between(birthDate, today).toTotalMonths();
            case "days":
                return java.time.temporal.ChronoUnit.DAYS.between(birthDate, today);
            default:
                return calculateAge(birthDate); // Default to years
        }
    }
}
```

## ⚖️ Method Resolution and Ambiguity

### Understanding Method Resolution
```java
public class MethodResolution {
    public static void main(String[] args) {
        // Demonstrating how Java chooses which overloaded method to call
        
        // Exact match
        process(5);        // Calls process(int)
        process(5.0);      // Calls process(double)
        process("Hello");  // Calls process(String)
        
        // Widening conversions
        process((byte) 5);   // byte -> int (calls process(int))
        process((short) 5);  // short -> int (calls process(int))
        process(5L);         // long -> double (calls process(double))
        process(5.0f);       // float -> double (calls process(double))
        
        // Autoboxing
        process(Integer.valueOf(5)); // Calls process(Integer)
        
        // Varargs (lowest priority)
        process(1, 2, 3);    // Calls process(int...)
    }
    
    public static void process(int value) {
        System.out.println("Processing int: " + value);
    }
    
    public static void process(double value) {
        System.out.println("Processing double: " + value);
    }
    
    public static void process(String value) {
        System.out.println("Processing String: " + value);
    }
    
    public static void process(Integer value) {
        System.out.println("Processing Integer object: " + value);
    }
    
    public static void process(int... values) {
        System.out.println("Processing varargs: " + 
                          java.util.Arrays.toString(values));
    }
}
```

### Ambiguous Overloading (Compilation Errors)
```java
public class AmbiguousOverloading {
    
    // COMPILATION ERROR: These methods are ambiguous
    /*
    public static void ambiguous(int a, double b) {
        System.out.println("int, double");
    }
    
    public static void ambiguous(double a, int b) {
        System.out.println("double, int");
    }
    
    // Calling ambiguous(5, 10) would be ambiguous because:
    // - Could be ambiguous(int, double) with 10 widened to 10.0
    // - Could be ambiguous(double, int) with 5 widened to 5.0
    */
    
    // SOLUTION: Make method signatures clearly distinct
    public static void processIntDouble(int a, double b) {
        System.out.println("Processing int: " + a + ", double: " + b);
    }
    
    public static void processDoubleInt(double a, int b) {
        System.out.println("Processing double: " + a + ", int: " + b);
    }
    
    // COMPILATION ERROR: Return type alone cannot distinguish methods
    /*
    public static int getValue() {
        return 5;
    }
    
    public static double getValue() {  // ERROR!
        return 5.0;
    }
    */
    
    // SOLUTION: Use different method names or parameters
    public static int getIntValue() {
        return 5;
    }
    
    public static double getDoubleValue() {
        return 5.0;
    }
    
    public static void main(String[] args) {
        processIntDouble(5, 10.0);
        processDoubleInt(5.0, 10);
        
        System.out.println("Int value: " + getIntValue());
        System.out.println("Double value: " + getDoubleValue());
    }
}
```

## ⚠️ Best Practices and Guidelines

### 1. Consistent Behavior Across Overloads
```java
public class ConsistentBehavior {
    
    // GOOD: All overloads have consistent behavior
    public static String concatenate(String a, String b) {
        return (a != null ? a : "") + (b != null ? b : "");
    }
    
    public static String concatenate(String a, String b, String c) {
        return concatenate(concatenate(a, b), c);
    }
    
    public static String concatenate(String... strings) {
        if (strings == null || strings.length == 0) {
            return "";
        }
        
        StringBuilder result = new StringBuilder();
        for (String s : strings) {
            result.append(s != null ? s : "");
        }
        return result.toString();
    }
    
    // BAD: Inconsistent behavior across overloads
    /*
    public static String badConcatenate(String a, String b) {
        return a + b;  // Doesn't handle nulls
    }
    
    public static String badConcatenate(String a, String b, String c) {
        // Different null handling behavior
        if (a == null) a = "";
        if (b == null) b = "";
        if (c == null) c = "";
        return a + b + c;
    }
    */
    
    public static void main(String[] args) {
        System.out.println("Two strings: '" + 
                          concatenate("Hello", " World") + "'");
        System.out.println("Three strings: '" + 
                          concatenate("Hello", " ", "World") + "'");
        System.out.println("Multiple strings: '" + 
                          concatenate("Java", " is", " awesome", "!") + "'");
        
        // Test null handling consistency
        System.out.println("With nulls: '" + 
                          concatenate(null, "World", null) + "'");
    }
}
```

### 2. Logical Parameter Progression
```java
public class LogicalProgression {
    
    // GOOD: Each overload adds more specific options
    public static void drawRectangle(int width, int height) {
        drawRectangle(width, height, '*');
    }
    
    public static void drawRectangle(int width, int height, char fillChar) {
        drawRectangle(width, height, fillChar, false);
    }
    
    public static void drawRectangle(int width, int height, char fillChar, 
                                   boolean outline) {
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                if (outline && (i == 0 || i == height - 1 || j == 0 || j == width - 1)) {
                    System.out.print(fillChar);
                } else if (!outline) {
                    System.out.print(fillChar);
                } else {
                    System.out.print(' ');
                }
            }
            System.out.println();
        }
        System.out.println();
    }
    
    public static void main(String[] args) {
        System.out.println("Basic rectangle:");
        drawRectangle(5, 3);
        
        System.out.println("Custom character:");
        drawRectangle(5, 3, '#');
        
        System.out.println("Outline only:");
        drawRectangle(5, 3, '@', true);
    }
}
```

### 3. Documentation and Naming
```java
public class WellDocumentedOverloading {
    
    /**
     * Searches for a substring in the given text.
     * @param text the text to search in
     * @param target the substring to find
     * @return the index of the first occurrence, or -1 if not found
     */
    public static int search(String text, String target) {
        return search(text, target, 0);
    }
    
    /**
     * Searches for a substring starting from a specific index.
     * @param text the text to search in
     * @param target the substring to find
     * @param startIndex the index to start searching from
     * @return the index of the first occurrence, or -1 if not found
     */
    public static int search(String text, String target, int startIndex) {
        return search(text, target, startIndex, false);
    }
    
    /**
     * Searches for a substring with case sensitivity option.
     * @param text the text to search in
     * @param target the substring to find
     * @param startIndex the index to start searching from
     * @param ignoreCase whether to ignore case differences
     * @return the index of the first occurrence, or -1 if not found
     */
    public static int search(String text, String target, int startIndex, 
                           boolean ignoreCase) {
        if (text == null || target == null || startIndex < 0 || 
            startIndex >= text.length()) {
            return -1;
        }
        
        String searchText = ignoreCase ? text.toLowerCase() : text;
        String searchTarget = ignoreCase ? target.toLowerCase() : target;
        
        return searchText.indexOf(searchTarget, startIndex);
    }
    
    public static void main(String[] args) {
        String text = "Hello World, Hello Java";
        
        System.out.println("Basic search for 'Hello': " + 
                          search(text, "Hello"));
        System.out.println("Search from index 10: " + 
                          search(text, "Hello", 10));
        System.out.println("Case-insensitive search for 'hello': " + 
                          search(text, "hello", 0, true));
    }
}
```

## 📋 Summary

- **Method Overloading:** Multiple methods with same name but different parameter lists
- **Distinguishing Factors:** Number, types, or order of parameters (not return type)
- **Method Resolution:** Java chooses the most specific matching method
- **Best Practices:** Consistent behavior, logical progression, clear documentation
- **Avoid Ambiguity:** Ensure overloaded methods can be clearly distinguished

## 🔗 Related Topics

- [Methods](./methods.md) - Basic method declaration and structure
- [Parameters](./parameters.md) - Method parameter details
- [Return Types](./return-types.md) - Method return values
- [Constructors](../02-oop-basics/constructors.md) - Constructor overloading

## 🎯 Practice Exercises

1. Create an overloaded `format` method for different number types with various precision options
2. Implement overloaded `sort` methods for different array types and sorting orders
3. Build an overloaded `validate` method for different input types (email, phone, etc.)
4. Create overloaded `convert` methods for different unit conversions (temperature, distance, etc.)
5. Implement an overloaded `log` method for different log levels and output formats
