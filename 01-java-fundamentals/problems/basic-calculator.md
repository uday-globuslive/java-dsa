# Basic Calculator

## 🎯 Problem Statement

Create a basic calculator that can perform fundamental arithmetic operations: addition, subtraction, multiplication, and division. The calculator should handle both integer and floating-point numbers, validate inputs, and provide a user-friendly interface.

**Examples:**
```
Input: 15 + 25
Output: 40.0

Input: 100 / 3
Output: 33.333333333333336

Input: 7 * 8
Output: 56.0
```

## 🎓 Learning Objectives

- Practice method creation and organization
- Learn input validation and error handling
- Understand operator precedence and evaluation
- Work with different numeric data types
- Handle division by zero and edge cases
- Practice user interface design with Scanner
- Learn about method overloading

## 🛠️ Java Implementation

### Basic Calculator Class

```java
public class BasicCalculator {
    
    /**
     * Performs addition of two numbers
     */
    public static double add(double a, double b) {
        return a + b;
    }
    
    /**
     * Performs subtraction of two numbers
     */
    public static double subtract(double a, double b) {
        return a - b;
    }
    
    /**
     * Performs multiplication of two numbers
     */
    public static double multiply(double a, double b) {
        return a * b;
    }
    
    /**
     * Performs division of two numbers with zero-check
     */
    public static double divide(double a, double b) {
        if (b == 0) {
            throw new ArithmeticException("Cannot divide by zero");
        }
        return a / b;
    }
    
    /**
     * Performs modulo operation with zero-check
     */
    public static double modulo(double a, double b) {
        if (b == 0) {
            throw new ArithmeticException("Cannot perform modulo with zero divisor");
        }
        return a % b;
    }
    
    /**
     * Calculates power (base^exponent)
     */
    public static double power(double base, double exponent) {
        return Math.pow(base, exponent);
    }
    
    /**
     * Calculates square root
     */
    public static double squareRoot(double number) {
        if (number < 0) {
            throw new IllegalArgumentException("Cannot calculate square root of negative number");
        }
        return Math.sqrt(number);
    }
    
    /**
     * Performs calculation based on operator
     */
    public static double calculate(double num1, char operator, double num2) {
        switch (operator) {
            case '+':
                return add(num1, num2);
            case '-':
                return subtract(num1, num2);
            case '*':
                return multiply(num1, num2);
            case '/':
                return divide(num1, num2);
            case '%':
                return modulo(num1, num2);
            case '^':
                return power(num1, num2);
            default:
                throw new IllegalArgumentException("Invalid operator: " + operator);
        }
    }
    
    /**
     * Validates if a character is a valid operator
     */
    public static boolean isValidOperator(char operator) {
        return operator == '+' || operator == '-' || operator == '*' || 
               operator == '/' || operator == '%' || operator == '^';
    }
}
```

### Enhanced Calculator with Additional Features

```java
public class EnhancedCalculator extends BasicCalculator {
    
    /**
     * Calculates factorial of a number
     */
    public static long factorial(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("Factorial is not defined for negative numbers");
        }
        if (n > 20) {
            throw new IllegalArgumentException("Factorial too large, would cause overflow");
        }
        
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result *= i;
        }
        return result;
    }
    
    /**
     * Calculates percentage
     */
    public static double percentage(double value, double percent) {
        return (value * percent) / 100.0;
    }
    
    /**
     * Finds absolute value
     */
    public static double absoluteValue(double number) {
        return Math.abs(number);
    }
    
    /**
     * Rounds number to specified decimal places
     */
    public static double roundToPlaces(double number, int decimalPlaces) {
        if (decimalPlaces < 0) {
            throw new IllegalArgumentException("Decimal places cannot be negative");
        }
        
        double multiplier = Math.pow(10, decimalPlaces);
        return Math.round(number * multiplier) / multiplier;
    }
    
    /**
     * Calculates average of an array of numbers
     */
    public static double average(double[] numbers) {
        if (numbers == null || numbers.length == 0) {
            throw new IllegalArgumentException("Array cannot be null or empty");
        }
        
        double sum = 0;
        for (double number : numbers) {
            sum += number;
        }
        return sum / numbers.length;
    }
    
    /**
     * Finds maximum of two numbers
     */
    public static double max(double a, double b) {
        return Math.max(a, b);
    }
    
    /**
     * Finds minimum of two numbers
     */
    public static double min(double a, double b) {
        return Math.min(a, b);
    }
    
    /**
     * Calculates compound interest
     */
    public static double compoundInterest(double principal, double rate, int time, int compoundingFrequency) {
        if (principal <= 0 || rate < 0 || time < 0 || compoundingFrequency <= 0) {
            throw new IllegalArgumentException("Invalid input parameters");
        }
        
        double rateDecimal = rate / 100.0;
        return principal * Math.pow(1 + (rateDecimal / compoundingFrequency), compoundingFrequency * time);
    }
}
```

