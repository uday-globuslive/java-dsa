# Operators and Expressions

## Overview
Operators are symbols that perform operations on operands (variables, values, expressions). Understanding operators is essential for building complex expressions and performing calculations in Java.

## Arithmetic Operators

### Basic Arithmetic
```java
public class ArithmeticOperators {
    public static void main(String[] args) {
        int a = 15, b = 4;
        
        // Basic arithmetic operators
        int addition = a + b;       // 19
        int subtraction = a - b;    // 11
        int multiplication = a * b; // 60
        int division = a / b;       // 3 (integer division)
        int modulus = a % b;        // 3 (remainder)
        
        System.out.println("a = " + a + ", b = " + b);
        System.out.println("Addition: " + a + " + " + b + " = " + addition);
        System.out.println("Subtraction: " + a + " - " + b + " = " + subtraction);
        System.out.println("Multiplication: " + a + " * " + b + " = " + multiplication);
        System.out.println("Division: " + a + " / " + b + " = " + division);
        System.out.println("Modulus: " + a + " % " + b + " = " + modulus);
        
        // Floating-point division
        double preciseDiv = (double) a / b; // 3.75
        System.out.println("Precise division: " + preciseDiv);
    }
}
```

### Unary Operators
```java
public class UnaryOperators {
    public static void main(String[] args) {
        int x = 10;
        int y = -5;
        
        // Unary plus and minus
        int positiveX = +x;  // 10 (no change)
        int negativeX = -x;  // -10
        int positiveY = -y;  // 5 (negation of negative)
        
        System.out.println("Original x: " + x);
        System.out.println("Unary plus x: " + positiveX);
        System.out.println("Unary minus x: " + negativeX);
        System.out.println("Negation of y(-5): " + positiveY);
        
        // Increment and decrement operators
        int count = 5;
        
        // Pre-increment: increment first, then use value
        int preIncrement = ++count;  // count becomes 6, preIncrement = 6
        System.out.println("After pre-increment: count = " + count + ", result = " + preIncrement);
        
        count = 5; // Reset
        // Post-increment: use value first, then increment
        int postIncrement = count++; // postIncrement = 5, then count becomes 6
        System.out.println("After post-increment: count = " + count + ", result = " + postIncrement);
        
        count = 5; // Reset
        // Pre-decrement: decrement first, then use value
        int preDecrement = --count;  // count becomes 4, preDecrement = 4
        System.out.println("After pre-decrement: count = " + count + ", result = " + preDecrement);
        
        count = 5; // Reset
        // Post-decrement: use value first, then decrement
        int postDecrement = count--; // postDecrement = 5, then count becomes 4
        System.out.println("After post-decrement: count = " + count + ", result = " + postDecrement);
    }
}
```

## Assignment Operators

### Basic and Compound Assignment
```java
public class AssignmentOperators {
    public static void main(String[] args) {
        // Basic assignment
        int x = 10;
        
        // Compound assignment operators
        x += 5;  // x = x + 5;  (15)
        System.out.println("After += 5: " + x);
        
        x -= 3;  // x = x - 3;  (12)
        System.out.println("After -= 3: " + x);
        
        x *= 2;  // x = x * 2;  (24)
        System.out.println("After *= 2: " + x);
        
        x /= 4;  // x = x / 4;  (6)
        System.out.println("After /= 4: " + x);
        
        x %= 4;  // x = x % 4;  (2)
        System.out.println("After %= 4: " + x);
        
        // Multiple assignments
        int a, b, c;
        a = b = c = 10; // All variables get value 10
        System.out.println("Multiple assignment: a=" + a + ", b=" + b + ", c=" + c);
        
        // String concatenation assignment
        String message = "Hello";
        message += " World"; // message = message + " World"
        message += "!";      // message = message + "!"
        System.out.println("String concatenation: " + message);
    }
}
```

## Comparison Operators

