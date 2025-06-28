# Method Declaration and Definition

## Overview
Methods are blocks of code that perform specific tasks and can be called from other parts of the program. Understanding method declaration, definition, and usage is fundamental to writing organized and reusable Java code.

## Method Structure

### Basic Method Syntax
```java
[access_modifier] [static] return_type method_name(parameter_list) {
    // Method body
    return value; // if return_type is not void
}
```

### Complete Method Example
```java
public class MethodBasics {
    
    // Method with all components
    public static int calculateSum(int a, int b) {
        int sum = a + b;
        return sum;
    }
    
    // Method without return value (void)
    public static void displayMessage(String message) {
        System.out.println("Message: " + message);
    }
    
    // Method without parameters
    public static double getCurrentTime() {
        return System.currentTimeMillis();
    }
    
    public static void main(String[] args) {
        // Calling methods
        int result = calculateSum(10, 20);
        displayMessage("Hello, World!");
        double time = getCurrentTime();
        
        System.out.println("Sum: " + result);
        System.out.println("Current time: " + time);
    }
}
```

## Access Modifiers

### Public Methods
```java
public class PublicMethods {
    // Public method - accessible from anywhere
    public static void publicMethod() {
        System.out.println("This is a public method");
    }
    
    public static int add(int a, int b) {
        return a + b;
    }
}

// Another class can access public methods
class AnotherClass {
    public void usePublicMethod() {
        PublicMethods.publicMethod(); // Can access public static method
        int sum = PublicMethods.add(5, 3);
    }
}
```

### Private Methods
```java
public class PrivateMethods {
    // Private method - only accessible within this class
    private static void privateMethod() {
        System.out.println("This is a private method");
    }
    
    private static boolean isValidAge(int age) {
        return age >= 0 && age <= 150;
    }
    
    // Public method that uses private method
    public static void validateAndPrintAge(int age) {
        if (isValidAge(age)) {
            System.out.println("Valid age: " + age);
        } else {
            System.out.println("Invalid age: " + age);
        }
    }
    
    public static void main(String[] args) {
        // Can call private method from within same class
        privateMethod();
        validateAndPrintAge(25);
        validateAndPrintAge(-5);
    }
}
```

### Protected and Package-Private Methods
```java
public class AccessModifierDemo {
    // Protected method - accessible within package and subclasses
    protected static void protectedMethod() {
        System.out.println("Protected method");
    }
    
    // Package-private method (no modifier) - accessible within package
    static void packagePrivateMethod() {
        System.out.println("Package-private method");
    }
    
    // Private method - only within this class
    private static void privateMethod() {
        System.out.println("Private method");
    }
    
    // Public method - accessible everywhere
    public static void publicMethod() {
        System.out.println("Public method");
    }
}
```

## Static vs Instance Methods

### Static Methods
```java
public class StaticMethods {
    private static int counter = 0;
    
    // Static method - belongs to class, not instance
    public static void incrementCounter() {
        counter++;
    }
    
    public static int getCounter() {
        return counter;
    }
    
    // Static method accessing static variables
    public static void resetCounter() {
        counter = 0;
        System.out.println("Counter reset to: " + counter);
    }
    
    public static void main(String[] args) {
        // Calling static methods using class name
        StaticMethods.incrementCounter();
        StaticMethods.incrementCounter();
        System.out.println("Counter value: " + StaticMethods.getCounter());
        
        StaticMethods.resetCounter();
    }
}
```

### Instance Methods
```java
public class InstanceMethods {
    private String name;
    private int age;
    
    // Constructor
    public InstanceMethods(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // Instance method - requires object to call
    public void displayInfo() {
        System.out.println("Name: " + name + ", Age: " + age);
    }
    
    public void celebrateBirthday() {
        age++;
        System.out.println("Happy Birthday! New age: " + age);
    }
    
    // Instance method with return value
    public String getFullInfo() {
        return "Person: " + name + " (Age: " + age + ")";
    }
    
    // Instance method calling another instance method
    public void introduce() {
        displayInfo(); // Can call other instance methods directly
        System.out.println("Nice to meet you!");
    }
    
    public static void main(String[] args) {
        // Must create object to call instance methods
        InstanceMethods person = new InstanceMethods("Alice", 25);
        
        person.displayInfo();
        person.celebrateBirthday();
        System.out.println(person.getFullInfo());
        person.introduce();
    }
}
```

