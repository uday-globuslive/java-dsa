# Conditional Statements

## Overview
Conditional statements allow programs to make decisions and execute different code paths based on certain conditions. They are fundamental to creating dynamic and responsive programs.

## If Statement

### Basic If Statement
```java
public class BasicIfStatement {
    public static void main(String[] args) {
        int age = 18;
        
        // Simple if statement
        if (age >= 18) {
            System.out.println("You are eligible to vote.");
        }
        
        // If statement with multiple statements
        if (age >= 21) {
            System.out.println("You can drink alcohol legally.");
            System.out.println("You have additional privileges.");
        }
        
        // If statement with complex condition
        boolean hasID = true;
        if (age >= 18 && hasID) {
            System.out.println("You can enter the club.");
        }
    }
}
```

### If-Else Statement
```java
public class IfElseStatement {
    public static void main(String[] args) {
        int score = 75;
        
        // Basic if-else
        if (score >= 60) {
            System.out.println("You passed the exam!");
        } else {
            System.out.println("You failed the exam.");
        }
        
        // If-else with complex conditions
        boolean isWeekend = false;
        int hour = 14;
        
        if (isWeekend || hour >= 17) {
            System.out.println("It's leisure time!");
        } else {
            System.out.println("It's work time.");
        }
        
        // Nested conditions
        int temperature = 25;
        boolean isRaining = false;
        
        if (temperature > 20) {
            if (isRaining) {
                System.out.println("Warm but rainy - take an umbrella!");
            } else {
                System.out.println("Perfect weather for outdoor activities!");
            }
        } else {
            System.out.println("It's cold outside.");
        }
    }
}
```

### If-Else-If Chain
```java
public class IfElseIfChain {
    public static void main(String[] args) {
        int grade = 85;
        
        // Grade classification
        if (grade >= 90) {
            System.out.println("Grade: A - Excellent!");
        } else if (grade >= 80) {
            System.out.println("Grade: B - Good job!");
        } else if (grade >= 70) {
            System.out.println("Grade: C - Satisfactory");
        } else if (grade >= 60) {
            System.out.println("Grade: D - Needs improvement");
        } else {
            System.out.println("Grade: F - Failed");
        }
        
        // Age categorization
        int age = 25;
        String category;
        
        if (age < 2) {
            category = "Infant";
        } else if (age < 4) {
            category = "Toddler";
        } else if (age < 13) {
            category = "Child";
        } else if (age < 20) {
            category = "Teenager";
        } else if (age < 65) {
            category = "Adult";
        } else {
            category = "Senior";
        }
        
        System.out.println("Age category: " + category);
    }
}
```

## Practical Examples

### Login System
```java
import java.util.Scanner;

public class LoginSystem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Predefined credentials
        String correctUsername = "admin";
        String correctPassword = "password123";
        int maxAttempts = 3;
        int attempts = 0;
        
        while (attempts < maxAttempts) {
            System.out.print("Enter username: ");
            String username = scanner.nextLine();
            
            System.out.print("Enter password: ");
            String password = scanner.nextLine();
            
            if (username.equals(correctUsername) && password.equals(correctPassword)) {
                System.out.println("Login successful! Welcome, " + username + "!");
                break;
            } else {
                attempts++;
                int remainingAttempts = maxAttempts - attempts;
                
                if (remainingAttempts > 0) {
                    System.out.println("Invalid credentials. " + remainingAttempts + " attempts remaining.");
                } else {
                    System.out.println("Account locked due to too many failed attempts.");
                }
            }
        }
        
        scanner.close();
    }
}
```

### BMI Calculator
```java
import java.util.Scanner;

public class BMICalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter your weight (kg): ");
        double weight = scanner.nextDouble();
        
        System.out.print("Enter your height (m): ");
        double height = scanner.nextDouble();
        
        // Input validation
        if (weight <= 0 || height <= 0) {
            System.out.println("Error: Weight and height must be positive values.");
            return;
        }
        
        // Calculate BMI
        double bmi = weight / (height * height);
        
        System.out.printf("Your BMI is: %.2f\n", bmi);
        
        // BMI categorization
        String category;
        String advice;
        
        if (bmi < 18.5) {
            category = "Underweight";
            advice = "Consider consulting a nutritionist to gain healthy weight.";
        } else if (bmi < 25.0) {
            category = "Normal weight";
            advice = "Great! Maintain your current lifestyle.";
        } else if (bmi < 30.0) {
            category = "Overweight";
            advice = "Consider a balanced diet and regular exercise.";
        } else {
            category = "Obese";
            advice = "Consult a healthcare professional for guidance.";
        }
        
        System.out.println("Category: " + category);
        System.out.println("Advice: " + advice);
        
        scanner.close();
    }
}
```