### Interactive Calculator Interface

```java
import java.util.Scanner;

public class InteractiveCalculator {
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        System.out.println("=== Welcome to Basic Calculator ===");
        System.out.println("Supported operations: +, -, *, /, %, ^");
        System.out.println("Type 'menu' for advanced operations or 'quit' to exit");
        
        while (true) {
            try {
                System.out.print("\nEnter calculation (e.g., 5 + 3): ");
                String input = scanner.nextLine().trim();
                
                if (input.equalsIgnoreCase("quit")) {
                    System.out.println("Thank you for using the calculator!");
                    break;
                } else if (input.equalsIgnoreCase("menu")) {
                    showAdvancedMenu();
                    continue;
                } else if (input.isEmpty()) {
                    System.out.println("Please enter a calculation.");
                    continue;
                }
                
                // Parse and calculate
                CalculationResult result = parseAndCalculate(input);
                if (result.isSuccess()) {
                    System.out.printf("Result: %.6f%n", result.getValue());
                } else {
                    System.out.println("Error: " + result.getErrorMessage());
                }
                
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
        
        scanner.close();
    }
    
    /**
     * Parses input string and performs calculation
     */
    private static CalculationResult parseAndCalculate(String input) {
        try {
            // Remove extra spaces
            input = input.replaceAll("\\s+", " ").trim();
            
            // Find operator
            char operator = '\0';
            int operatorIndex = -1;
            
            // Look for operators (excluding negative sign at the beginning)
            for (int i = 1; i < input.length(); i++) {
                char ch = input.charAt(i);
                if (BasicCalculator.isValidOperator(ch)) {
                    operator = ch;
                    operatorIndex = i;
                    break;
                }
            }
            
            if (operatorIndex == -1) {
                return CalculationResult.failure("No valid operator found");
            }
            
            // Extract operands
            String leftOperand = input.substring(0, operatorIndex).trim();
            String rightOperand = input.substring(operatorIndex + 1).trim();
            
            if (leftOperand.isEmpty() || rightOperand.isEmpty()) {
                return CalculationResult.failure("Missing operand");
            }
            
            // Parse numbers
            double num1 = Double.parseDouble(leftOperand);
            double num2 = Double.parseDouble(rightOperand);
            
            // Perform calculation
            double result = BasicCalculator.calculate(num1, operator, num2);
            return CalculationResult.success(result);
            
        } catch (NumberFormatException e) {
            return CalculationResult.failure("Invalid number format");
        } catch (ArithmeticException e) {
            return CalculationResult.failure(e.getMessage());
        } catch (Exception e) {
            return CalculationResult.failure("Calculation error: " + e.getMessage());
        }
    }
    
    /**
     * Shows advanced calculator menu
     */
    private static void showAdvancedMenu() {
        while (true) {
            System.out.println("\n=== Advanced Calculator Menu ===");
            System.out.println("1. Square Root");
            System.out.println("2. Factorial");
            System.out.println("3. Percentage");
            System.out.println("4. Average of numbers");
            System.out.println("5. Compound Interest");
            System.out.println("6. Back to basic calculator");
            System.out.print("Choose an option: ");
            
            String choice = scanner.nextLine().trim();
            
            switch (choice) {
                case "1":
                    handleSquareRoot();
                    break;
                case "2":
                    handleFactorial();
                    break;
                case "3":
                    handlePercentage();
                    break;
                case "4":
                    handleAverage();
                    break;
                case "5":
                    handleCompoundInterest();
                    break;
                case "6":
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    
    private static void handleSquareRoot() {
        try {
            System.out.print("Enter a number: ");
            double number = Double.parseDouble(scanner.nextLine().trim());
            double result = BasicCalculator.squareRoot(number);
            System.out.printf("Square root of %.6f = %.6f%n", number, result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    private static void handleFactorial() {
        try {
            System.out.print("Enter a non-negative integer: ");
            int number = Integer.parseInt(scanner.nextLine().trim());
            long result = EnhancedCalculator.factorial(number);
            System.out.printf("Factorial of %d = %d%n", number, result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    private static void handlePercentage() {
        try {
            System.out.print("Enter the value: ");
            double value = Double.parseDouble(scanner.nextLine().trim());
            System.out.print("Enter the percentage: ");
            double percent = Double.parseDouble(scanner.nextLine().trim());
            double result = EnhancedCalculator.percentage(value, percent);
            System.out.printf("%.2f%% of %.6f = %.6f%n", percent, value, result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    private static void handleAverage() {
        try {
            System.out.print("Enter numbers separated by spaces: ");
            String input = scanner.nextLine().trim();
            String[] numberStrings = input.split("\\s+");
            
            double[] numbers = new double[numberStrings.length];
            for (int i = 0; i < numberStrings.length; i++) {
                numbers[i] = Double.parseDouble(numberStrings[i]);
            }
            
            double result = EnhancedCalculator.average(numbers);
            System.out.printf("Average of the numbers = %.6f%n", result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    private static void handleCompoundInterest() {
        try {
            System.out.print("Enter principal amount: ");
            double principal = Double.parseDouble(scanner.nextLine().trim());
            System.out.print("Enter annual interest rate (%): ");
            double rate = Double.parseDouble(scanner.nextLine().trim());
            System.out.print("Enter time period (years): ");
            int time = Integer.parseInt(scanner.nextLine().trim());
            System.out.print("Enter compounding frequency per year: ");
            int frequency = Integer.parseInt(scanner.nextLine().trim());
            
            double result = EnhancedCalculator.compoundInterest(principal, rate, time, frequency);
            System.out.printf("Final amount after compound interest = %.2f%n", result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
    /**
     * Helper class to encapsulate calculation results
     */
    private static class CalculationResult {
        private final boolean success;
        private final double value;
        private final String errorMessage;
        
        private CalculationResult(boolean success, double value, String errorMessage) {
            this.success = success;
            this.value = value;
            this.errorMessage = errorMessage;
        }
        
        public static CalculationResult success(double value) {
            return new CalculationResult(true, value, null);
        }
        
        public static CalculationResult failure(String errorMessage) {
            return new CalculationResult(false, 0, errorMessage);
        }
        
        public boolean isSuccess() { return success; }
        public double getValue() { return value; }
        public String getErrorMessage() { return errorMessage; }
    }
}
```