### Relational Operators
```java
public class ComparisonOperators {
    public static void main(String[] args) {
        int a = 10, b = 20, c = 10;
        
        // Relational operators
        boolean equal = (a == c);           // true
        boolean notEqual = (a != b);        // true
        boolean lessThan = (a < b);         // true
        boolean lessThanOrEqual = (a <= c); // true
        boolean greaterThan = (a > b);      // false
        boolean greaterThanOrEqual = (a >= c); // true
        
        System.out.println("a = " + a + ", b = " + b + ", c = " + c);
        System.out.println("a == c: " + equal);
        System.out.println("a != b: " + notEqual);
        System.out.println("a < b: " + lessThan);
        System.out.println("a <= c: " + lessThanOrEqual);
        System.out.println("a > b: " + greaterThan);
        System.out.println("a >= c: " + greaterThanOrEqual);
        
        // String comparison (be careful!)
        String str1 = "Hello";
        String str2 = "Hello";
        String str3 = new String("Hello");
        
        System.out.println("\nString comparisons:");
        System.out.println("str1 == str2: " + (str1 == str2));         // true (string pooling)
        System.out.println("str1 == str3: " + (str1 == str3));         // false (different objects)
        System.out.println("str1.equals(str3): " + str1.equals(str3)); // true (content comparison)
    }
}
```

## Logical Operators

### Boolean Logic
```java
public class LogicalOperators {
    public static void main(String[] args) {
        boolean a = true, b = false, c = true;
        
        // Logical AND (&&) - both must be true
        boolean andResult1 = a && c; // true && true = true
        boolean andResult2 = a && b; // true && false = false
        
        // Logical OR (||) - at least one must be true
        boolean orResult1 = a || b;  // true || false = true
        boolean orResult2 = b || false; // false || false = false
        
        // Logical NOT (!) - inverts boolean value
        boolean notResult1 = !a;     // !true = false
        boolean notResult2 = !b;     // !false = true
        
        System.out.println("a = " + a + ", b = " + b + ", c = " + c);
        System.out.println("a && c: " + andResult1);
        System.out.println("a && b: " + andResult2);
        System.out.println("a || b: " + orResult1);
        System.out.println("b || false: " + orResult2);
        System.out.println("!a: " + notResult1);
        System.out.println("!b: " + notResult2);
        
        // Complex logical expressions
        int age = 25;
        boolean hasLicense = true;
        boolean isEmployee = true;
        
        boolean canDrive = (age >= 18) && hasLicense;
        boolean eligibleForDiscount = (age < 25) || isEmployee;
        boolean complexCondition = ((age >= 21) && hasLicense) || (isEmployee && (age > 16));
        
        System.out.println("\nComplex conditions:");
        System.out.println("Can drive: " + canDrive);
        System.out.println("Eligible for discount: " + eligibleForDiscount);
        System.out.println("Complex condition: " + complexCondition);
    }
}
```

### Short-Circuit Evaluation
```java
public class ShortCircuitEvaluation {
    public static void main(String[] args) {
        // Short-circuit AND (&&)
        boolean result1 = false && expensiveOperation(); // expensiveOperation() not called
        System.out.println("Short-circuit AND result: " + result1);
        
        // Short-circuit OR (||)
        boolean result2 = true || expensiveOperation(); // expensiveOperation() not called
        System.out.println("Short-circuit OR result: " + result2);
        
        // Non-short-circuit operators (& and |)
        boolean result3 = false & expensiveOperation(); // expensiveOperation() IS called
        System.out.println("Non-short-circuit AND result: " + result3);
        
        // Practical example: null checking
        String text = null;
        if (text != null && text.length() > 0) {
            System.out.println("Text is not empty");
        } else {
            System.out.println("Text is null or empty");
        }
        
        // Without short-circuit, this would throw NullPointerException:
        // if (text.length() > 0 && text != null) // WRONG ORDER!
    }
    
    private static boolean expensiveOperation() {
        System.out.println("Expensive operation called!");
        return true;
    }
}
```

## Bitwise Operators

