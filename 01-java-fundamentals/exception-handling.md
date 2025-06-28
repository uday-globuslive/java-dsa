# Exception Handling in Java

## 🎯 Overview

Exception handling is a powerful mechanism in Java that allows programs to handle runtime errors gracefully and maintain normal program flow. Instead of crashing, well-designed programs can recover from errors, provide meaningful feedback to users, and continue execution when possible.

## 🔍 What are Exceptions?

An **exception** is an event that occurs during program execution that disrupts the normal flow of instructions. When an exceptional condition arises, an object representing that exception is created and thrown in the method that caused the error.

### Exception vs Error vs Runtime Issues

```java
// Compile-time Error (not an exception)
int x = "Hello";  // Type mismatch - won't compile

// Runtime Exception
int[] array = {1, 2, 3};
int value = array[5];  // ArrayIndexOutOfBoundsException

// Error (serious JVM issues)
// OutOfMemoryError, StackOverflowError - usually not recoverable
```

## 📚 Exception Hierarchy

```
java.lang.Throwable
├── java.lang.Error (Unchecked)
│   ├── OutOfMemoryError
│   ├── StackOverflowError
│   └── VirtualMachineError
└── java.lang.Exception
    ├── RuntimeException (Unchecked)
    │   ├── NullPointerException
    │   ├── ArrayIndexOutOfBoundsException
    │   ├── IllegalArgumentException
    │   └── NumberFormatException
    └── Checked Exceptions
        ├── IOException
        ├── SQLException
        ├── ClassNotFoundException
        └── ParseException
```

### Checked vs Unchecked Exceptions

| Type | Description | Handling Required | Examples |
|------|-------------|-------------------|----------|
| **Checked** | Compile-time exceptions | Must be handled or declared | IOException, SQLException |
| **Unchecked** | Runtime exceptions | Optional handling | NullPointerException, ArrayIndexOutOfBoundsException |
| **Errors** | JVM-level problems | Usually not handled | OutOfMemoryError, StackOverflowError |

## 🛠️ Exception Handling Mechanisms

### 1. try-catch Block

```java
public class BasicExceptionHandling {
    public static void main(String[] args) {
        try {
            // Code that might throw an exception
            int result = 10 / 0;  // ArithmeticException
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            // Handle the specific exception
            System.out.println("Error: Cannot divide by zero!");
            System.out.println("Exception message: " + e.getMessage());
        }
        
        System.out.println("Program continues...");
    }
}
```

### 2. Multiple catch Blocks

```java
public class MultipleCatchExample {
    public static void parseAndDivide(String[] args) {
        try {
            // Multiple potential exceptions
            int num1 = Integer.parseInt(args[0]);  // NumberFormatException
            int num2 = Integer.parseInt(args[1]);  // ArrayIndexOutOfBoundsException
            int result = num1 / num2;              // ArithmeticException
            
            System.out.println("Result: " + result);
            
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Please provide two numbers as arguments");
        } catch (NumberFormatException e) {
            System.out.println("Error: Please provide valid integers");
        } catch (ArithmeticException e) {
            System.out.println("Error: Cannot divide by zero");
        }
    }
}
```

### 3. Multi-catch Block (Java 7+)

```java
public class MultiCatchExample {
    public static void processFile(String filename) {
        try {
            FileReader file = new FileReader(filename);
            BufferedReader reader = new BufferedReader(file);
            String line = reader.readLine();
            int number = Integer.parseInt(line);
            
        } catch (IOException | NumberFormatException e) {
            // Handle multiple exception types in one block
            System.out.println("Error processing file: " + e.getMessage());
            
            // Note: 'e' is effectively final in multi-catch
            if (e instanceof IOException) {
                System.out.println("File operation failed");
            } else if (e instanceof NumberFormatException) {
                System.out.println("Invalid number format in file");
            }
        }
    }
}
```

### 4. Catching Parent Exception Classes