### Calculator with Expression Evaluation

```java
public class ExpressionCalculator {
    
    /**
     * Evaluates simple expressions with proper operator precedence
     * Supports: +, -, *, /, parentheses
     */
    public static double evaluate(String expression) {
        if (expression == null || expression.trim().isEmpty()) {
            throw new IllegalArgumentException("Expression cannot be null or empty");
        }
        
        // Remove spaces
        expression = expression.replaceAll("\\s+", "");
        
        // Validate characters
        if (!isValidExpression(expression)) {
            throw new IllegalArgumentException("Expression contains invalid characters");
        }
        
        try {
            return evaluateExpression(expression);
        } catch (Exception e) {
            throw new RuntimeException("Error evaluating expression: " + e.getMessage());
        }
    }
    
    private static boolean isValidExpression(String expression) {
        for (char c : expression.toCharArray()) {
            if (!Character.isDigit(c) && c != '.' && c != '+' && c != '-' && 
                c != '*' && c != '/' && c != '(' && c != ')') {
                return false;
            }
        }
        return true;
    }
    
    /**
     * Simple recursive descent parser for arithmetic expressions
     */
    private static double evaluateExpression(String expression) {
        return parseExpression(expression, 0).value;
    }
    
    private static ParseResult parseExpression(String expr, int index) {
        ParseResult left = parseTerm(expr, index);
        index = left.nextIndex;
        
        while (index < expr.length() && (expr.charAt(index) == '+' || expr.charAt(index) == '-')) {
            char operator = expr.charAt(index);
            index++;
            ParseResult right = parseTerm(expr, index);
            
            if (operator == '+') {
                left = new ParseResult(left.value + right.value, right.nextIndex);
            } else {
                left = new ParseResult(left.value - right.value, right.nextIndex);
            }
            index = left.nextIndex;
        }
        
        return left;
    }
    
    private static ParseResult parseTerm(String expr, int index) {
        ParseResult left = parseFactor(expr, index);
        index = left.nextIndex;
        
        while (index < expr.length() && (expr.charAt(index) == '*' || expr.charAt(index) == '/')) {
            char operator = expr.charAt(index);
            index++;
            ParseResult right = parseFactor(expr, index);
            
            if (operator == '*') {
                left = new ParseResult(left.value * right.value, right.nextIndex);
            } else {
                if (right.value == 0) {
                    throw new ArithmeticException("Division by zero");
                }
                left = new ParseResult(left.value / right.value, right.nextIndex);
            }
            index = left.nextIndex;
        }
        
        return left;
    }
    
    private static ParseResult parseFactor(String expr, int index) {
        if (index >= expr.length()) {
            throw new IllegalArgumentException("Unexpected end of expression");
        }
        
        // Handle parentheses
        if (expr.charAt(index) == '(') {
            index++; // skip '('
            ParseResult result = parseExpression(expr, index);
            index = result.nextIndex;
            
            if (index >= expr.length() || expr.charAt(index) != ')') {
                throw new IllegalArgumentException("Missing closing parenthesis");
            }
            index++; // skip ')'
            
            return new ParseResult(result.value, index);
        }
        
        // Handle negative numbers
        boolean negative = false;
        if (expr.charAt(index) == '-') {
            negative = true;
            index++;
        } else if (expr.charAt(index) == '+') {
            index++;
        }
        
        // Parse number
        StringBuilder numberStr = new StringBuilder();
        while (index < expr.length() && (Character.isDigit(expr.charAt(index)) || expr.charAt(index) == '.')) {
            numberStr.append(expr.charAt(index));
            index++;
        }
        
        if (numberStr.length() == 0) {
            throw new IllegalArgumentException("Expected number");
        }
        
        double value = Double.parseDouble(numberStr.toString());
        if (negative) {
            value = -value;
        }
        
        return new ParseResult(value, index);
    }
    
    private static class ParseResult {
        final double value;
        final int nextIndex;
        
        ParseResult(double value, int nextIndex) {
            this.value = value;
            this.nextIndex = nextIndex;
        }
    }
}
```

