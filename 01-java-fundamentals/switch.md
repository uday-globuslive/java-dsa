# Switch Statements in Java

## 🎯 Overview

The `switch` statement in Java provides an elegant way to execute different blocks of code based on the value of a variable or expression. It's particularly useful when you have multiple conditions to check against a single variable, offering a cleaner alternative to multiple if-else statements.

## 📚 Basic Switch Statement Syntax

### Traditional Switch Statement
```java
switch (expression) {
    case value1:
        // Code to execute if expression equals value1
        break;
    case value2:
        // Code to execute if expression equals value2
        break;
    case value3:
        // Code to execute if expression equals value3
        break;
    default:
        // Code to execute if no cases match
        break;
}
```

### Simple Example
```java
public class BasicSwitchExample {
    public static void main(String[] args) {
        int dayOfWeek = 3;
        String dayName;
        
        switch (dayOfWeek) {
            case 1:
                dayName = "Monday";
                break;
            case 2:
                dayName = "Tuesday";
                break;
            case 3:
                dayName = "Wednesday";
                break;
            case 4:
                dayName = "Thursday";
                break;
            case 5:
                dayName = "Friday";
                break;
            case 6:
                dayName = "Saturday";
                break;
            case 7:
                dayName = "Sunday";
                break;
            default:
                dayName = "Invalid day";
                break;
        }
        
        System.out.println("Day " + dayOfWeek + " is " + dayName);
    }
}
```

**Output:**
```
Day 3 is Wednesday
```

## 🔧 Supported Data Types

### Compatible Types for Switch Expression
```java
public class SwitchDataTypes {
    public static void main(String[] args) {
        // 1. int and Integer
        int number = 5;
        switch (number) {
            case 5:
                System.out.println("Number is five");
                break;
        }
        
        // 2. char and Character
        char grade = 'A';
        switch (grade) {
            case 'A':
                System.out.println("Excellent!");
                break;
            case 'B':
                System.out.println("Good!");
                break;
            case 'C':
                System.out.println("Average!");
                break;
            default:
                System.out.println("Grade: " + grade);
        }
        
        // 3. String (Java 7+)
        String month = "January";
        switch (month) {
            case "January":
                System.out.println("New Year month");
                break;
            case "December":
                System.out.println("Holiday month");
                break;
            default:
                System.out.println("Month: " + month);
        }
        
        // 4. Enum
        Day today = Day.FRIDAY;
        switch (today) {
            case MONDAY:
                System.out.println("Start of work week");
                break;
            case FRIDAY:
                System.out.println("TGIF!");
                break;
            case SATURDAY:
            case SUNDAY:
                System.out.println("Weekend!");
                break;
            default:
                System.out.println("Regular weekday");
        }
    }
    
    enum Day {
        MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
    }
}
```

## 🔄 Fall-Through Behavior

### Understanding Fall-Through
When you omit the `break` statement, execution "falls through" to the next case:

```java
public class FallThroughExample {
    public static void main(String[] args) {
        int month = 12;
        String season;
        
        switch (month) {
            case 12:
            case 1:
            case 2:
                season = "Winter";
                break;
            case 3:
            case 4:
            case 5:
                season = "Spring";
                break;
            case 6:
            case 7:
            case 8:
                season = "Summer";
                break;
            case 9:
            case 10:
            case 11:
                season = "Fall";
                break;
            default:
                season = "Invalid month";
                break;
        }
        
        System.out.println("Month " + month + " is in " + season);
    }
}
```

### Intentional Fall-Through Example
```java
public class GradingSystem {
    public static void main(String[] args) {
        char grade = 'B';
        String feedback = "";
        
        switch (grade) {
            case 'A':
                feedback += "Excellent work! ";
                // Fall through
            case 'B':
                feedback += "Good job! ";
                // Fall through
            case 'C':
                feedback += "You passed. ";
                break;
            case 'D':
                feedback += "Need improvement. ";
                break;
            case 'F':
                feedback += "Failed. Please retake. ";
                break;
            default:
                feedback = "Invalid grade.";
        }
        
        System.out.println("Grade " + grade + ": " + feedback);
    }
}
```

