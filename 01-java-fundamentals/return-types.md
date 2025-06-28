# Return Types in Java

## 🎯 Overview

Return types specify what kind of data a method sends back to the caller after execution. Understanding return types is fundamental to creating methods that produce useful results and can be chained together to build complex functionality. Java supports various return types including primitives, objects, arrays, and special cases like void.

## 📚 Basic Return Type Concepts

### Method Signature with Return Types
```java
// General syntax
accessModifier static/non-static returnType methodName(parameters) {
    // Method body
    return value; // Must match return type
}

// Examples of different return types
public static int getNumber() {
    return 42;
}

public static String getMessage() {
    return "Hello, World!";
}

public static void displayInfo() {
    System.out.println("This method returns nothing");
    // No return statement needed for void
}
```

### Simple Return Type Examples
```java
public class BasicReturnTypes {
    public static void main(String[] args) {
        // Using methods with different return types
        int number = getRandomNumber();
        System.out.println("Random number: " + number);
        
        String greeting = createGreeting("Alice");
        System.out.println(greeting);
        
        boolean isValid = validateAge(25);
        System.out.println("Age is valid: " + isValid);
        
        double area = calculateCircleArea(5.0);
        System.out.println("Circle area: " + area);
    }
    
    // Returns int
    public static int getRandomNumber() {
        return (int) (Math.random() * 100) + 1;
    }
    
    // Returns String
    public static String createGreeting(String name) {
        return "Hello, " + name + "! Welcome to Java.";
    }
    
    // Returns boolean
    public static boolean validateAge(int age) {
        return age >= 0 && age <= 120;
    }
    
    // Returns double
    public static double calculateCircleArea(double radius) {
        return Math.PI * radius * radius;
    }
}
```

## 🔧 Primitive Return Types

### All Primitive Return Types
```java
public class PrimitiveReturnTypes {
    public static void main(String[] args) {
        System.out.println("Byte value: " + getByteValue());
        System.out.println("Short value: " + getShortValue());
        System.out.println("Int value: " + getIntValue());
        System.out.println("Long value: " + getLongValue());
        System.out.println("Float value: " + getFloatValue());
        System.out.println("Double value: " + getDoubleValue());
        System.out.println("Char value: " + getCharValue());
        System.out.println("Boolean value: " + getBooleanValue());
    }
    
    public static byte getByteValue() {
        return 127; // Max byte value
    }
    
    public static short getShortValue() {
        return 32767; // Max short value
    }
    
    public static int getIntValue() {
        return 2147483647; // Max int value
    }
    
    public static long getLongValue() {
        return 9223372036854775807L; // Max long value
    }
    
    public static float getFloatValue() {
        return 3.14159f;
    }
    
    public static double getDoubleValue() {
        return 2.718281828459045;
    }
    
    public static char getCharValue() {
        return 'A';
    }
    
    public static boolean getBooleanValue() {
        return true;
    }
}
```

### Conditional Returns with Primitives
```java
public class ConditionalPrimitiveReturns {
    public static void main(String[] args) {
        System.out.println("Grade for 95: " + getLetterGrade(95));
        System.out.println("Grade for 67: " + getLetterGrade(67));
        System.out.println("Absolute value of -5: " + absoluteValue(-5));
        System.out.println("Max of 10, 20: " + maximum(10, 20));
    }
    
    public static char getLetterGrade(int score) {
        if (score >= 90) {
            return 'A';
        } else if (score >= 80) {
            return 'B';
        } else if (score >= 70) {
            return 'C';
        } else if (score >= 60) {
            return 'D';
        } else {
            return 'F';
        }
    }
    
    public static int absoluteValue(int number) {
        if (number < 0) {
            return -number;
        } else {
            return number;
        }
    }
    
    public static double maximum(double a, double b) {
        return (a > b) ? a : b; // Ternary operator
    }
}
```

## 📦 Object Return Types

