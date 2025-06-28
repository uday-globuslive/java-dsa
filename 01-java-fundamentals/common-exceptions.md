# Common Java Exceptions

## 🎯 Overview

Understanding common Java exceptions is essential for effective debugging and writing robust applications. This guide covers the most frequently encountered exceptions, their causes, prevention strategies, and practical examples.

## 🔍 Runtime Exceptions (Unchecked)

### 1. NullPointerException (NPE)

**Most common Java exception** - occurs when attempting to use a reference that points to no location in memory (null).

```java
public class NullPointerExceptionDemo {
    
    // Common scenarios that cause NPE
    public static void demonstrateNPE() {
        
        // Scenario 1: Calling method on null reference
        String str = null;
        try {
            int length = str.length();  // NPE here
        } catch (NullPointerException e) {
            System.out.println("NPE: Calling method on null reference");
        }
        
        // Scenario 2: Accessing array element when array is null
        int[] array = null;
        try {
            int value = array[0];  // NPE here
        } catch (NullPointerException e) {
            System.out.println("NPE: Accessing null array");
        }
        
        // Scenario 3: Getting field of null object
        Person person = null;
        try {
            String name = person.name;  // NPE here
        } catch (NullPointerException e) {
            System.out.println("NPE: Accessing field of null object");
        }
        
        // Scenario 4: Synchronizing on null object
        Object lock = null;
        try {
            synchronized(lock) {  // NPE here
                // some code
            }
        } catch (NullPointerException e) {
            System.out.println("NPE: Synchronizing on null object");
        }
    }
    
    // Prevention strategies
    public static void preventNPE() {
        String str = getStringFromSomewhere();
        
        // Strategy 1: Null check
        if (str != null) {
            int length = str.length();
            System.out.println("Length: " + length);
        }
        
        // Strategy 2: Use Optional (Java 8+)
        Optional<String> optionalStr = Optional.ofNullable(str);
        optionalStr.ifPresent(s -> System.out.println("Length: " + s.length()));
        
        // Strategy 3: Defensive programming
        String result = safeStringOperation(str);
        
        // Strategy 4: Use null-safe utilities
        boolean isEmpty = Objects.isNull(str) || str.isEmpty();
    }
    
    public static String safeStringOperation(String input) {
        return input != null ? input.toUpperCase() : "DEFAULT";
    }
    
    private static String getStringFromSomewhere() {
        // Simulate method that might return null
        return Math.random() > 0.5 ? "Hello" : null;
    }
    
    static class Person {
        String name;
    }
}
```

### 2. ArrayIndexOutOfBoundsException

Occurs when trying to access an array element with an invalid index.

```java
public class ArrayIndexOutOfBoundsDemo {
    
    public static void demonstrateArrayIndexOutOfBounds() {
        int[] numbers = {1, 2, 3, 4, 5};
        
        // Valid access
        System.out.println("Valid access: " + numbers[2]);  // Index 2 is valid
        
        // Invalid accesses
        try {
            int value = numbers[10];  // Index 10 doesn't exist
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Index 10 is out of bounds for array length " + numbers.length);
        }
        
        try {
            int value = numbers[-1];  // Negative index
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Error: Negative index -1 is invalid");
        }
        
        // Common mistake: off-by-one error
        try {
            for (int i = 0; i <= numbers.length; i++) {  // Should be i < numbers.length
                System.out.println(numbers[i]);
            }
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Off-by-one error: accessed index " + numbers.length);
        }
    }
    
    // Safe array access methods
    public static int safeArrayAccess(int[] array, int index) {
        if (array == null) {
            throw new IllegalArgumentException("Array cannot be null");
        }
        if (index < 0 || index >= array.length) {
            throw new IllegalArgumentException("Index " + index + " is out of bounds for array length " + array.length);
        }
        return array[index];
    }
    
    public static Optional<Integer> safestArrayAccess(int[] array, int index) {
        if (array == null || index < 0 || index >= array.length) {
            return Optional.empty();
        }
        return Optional.of(array[index]);
    }
    
    // Prevention patterns
    public static void preventArrayIndexOutOfBounds() {
        int[] numbers = {1, 2, 3, 4, 5};
        
        // Pattern 1: Standard loop
        for (int i = 0; i < numbers.length; i++) {
            System.out.println("Element " + i + ": " + numbers[i]);
        }
        
        // Pattern 2: Enhanced for loop (recommended when index not needed)
        for (int number : numbers) {
            System.out.println("Element: " + number);
        }
        
        // Pattern 3: Check bounds before access
        int index = 7;
        if (index >= 0 && index < numbers.length) {
            System.out.println("Safe access: " + numbers[index]);
        } else {
            System.out.println("Index " + index + " is out of bounds");
        }
    }
}
```