### Number Guessing Game
```java
import java.util.Random;
import java.util.Scanner;

public class NumberGuessingGame {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Random random = new Random();
        
        int targetNumber = random.nextInt(100) + 1; // Random number 1-100
        int attempts = 0;
        int maxAttempts = 7;
        boolean hasWon = false;
        
        System.out.println("Welcome to the Number Guessing Game!");
        System.out.println("I'm thinking of a number between 1 and 100.");
        System.out.println("You have " + maxAttempts + " attempts to guess it.");
        
        while (attempts < maxAttempts && !hasWon) {
            attempts++;
            System.out.print("Attempt " + attempts + ": Enter your guess: ");
            
            if (!scanner.hasNextInt()) {
                System.out.println("Please enter a valid number.");
                scanner.next(); // Clear invalid input
                attempts--; // Don't count invalid input as an attempt
                continue;
            }
            
            int guess = scanner.nextInt();
            
            if (guess < 1 || guess > 100) {
                System.out.println("Please enter a number between 1 and 100.");
                attempts--; // Don't count out-of-range as an attempt
            } else if (guess == targetNumber) {
                hasWon = true;
                System.out.println("Congratulations! You guessed the number in " + attempts + " attempts!");
            } else if (guess < targetNumber) {
                System.out.println("Too low! Try a higher number.");
                
                // Give hints based on how close they are
                int difference = targetNumber - guess;
                if (difference <= 5) {
                    System.out.println("You're very close!");
                } else if (difference <= 15) {
                    System.out.println("You're getting warm!");
                }
            } else {
                System.out.println("Too high! Try a lower number.");
                
                // Give hints based on how close they are
                int difference = guess - targetNumber;
                if (difference <= 5) {
                    System.out.println("You're very close!");
                } else if (difference <= 15) {
                    System.out.println("You're getting warm!");
                }
            }
            
            // Show remaining attempts
            if (!hasWon && attempts < maxAttempts) {
                int remaining = maxAttempts - attempts;
                System.out.println("Attempts remaining: " + remaining);
            }
        }
        
        if (!hasWon) {
            System.out.println("Game over! The number was: " + targetNumber);
        }
        
        scanner.close();
    }
}
```

### Calculator with Input Validation
```java
import java.util.Scanner;

public class AdvancedCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("Advanced Calculator");
        System.out.println("Supported operations: +, -, *, /, %, ^(power)");
        
        System.out.print("Enter first number: ");
        if (!scanner.hasNextDouble()) {
            System.out.println("Error: Please enter a valid number.");
            return;
        }
        double num1 = scanner.nextDouble();
        
        System.out.print("Enter operator (+, -, *, /, %, ^): ");
        String operator = scanner.next();
        
        System.out.print("Enter second number: ");
        if (!scanner.hasNextDouble()) {
            System.out.println("Error: Please enter a valid number.");
            return;
        }
        double num2 = scanner.nextDouble();
        
        double result = 0;
        boolean validOperation = true;
        String operationName = "";
        
        // Perform calculation based on operator
        if (operator.equals("+")) {
            result = num1 + num2;
            operationName = "Addition";
        } else if (operator.equals("-")) {
            result = num1 - num2;
            operationName = "Subtraction";
        } else if (operator.equals("*")) {
            result = num1 * num2;
            operationName = "Multiplication";
        } else if (operator.equals("/")) {
            if (num2 == 0) {
                System.out.println("Error: Division by zero is not allowed.");
                validOperation = false;
            } else {
                result = num1 / num2;
                operationName = "Division";
            }
        } else if (operator.equals("%")) {
            if (num2 == 0) {
                System.out.println("Error: Modulus by zero is not allowed.");
                validOperation = false;
            } else {
                result = num1 % num2;
                operationName = "Modulus";
            }
        } else if (operator.equals("^")) {
            result = Math.pow(num1, num2);
            operationName = "Power";
        } else {
            System.out.println("Error: Invalid operator. Supported: +, -, *, /, %, ^");
            validOperation = false;
        }
        
        // Display result
        if (validOperation) {
            System.out.println("\n" + operationName + " Result:");
            System.out.println(num1 + " " + operator + " " + num2 + " = " + result);
            
            // Additional information based on operation
            if (operator.equals("/") && num1 % num2 != 0) {
                System.out.printf("Decimal result: %.6f\n", result);
            } else if (operator.equals("^")) {
                if (num2 == 2) {
                    System.out.println("This is " + num1 + " squared.");
                } else if (num2 == 3) {
                    System.out.println("This is " + num1 + " cubed.");
                }
            }
        }
        
        scanner.close();
    }
}
```