### Bit Manipulation
```java
public class BitwiseOperators {
    public static void main(String[] args) {
        int a = 12;  // Binary: 1100
        int b = 10;  // Binary: 1010
        
        // Bitwise AND (&)
        int andResult = a & b;  // 1100 & 1010 = 1000 (8)
        
        // Bitwise OR (|)
        int orResult = a | b;   // 1100 | 1010 = 1110 (14)
        
        // Bitwise XOR (^)
        int xorResult = a ^ b;  // 1100 ^ 1010 = 0110 (6)
        
        // Bitwise NOT (~)
        int notResult = ~a;     // ~1100 = ...11110011 (-13 in two's complement)
        
        System.out.println("a = " + a + " (binary: " + Integer.toBinaryString(a) + ")");
        System.out.println("b = " + b + " (binary: " + Integer.toBinaryString(b) + ")");
        System.out.println("a & b = " + andResult + " (binary: " + Integer.toBinaryString(andResult) + ")");
        System.out.println("a | b = " + orResult + " (binary: " + Integer.toBinaryString(orResult) + ")");
        System.out.println("a ^ b = " + xorResult + " (binary: " + Integer.toBinaryString(xorResult) + ")");
        System.out.println("~a = " + notResult);
        
        // Shift operators
        int leftShift = a << 2;   // 1100 << 2 = 110000 (48) - multiply by 2^2
        int rightShift = a >> 2;  // 1100 >> 2 = 11 (3) - divide by 2^2
        int unsignedRightShift = a >>> 2; // Same as >> for positive numbers
        
        System.out.println("\nShift operations:");
        System.out.println("a << 2 = " + leftShift);
        System.out.println("a >> 2 = " + rightShift);
        System.out.println("a >>> 2 = " + unsignedRightShift);
    }
}
```

## Ternary Operator

### Conditional Expression
```java
public class TernaryOperator {
    public static void main(String[] args) {
        // Syntax: condition ? value_if_true : value_if_false
        
        int age = 20;
        String status = (age >= 18) ? "Adult" : "Minor";
        System.out.println("Age: " + age + ", Status: " + status);
        
        // Multiple ternary operators (nested)
        int score = 85;
        String grade = (score >= 90) ? "A" : 
                      (score >= 80) ? "B" : 
                      (score >= 70) ? "C" : 
                      (score >= 60) ? "D" : "F";
        System.out.println("Score: " + score + ", Grade: " + grade);
        
        // Ternary with different data types
        boolean isPositive = true;
        double result = isPositive ? 10.5 : -3.2;
        System.out.println("Result: " + result);
        
        // Ternary vs if-else comparison
        int x = 15, y = 25;
        
        // Using ternary
        int max1 = (x > y) ? x : y;
        
        // Using if-else (equivalent)
        int max2;
        if (x > y) {
            max2 = x;
        } else {
            max2 = y;
        }
        
        System.out.println("Max using ternary: " + max1);
        System.out.println("Max using if-else: " + max2);
        
        // Complex expressions with ternary
        String message = (age >= 18) ? 
                        ((age >= 65) ? "Senior citizen" : "Adult") : 
                        "Minor";
        System.out.println("Age category: " + message);
    }
}
```

## Operator Precedence and Associativity

### Understanding Order of Operations
```java
public class OperatorPrecedence {
    public static void main(String[] args) {
        // Precedence examples
        int result1 = 2 + 3 * 4;        // 14, not 20 (multiplication first)
        int result2 = (2 + 3) * 4;      // 20 (parentheses override precedence)
        
        System.out.println("2 + 3 * 4 = " + result1);
        System.out.println("(2 + 3) * 4 = " + result2);
        
        // Complex expression
        int a = 5, b = 10, c = 15;
        boolean complex = a < b && b < c || a > c; // true (&& has higher precedence than ||)
        System.out.println("Complex boolean: " + complex);
        
        // Associativity examples
        int rightToLeft = a = b = c;    // Assignment is right-to-left associative
        System.out.println("Right-to-left assignment: " + rightToLeft);
        
        int leftToRight = 20 - 10 + 5; // 15, not 5 (left-to-right for same precedence)
        System.out.println("Left-to-right subtraction/addition: " + leftToRight);
        
        // Increment operator precedence
        int[] array = {1, 2, 3};
        int index = 0;
        int value = array[index++]; // Post-increment has high precedence
        System.out.println("Array value: " + value + ", index after: " + index);
    }
}
```