### 3. NumberFormatException

Occurs when attempting to convert a string to a numeric type, but the string doesn't have an appropriate format.

```java
public class NumberFormatExceptionDemo {
    
    public static void demonstrateNumberFormatException() {
        
        // Common scenarios
        String[] inputs = {
            "123",        // Valid
            "12.34",      // Valid for Double, invalid for Integer
            "abc",        // Invalid
            "",           // Empty string
            " 123 ",      // Leading/trailing spaces
            "123abc",     // Mixed content
            "12,345",     // Comma separator
            null          // Null input
        };
        
        for (String input : inputs) {
            try {
                if (input == null) {
                    System.out.println("Input: null -> Cannot parse null");
                    Integer.parseInt(input);
                } else {
                    int number = Integer.parseInt(input);
                    System.out.println("Input: '" + input + "' -> " + number);
                }
            } catch (NumberFormatException e) {
                System.out.println("Input: '" + input + "' -> NumberFormatException: " + e.getMessage());
            }
        }
    }
    
    // Safe parsing methods
    public static OptionalInt safeParseInt(String str) {
        if (str == null || str.trim().isEmpty()) {
            return OptionalInt.empty();
        }
        
        try {
            return OptionalInt.of(Integer.parseInt(str.trim()));
        } catch (NumberFormatException e) {
            return OptionalInt.empty();
        }
    }
    
    public static int parseIntWithDefault(String str, int defaultValue) {
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
    
    // Validation before parsing
    public static boolean isValidInteger(String str) {
        if (str == null || str.trim().isEmpty()) {
            return false;
        }
        
        String trimmed = str.trim();
        
        // Check for sign
        int startIndex = 0;
        if (trimmed.charAt(0) == '-' || trimmed.charAt(0) == '+') {
            if (trimmed.length() == 1) {
                return false;  // Just a sign
            }
            startIndex = 1;
        }
        
        // Check remaining characters
        for (int i = startIndex; i < trimmed.length(); i++) {
            if (!Character.isDigit(trimmed.charAt(i))) {
                return false;
            }
        }
        
        return true;
    }
    
    // Advanced parsing with validation
    public static class SafeParser {
        
        public static Result<Integer> parseInt(String str) {
            if (str == null) {
                return Result.failure("Input cannot be null");
            }
            
            String trimmed = str.trim();
            if (trimmed.isEmpty()) {
                return Result.failure("Input cannot be empty");
            }
            
            try {
                int value = Integer.parseInt(trimmed);
                return Result.success(value);
            } catch (NumberFormatException e) {
                return Result.failure("Invalid number format: " + str);
            }
        }
        
        public static Result<Double> parseDouble(String str) {
            if (str == null) {
                return Result.failure("Input cannot be null");
            }
            
            String trimmed = str.trim();
            if (trimmed.isEmpty()) {
                return Result.failure("Input cannot be empty");
            }
            
            try {
                double value = Double.parseDouble(trimmed);
                if (Double.isInfinite(value) || Double.isNaN(value)) {
                    return Result.failure("Invalid double value: " + str);
                }
                return Result.success(value);
            } catch (NumberFormatException e) {
                return Result.failure("Invalid number format: " + str);
            }
        }
    }
    
    // Result wrapper class
    public static class Result<T> {
        private final T value;
        private final String error;
        private final boolean isSuccess;
        
        private Result(T value, String error, boolean isSuccess) {
            this.value = value;
            this.error = error;
            this.isSuccess = isSuccess;
        }
        
        public static <T> Result<T> success(T value) {
            return new Result<>(value, null, true);
        }
        
        public static <T> Result<T> failure(String error) {
            return new Result<>(null, error, false);
        }
        
        public boolean isSuccess() { return isSuccess; }
        public T getValue() { return value; }
        public String getError() { return error; }
    }
}
```

### 4. IllegalArgumentException

Thrown when a method receives an argument that is inappropriate or invalid.