```java
public class ParentExceptionExample {
    public static void riskyOperation() {
        try {
            // Various operations that might throw different exceptions
            performFileOperation();
            performNetworkOperation();
            performDatabaseOperation();
            
        } catch (IOException e) {
            // Catches FileNotFoundException, SocketException, etc.
            System.out.println("I/O Error: " + e.getMessage());
        } catch (Exception e) {
            // Catches any other exception
            System.out.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

## 🔧 The finally Block

The `finally` block always executes, regardless of whether an exception occurs or not. It's commonly used for cleanup operations.

```java
public class FinallyExample {
    public static void readFile(String filename) {
        FileInputStream file = null;
        try {
            file = new FileInputStream(filename);
            // Read file operations
            System.out.println("File opened successfully");
            
        } catch (FileNotFoundException e) {
            System.out.println("File not found: " + filename);
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        } finally {
            // Cleanup - always executes
            if (file != null) {
                try {
                    file.close();
                    System.out.println("File closed");
                } catch (IOException e) {
                    System.out.println("Error closing file: " + e.getMessage());
                }
            }
        }
    }
}
```

### finally Block Execution Scenarios

```java
public class FinallyScenarios {
    
    // Scenario 1: Normal execution
    public static int scenario1() {
        try {
            return 1;
        } finally {
            System.out.println("Finally executes before return");
        }
    }
    
    // Scenario 2: Exception thrown
    public static void scenario2() {
        try {
            throw new RuntimeException("Error");
        } catch (RuntimeException e) {
            System.out.println("Exception caught");
        } finally {
            System.out.println("Finally executes after catch");
        }
    }
    
    // Scenario 3: System.exit() - finally does NOT execute
    public static void scenario3() {
        try {
            System.exit(0);  // JVM terminates
        } finally {
            System.out.println("This will NOT execute");
        }
    }
    
    // Scenario 4: Return value can be overridden by finally
    public static int scenario4() {
        try {
            return 1;
        } finally {
            return 2;  // This overrides the return from try block
        }
        // Result: 2 (not recommended practice)
    }
}
```

## 🚀 Throwing Exceptions

### Using throw Statement

```java
public class ThrowExample {
    
    public static void validateAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative: " + age);
        }
        if (age > 150) {
            throw new IllegalArgumentException("Age seems unrealistic: " + age);
        }
        System.out.println("Valid age: " + age);
    }
    
    public static double calculateSquareRoot(double number) {
        if (number < 0) {
            throw new ArithmeticException("Cannot calculate square root of negative number");
        }
        return Math.sqrt(number);
    }
    
    public static void main(String[] args) {
        try {
            validateAge(-5);
        } catch (IllegalArgumentException e) {
            System.out.println("Validation error: " + e.getMessage());
        }
        
        try {
            double result = calculateSquareRoot(-4);
        } catch (ArithmeticException e) {
            System.out.println("Math error: " + e.getMessage());
        }
    }
}
```

### Using throws Declaration

```java
public class ThrowsExample {
    
    // Method declares it might throw checked exceptions
    public static void readFileContent(String filename) throws IOException {
        FileReader file = new FileReader(filename);  // May throw FileNotFoundException
        BufferedReader reader = new BufferedReader(file);
        
        String line;
        while ((line = reader.readLine()) != null) {  // May throw IOException
            System.out.println(line);
        }
        
        reader.close();  // May throw IOException
    }
    
    // Method that calls another method with throws declaration
    public static void processFile(String filename) {
        try {
            readFileContent(filename);  // Must handle declared exceptions
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
    }
    
    // Alternative: Propagate the exception further
    public static void processFileAlternative(String filename) throws IOException {
        readFileContent(filename);  // Let caller handle the exception
    }
}
```

## 🎯 Custom Exceptions

Creating custom exceptions helps make your code more readable and provides specific error handling for your domain.

### Creating Custom Checked Exceptions

```java
// Custom checked exception
public class InsufficientFundsException extends Exception {
    private double amount;
    private double balance;
    
    public InsufficientFundsException(double amount, double balance) {
        super("Insufficient funds: Attempted to withdraw " + amount + 
              " but balance is only " + balance);
        this.amount = amount;
        this.balance = balance;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public double getBalance() {
        return balance;
    }
}

// Using the custom exception
public class BankAccount {
    private double balance;
    
    public BankAccount(double initialBalance) {
        this.balance = initialBalance;
    }
    
    public void withdraw(double amount) throws InsufficientFundsException {
        if (amount > balance) {
            throw new InsufficientFundsException(amount, balance);
        }
        balance -= amount;
        System.out.println("Withdrawn: $" + amount + ", Remaining: $" + balance);
    }
}
```

### Creating Custom Unchecked Exceptions

```java
// Custom unchecked exception
public class InvalidEmailException extends RuntimeException {
    private String email;
    
    public InvalidEmailException(String email) {
        super("Invalid email format: " + email);
        this.email = email;
    }
    
    public String getEmail() {
        return email;
    }
}

// Using the custom unchecked exception
public class EmailValidator {
    
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new InvalidEmailException(email);
        }
        