## Return Types

### Methods with Different Return Types
```java
public class ReturnTypes {
    
    // Void method - no return value
    public static void printMessage(String message) {
        System.out.println(message);
        // return; // Optional for void methods
    }
    
    // Primitive return types
    public static int getAge() {
        return 25;
    }
    
    public static double calculateCircleArea(double radius) {
        return Math.PI * radius * radius;
    }
    
    public static boolean isEven(int number) {
        return number % 2 == 0;
    }
    
    public static char getGrade(int score) {
        if (score >= 90) return 'A';
        else if (score >= 80) return 'B';
        else if (score >= 70) return 'C';
        else if (score >= 60) return 'D';
        else return 'F';
    }
    
    // Object return types
    public static String formatName(String firstName, String lastName) {
        return lastName + ", " + firstName;
    }
    
    public static int[] createNumberArray(int size) {
        int[] array = new int[size];
        for (int i = 0; i < size; i++) {
            array[i] = i + 1;
        }
        return array;
    }
    
    // Multiple return statements
    public static String categorizeAge(int age) {
        if (age < 0) {
            return "Invalid age";
        } else if (age < 13) {
            return "Child";
        } else if (age < 20) {
            return "Teenager";
        } else if (age < 65) {
            return "Adult";
        } else {
            return "Senior";
        }
    }
    
    public static void main(String[] args) {
        printMessage("Testing return types");
        
        int age = getAge();
        double area = calculateCircleArea(5.0);
        boolean evenCheck = isEven(8);
        char grade = getGrade(85);
        String name = formatName("John", "Doe");
        int[] numbers = createNumberArray(5);
        String category = categorizeAge(30);
        
        System.out.println("Age: " + age);
        System.out.println("Circle area: " + area);
        System.out.println("Is 8 even: " + evenCheck);
        System.out.println("Grade for 85: " + grade);
        System.out.println("Formatted name: " + name);
        System.out.println("Array length: " + numbers.length);
        System.out.println("Age category: " + category);
    }
}
```

## Method Parameters

### Different Parameter Types
```java
public class MethodParameters {
    
    // No parameters
    public static void sayHello() {
        System.out.println("Hello!");
    }
    
    // Single parameter
    public static void greet(String name) {
        System.out.println("Hello, " + name + "!");
    }
    
    // Multiple parameters
    public static int add(int a, int b) {
        return a + b;
    }
    
    public static double calculateRectangleArea(double length, double width) {
        return length * width;
    }
    
    // Mixed parameter types
    public static void printPersonInfo(String name, int age, boolean isStudent) {
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        System.out.println("Student: " + isStudent);
    }
    
    // Array parameter
    public static int findMax(int[] numbers) {
        if (numbers.length == 0) {
            throw new IllegalArgumentException("Array cannot be empty");
        }
        
        int max = numbers[0];
        for (int i = 1; i < numbers.length; i++) {
            if (numbers[i] > max) {
                max = numbers[i];
            }
        }
        return max;
    }
    
    // Object parameter
    public static void printStringInfo(String text) {
        if (text != null) {
            System.out.println("Text: '" + text + "'");
            System.out.println("Length: " + text.length());
            System.out.println("Uppercase: " + text.toUpperCase());
        } else {
            System.out.println("Text is null");
        }
    }
    
    public static void main(String[] args) {
        sayHello();
        greet("Alice");
        
        int sum = add(10, 15);
        System.out.println("Sum: " + sum);
        
        double area = calculateRectangleArea(5.0, 3.0);
        System.out.println("Rectangle area: " + area);
        
        printPersonInfo("Bob", 20, true);
        
        int[] numbers = {3, 7, 2, 9, 1};
        int maximum = findMax(numbers);
        System.out.println("Maximum: " + maximum);
        
        printStringInfo("Java Programming");
        printStringInfo(null);
    }
}
```