```java
public class IllegalArgumentExceptionDemo {
    
    // Common scenarios and prevention
    public static class Calculator {
        
        public static double divide(double numerator, double denominator) {
            if (denominator == 0) {
                throw new IllegalArgumentException("Denominator cannot be zero");
            }
            return numerator / denominator;
        }
        
        public static double sqrt(double number) {
            if (number < 0) {
                throw new IllegalArgumentException("Cannot calculate square root of negative number: " + number);
            }
            return Math.sqrt(number);
        }
        
        public static int factorial(int n) {
            if (n < 0) {
                throw new IllegalArgumentException("Factorial is not defined for negative numbers: " + n);
            }
            if (n > 20) {
                throw new IllegalArgumentException("Factorial of " + n + " would cause integer overflow");
            }
            
            int result = 1;
            for (int i = 2; i <= n; i++) {
                result *= i;
            }
            return result;
        }
    }
    
    public static class StringValidator {
        
        public static String validateAndFormat(String input) {
            if (input == null) {
                throw new IllegalArgumentException("Input cannot be null");
            }
            if (input.trim().isEmpty()) {
                throw new IllegalArgumentException("Input cannot be empty or whitespace only");
            }
            
            return input.trim().toLowerCase();
        }
        
        public static void validateEmail(String email) {
            if (email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Email cannot be null or empty");
            }
            
            email = email.trim();
            
            if (!email.contains("@")) {
                throw new IllegalArgumentException("Email must contain @ symbol: " + email);
            }
            
            if (!email.contains(".")) {
                throw new IllegalArgumentException("Email must contain domain: " + email);
            }
            
            String[] parts = email.split("@");
            if (parts.length != 2) {
                throw new IllegalArgumentException("Email format is invalid: " + email);
            }
            
            if (parts[0].isEmpty() || parts[1].isEmpty()) {
                throw new IllegalArgumentException("Email parts cannot be empty: " + email);
            }
        }
    }
    
    public static class ArrayUtilities {
        
        public static int findMax(int[] array) {
            if (array == null) {
                throw new IllegalArgumentException("Array cannot be null");
            }
            if (array.length == 0) {
                throw new IllegalArgumentException("Array cannot be empty");
            }
            
            int max = array[0];
            for (int i = 1; i < array.length; i++) {
                if (array[i] > max) {
                    max = array[i];
                }
            }
            return max;
        }
        
        public static void validateRange(int value, int min, int max, String fieldName) {
            if (value < min || value > max) {
                throw new IllegalArgumentException(
                    String.format("%s must be between %d and %d, but was %d", 
                                fieldName, min, max, value));
            }
        }
    }
    
    // Usage examples with proper error handling
    public static void demonstrateUsage() {
        
        // Calculator examples
        try {
            double result = Calculator.divide(10, 0);
        } catch (IllegalArgumentException e) {
            System.out.println("Calculator error: " + e.getMessage());
        }
        
        try {
            double sqrtResult = Calculator.sqrt(-4);
        } catch (IllegalArgumentException e) {
            System.out.println("Math error: " + e.getMessage());
        }
        
        // Validation examples
        try {
            StringValidator.validateEmail("invalid-email");
        } catch (IllegalArgumentException e) {
            System.out.println("Validation error: " + e.getMessage());
        }
        
        try {
            ArrayUtilities.validateRange(150, 0, 100, "Age");
        } catch (IllegalArgumentException e) {
            System.out.println("Range error: " + e.getMessage());
        }
    }
}
```

### 5. IllegalStateException

Thrown when a method is invoked at an inappropriate time or when the object is in an inappropriate state.