        if (!email.contains("@") || !email.contains(".")) {
            throw new InvalidEmailException(email);
        }
        
        return true;
    }
    
    public static void validateAndSendEmail(String email) {
        try {
            if (isValidEmail(email)) {
                System.out.println("Sending email to: " + email);
            }
        } catch (InvalidEmailException e) {
            System.out.println("Email validation failed: " + e.getMessage());
        }
    }
}
```

## 🛡️ Exception Handling Best Practices

### 1. Be Specific with Exception Types

```java
// Bad - Too generic
public void processData(String data) throws Exception {
    // ...
}

// Good - Specific exceptions
public void processData(String data) throws InvalidDataException, 
                                            ProcessingException {
    // ...
}
```

### 2. Don't Swallow Exceptions

```java
// Bad - Silently ignoring exceptions
try {
    riskyOperation();
} catch (Exception e) {
    // Do nothing - BAD!
}

// Good - At least log the exception
try {
    riskyOperation();
} catch (Exception e) {
    logger.error("Error in risky operation", e);
    // Optionally re-throw or handle appropriately
}
```

### 3. Use try-with-resources for AutoCloseable Resources

```java
// Old way - manual resource management
public void readFileOldWay(String filename) throws IOException {
    FileInputStream fis = null;
    try {
        fis = new FileInputStream(filename);
        // Use the stream
    } finally {
        if (fis != null) {
            try {
                fis.close();
            } catch (IOException e) {
                // Handle close exception
            }
        }
    }
}

// Better way - try-with-resources (Java 7+)
public void readFileNewWay(String filename) throws IOException {
    try (FileInputStream fis = new FileInputStream(filename)) {
        // Use the stream
        // Automatically closed, even if exception occurs
    }
}

// Multiple resources
public void copyFile(String source, String destination) throws IOException {
    try (FileInputStream fis = new FileInputStream(source);
         FileOutputStream fos = new FileOutputStream(destination)) {
        
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = fis.read(buffer)) != -1) {
            fos.write(buffer, 0, bytesRead);
        }
    }
    // Both streams automatically closed
}
```

### 4. Provide Meaningful Error Messages

```java
public class MeaningfulExceptions {
    
    public static void processUserInput(String input, int index) {
        if (input == null) {
            throw new IllegalArgumentException("Input cannot be null");
        }
        
        if (index < 0 || index >= input.length()) {
            throw new IndexOutOfBoundsException(
                String.format("Index %d is out of bounds for string of length %d", 
                            index, input.length()));
        }
        
        // Process the input
        char character = input.charAt(index);
        System.out.println("Character at index " + index + ": " + character);
    }
}
```

### 5. Don't Use Exceptions for Control Flow

```java
// Bad - Using exceptions for control flow
public boolean isValidNumber(String str) {
    try {
        Integer.parseInt(str);
        return true;
    } catch (NumberFormatException e) {
        return false;
    }
}

// Good - Proper validation
public boolean isValidNumber(String str) {
    if (str == null || str.trim().isEmpty()) {
        return false;
    }
    
    try {
        Integer.parseInt(str);
        return true;
    } catch (NumberFormatException e) {
        return false;
    }
}

// Even better - Use regex or dedicated validation
public boolean isValidNumberBest(String str) {
    return str != null && str.matches("-?\\d+");
}
```

## 🏁 Practical Examples

### 1. File Processing with Multiple Exception Types

```java
public class FileProcessor {
    
    public static void processFile(String filename) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            
            String line;
            int lineNumber = 0;
            
            while ((line = reader.readLine()) != null) {
                lineNumber++;
                
                try {
                    processLine(line, lineNumber);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid number format at line " + lineNumber + 
                                     ": " + line);
                } catch (IllegalArgumentException e) {
                    System.err.println("Invalid data at line " + lineNumber + 
                                     ": " + e.getMessage());
                }
            }
            
        } catch (FileNotFoundException e) {
            System.err.println("File not found: " + filename);
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
        }
    }
    
    private static void processLine(String line, int lineNumber) {
        if (line.trim().isEmpty()) {
            throw new IllegalArgumentException("Empty line");
        }
        
        String[] parts = line.split(",");
        if (parts.length != 3) {
            throw new IllegalArgumentException("Expected 3 fields, got " + parts.length);
        }
        
        String name = parts[0].trim();
        int age = Integer.parseInt(parts[1].trim());  // May throw NumberFormatException
        double salary = Double.parseDouble(parts[2].trim());  // May throw NumberFormatException
        
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("Invalid age: " + age);
        }
        
        System.out.println("Processed: " + name + ", Age: " + age + ", Salary: $" + salary);
    }
}
```

### 2. Database Connection with Exception Handling

```java
public class DatabaseManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mydb";
    private static final String USER = "username";
    private static final String PASSWORD = "password";
    
    public static List<User> getUsers() throws DatabaseException {
        List<User> users = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
            
        } catch (SQLException e) {
            throw new DatabaseException("Failed to retrieve users from database", e);
        }
        
        return users;
    }
    
    // Custom exception for database operations
    public static class DatabaseException extends Exception {
        public DatabaseException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}