### String Return Types
```java
public class StringReturnTypes {
    public static void main(String[] args) {
        System.out.println(formatName("john", "doe"));
        System.out.println(reverseString("hello"));
        System.out.println(getFileExtension("document.pdf"));
        System.out.println(generatePassword(8));
    }
    
    public static String formatName(String firstName, String lastName) {
        if (firstName == null || lastName == null) {
            return "Unknown";
        }
        
        String formattedFirst = firstName.substring(0, 1).toUpperCase() + 
                               firstName.substring(1).toLowerCase();
        String formattedLast = lastName.substring(0, 1).toUpperCase() + 
                              lastName.substring(1).toLowerCase();
        
        return formattedLast + ", " + formattedFirst;
    }
    
    public static String reverseString(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }
        
        StringBuilder reversed = new StringBuilder();
        for (int i = input.length() - 1; i >= 0; i--) {
            reversed.append(input.charAt(i));
        }
        return reversed.toString();
    }
    
    public static String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        
        int lastDotIndex = filename.lastIndexOf('.');
        return filename.substring(lastDotIndex + 1);
    }
    
    public static String generatePassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder password = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            int index = (int) (Math.random() * chars.length());
            password.append(chars.charAt(index));
        }
        
        return password.toString();
    }
}
```

### Array Return Types
```java
public class ArrayReturnTypes {
    public static void main(String[] args) {
        int[] numbers = generateNumbers(5);
        System.out.println("Generated numbers: " + 
                          java.util.Arrays.toString(numbers));
        
        String[] words = splitSentence("Hello world from Java");
        System.out.println("Words: " + java.util.Arrays.toString(words));
        
        int[] evenNumbers = filterEvenNumbers(new int[]{1, 2, 3, 4, 5, 6, 7, 8});
        System.out.println("Even numbers: " + 
                          java.util.Arrays.toString(evenNumbers));
        
        int[][] matrix = createIdentityMatrix(3);
        System.out.println("Identity matrix:");
        printMatrix(matrix);
    }
    
    public static int[] generateNumbers(int count) {
        int[] numbers = new int[count];
        for (int i = 0; i < count; i++) {
            numbers[i] = (int) (Math.random() * 100) + 1;
        }
        return numbers;
    }
    
    public static String[] splitSentence(String sentence) {
        if (sentence == null || sentence.trim().isEmpty()) {
            return new String[0]; // Return empty array
        }
        return sentence.trim().split("\\s+");
    }
    
    public static int[] filterEvenNumbers(int[] input) {
        if (input == null) {
            return new int[0];
        }
        
        // Count even numbers first
        int evenCount = 0;
        for (int num : input) {
            if (num % 2 == 0) {
                evenCount++;
            }
        }
        
        // Create result array
        int[] evenNumbers = new int[evenCount];
        int index = 0;
        for (int num : input) {
            if (num % 2 == 0) {
                evenNumbers[index++] = num;
            }
        }
        
        return evenNumbers;
    }
    
    public static int[][] createIdentityMatrix(int size) {
        int[][] matrix = new int[size][size];
        for (int i = 0; i < size; i++) {
            matrix[i][i] = 1; // Set diagonal elements to 1
        }
        return matrix;
    }
    
    public static void printMatrix(int[][] matrix) {
        for (int[] row : matrix) {
            for (int element : row) {
                System.out.printf("%3d ", element);
            }
            System.out.println();
        }
    }
}
```