```java
public class IllegalStateExceptionDemo {
    
    // Example: State machine
    public static class OrderProcessor {
        enum OrderState {
            CREATED, PAID, SHIPPED, DELIVERED, CANCELLED
        }
        
        private OrderState currentState = OrderState.CREATED;
        private String orderId;
        
        public OrderProcessor(String orderId) {
            this.orderId = orderId;
        }
        
        public void payOrder() {
            if (currentState != OrderState.CREATED) {
                throw new IllegalStateException("Cannot pay order in state: " + currentState);
            }
            currentState = OrderState.PAID;
            System.out.println("Order " + orderId + " has been paid");
        }
        
        public void shipOrder() {
            if (currentState != OrderState.PAID) {
                throw new IllegalStateException("Cannot ship order in state: " + currentState);
            }
            currentState = OrderState.SHIPPED;
            System.out.println("Order " + orderId + " has been shipped");
        }
        
        public void deliverOrder() {
            if (currentState != OrderState.SHIPPED) {
                throw new IllegalStateException("Cannot deliver order in state: " + currentState);
            }
            currentState = OrderState.DELIVERED;
            System.out.println("Order " + orderId + " has been delivered");
        }
        
        public void cancelOrder() {
            if (currentState == OrderState.DELIVERED) {
                throw new IllegalStateException("Cannot cancel delivered order");
            }
            if (currentState == OrderState.CANCELLED) {
                throw new IllegalStateException("Order is already cancelled");
            }
            currentState = OrderState.CANCELLED;
            System.out.println("Order " + orderId + " has been cancelled");
        }
        
        public OrderState getCurrentState() {
            return currentState;
        }
    }
    
    // Example: Resource management
    public static class DatabaseConnection {
        private boolean isConnected = false;
        private boolean isTransactionActive = false;
        
        public void connect() {
            if (isConnected) {
                throw new IllegalStateException("Already connected to database");
            }
            isConnected = true;
            System.out.println("Connected to database");
        }
        
        public void disconnect() {
            if (!isConnected) {
                throw new IllegalStateException("Not connected to database");
            }
            if (isTransactionActive) {
                throw new IllegalStateException("Cannot disconnect while transaction is active");
            }
            isConnected = false;
            System.out.println("Disconnected from database");
        }
        
        public void beginTransaction() {
            if (!isConnected) {
                throw new IllegalStateException("Must be connected to begin transaction");
            }
            if (isTransactionActive) {
                throw new IllegalStateException("Transaction is already active");
            }
            isTransactionActive = true;
            System.out.println("Transaction started");
        }
        
        public void commitTransaction() {
            if (!isConnected) {
                throw new IllegalStateException("Must be connected to commit transaction");
            }
            if (!isTransactionActive) {
                throw new IllegalStateException("No active transaction to commit");
            }
            isTransactionActive = false;
            System.out.println("Transaction committed");
        }
        
        public void rollbackTransaction() {
            if (!isConnected) {
                throw new IllegalStateException("Must be connected to rollback transaction");
            }
            if (!isTransactionActive) {
                throw new IllegalStateException("No active transaction to rollback");
            }
            isTransactionActive = false;
            System.out.println("Transaction rolled back");
        }
    }
    
    // Demonstration of proper usage
    public static void demonstrateStateMachine() {
        OrderProcessor order = new OrderProcessor("ORD-001");
        
        try {
            // Correct sequence
            order.payOrder();
            order.shipOrder();
            order.deliverOrder();
            
        } catch (IllegalStateException e) {
            System.out.println("State error: " + e.getMessage());
        }
        
        // Try invalid operations
        OrderProcessor order2 = new OrderProcessor("ORD-002");
        try {
            order2.shipOrder();  // Should fail - not paid yet
        } catch (IllegalStateException e) {
            System.out.println("Expected error: " + e.getMessage());
        }
    }
}
```

## 🔧 Checked Exceptions

### 1. IOException

Signals that an I/O exception of some sort has occurred.

```java
public class IOExceptionDemo {
    
    // File operations that can throw IOException
    public static void fileOperationsExample() {
        String filename = "nonexistent-file.txt";
        
        // Reading files
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line = reader.readLine();
            System.out.println("Read: " + line);
        } catch (FileNotFoundException e) {
            System.out.println("File not found: " + filename);
        } catch (IOException e) {
            System.out.println("I/O Error: " + e.getMessage());
        }
        
        // Writing files
        try (PrintWriter writer = new PrintWriter(new FileWriter("output.txt"))) {
            writer.println("Hello, World!");
            writer.println("This is a test file.");
        } catch (IOException e) {
            System.out.println("Error writing file: " + e.getMessage());
        }
    }
    
    // Network operations
    public static void networkOperationsExample() {
        try {
            URL url = new URL("https://api.example.com/data");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            
            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()))) {
                
                String line;
                StringBuilder response = new StringBuilder();
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                
                System.out.println("Response: " + response.toString());
                
            }
        } catch (MalformedURLException e) {
            System.out.println("Invalid URL: " + e.getMessage());
        } catch (IOException e) {
            System.out.println("Network error: " + e.getMessage());
        }
    }
    
    // Safe file operations utility
    public static Optional<String> safeReadFile(String filename) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line).append(System.lineSeparator());
            }
            return Optional.of(content.toString());
        } catch (IOException e) {
            System.err.println("Failed to read file " + filename + ": " + e.getMessage());
            return Optional.empty();
        }
    }
}
```