### Variable Arguments (Varargs)
```java
public class VarargsDemo {
    
    // Method with variable arguments
    public static int sum(int... numbers) {
        int total = 0;
        for (int num : numbers) {
            total += num;
        }
        return total;
    }
    
    public static void printNames(String prefix, String... names) {
        System.out.println("Prefix: " + prefix);
        for (String name : names) {
            System.out.println("- " + name);
        }
    }
    
    // Varargs with other parameters (varargs must be last)
    public static double calculateAverage(String subject, int... scores) {
        if (scores.length == 0) {
            return 0.0;
        }
        
        int total = 0;
        for (int score : scores) {
            total += score;
        }
        
        double average = (double) total / scores.length;
        System.out.println("Average for " + subject + ": " + average);
        return average;
    }
    
    public static void main(String[] args) {
        // Calling varargs methods with different numbers of arguments
        int sum1 = sum();                    // 0 arguments
        int sum2 = sum(5);                   // 1 argument
        int sum3 = sum(1, 2, 3);            // 3 arguments
        int sum4 = sum(10, 20, 30, 40, 50); // 5 arguments
        
        System.out.println("Sum with no args: " + sum1);
        System.out.println("Sum with 1 arg: " + sum2);
        System.out.println("Sum with 3 args: " + sum3);
        System.out.println("Sum with 5 args: " + sum4);
        
        printNames("Students", "Alice", "Bob", "Charlie");
        printNames("Teachers", "Dr. Smith");
        
        calculateAverage("Math", 85, 90, 78, 92);
        calculateAverage("Science", 88, 94);
        calculateAverage("History"); // No scores
    }
}
```

## Method Examples - Practical Applications

### Mathematical Utility Methods
```java
public class MathUtils {
    
    // Calculate factorial
    public static long factorial(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("Factorial not defined for negative numbers");
        }
        if (n == 0 || n == 1) {
            return 1;
        }
        
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result *= i;
        }
        return result;
    }
    
    // Check if number is prime
    public static boolean isPrime(int number) {
        if (number <= 1) {
            return false;
        }
        if (number <= 3) {
            return true;
        }
        if (number % 2 == 0 || number % 3 == 0) {
            return false;
        }
        
        for (int i = 5; i * i <= number; i += 6) {
            if (number % i == 0 || number % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }
    
    // Find GCD (Greatest Common Divisor)
    public static int gcd(int a, int b) {
        a = Math.abs(a);
        b = Math.abs(b);
        
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    
    // Calculate power
    public static double power(double base, int exponent) {
        if (exponent == 0) {
            return 1;
        }
        
        double result = 1;
        boolean isNegativeExp = exponent < 0;
        exponent = Math.abs(exponent);
        
        for (int i = 0; i < exponent; i++) {
            result *= base;
        }
        
        return isNegativeExp ? 1.0 / result : result;
    }
    
    public static void main(String[] args) {
        // Test mathematical methods
        System.out.println("Factorial of 5: " + factorial(5));
        System.out.println("Is 17 prime: " + isPrime(17));
        System.out.println("Is 15 prime: " + isPrime(15));
        System.out.println("GCD of 48 and 18: " + gcd(48, 18));
        System.out.println("2^5: " + power(2, 5));
        System.out.println("3^-2: " + power(3, -2));
    }
}
```

### String Utility Methods
```java
public class StringUtils {
    
    // Reverse a string
    public static String reverse(String str) {
        if (str == null || str.length() <= 1) {
            return str;
        }
        
        StringBuilder reversed = new StringBuilder();
        for (int i = str.length() - 1; i >= 0; i--) {
            reversed.append(str.charAt(i));
        }
        return reversed.toString();
    }
    
    // Check if string is palindrome
    public static boolean isPalindrome(String str) {
        if (str == null) {
            return false;
        }
        
        String cleaned = str.toLowerCase().replaceAll("[^a-z0-9]", "");
        return cleaned.equals(reverse(cleaned));
    }
    
    // Count words in string
    public static int countWords(String str) {
        if (str == null || str.trim().isEmpty()) {
            return 0;
        }
        
        String[] words = str.trim().split("\\s+");
        return words.length;
    }
    
    // Capitalize first letter of each word
    public static String capitalizeWords(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        
        StringBuilder result = new StringBuilder();
        boolean capitalizeNext = true;
        
        for (char c : str.toCharArray()) {
            if (Character.isWhitespace(c)) {
                capitalizeNext = true;
                result.append(c);
            } else if (capitalizeNext) {
                result.append(Character.toUpperCase(c));
                capitalizeNext = false;
            } else {
                result.append(Character.toLowerCase(c));
            }
        }
        
        return result.toString();
    }
    
    public static void main(String[] args) {
        String test1 = "Hello World";
        String test2 = "A man a plan a canal Panama";
        String test3 = "  Java   programming  is   fun  ";
        
        System.out.println("Original: " + test1);
        System.out.println("Reversed: " + reverse(test1));
        
        System.out.println("Is '" + test2 + "' palindrome: " + isPalindrome(test2));
        
        System.out.println("Word count in '" + test3 + "': " + countWords(test3));
        
        System.out.println("Capitalized: " + capitalizeWords("hello world java programming"));
    }
}
```