### Custom Object Return Types
```java
// Custom classes for demonstration
class Person {
    private String name;
    private int age;
    private String email;
    
    public Person(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }
    
    // Getters and setters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getEmail() { return email; }
    
    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + ", email='" + email + "'}";
    }
}

class Result {
    private boolean success;
    private String message;
    private Object data;
    
    public Result(boolean success, String message, Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }
    
    public boolean isSuccess() { return success; }
    public String getMessage() { return message; }
    public Object getData() { return data; }
    
    @Override
    public String toString() {
        return "Result{success=" + success + ", message='" + message + "', data=" + data + "}";
    }
}

public class CustomObjectReturnTypes {
    public static void main(String[] args) {
        Person person = createPerson("Alice Johnson", 30, "alice@example.com");
        System.out.println("Created person: " + person);
        
        Result validationResult = validatePerson(person);
        System.out.println("Validation result: " + validationResult);
        
        Person foundPerson = findPersonByName("Alice Johnson");
        System.out.println("Found person: " + foundPerson);
        
        Result operationResult = performOperation("divide", 10, 2);
        System.out.println("Operation result: " + operationResult);
    }
    
    public static Person createPerson(String name, int age, String email) {
        return new Person(name, age, email);
    }
    
    public static Result validatePerson(Person person) {
        if (person == null) {
            return new Result(false, "Person cannot be null", null);
        }
        
        if (person.getName() == null || person.getName().trim().isEmpty()) {
            return new Result(false, "Name is required", null);
        }
        
        if (person.getAge() < 0 || person.getAge() > 150) {
            return new Result(false, "Invalid age range", null);
        }
        
        if (person.getEmail() == null || !person.getEmail().contains("@")) {
            return new Result(false, "Invalid email format", null);
        }
        
        return new Result(true, "Person is valid", person);
    }
    
    public static Person findPersonByName(String name) {
        // Simulate database lookup
        if ("Alice Johnson".equals(name)) {
            return new Person("Alice Johnson", 30, "alice@example.com");
        } else if ("Bob Smith".equals(name)) {
            return new Person("Bob Smith", 25, "bob@example.com");
        } else {
            return null; // Person not found
        }
    }
    
    public static Result performOperation(String operation, double a, double b) {
        switch (operation.toLowerCase()) {
            case "add":
                return new Result(true, "Addition successful", a + b);
            case "subtract":
                return new Result(true, "Subtraction successful", a - b);
            case "multiply":
                return new Result(true, "Multiplication successful", a * b);
            case "divide":
                if (b == 0) {
                    return new Result(false, "Division by zero", null);
                }
                return new Result(true, "Division successful", a / b);
            default:
                return new Result(false, "Unknown operation: " + operation, null);
        }
    }
}
```

## 🚫 Void Return Type

### Understanding Void Methods
```java
import java.util.Scanner;

public class VoidReturnMethods {
    public static void main(String[] args) {
        // Void methods don't return values, they perform actions
        printWelcomeMessage();
        displayCurrentTime();
        
        int[] numbers = {5, 2, 8, 1, 9, 3};
        System.out.println("Before sorting: " + 
                          java.util.Arrays.toString(numbers));
        sortArray(numbers); // Modifies the array in-place
        System.out.println("After sorting: " + 
                          java.util.Arrays.toString(numbers));
        
        processUserInput();
    }
    
    public static void printWelcomeMessage() {
        System.out.println("=" .repeat(50));
        System.out.println("    Welcome to Java Programming!");
        System.out.println("=" .repeat(50));
    }
    
    public static void displayCurrentTime() {
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        java.time.format.DateTimeFormatter formatter = 
            java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        System.out.println("Current time: " + now.format(formatter));
    }
    
    public static void sortArray(int[] array) {
        // Bubble sort - modifies array in place
        for (int i = 0; i < array.length - 1; i++) {
            for (int j = 0; j < array.length - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    // Swap elements
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }
    
    public static void processUserInput() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your name: ");
        String name = scanner.nextLine();
        
        System.out.print("Enter your age: ");
        int age = scanner.nextInt();
        
        // Process and display information
        displayUserInfo(name, age);
        scanner.close();
    }
    
    public static void displayUserInfo(String name, int age) {
        System.out.println("\n--- User Information ---");
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        
        if (age >= 18) {
            System.out.println("Status: Adult");
        } else {
            System.out.println("Status: Minor");
        }
    }
}
```