### 2. ClassNotFoundException

Thrown when an application tries to load a class through its string name but the class cannot be found.

```java
public class ClassNotFoundExceptionDemo {
    
    public static void demonstrateClassLoading() {
        String[] classNames = {
            "java.lang.String",           // Valid class
            "java.util.ArrayList",        // Valid class
            "com.nonexistent.MyClass",    // Non-existent class
            "java.lang.NonExistentClass"  // Non-existent class
        };
        
        for (String className : classNames) {
            try {
                Class<?> clazz = Class.forName(className);
                System.out.println("Successfully loaded: " + clazz.getName());
                
                // Create instance if possible
                if (clazz.getName().equals("java.util.ArrayList")) {
                    Object instance = clazz.getDeclaredConstructor().newInstance();
                    System.out.println("Created instance: " + instance.getClass().getSimpleName());
                }
                
            } catch (ClassNotFoundException e) {
                System.out.println("Class not found: " + className);
            } catch (Exception e) {
                System.out.println("Error creating instance of " + className + ": " + e.getMessage());
            }
        }
    }
    
    // Safe class loading utility
    public static Optional<Class<?>> safeLoadClass(String className) {
        try {
            return Optional.of(Class.forName(className));
        } catch (ClassNotFoundException e) {
            System.err.println("Failed to load class: " + className);
            return Optional.empty();
        }
    }
    
    // Dynamic plugin loading example
    public static void loadPlugin(String pluginClassName) {
        try {
            Class<?> pluginClass = Class.forName(pluginClassName);
            
            // Check if it implements the required interface
            if (Plugin.class.isAssignableFrom(pluginClass)) {
                Plugin plugin = (Plugin) pluginClass.getDeclaredConstructor().newInstance();
                plugin.initialize();
                System.out.println("Plugin loaded successfully: " + plugin.getName());
            } else {
                System.out.println("Class " + pluginClassName + " does not implement Plugin interface");
            }
            
        } catch (ClassNotFoundException e) {
            System.out.println("Plugin class not found: " + pluginClassName);
        } catch (Exception e) {
            System.out.println("Error loading plugin: " + e.getMessage());
        }
    }
    
    interface Plugin {
        void initialize();
        String getName();
    }
}
```

## 🛡️ Exception Prevention Strategies

### 1. Defensive Programming

```java
public class DefensiveProgramming {
    
    // Input validation
    public static String processUserInput(String input) {
        // Null check
        if (input == null) {
            throw new IllegalArgumentException("Input cannot be null");
        }
        
        // Empty check
        String trimmed = input.trim();
        if (trimmed.isEmpty()) {
            throw new IllegalArgumentException("Input cannot be empty");
        }
        
        // Length validation
        if (trimmed.length() > 1000) {
            throw new IllegalArgumentException("Input too long (max 1000 characters)");
        }
        
        return trimmed.toLowerCase();
    }
    
    // Safe collection operations
    public static <T> T safeGet(List<T> list, int index) {
        Objects.requireNonNull(list, "List cannot be null");
        
        if (index < 0 || index >= list.size()) {
            throw new IndexOutOfBoundsException(
                "Index " + index + " out of bounds for list size " + list.size());
        }
        
        return list.get(index);
    }
    
    // Safe map operations
    public static <K, V> V safeMapGet(Map<K, V> map, K key, V defaultValue) {
        if (map == null) {
            return defaultValue;
        }
        
        V value = map.get(key);
        return value != null ? value : defaultValue;
    }
}
```

### 2. Using Optional for Null Safety