### Precedence Table (High to Low)
```java
public class PrecedenceDemo {
    public static void main(String[] args) {
        /*
         * Operator Precedence (highest to lowest):
         * 
         * 1. Postfix: expr++, expr--
         * 2. Unary: ++expr, --expr, +expr, -expr, ~, !
         * 3. Multiplicative: *, /, %
         * 4. Additive: +, -
         * 5. Shift: <<, >>, >>>
         * 6. Relational: <, >, <=, >=, instanceof
         * 7. Equality: ==, !=
         * 8. Bitwise AND: &
         * 9. Bitwise XOR: ^
         * 10. Bitwise OR: |
         * 11. Logical AND: &&
         * 12. Logical OR: ||
         * 13. Ternary: ? :
         * 14. Assignment: =, +=, -=, *=, /=, %=, &=, ^=, |=, <<=, >>=, >>>=
         */
        
        // Examples demonstrating precedence
        int x = 5;
        int y = 2;
        
        // Without parentheses
        int result1 = x + y * 3;     // 5 + (2 * 3) = 11
        
        // With parentheses to change order
        int result2 = (x + y) * 3;   // (5 + 2) * 3 = 21
        
        System.out.println("x + y * 3 = " + result1);
        System.out.println("(x + y) * 3 = " + result2);
        
        // Complex expression
        boolean complexResult = x > 3 && y < 5 || x == 5;
        // Evaluated as: ((x > 3) && (y < 5)) || (x == 5)
        // ((5 > 3) && (2 < 5)) || (5 == 5)
        // (true && true) || true
        // true || true = true
        System.out.println("Complex boolean result: " + complexResult);
    }
}
```

## Practical Examples

### Calculator Application
```java
import java.util.Scanner;

public class SimpleCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter first number: ");
        double num1 = scanner.nextDouble();
        
        System.out.print("Enter operator (+, -, *, /, %): ");
        char operator = scanner.next().charAt(0);
        
        System.out.print("Enter second number: ");
        double num2 = scanner.nextDouble();
        
        double result = 0;
        boolean validOperation = true;
        
        switch (operator) {
            case '+':
                result = num1 + num2;
                break;
            case '-':
                result = num1 - num2;
                break;
            case '*':
                result = num1 * num2;
                break;
            case '/':
                if (num2 != 0) {
                    result = num1 / num2;
                } else {
                    System.out.println("Error: Division by zero!");
                    validOperation = false;
                }
                break;
            case '%':
                if (num2 != 0) {
                    result = num1 % num2;
                } else {
                    System.out.println("Error: Modulus by zero!");
                    validOperation = false;
                }
                break;
            default:
                System.out.println("Error: Invalid operator!");
                validOperation = false;
        }
        
        if (validOperation) {
            System.out.println(num1 + " " + operator + " " + num2 + " = " + result);
        }
        
        scanner.close();
    }
}
```