### Early Returns in Void Methods
```java
public class VoidEarlyReturns {
    public static void main(String[] args) {
        validateAndProcess(null);
        validateAndProcess("");
        validateAndProcess("valid input");
        
        printNumberInfo(-5);
        printNumberInfo(0);
        printNumberInfo(15);
    }
    
    public static void validateAndProcess(String input) {
        System.out.println("Processing input: '" + input + "'");
        
        // Early return for null input
        if (input == null) {
            System.out.println("Error: Input is null");
            return; // Exit method early
        }
        
        // Early return for empty input
        if (input.trim().isEmpty()) {
            System.out.println("Error: Input is empty");
            return; // Exit method early
        }
        
        // Process valid input
        System.out.println("Input is valid: " + input.toUpperCase());
        System.out.println("Length: " + input.length());
        System.out.println("Processing complete!\n");
    }
    
    public static void printNumberInfo(int number) {
        System.out.println("Analyzing number: " + number);
        
        // Early return for negative numbers
        if (number < 0) {
            System.out.println("Cannot process negative numbers\n");
            return;
        }
        
        // Early return for zero
        if (number == 0) {
            System.out.println("Number is zero - no further analysis needed\n");
            return;
        }
        
        // Process positive numbers
        System.out.println("Number is positive");
        System.out.println("Square: " + (number * number));
        System.out.println("Is even: " + (number % 2 == 0));
        System.out.println("Analysis complete!\n");
    }
}
```

## 🔄 Multiple Return Statements

### Conditional Returns
```java
public class MultipleReturnStatements {
    public static void main(String[] args) {
        System.out.println("Day type for 1: " + getDayType(1));
        System.out.println("Day type for 6: " + getDayType(6));
        System.out.println("Day type for 8: " + getDayType(8));
        
        System.out.println("Grade description for A: " + getGradeDescription('A'));
        System.out.println("Grade description for C: " + getGradeDescription('C'));
        System.out.println("Grade description for X: " + getGradeDescription('X'));
        
        System.out.println("Number category for -5: " + categorizeNumber(-5));
        System.out.println("Number category for 0: " + categorizeNumber(0));
        System.out.println("Number category for 42: " + categorizeNumber(42));
    }
    
    public static String getDayType(int dayOfWeek) {
        if (dayOfWeek >= 1 && dayOfWeek <= 5) {
            return "Weekday";
        } else if (dayOfWeek == 6 || dayOfWeek == 7) {
            return "Weekend";
        } else {
            return "Invalid day";
        }
    }
    
    public static String getGradeDescription(char grade) {
        switch (Character.toUpperCase(grade)) {
            case 'A':
                return "Excellent";
            case 'B':
                return "Good";
            case 'C':
                return "Average";
            case 'D':
                return "Below Average";
            case 'F':
                return "Fail";
            default:
                return "Invalid Grade";
        }
    }
    
    public static String categorizeNumber(int number) {
        if (number > 0) {
            return "Positive";
        }
        
        if (number < 0) {
            return "Negative";
        }
        
        return "Zero"; // This handles number == 0
    }
    
    // Complex example with multiple conditions
    public static String analyzePassword(String password) {
        if (password == null) {
            return "Password cannot be null";
        }
        
        if (password.length() < 8) {
            return "Password too short (minimum 8 characters)";
        }
        
        if (password.length() > 128) {
            return "Password too long (maximum 128 characters)";
        }
        
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUpper = true;
            } else if (Character.isLowerCase(c)) {
                hasLower = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isLetterOrDigit(c)) {
                hasSpecial = true;
            }
        }
        
        if (!hasUpper) {
            return "Password must contain at least one uppercase letter";
        }
        
        if (!hasLower) {
            return "Password must contain at least one lowercase letter";
        }
        
        if (!hasDigit) {
            return "Password must contain at least one digit";
        }
        
        if (!hasSpecial) {
            return "Password must contain at least one special character";
        }
        
        return "Password is strong";
    }
}
```

## 💡 Advanced Return Patterns