### Array Utility Methods
```java
public class ArrayUtils {
    
    // Print array elements
    public static void printArray(int[] array) {
        if (array == null) {
            System.out.println("Array is null");
            return;
        }
        
        System.out.print("[");
        for (int i = 0; i < array.length; i++) {
            System.out.print(array[i]);
            if (i < array.length - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }
    
    // Find element in array
    public static int linearSearch(int[] array, int target) {
        if (array == null) {
            return -1;
        }
        
        for (int i = 0; i < array.length; i++) {
            if (array[i] == target) {
                return i;
            }
        }
        return -1;
    }
    
    // Sort array (bubble sort)
    public static void bubbleSort(int[] array) {
        if (array == null || array.length <= 1) {
            return;
        }
        
        int n = array.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    // Swap elements
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }
    
    // Get array statistics
    public static void printArrayStats(int[] array) {
        if (array == null || array.length == 0) {
            System.out.println("Array is null or empty");
            return;
        }
        
        int min = array[0];
        int max = array[0];
        int sum = 0;
        
        for (int value : array) {
            min = Math.min(min, value);
            max = Math.max(max, value);
            sum += value;
        }
        
        double average = (double) sum / array.length;
        
        System.out.println("Array Statistics:");
        System.out.println("Min: " + min);
        System.out.println("Max: " + max);
        System.out.println("Sum: " + sum);
        System.out.println("Average: " + average);
        System.out.println("Length: " + array.length);
    }
    
    public static void main(String[] args) {
        int[] numbers = {64, 34, 25, 12, 22, 11, 90};
        
        System.out.println("Original array:");
        printArray(numbers);
        
        printArrayStats(numbers);
        
        int index = linearSearch(numbers, 25);
        System.out.println("Index of 25: " + index);
        
        bubbleSort(numbers);
        System.out.println("Sorted array:");
        printArray(numbers);
    }
}
```

## Method Best Practices

### Good Method Design
```java
public class MethodBestPractices {
    
    // Good: Single responsibility - method does one thing well
    public static boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        return email.contains("@") && email.contains(".");
    }
    
    // Good: Descriptive name and clear purpose
    public static double calculateCompoundInterest(double principal, double rate, 
                                                  int timesCompounded, int years) {
        return principal * Math.pow(1 + rate / timesCompounded, timesCompounded * years);
    }
    
    // Good: Input validation
    public static int divide(int dividend, int divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("Divisor cannot be zero");
        }
        return dividend / divisor;
    }
    
    // Good: Constants instead of magic numbers
    private static final int MIN_PASSWORD_LENGTH = 8;
    private static final int MAX_PASSWORD_LENGTH = 128;
    
    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        
        int length = password.length();
        return length >= MIN_PASSWORD_LENGTH && length <= MAX_PASSWORD_LENGTH;
    }
    
    // Good: Helper methods to break down complex logic
    public static String generateReport(String[] data) {
        if (!isValidData(data)) {
            return "Invalid data provided";
        }
        
        String header = createReportHeader();
        String body = createReportBody(data);
        String footer = createReportFooter();
        
        return header + body + footer;
    }
    
    private static boolean isValidData(String[] data) {
        return data != null && data.length > 0;
    }
    
    private static String createReportHeader() {
        return "=== REPORT ===\n";
    }
    
    private static String createReportBody(String[] data) {
        StringBuilder body = new StringBuilder();
        for (String item : data) {
            body.append("- ").append(item).append("\n");
        }
        return body.toString();
    }
    
    private static String createReportFooter() {
        return "=== END ===\n";
    }
    
    public static void main(String[] args) {
        // Test best practices methods
        System.out.println("Valid email: " + isValidEmail("user@example.com"));
        System.out.println("Invalid email: " + isValidEmail("invalid-email"));
        
        double interest = calculateCompoundInterest(1000, 0.05, 12, 5);
        System.out.println("Compound interest: $" + interest);
        
        System.out.println("Valid password: " + isValidPassword("mypassword123"));
        System.out.println("Invalid password: " + isValidPassword("short"));
        
        String[] reportData = {"Item 1", "Item 2", "Item 3"};
        System.out.println(generateReport(reportData));
    }
}
```