## Complex Conditional Logic

### Nested Conditions
```java
public class NestedConditions {
    public static void main(String[] args) {
        int age = 20;
        boolean hasJob = true;
        boolean hasGoodCredit = false;
        double income = 35000;
        
        // Loan approval system
        System.out.println("=== Loan Approval System ===");
        
        if (age >= 18) {
            System.out.println("✓ Age requirement met");
            
            if (hasJob) {
                System.out.println("✓ Employment requirement met");
                
                if (income >= 25000) {
                    System.out.println("✓ Income requirement met");
                    
                    if (hasGoodCredit) {
                        System.out.println("✓ Credit requirement met");
                        System.out.println("APPROVED: Premium loan with low interest rate");
                    } else {
                        System.out.println("✗ Credit requirement not met");
                        if (income >= 50000) {
                            System.out.println("APPROVED: Standard loan with higher interest rate");
                        } else {
                            System.out.println("DENIED: Insufficient credit score and income");
                        }
                    }
                } else {
                    System.out.println("✗ Income requirement not met");
                    System.out.println("DENIED: Minimum income requirement is $25,000");
                }
            } else {
                System.out.println("✗ Employment requirement not met");
                System.out.println("DENIED: Employment required for loan approval");
            }
        } else {
            System.out.println("✗ Age requirement not met");
            System.out.println("DENIED: Must be at least 18 years old");
        }
    }
}
```

### Logical Operators in Conditions
```java
public class LogicalConditions {
    public static void main(String[] args) {
        // User permissions system
        boolean isAdmin = false;
        boolean isModerator = true;
        boolean isOwner = false;
        boolean isLoggedIn = true;
        int accountAge = 30; // days
        
        // Check various permission levels
        if (isAdmin || isOwner) {
            System.out.println("Full access granted - Admin/Owner privileges");
        } else if (isModerator && isLoggedIn) {
            System.out.println("Moderate access granted - Moderator privileges");
        } else if (isLoggedIn && accountAge >= 7) {
            System.out.println("Standard access granted - Verified user");
        } else if (isLoggedIn) {
            System.out.println("Limited access - New user restrictions apply");
        } else {
            System.out.println("Access denied - Please log in");
        }
        
        // Complex business logic
        boolean isWeekend = false;
        boolean isHoliday = false;
        int hour = 14;
        boolean isEmergency = false;
        
        System.out.println("\n=== Office Hours System ===");
        
        if (isEmergency) {
            System.out.println("Emergency protocol: 24/7 access granted");
        } else if ((isWeekend || isHoliday) && !isEmergency) {
            System.out.println("Office closed - Weekend/Holiday");
        } else if (hour >= 9 && hour <= 17) {
            System.out.println("Office open - Regular business hours");
        } else if ((hour >= 7 && hour < 9) || (hour > 17 && hour <= 20)) {
            System.out.println("Office open - Extended hours");
        } else {
            System.out.println("Office closed - Outside business hours");
        }
        
        // Short-circuit evaluation example
        String username = null;
        
        // Safe null checking with short-circuit AND
        if (username != null && username.length() > 0) {
            System.out.println("Username: " + username);
        } else {
            System.out.println("No username provided");
        }
        
        // This would cause NullPointerException without short-circuit:
        // if (username.length() > 0 && username != null) // WRONG ORDER!
    }
}
```

## Common Patterns and Best Practices

### Early Return Pattern
```java
public class EarlyReturnPattern {
    
    // Without early return (nested conditions)
    public static String validateUserBad(String username, String password, int age) {
        if (username != null) {
            if (username.length() >= 3) {
                if (password != null) {
                    if (password.length() >= 8) {
                        if (age >= 13) {
                            return "Valid user";
                        } else {
                            return "Age must be at least 13";
                        }
                    } else {
                        return "Password must be at least 8 characters";
                    }
                } else {
                    return "Password cannot be null";
                }
            } else {
                return "Username must be at least 3 characters";
            }
        } else {
            return "Username cannot be null";
        }
    }
    
    // With early return (cleaner)
    public static String validateUserGood(String username, String password, int age) {
        if (username == null) {
            return "Username cannot be null";
        }
        
        if (username.length() < 3) {
            return "Username must be at least 3 characters";
        }
        
        if (password == null) {
            return "Password cannot be null";
        }
        
        if (password.length() < 8) {
            return "Password must be at least 8 characters";
        }
        
        if (age < 13) {
            return "Age must be at least 13";
        }
        
        return "Valid user";
    }
    
    public static void main(String[] args) {
        String result1 = validateUserBad("john", "password123", 25);
        String result2 = validateUserGood("john", "password123", 25);
        
        System.out.println("Result 1: " + result1);
        System.out.println("Result 2: " + result2);
        
        // Test with invalid data
        String result3 = validateUserGood("jo", "short", 10);
        System.out.println("Invalid result: " + result3);
    }
}
```