### Optional Return Types (Java 8+)
```java
import java.util.Optional;

public class OptionalReturnTypes {
    public static void main(String[] args) {
        // Using Optional to handle potentially null returns
        Optional<String> result1 = findUserEmail("john");
        if (result1.isPresent()) {
            System.out.println("Found email: " + result1.get());
        } else {
            System.out.println("Email not found for john");
        }
        
        // Using Optional with default values
        String email = findUserEmail("jane").orElse("no-email@example.com");
        System.out.println("Email for jane: " + email);
        
        // Using Optional with alternative actions
        findUserEmail("bob").ifPresentOrElse(
            e -> System.out.println("Bob's email: " + e),
            () -> System.out.println("Bob's email not found")
        );
        
        // Chaining Optional operations
        Optional<Integer> number = parsePositiveInteger("42");
        number.map(n -> n * 2)
              .filter(n -> n > 50)
              .ifPresent(n -> System.out.println("Doubled and filtered: " + n));
    }
    
    public static Optional<String> findUserEmail(String username) {
        // Simulate database lookup
        switch (username.toLowerCase()) {
            case "john":
                return Optional.of("john@example.com");
            case "jane":
                return Optional.of("jane@example.com");
            default:
                return Optional.empty(); // No result found
        }
    }
    
    public static Optional<Integer> parsePositiveInteger(String str) {
        try {
            int value = Integer.parseInt(str);
            return value > 0 ? Optional.of(value) : Optional.empty();
        } catch (NumberFormatException e) {
            return Optional.empty();
        }
    }
}
```

### Generic Return Types
```java
import java.util.ArrayList;
import java.util.List;

public class GenericReturnTypes {
    public static void main(String[] args) {
        List<String> stringList = createList("Hello", "World", "Java");
        System.out.println("String list: " + stringList);
        
        List<Integer> intList = createList(1, 2, 3, 4, 5);
        System.out.println("Integer list: " + intList);
        
        String maxString = findMax("apple", "banana", "cherry");
        System.out.println("Max string: " + maxString);
        
        Integer maxInt = findMax(10, 5, 20, 15);
        System.out.println("Max integer: " + maxInt);
        
        // Using generic methods with custom objects
        Person person1 = new Person("Alice", 30, "alice@example.com");
        Person person2 = new Person("Bob", 25, "bob@example.com");
        Person olderPerson = findMax(person1, person2);
        System.out.println("Older person: " + olderPerson);
    }
    
    // Generic method that returns a List of type T
    @SafeVarargs
    public static <T> List<T> createList(T... elements) {
        List<T> list = new ArrayList<>();
        for (T element : elements) {
            list.add(element);
        }
        return list;
    }
    
    // Generic method that finds maximum of comparable elements
    @SafeVarargs
    public static <T extends Comparable<T>> T findMax(T... elements) {
        if (elements.length == 0) {
            return null;
        }
        
        T max = elements[0];
        for (int i = 1; i < elements.length; i++) {
            if (elements[i].compareTo(max) > 0) {
                max = elements[i];
            }
        }
        return max;
    }
    
    // Generic method with bounded type parameter
    public static <T extends Number> double calculateAverage(List<T> numbers) {
        if (numbers.isEmpty()) {
            return 0.0;
        }
        
        double sum = 0.0;
        for (T number : numbers) {
            sum += number.doubleValue();
        }
        return sum / numbers.size();
    }
}

// Person class implementing Comparable for generic method example
class Person implements Comparable<Person> {
    private String name;
    private int age;
    private String email;
    
    public Person(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }
    
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getEmail() { return email; }
    
    @Override
    public int compareTo(Person other) {
        return Integer.compare(this.age, other.age);
    }
    
    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + "}";
    }
}
```

## ⚠️ Best Practices and Common Pitfalls

### 1. Consistent Return Types
```java
public class ConsistentReturnTypes {
    
    // BAD: Inconsistent return behavior
    public static String badGetUserName(int userId) {
        if (userId == 1) {
            return "John";
        } else if (userId == 2) {
            return "Jane";
        }
        // Missing return for other cases - compilation error!
        // return null; // This line is needed
    }
    
    // GOOD: All paths return a value
    public static String getUserName(int userId) {
        switch (userId) {
            case 1:
                return "John";
            case 2:
                return "Jane";
            default:
                return "Unknown User";
        }
    }
    
    // BETTER: Use Optional for potentially missing values
    public static Optional<String> findUserName(int userId) {
        switch (userId) {
            case 1:
                return Optional.of("John");
            case 2:
                return Optional.of("Jane");
            default:
                return Optional.empty();
        }
    }
}
```