## Common Mistakes

### Method Mistakes to Avoid
```java
public class MethodMistakes {
    
    // Mistake 1: Method doing too many things
    // BAD: This method does too much
    public static void badUserProcessing(String name, int age, String email) {
        // Validating
        if (name == null || name.isEmpty()) {
            System.out.println("Invalid name");
            return;
        }
        
        // Processing
        String processedName = name.toUpperCase();
        
        // Calculating
        int nextAge = age + 1;
        
        // Saving (hypothetical)
        System.out.println("Saving user: " + processedName);
        
        // Sending email (hypothetical)
        System.out.println("Sending email to: " + email);
        
        // Logging
        System.out.println("User processed successfully");
    }
    
    // BETTER: Split into focused methods
    public static boolean validateUser(String name, int age, String email) {
        return name != null && !name.isEmpty() && age > 0 && 
               email != null && email.contains("@");
    }
    
    public static String processName(String name) {
        return name.toUpperCase().trim();
    }
    
    public static void saveUser(String name, int age, String email) {
        System.out.println("Saving user: " + name);
    }
    
    // Mistake 2: Poor naming
    // BAD: Unclear method names
    public static int calc(int a, int b) { // What does it calculate?
        return a * b;
    }
    
    public static void proc() { // What does it process?
        System.out.println("Processing...");
    }
    
    // BETTER: Clear, descriptive names
    public static int calculateArea(int length, int width) {
        return length * width;
    }
    
    public static void processUserRegistration() {
        System.out.println("Processing user registration...");
    }
    
    // Mistake 3: Not handling edge cases
    // BAD: No input validation
    public static double badDivision(double a, double b) {
        return a / b; // What if b is 0?
    }
    
    // BETTER: Handle edge cases
    public static double safeDivision(double dividend, double divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("Cannot divide by zero");
        }
        return dividend / divisor;
    }
    
    // Mistake 4: Returning null instead of empty collections
    // BAD: Returning null
    public static int[] badGetNumbers() {
        // Some condition
        return null; // Forces null checks everywhere
    }
    
    // BETTER: Return empty array
    public static int[] getNumbers() {
        // Some condition
        return new int[0]; // Safe to iterate over
    }
    
    public static void main(String[] args) {
        // Demonstrate issues with poor method design
        try {
            double result = safeDivision(10, 0);
        } catch (IllegalArgumentException e) {
            System.out.println("Error caught: " + e.getMessage());
        }
        
        // Safe array handling
        int[] numbers = getNumbers();
        System.out.println("Array length: " + numbers.length); // No null check needed
    }
}
```

## Key Takeaways

1. **Use descriptive method names** that clearly indicate what the method does
2. **Keep methods focused** - each method should have a single responsibility
3. **Validate input parameters** to prevent errors and unexpected behavior
4. **Choose appropriate access modifiers** based on where the method should be accessible
5. **Use static methods** for utility functions that don't need object state
6. **Handle edge cases** like null inputs, division by zero, empty arrays
7. **Return meaningful values** - avoid returning null when possible
8. **Break complex logic** into smaller, helper methods
9. **Use consistent naming conventions** and formatting
10. **Document complex methods** with comments explaining the logic

## Next Steps

Now that you understand method declaration and definition:
1. Practice creating methods with different signatures and purposes
2. Experiment with static vs instance methods
3. Learn about [Parameter Passing](./parameters.md) and method overloading
4. Study [Return Types and Values](./return-types.md) in more detail
5. Explore [Method Overloading](./overloading.md) concepts