### Grade Calculator
```java
public class GradeCalculator {
    public static void main(String[] args) {
        // Student scores
        int mathScore = 85;
        int scienceScore = 92;
        int englishScore = 78;
        int historyScore = 88;
        
        // Calculate average using arithmetic operators
        double average = (mathScore + scienceScore + englishScore + historyScore) / 4.0;
        
        // Determine grade using comparison and ternary operators
        String letterGrade = (average >= 90) ? "A" :
                            (average >= 80) ? "B" :
                            (average >= 70) ? "C" :
                            (average >= 60) ? "D" : "F";
        
        // Determine pass/fail using logical operators
        boolean passed = (average >= 60) && (mathScore >= 50) && (scienceScore >= 50) && 
                        (englishScore >= 50) && (historyScore >= 50);
        
        // Display results
        System.out.println("=== Grade Report ===");
        System.out.println("Math: " + mathScore);
        System.out.println("Science: " + scienceScore);
        System.out.println("English: " + englishScore);
        System.out.println("History: " + historyScore);
        System.out.println("Average: " + average);
        System.out.println("Letter Grade: " + letterGrade);
        System.out.println("Status: " + (passed ? "PASSED" : "FAILED"));
        
        // Bonus calculation using compound assignment
        double bonus = 0.0;
        if (average >= 95) {
            bonus += 10.0;  // Excellence bonus
        }
        if (mathScore >= 90 && scienceScore >= 90) {
            bonus += 5.0;   // STEM bonus
        }
        
        System.out.println("Bonus points: " + bonus);
        System.out.println("Final average: " + (average + bonus));
    }
}
```

## Common Mistakes and Best Practices

### Common Mistakes
```java
public class CommonMistakes {
    public static void main(String[] args) {
        // Mistake 1: Confusing assignment with equality
        int x = 5;
        boolean wrong = (x = 10); // Assignment, not comparison! x becomes 10, result is true
        boolean correct = (x == 10); // Comparison
        
        System.out.println("After assignment in boolean: x = " + x + ", result = " + wrong);
        System.out.println("Equality check: " + correct);
        
        // Mistake 2: Integer division losing precision
        int a = 5, b = 2;
        double wrongResult = a / b;        // 2.0 (integer division)
        double correctResult = (double) a / b; // 2.5 (floating-point division)
        
        System.out.println("Integer division: " + wrongResult);
        System.out.println("Correct division: " + correctResult);
        
        // Mistake 3: Operator precedence confusion
        boolean condition1 = 5 > 3 && 2 > 1; // true
        boolean condition2 = 5 > 3 & 2 > 1;  // true (but & doesn't short-circuit)
        
        // Mistake 4: Confusing increment operators
        int count = 5;
        int result1 = count++ + ++count; // 5 + 7 = 12 (confusing!)
        System.out.println("Confusing increment result: " + result1 + ", count = " + count);
    }
}
```

### Best Practices
```java
public class BestPractices {
    public static void main(String[] args) {
        // Use parentheses for clarity
        int result = (2 + 3) * (4 + 5); // Clear intention
        
        // Use meaningful variable names
        boolean isEligibleForDiscount = (age >= 65) || (isStudent && age < 25);
        
        // Avoid complex expressions in single line
        // Instead of: boolean complex = (a > b) && (c < d) || (e == f) && (g != h);
        boolean condition1 = (a > b) && (c < d);
        boolean condition2 = (e == f) && (g != h);
        boolean complex = condition1 || condition2;
        
        // Use appropriate data types
        double price = 19.99; // Use double for money calculations
        int quantity = 5;     // Use int for counts
        
        // Check for division by zero
        double result2 = (b != 0) ? (double) a / b : 0.0;
        
        // Use constants for magic numbers
        final double TAX_RATE = 0.08;
        double total = price * quantity * (1 + TAX_RATE);
    }
}
```

## Key Takeaways

1. **Understand operator precedence** - use parentheses when in doubt
2. **Know the difference** between = (assignment) and == (comparison)
3. **Be careful with integer division** - cast to double for precision
4. **Use logical operators correctly** - understand short-circuit evaluation
5. **Choose appropriate operators** for the task at hand
6. **Make code readable** with meaningful expressions and proper spacing
7. **Understand increment/decrement** operators and their timing
8. **Use ternary operator** for simple conditional assignments

## Next Steps

Now that you understand operators and expressions:
1. Practice with complex expressions and operator combinations
2. Create small calculator programs using different operators
3. Learn about [Type Casting and Conversion](./type-casting.md)
4. Study [Conditional Statements](./conditionals.md)