## 🧪 Comprehensive Testing

```java
public class CalculatorTester {
    
    public static void main(String[] args) {
        testBasicOperations();
        testEdgeCases();
        testAdvancedOperations();
        testExpressionEvaluator();
    }
    
    private static void testBasicOperations() {
        System.out.println("=== Testing Basic Operations ===");
        
        // Test addition
        System.out.println("15 + 25 = " + BasicCalculator.add(15, 25));
        System.out.println("3.14 + 2.86 = " + BasicCalculator.add(3.14, 2.86));
        
        // Test subtraction
        System.out.println("100 - 30 = " + BasicCalculator.subtract(100, 30));
        System.out.println("5.5 - 2.2 = " + BasicCalculator.subtract(5.5, 2.2));
        
        // Test multiplication
        System.out.println("7 * 8 = " + BasicCalculator.multiply(7, 8));
        System.out.println("2.5 * 4 = " + BasicCalculator.multiply(2.5, 4));
        
        // Test division
        System.out.println("100 / 4 = " + BasicCalculator.divide(100, 4));
        System.out.println("22 / 7 = " + BasicCalculator.divide(22, 7));
        
        // Test power
        System.out.println("2 ^ 8 = " + BasicCalculator.power(2, 8));
        System.out.println("3 ^ 3 = " + BasicCalculator.power(3, 3));
    }
    
    private static void testEdgeCases() {
        System.out.println("\n=== Testing Edge Cases ===");
        
        // Division by zero
        try {
            BasicCalculator.divide(10, 0);
        } catch (ArithmeticException e) {
            System.out.println("Division by zero correctly caught: " + e.getMessage());
        }
        
        // Square root of negative number
        try {
            BasicCalculator.squareRoot(-4);
        } catch (IllegalArgumentException e) {
            System.out.println("Negative square root correctly caught: " + e.getMessage());
        }
        
        // Large factorial
        try {
            EnhancedCalculator.factorial(25);
        } catch (IllegalArgumentException e) {
            System.out.println("Large factorial correctly caught: " + e.getMessage());
        }
    }
    
    private static void testAdvancedOperations() {
        System.out.println("\n=== Testing Advanced Operations ===");
        
        // Factorial
        System.out.println("5! = " + EnhancedCalculator.factorial(5));
        System.out.println("0! = " + EnhancedCalculator.factorial(0));
        
        // Percentage
        System.out.println("20% of 150 = " + EnhancedCalculator.percentage(150, 20));
        
        // Average
        double[] numbers = {10, 20, 30, 40, 50};
        System.out.println("Average of [10,20,30,40,50] = " + EnhancedCalculator.average(numbers));
        
        // Compound interest
        double result = EnhancedCalculator.compoundInterest(1000, 5, 3, 4);
        System.out.printf("Compound interest: $1000 at 5%% for 3 years = $%.2f%n", result);
    }
    
    private static void testExpressionEvaluator() {
        System.out.println("\n=== Testing Expression Evaluator ===");
        
        String[] expressions = {
            "2 + 3 * 4",
            "(2 + 3) * 4",
            "10 - 4 + 2",
            "100 / 10 / 2",
            "2 + 3 * 4 - 1",
            "(10 + 5) / (2 + 1)"
        };
        
        for (String expr : expressions) {
            try {
                double result = ExpressionCalculator.evaluate(expr);
                System.out.printf("%s = %.6f%n", expr, result);
            } catch (Exception e) {
                System.out.printf("%s = Error: %s%n", expr, e.getMessage());
            }
        }
    }
}
```