```java
public class OptionalUsage {
    
    // Repository pattern with Optional
    public static class UserRepository {
        private Map<Integer, User> users = new HashMap<>();
        
        public Optional<User> findById(Integer id) {
            return Optional.ofNullable(users.get(id));
        }
        
        public Optional<User> findByEmail(String email) {
            return users.values().stream()
                    .filter(user -> email.equals(user.getEmail()))
                    .findFirst();
        }
        
        public void save(User user) {
            Objects.requireNonNull(user, "User cannot be null");
            Objects.requireNonNull(user.getId(), "User ID cannot be null");
            users.put(user.getId(), user);
        }
    }
    
    // Service using Optional
    public static class UserService {
        private UserRepository repository = new UserRepository();
        
        public String getUserDisplayName(Integer userId) {
            return repository.findById(userId)
                    .map(User::getName)
                    .orElse("Unknown User");
        }
        
        public void processUser(Integer userId) {
            repository.findById(userId)
                    .ifPresentOrElse(
                        user -> System.out.println("Processing user: " + user.getName()),
                        () -> System.out.println("User not found with ID: " + userId)
                    );
        }
        
        public Optional<String> getUserEmail(Integer userId) {
            return repository.findById(userId)
                    .map(User::getEmail)
                    .filter(email -> !email.isEmpty());
        }
    }
    
    static class User {
        private Integer id;
        private String name;
        private String email;
        
        // Constructors, getters, setters
        public User(Integer id, String name, String email) {
            this.id = id;
            this.name = name;
            this.email = email;
        }
        
        public Integer getId() { return id; }
        public String getName() { return name; }
        public String getEmail() { return email; }
    }
}
```

## 🏁 Exception Handling Utilities

### 1. Exception Logging and Monitoring

```java
public class ExceptionUtils {
    private static final Logger logger = LoggerFactory.getLogger(ExceptionUtils.class);
    
    // Exception logging with context
    public static void logException(String operation, Exception e, Object... context) {
        StringBuilder contextStr = new StringBuilder();
        for (int i = 0; i < context.length; i += 2) {
            if (i + 1 < context.length) {
                contextStr.append(context[i]).append("=").append(context[i + 1]).append(" ");
            }
        }
        
        logger.error("Exception in operation '{}' with context: {} - {}", 
                    operation, contextStr.toString(), e.getMessage(), e);
    }
    
    // Safe execution wrapper
    public static <T> Optional<T> safeExecute(Supplier<T> operation, String operationName) {
        try {
            T result = operation.get();
            return Optional.ofNullable(result);
        } catch (Exception e) {
            logException(operationName, e);
            return Optional.empty();
        }
    }
    
    // Retry mechanism
    public static <T> Optional<T> executeWithRetry(Supplier<T> operation, int maxRetries, String operationName) {
        Exception lastException = null;
        
        for (int attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                T result = operation.get();
                if (attempt > 1) {
                    logger.info("Operation '{}' succeeded on attempt {}", operationName, attempt);
                }
                return Optional.ofNullable(result);
            } catch (Exception e) {
                lastException = e;
                logger.warn("Operation '{}' failed on attempt {}/{}: {}", 
                           operationName, attempt, maxRetries, e.getMessage());
                
                if (attempt < maxRetries) {
                    try {
                        Thread.sleep(1000 * attempt); // Exponential backoff
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        break;
                    }
                }
            }
        }
        
        logException(operationName + " (after " + maxRetries + " attempts)", lastException);
        return Optional.empty();
    }
}
```

## 📋 Summary

Understanding common Java exceptions is crucial for robust application development:

### Most Critical Exceptions to Master:
1. **NullPointerException** - Use null checks and Optional
2. **ArrayIndexOutOfBoundsException** - Validate array bounds
3. **NumberFormatException** - Validate input before parsing
4. **IllegalArgumentException** - Validate method parameters
5. **IllegalStateException** - Check object state before operations
6. **IOException** - Handle I/O operations gracefully
7. **ClassNotFoundException** - Handle dynamic class loading

### Prevention Strategies:
- ✅ **Defensive programming** with input validation
- ✅ **Use Optional** for null-safe operations
- ✅ **Validate parameters** at method entry points
- ✅ **Check array bounds** before accessing elements
- ✅ **Use try-with-resources** for resource management
- ✅ **Log exceptions** with proper context
- ✅ **Provide meaningful error messages**

### Best Practices:
- Handle specific exceptions rather than catching `Exception`
- Use custom exceptions for domain-specific errors
- Always clean up resources in finally blocks or use try-with-resources
- Log exceptions with sufficient context for debugging
- Don't suppress exceptions unless you have a good reason
- Fail fast with clear error messages

Mastering these common exceptions and their prevention strategies will significantly improve your Java programming skills and application reliability.