### 2. Null Safety
```java
public class NullSafetyReturns {
    
    // BAD: Can return null unexpectedly
    public static String[] badSplitString(String input) {
        if (input.contains(",")) {
            return input.split(",");
        }
        return null; // Potential NullPointerException for caller
    }
    
    // GOOD: Never return null for arrays/collections
    public static String[] splitString(String input) {
        if (input == null || !input.contains(",")) {
            return new String[0]; // Return empty array instead of null
        }
        return input.split(",");
    }
    
    // BETTER: Use defensive programming
    public static List<String> splitStringToList(String input) {
        List<String> result = new ArrayList<>();
        if (input != null && input.contains(",")) {
            String[] parts = input.split(",");
            for (String part : parts) {
                result.add(part.trim());
            }
        } else if (input != null) {
            result.add(input.trim());
        }
        return result; // Never null
    }
    
    // BEST: Document return behavior clearly
    /**
     * Finds a user by ID.
     * @param userId the user ID to search for
     * @return the user if found, null if not found or invalid ID
     */
    public static User findUser(int userId) {
        if (userId <= 0) {
            return null; // Clearly documented behavior
        }
        
        // Simulate database lookup
        if (userId == 1) {
            return new User("John", "john@example.com");
        }
        
        return null; // User not found
    }
    
    static class User {
        private String name;
        private String email;
        
        public User(String name, String email) {
            this.name = name;
            this.email = email;
        }
        
        public String getName() { return name; }
        public String getEmail() { return email; }
    }
}
```

### 3. Performance Considerations
```java
public class PerformanceConsiderations {
    
    // AVOID: Creating unnecessary objects
    public static String badConcatenation(String[] words) {
        String result = "";
        for (String word : words) {
            result += word + " "; // Creates new String objects repeatedly
        }
        return result.trim();
    }
    
    // BETTER: Use StringBuilder for string concatenation
    public static String efficientConcatenation(String[] words) {
        if (words == null || words.length == 0) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            sb.append(words[i]);
            if (i < words.length - 1) {
                sb.append(" ");
            }
        }
        return sb.toString();
    }
    
    // GOOD: Cache expensive computations
    private static final java.util.Map<Integer, Long> fibonacciCache = 
        new java.util.HashMap<>();
    
    public static long fibonacci(int n) {
        if (n <= 1) {
            return n;
        }
        
        // Check cache first
        if (fibonacciCache.containsKey(n)) {
            return fibonacciCache.get(n);
        }
        
        // Compute and cache result
        long result = fibonacci(n - 1) + fibonacci(n - 2);
        fibonacciCache.put(n, result);
        return result;
    }
    
    // GOOD: Return immutable objects when possible
    public static List<String> getConstantList() {
        return java.util.Arrays.asList("One", "Two", "Three");
        // Or for full immutability in newer Java versions:
        // return List.of("One", "Two", "Three");
    }
}
```

## 📋 Summary

- **Return Types:** Specify what data a method returns to its caller
- **Primitive Returns:** Return fundamental data types (int, double, boolean, etc.)
- **Object Returns:** Return complex objects, arrays, strings, or custom classes
- **Void Methods:** Perform actions without returning values
- **Multiple Returns:** Use conditional logic to return different values
- **Best Practices:** Ensure all paths return values, handle null safely, document behavior

## 🔗 Related Topics

- [Methods](./methods.md) - Method declaration and structure
- [Parameters](./parameters.md) - Method input parameters
- [Method Overloading](./overloading.md) - Multiple methods with same name
- [Exception Handling](./exception-handling.md) - Handling errors in methods

## 🎯 Practice Exercises

1. Create a calculator class with methods returning different numeric types
2. Implement string manipulation methods with various return types
3. Build a data validation system using boolean return types
4. Create array processing methods that return filtered or transformed arrays
5. Implement a file utility class with methods returning Optional types for safe operations