## ⚠️ Common Pitfalls and Solutions

### 1. Division by Zero
```java
// Problem: Not checking for zero division
public static double divide(double a, double b) {
    return a / b; // Can result in Infinity or NaN
}

// Solution: Explicit validation
public static double divide(double a, double b) {
    if (b == 0) {
        throw new ArithmeticException("Cannot divide by zero");
    }
    return a / b;
}
```

### 2. Floating Point Precision
```java
// Problem: Floating point precision issues
System.out.println(0.1 + 0.2); // Outputs: 0.30000000000000004

// Solution: Round results when needed
public static double roundToPlaces(double number, int places) {
    double multiplier = Math.pow(10, places);
    return Math.round(number * multiplier) / multiplier;
}
```

### 3. Integer Overflow in Factorial
```java
// Problem: Large factorials cause overflow
public static int factorial(int n) {
    int result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i; // Overflow for large n
    }
    return result;
}

// Solution: Use long and validate input
public static long factorial(int n) {
    if (n > 20) {
        throw new IllegalArgumentException("Factorial too large");
    }
    long result = 1;
    for (int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}
```

## 📊 Complexity Analysis

- **Basic Operations**: O(1) time, O(1) space
- **Factorial**: O(n) time, O(1) space
- **Expression Parsing**: O(n) time, O(d) space (where d is depth of parentheses)

## 🎯 Enhancement Ideas

1. **Scientific Calculator**: Add trigonometric functions, logarithms
2. **History Feature**: Store and recall previous calculations
3. **Memory Functions**: M+, M-, MR, MC operations
4. **Unit Conversions**: Length, weight, temperature conversions
5. **Graph Plotting**: Simple function graphing capabilities

## 🔗 Related Concepts

- Method design and organization
- Error handling and validation
- User interface design
- String parsing and manipulation
- Operator precedence
- Recursive descent parsing
- Floating point arithmetic

This calculator project provides excellent practice for fundamental programming concepts while building a practical and useful application!