**Output:**
```
Grade B: Good job! You passed. 
```

## 🆕 Enhanced Switch Expressions (Java 12+)

### Switch Expressions with Arrow Syntax
```java
public class ModernSwitchExpressions {
    public static void main(String[] args) {
        // Traditional approach
        int dayNumber = 3;
        String dayType = switch (dayNumber) {
            case 1, 2, 3, 4, 5 -> "Weekday";
            case 6, 7 -> "Weekend";
            default -> "Invalid day";
        };
        
        System.out.println("Day " + dayNumber + " is a " + dayType);
        
        // More complex example with blocks
        String month = "March";
        int daysInMonth = switch (month) {
            case "January", "March", "May", "July", 
                 "August", "October", "December" -> 31;
            case "April", "June", "September", "November" -> 30;
            case "February" -> {
                // Complex logic in block
                boolean isLeapYear = checkLeapYear(2024);
                yield isLeapYear ? 29 : 28;
            }
            default -> throw new IllegalArgumentException("Invalid month: " + month);
        };
        
        System.out.println(month + " has " + daysInMonth + " days");
    }
    
    private static boolean checkLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
}
```

### Yield Statement in Switch Expressions
```java
public class YieldExample {
    public static void main(String[] args) {
        String operation = "multiply";
        int a = 10, b = 5;
        
        int result = switch (operation) {
            case "add" -> a + b;
            case "subtract" -> a - b;
            case "multiply" -> a * b;
            case "divide" -> {
                if (b == 0) {
                    throw new ArithmeticException("Division by zero!");
                }
                yield a / b;  // yield is required in blocks
            }
            default -> {
                System.out.println("Unknown operation: " + operation);
                yield 0;
            }
        };
        
        System.out.println("Result: " + result);
    }
}
```

## 💡 Practical Examples

### Example 1: Command-Line Calculator
```java
import java.util.Scanner;

public class SwitchCalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter first number: ");
        double num1 = scanner.nextDouble();
        
        System.out.print("Enter operator (+, -, *, /): ");
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
            default:
                System.out.println("Error: Invalid operator!");
                validOperation = false;
        }
        
        if (validOperation) {
            System.out.printf("%.2f %c %.2f = %.2f%n", 
                            num1, operator, num2, result);
        }
        
        scanner.close();
    }
}
```

### Example 2: Menu-Driven Application
```java
import java.util.Scanner;

public class StudentManagementSystem {
    private static Scanner scanner = new Scanner(System.in);
    
    public static void main(String[] args) {
        boolean running = true;
        
        while (running) {
            displayMenu();
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    addStudent();
                    break;
                case 2:
                    viewStudents();
                    break;
                case 3:
                    searchStudent();
                    break;
                case 4:
                    updateStudent();
                    break;
                case 5:
                    deleteStudent();
                    break;
                case 6:
                    System.out.println("Exiting... Goodbye!");
                    running = false;
                    break;
                default:
                    System.out.println("Invalid choice! Please try again.");
            }
            
            if (running) {
                System.out.println("\nPress Enter to continue...");
                scanner.nextLine();
            }
        }
        
        scanner.close();
    }
    
    private static void displayMenu() {
        System.out.println("\n=== Student Management System ===");
        System.out.println("1. Add Student");
        System.out.println("2. View All Students");
        System.out.println("3. Search Student");
        System.out.println("4. Update Student");
        System.out.println("5. Delete Student");
        System.out.println("6. Exit");
        System.out.print("Enter your choice: ");
    }
    
    private static void addStudent() {
        System.out.println("Adding new student...");
        // Implementation would go here
    }
    
    private static void viewStudents() {
        System.out.println("Displaying all students...");
        // Implementation would go here
    }
    
    private static void searchStudent() {
        System.out.println("Searching for student...");
        // Implementation would go here
    }
    
    private static void updateStudent() {
        System.out.println("Updating student information...");
        // Implementation would go here
    }
    
    private static void deleteStudent() {
        System.out.println("Deleting student...");
        // Implementation would go here
    }
}
```