```

### 3. Input Validation Framework

```java
public class ValidationFramework {
    
    public static class ValidationException extends Exception {
        private List<String> errors;
        
        public ValidationException(List<String> errors) {
            super("Validation failed: " + String.join(", ", errors));
            this.errors = errors;
        }
        
        public List<String> getErrors() {
            return errors;
        }
    }
    
    public static void validateUser(User user) throws ValidationException {
        List<String> errors = new ArrayList<>();
        
        if (user.getName() == null || user.getName().trim().isEmpty()) {
            errors.add("Name is required");
        }
        
        if (user.getEmail() == null || !isValidEmail(user.getEmail())) {
            errors.add("Valid email is required");
        }
        
        if (user.getAge() < 0 || user.getAge() > 150) {
            errors.add("Age must be between 0 and 150");
        }
        
        if (!errors.isEmpty()) {
            throw new ValidationException(errors);
        }
    }
    
    private static boolean isValidEmail(String email) {
        return email.contains("@") && email.contains(".");
    }
    
    public static void processUser(User user) {
        try {
            validateUser(user);
            System.out.println("User is valid: " + user);
            // Process the user
        } catch (ValidationException e) {
            System.err.println("User validation failed:");
            for (String error : e.getErrors()) {
                System.err.println("  - " + error);
            }
        }
    }
}
```

## ⚠️ Common Pitfalls

### 1. Catching Exception Too Broadly

```java
// Bad - Catches everything, including programming errors
try {
    doSomething();
} catch (Exception e) {
    // This might catch NullPointerException, which indicates a bug
}

// Good - Catch specific expected exceptions
try {
    doSomething();
} catch (IOException e) {
    // Handle I/O issues
} catch (ParseException e) {
    // Handle parsing issues
}
```

### 2. Not Documenting Thrown Exceptions

```java
// Bad - No documentation about exceptions
public void processData(String data) throws Exception {
    // ...
}

// Good - Documented exceptions
/**
 * Processes the given data string.
 * 
 * @param data the data to process
 * @throws IllegalArgumentException if data is null or empty
 * @throws ProcessingException if data format is invalid
 * @throws IOException if file operations fail
 */
public void processData(String data) throws IllegalArgumentException, 
                                           ProcessingException, 
                                           IOException {
    // ...
}
```

### 3. Resource Leaks

```java
// Bad - Potential resource leak
public void readFile(String filename) throws IOException {
    FileInputStream fis = new FileInputStream(filename);
    // If exception occurs here, stream is never closed
    byte[] data = fis.readAllBytes();
    fis.close();
}

// Good - Using try-with-resources
public void readFile(String filename) throws IOException {
    try (FileInputStream fis = new FileInputStream(filename)) {
        byte[] data = fis.readAllBytes();
        // Stream automatically closed
    }
}
```

## 📋 Summary

Exception handling is crucial for building robust Java applications:

### Key Concepts:
1. **Exceptions** represent recoverable errors that can be handled
2. **Checked exceptions** must be handled or declared
3. **Unchecked exceptions** (runtime exceptions) are optional to handle
4. **finally** blocks always execute for cleanup operations
5. **try-with-resources** automatically manages resource cleanup

### Best Practices:
- ✅ Be specific with exception types
- ✅ Provide meaningful error messages
- ✅ Use try-with-resources for resource management
- ✅ Log exceptions appropriately
- ✅ Create custom exceptions for domain-specific errors
- ❌ Don't use exceptions for control flow
- ❌ Don't swallow exceptions silently
- ❌ Don't catch exceptions too broadly

### When to Use:
- Error conditions that can be recovered from
- Input validation and user feedback
- Resource management and cleanup
- API error communication

Exception handling transforms potential crashes into manageable situations, making your applications more reliable and user-friendly.