### Guard Clauses
```java
public class GuardClauses {
    
    public static double calculateDiscount(double price, int customerType, boolean isHoliday) {
        // Guard clauses - handle edge cases first
        if (price <= 0) {
            return 0; // No discount for invalid price
        }
        
        if (customerType < 1 || customerType > 3) {
            return 0; // No discount for invalid customer type
        }
        
        // Main logic after guards
        double discount = 0;
        
        // Base discount by customer type
        if (customerType == 1) {        // Regular customer
            discount = 0.05; // 5%
        } else if (customerType == 2) { // Premium customer
            discount = 0.10; // 10%
        } else if (customerType == 3) { // VIP customer
            discount = 0.15; // 15%
        }
        
        // Additional holiday discount
        if (isHoliday) {
            discount += 0.05; // Additional 5%
        }
        
        // Cap maximum discount at 25%
        if (discount > 0.25) {
            discount = 0.25;
        }
        
        return price * discount;
    }
    
    public static void main(String[] args) {
        // Test discount calculation
        System.out.println("Regular customer, normal day: $" + 
                          calculateDiscount(100, 1, false));
        System.out.println("VIP customer, holiday: $" + 
                          calculateDiscount(100, 3, true));
        System.out.println("Invalid price: $" + 
                          calculateDiscount(-50, 2, false));
        System.out.println("Invalid customer type: $" + 
                          calculateDiscount(100, 5, false));
    }
}
```

## Common Mistakes and How to Avoid Them

### Common Conditional Mistakes
```java
public class ConditionalMistakes {
    public static void main(String[] args) {
        // Mistake 1: Using assignment instead of comparison
        int x = 5;
        
        // WRONG: Assignment in condition
        // if (x = 10) {  // This assigns 10 to x, doesn't compile
        //     System.out.println("This won't work");
        // }
        
        // CORRECT: Comparison
        if (x == 10) {
            System.out.println("x equals 10");
        }
        
        // Mistake 2: Comparing floating-point numbers directly
        double a = 0.1 + 0.2;
        double b = 0.3;
        
        // WRONG: Direct comparison (often fails due to precision)
        if (a == b) {
            System.out.println("Equal"); // This might not print!
        }
        
        // CORRECT: Compare with tolerance
        double tolerance = 0.000001;
        if (Math.abs(a - b) < tolerance) {
            System.out.println("Approximately equal");
        }
        
        // Mistake 3: Not handling null values
        String text = null;
        
        // WRONG: This will throw NullPointerException
        // if (text.equals("hello")) {
        //     System.out.println("Found hello");
        // }
        
        // CORRECT: Null-safe comparison
        if (text != null && text.equals("hello")) {
            System.out.println("Found hello");
        }
        
        // Or use Objects.equals() for null-safe comparison
        if (java.util.Objects.equals(text, "hello")) {
            System.out.println("Found hello (null-safe)");
        }
        
        // Mistake 4: Unreachable code
        boolean condition = true;
        if (condition) {
            System.out.println("This will always execute");
            return;
        }
        // This code is unreachable
        System.out.println("This will never execute");
    }
}
```

## Key Takeaways

1. **Use proper comparison operators** - remember == for comparison, = for assignment
2. **Handle edge cases** - null values, empty strings, division by zero
3. **Use logical operators correctly** - understand short-circuit evaluation
4. **Keep conditions readable** - use parentheses and break complex conditions into variables
5. **Use early returns** to avoid deep nesting
6. **Validate inputs** before processing
7. **Be careful with floating-point comparisons** - use tolerance for equality checks
8. **Choose the right conditional structure** - if/else vs switch vs ternary operator

## Next Steps

Now that you understand conditional statements:
1. Practice with complex decision-making scenarios
2. Combine conditions with loops for more dynamic programs
3. Learn about [Switch Statements](./switch.md) as an alternative to if-else chains
4. Study [Loops (for, while, do-while)](./loops.md) to add repetition to your programs
5. Explore [Exception Handling](./exception-handling.md) for robust error management