### Example 3: Traffic Light System
```java
public class TrafficLightSystem {
    enum LightColor {
        RED, YELLOW, GREEN
    }
    
    public static void main(String[] args) {
        LightColor currentLight = LightColor.RED;
        
        String action = switch (currentLight) {
            case RED -> {
                System.out.println("Light is RED");
                yield "STOP - Do not proceed";
            }
            case YELLOW -> {
                System.out.println("Light is YELLOW");
                yield "CAUTION - Prepare to stop";
            }
            case GREEN -> {
                System.out.println("Light is GREEN");
                yield "GO - Proceed with caution";
            }
        };
        
        System.out.println("Action: " + action);
        
        // Simulate light change timing
        int duration = switch (currentLight) {
            case RED -> 30;      // 30 seconds
            case YELLOW -> 5;    // 5 seconds
            case GREEN -> 25;    // 25 seconds
        };
        
        System.out.println("Duration: " + duration + " seconds");
    }
}
```

### Example 4: Grade Classification System
```java
public class GradeClassifier {
    public static void main(String[] args) {
        int score = 87;
        
        // Traditional switch with ranges (using division trick)
        String grade = switch (score / 10) {
            case 10, 9 -> "A";
            case 8 -> "B";
            case 7 -> "C";
            case 6 -> "D";
            default -> "F";
        };
        
        String description = switch (grade) {
            case "A" -> "Excellent! Outstanding performance.";
            case "B" -> "Good work! Above average performance.";
            case "C" -> "Satisfactory. Average performance.";
            case "D" -> "Below average. Needs improvement.";
            case "F" -> "Failing. Significant improvement required.";
            default -> "Invalid grade.";
        };
        
        String gpa = switch (grade) {
            case "A" -> "4.0";
            case "B" -> "3.0";
            case "C" -> "2.0";
            case "D" -> "1.0";
            case "F" -> "0.0";
            default -> "N/A";
        };
        
        System.out.println("Score: " + score);
        System.out.println("Grade: " + grade);
        System.out.println("Description: " + description);
        System.out.println("GPA Points: " + gpa);
    }
}
```

## 🆚 Switch vs If-Else Comparison

### When to Use Switch
```java
// Good use of switch - multiple discrete values
public class SwitchVsIfElse {
    
    // GOOD: Switch for discrete values
    public static String getDayType(int day) {
        return switch (day) {
            case 1, 2, 3, 4, 5 -> "Weekday";
            case 6, 7 -> "Weekend";
            default -> "Invalid";
        };
    }
    
    // BETTER: If-else for ranges and complex conditions
    public static String getAgeGroup(int age) {
        if (age < 0) {
            return "Invalid age";
        } else if (age <= 12) {
            return "Child";
        } else if (age <= 17) {
            return "Teenager";
        } else if (age <= 64) {
            return "Adult";
        } else {
            return "Senior";
        }
    }
    
    // GOOD: Switch for enums
    public static double getEmployeeBonus(EmployeeLevel level) {
        return switch (level) {
            case INTERN -> 500.0;
            case JUNIOR -> 1000.0;
            case SENIOR -> 2000.0;
            case LEAD -> 3000.0;
            case MANAGER -> 5000.0;
        };
    }
    
    enum EmployeeLevel {
        INTERN, JUNIOR, SENIOR, LEAD, MANAGER
    }
}
```

### Performance Considerations
```java
public class PerformanceComparison {
    // Switch statements can be optimized by JVM
    // Better for 3+ discrete value comparisons
    public static String processCommand(String command) {
        return switch (command.toLowerCase()) {
            case "start" -> "Starting application...";
            case "stop" -> "Stopping application...";
            case "restart" -> "Restarting application...";
            case "status" -> "Checking status...";
            case "help" -> "Displaying help...";
            default -> "Unknown command";
        };
    }
    
    // If-else better for complex conditions
    public static String validateInput(String input) {
        if (input == null || input.trim().isEmpty()) {
            return "Input cannot be empty";
        } else if (input.length() < 3) {
            return "Input too short";
        } else if (input.length() > 50) {
            return "Input too long";
        } else if (!input.matches("[a-zA-Z0-9\\s]+")) {
            return "Invalid characters";
        } else {
            return "Valid input";
        }
    }
}
```

## ⚠️ Best Practices and Common Pitfalls

### 1. Always Include Break Statements
```java
// WRONG - Missing breaks cause fall-through
switch (choice) {
    case 1:
        System.out.println("One");
        // Missing break!
    case 2:
        System.out.println("Two");  // This will also execute for case 1
        break;
}

// CORRECT
switch (choice) {
    case 1:
        System.out.println("One");
        break;
    case 2:
        System.out.println("Two");
        break;
}
```

### 2. Handle Default Cases
```java
// GOOD: Always include default case
switch (userInput) {
    case "yes":
    case "y":
        return true;
    case "no":
    case "n":
        return false;
    default:
        throw new IllegalArgumentException("Invalid input: " + userInput);
}
```

### 3. Use Enums for Type Safety
```java
// BETTER: Use enums instead of magic numbers/strings
public enum Status {
    PENDING, APPROVED, REJECTED, CANCELLED
}

public static void processApplication(Status status) {
    switch (status) {
        case PENDING -> System.out.println("Application under review");
        case APPROVED -> System.out.println("Application approved");
        case REJECTED -> System.out.println("Application rejected");
        case CANCELLED -> System.out.println("Application cancelled");
        // No default needed - enum is exhaustive
    }
}
```

### 4. Keep Cases Simple
```java
// AVOID: Complex logic in cases
switch (type) {
    case "complex":
        // Lots of complex code here...
        break;
}

// BETTER: Extract to methods
switch (type) {
    case "complex" -> handleComplexType();
    case "simple" -> handleSimpleType();
}

private static void handleComplexType() {
    // Complex logic in separate method
}
```

## 🔍 Debugging Switch Statements

### Common Issues and Solutions
```java
public class SwitchDebugging {
    public static void main(String[] args) {
        // Issue 1: Case sensitivity with Strings
        String input = "Hello";
        switch (input.toLowerCase()) { // Convert to lowercase
            case "hello" -> System.out.println("Greeting detected");
            case "goodbye" -> System.out.println("Farewell detected");
        }
        
        // Issue 2: Null handling
        String nullableInput = null;
        switch (nullableInput != null ? nullableInput : "default") {
            case "test" -> System.out.println("Test case");
            case "default" -> System.out.println("Default or null case");
        }
        
        // Issue 3: Using wrapper types
        Integer number = null;
        if (number != null) { // Check for null before switch
            switch (number) {
                case 1 -> System.out.println("One");
                case 2 -> System.out.println("Two");
            }
        }
    }
}
```

## 📋 Summary

- **Switch Statement:** Multi-way branching based on expression value
- **Supported Types:** int, char, String, enum, and their wrapper classes
- **Fall-Through:** Execution continues to next case without break
- **Modern Syntax:** Arrow syntax and expressions available in Java 12+
- **Best Practices:** Use breaks, handle defaults, prefer enums
- **Use Cases:** Discrete value comparisons, menu systems, state machines

## 🔗 Related Topics

- [Conditional Statements](./conditionals.md) - If-else alternatives
- [Break and Continue](./break-continue.md) - Loop control statements
- [Enums](../02-oop-concepts/README.md#enums) - Type-safe constants for switch
- [Methods](./methods.md) - Extracting switch logic into methods

## 🎯 Practice Exercises

1. Create a month-to-season converter using switch statements
2. Build a simple text-based RPG combat system with attack types
3. Implement a unit converter (length, weight, temperature) using switch
4. Create a command-line file manager with switch-based menu
5. Build a simple state machine for a vending machine using enums and switch
