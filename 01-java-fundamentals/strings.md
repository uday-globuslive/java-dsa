# Strings in Java

## 🎯 Overview

Strings are one of the most important and frequently used data types in Java programming. Unlike primitive data types, String is a reference type that represents a sequence of characters. Java provides extensive support for string manipulation through the String class and related classes like StringBuilder and StringBuffer. Understanding strings is crucial for text processing, user input handling, file operations, and many other programming tasks.

## 📚 String Fundamentals

### What is a String?

In Java, a String is an object that represents an immutable sequence of characters. Once created, the content of a String object cannot be changed, which makes strings thread-safe but requires creating new objects for modifications.

### String Characteristics
- **Immutable:** String objects cannot be modified after creation
- **Reference Type:** Strings are objects, not primitives
- **Unicode Support:** Supports international characters
- **Memory Efficient:** String literal pool prevents duplicate strings
- **Thread-Safe:** Immutability makes strings inherently thread-safe

### Basic String Creation
```java
public class StringBasics {
    public static void main(String[] args) {
        // Method 1: String literals (most common)
        String str1 = "Hello, World!";
        String str2 = "Java Programming";
        
        // Method 2: Using new keyword (creates new object)
        String str3 = new String("Hello, World!");
        String str4 = new String("Java Programming");
        
        // Method 3: Character array to string
        char[] charArray = {'J', 'a', 'v', 'a'};
        String str5 = new String(charArray);
        
        // Method 4: StringBuilder/StringBuffer to string
        StringBuilder sb = new StringBuilder("Dynamic String");
        String str6 = sb.toString();
        
        // Method 5: Empty string
        String empty1 = "";
        String empty2 = new String();
        
        // Display strings
        System.out.println("String literal: " + str1);
        System.out.println("New String object: " + str3);
        System.out.println("From char array: " + str5);
        System.out.println("From StringBuilder: " + str6);
        System.out.println("Empty string length: " + empty1.length());
        
        // String comparison - reference vs content
        System.out.println("\n=== String Comparison ===");
        System.out.println("str1 == str3: " + (str1 == str3)); // false (different objects)
        System.out.println("str1.equals(str3): " + str1.equals(str3)); // true (same content)
        
        // String pool demonstration
        String pooled1 = "Hello";
        String pooled2 = "Hello";
        System.out.println("pooled1 == pooled2: " + (pooled1 == pooled2)); // true (same object from pool)
    }
}
```

## 🔧 String Properties and Methods

### Basic String Properties
```java
public class StringProperties {
    public static void main(String[] args) {
        String text = "Java Programming Language";
        
        // Length
        System.out.println("String: \"" + text + "\"");
        System.out.println("Length: " + text.length());
        
        // Character access
        System.out.println("First character: " + text.charAt(0));
        System.out.println("Last character: " + text.charAt(text.length() - 1));
        System.out.println("Character at index 5: " + text.charAt(5));
        
        // Index operations
        System.out.println("Index of 'P': " + text.indexOf('P'));
        System.out.println("Index of 'a' (first): " + text.indexOf('a'));
        System.out.println("Last index of 'a': " + text.lastIndexOf('a'));
        System.out.println("Index of 'xyz': " + text.indexOf("xyz")); // -1 (not found)
        
        // Substring operations
        System.out.println("Substring (5, 16): " + text.substring(5, 16));
        System.out.println("Substring from 17: " + text.substring(17));
        
        // Case operations
        System.out.println("Uppercase: " + text.toUpperCase());
        System.out.println("Lowercase: " + text.toLowerCase());
        
        // Trim whitespace
        String withSpaces = "  Hello World  ";
        System.out.println("Original: \"" + withSpaces + "\"");
        System.out.println("Trimmed: \"" + withSpaces.trim() + "\"");
        
        // Check string properties
        System.out.println("\n=== String Checks ===");
        String empty = "";
        String space = " ";
        String nullStr = null;
        
        System.out.println("Empty string isEmpty(): " + empty.isEmpty());
        System.out.println("Space string isEmpty(): " + space.isEmpty());
        System.out.println("Space string isBlank(): " + space.isBlank()); // Java 11+
        
        // Safe null checks
        System.out.println("Null-safe empty check: " + isNullOrEmpty(nullStr));
        System.out.println("Null-safe blank check: " + isNullOrBlank(space));
    }
    
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty();
    }
    
    public static boolean isNullOrBlank(String str) {
        return str == null || str.trim().isEmpty();
    }
}
```

### String Comparison Methods
```java
public class StringComparison {
    public static void main(String[] args) {
        String str1 = "Hello";
        String str2 = "hello";
        String str3 = "Hello";
        String str4 = "Hello World";
        
        System.out.println("=== String Comparison Methods ===");
        
        // Basic equality
        System.out.println("str1.equals(str2): " + str1.equals(str2)); // false
        System.out.println("str1.equals(str3): " + str1.equals(str3)); // true
        
        // Case-insensitive comparison
        System.out.println("str1.equalsIgnoreCase(str2): " + str1.equalsIgnoreCase(str2)); // true
        
        // Lexicographic comparison
        System.out.println("str1.compareTo(str2): " + str1.compareTo(str2)); // negative (H < h in ASCII)
        System.out.println("str1.compareTo(str3): " + str1.compareTo(str3)); // 0 (equal)
        System.out.println("str1.compareToIgnoreCase(str2): " + str1.compareToIgnoreCase(str2)); // 0
        
        // Prefix and suffix checks
        System.out.println("str4.startsWith(\"Hello\"): " + str4.startsWith("Hello")); // true
        System.out.println("str4.endsWith(\"World\"): " + str4.endsWith("World")); // true
        System.out.println("str4.contains(\"lo Wo\"): " + str4.contains("lo Wo")); // true
        
        // Region matching
        String text1 = "Java Programming";
        String text2 = "JAVA LANGUAGE";
        
        System.out.println("Region match (case sensitive): " + 
                          text1.regionMatches(0, text2, 0, 4)); // false
        System.out.println("Region match (case insensitive): " + 
                          text1.regionMatches(true, 0, text2, 0, 4)); // true
        
        // Demonstration of common comparison pitfalls
        demonstrateComparisonPitfalls();
    }
    
    public static void demonstrateComparisonPitfalls() {
        System.out.println("\n=== Common Comparison Pitfalls ===");
        
        String str1 = "Hello";
        String str2 = null;
        
        // WRONG - NullPointerException risk
        try {
            System.out.println(str2.equals(str1)); // NullPointerException
        } catch (NullPointerException e) {
            System.out.println("Error: Cannot call equals on null string");
        }
        
        // CORRECT - Safe comparison
        System.out.println("Safe comparison: " + str1.equals(str2)); // false
        System.out.println("Safe comparison with Objects.equals: " + 
                          java.util.Objects.equals(str1, str2)); // false
        
        // String interning and == operator
        String s1 = "Java";
        String s2 = "Java";
        String s3 = new String("Java");
        String s4 = s3.intern();
        
        System.out.println("s1 == s2 (literals): " + (s1 == s2)); // true
        System.out.println("s1 == s3 (new object): " + (s1 == s3)); // false
        System.out.println("s1 == s4 (interned): " + (s1 == s4)); // true
    }
}
```

## 🔨 String Manipulation Methods

### Search and Replace Operations
```java
import java.util.regex.Pattern;

public class StringManipulation {
    public static void main(String[] args) {
        String text = "Java is a programming language. Java is powerful.";
        
        System.out.println("Original text: " + text);
        System.out.println();
        
        // Finding occurrences
        findOccurrences(text);
        
        // Replace operations
        performReplacements(text);
        
        // Split operations
        performSplitOperations();
        
        // Regular expression operations
        performRegexOperations();
    }
    
    public static void findOccurrences(String text) {
        System.out.println("=== Finding Occurrences ===");
        
        String target = "Java";
        int firstIndex = text.indexOf(target);
        int lastIndex = text.lastIndexOf(target);
        
        System.out.println("First occurrence of '" + target + "': " + firstIndex);
        System.out.println("Last occurrence of '" + target + "': " + lastIndex);
        
        // Find all occurrences
        System.out.println("All occurrences of '" + target + "':");
        int index = 0;
        int count = 0;
        while ((index = text.indexOf(target, index)) != -1) {
            System.out.println("  Found at index: " + index);
            index += target.length();
            count++;
        }
        System.out.println("Total count: " + count);
        System.out.println();
    }
    
    public static void performReplacements(String text) {
        System.out.println("=== Replace Operations ===");
        
        // Replace first occurrence
        String replaced1 = text.replaceFirst("Java", "Python");
        System.out.println("Replace first 'Java': " + replaced1);
        
        // Replace all occurrences
        String replaced2 = text.replace("Java", "Python");
        System.out.println("Replace all 'Java': " + replaced2);
        
        // Replace with regex
        String replaced3 = text.replaceAll("\\b[Jj]ava\\b", "Python");
        System.out.println("Replace with regex: " + replaced3);
        
        // Character replacement
        String replaced4 = text.replace('a', 'X');
        System.out.println("Replace character 'a': " + replaced4);
        
        System.out.println();
    }
    
    public static void performSplitOperations() {
        System.out.println("=== Split Operations ===");
        
        String csv = "apple,banana,cherry,date,elderberry";
        String[] fruits = csv.split(",");
        
        System.out.println("CSV: " + csv);
        System.out.println("Split by comma:");
        for (int i = 0; i < fruits.length; i++) {
            System.out.println("  [" + i + "]: " + fruits[i]);
        }
        
        // Split with limit
        String[] limitedSplit = csv.split(",", 3);
        System.out.println("Split with limit 3:");
        for (int i = 0; i < limitedSplit.length; i++) {
            System.out.println("  [" + i + "]: " + limitedSplit[i]);
        }
        
        // Split by whitespace
        String sentence = "The quick brown fox jumps";
        String[] words = sentence.split("\\s+");
        System.out.println("Split by whitespace: " + java.util.Arrays.toString(words));
        
        // Split by multiple delimiters
        String mixed = "apple;banana,cherry:date|elderberry";
        String[] mixedSplit = mixed.split("[;,:│]");
        System.out.println("Mixed delimiters: " + java.util.Arrays.toString(mixedSplit));
        
        System.out.println();
    }
    
    public static void performRegexOperations() {
        System.out.println("=== Regular Expression Operations ===");
        
        String email = "user@example.com";
        String phone = "123-456-7890";
        String notEmail = "invalid.email";
        
        // Email validation
        String emailRegex = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$";
        System.out.println(email + " is valid email: " + email.matches(emailRegex));
        System.out.println(notEmail + " is valid email: " + notEmail.matches(emailRegex));
        
        // Phone number validation
        String phoneRegex = "\\d{3}-\\d{3}-\\d{4}";
        System.out.println(phone + " matches phone pattern: " + phone.matches(phoneRegex));
        
        // Extract numbers from string
        String text = "I have 5 apples and 10 oranges";
        String[] numbers = text.split("\\D+");
        System.out.println("Numbers extracted: " + java.util.Arrays.toString(numbers));
        
        // Replace with regex patterns
        String withNumbers = "Product123 costs $45.99 on 2024-01-15";
        String noNumbers = withNumbers.replaceAll("\\d+", "X");
        System.out.println("Replace digits: " + noNumbers);
        
        System.out.println();
    }
}
```

### String Building and Formatting
```java
public class StringBuilding {
    public static void main(String[] args) {
        // String concatenation methods
        demonstrateConcatenation();
        
        // String formatting
        demonstrateFormatting();
        
        // String joining
        demonstrateJoining();
        
        // Performance comparison
        comparePerformance();
    }
    
    public static void demonstrateConcatenation() {
        System.out.println("=== String Concatenation ===");
        
        // Method 1: Using + operator
        String first = "Hello";
        String second = "World";
        String result1 = first + " " + second + "!";
        System.out.println("Using + operator: " + result1);
        
        // Method 2: Using concat() method
        String result2 = first.concat(" ").concat(second).concat("!");
        System.out.println("Using concat(): " + result2);
        
        // Method 3: Using StringBuilder (recommended for multiple operations)
        StringBuilder sb = new StringBuilder();
        sb.append(first).append(" ").append(second).append("!");
        String result3 = sb.toString();
        System.out.println("Using StringBuilder: " + result3);
        
        // Method 4: Using String.join()
        String result4 = String.join(" ", first, second) + "!";
        System.out.println("Using String.join(): " + result4);
        
        System.out.println();
    }
    
    public static void demonstrateFormatting() {
        System.out.println("=== String Formatting ===");
        
        String name = "Alice";
        int age = 25;
        double salary = 50000.75;
        boolean employed = true;
        
        // Using String.format()
        String formatted1 = String.format("Name: %s, Age: %d, Salary: $%.2f, Employed: %b",
                                        name, age, salary, employed);
        System.out.println("String.format(): " + formatted1);
        
        // Using printf() (same formatting as String.format)
        System.out.printf("printf(): Name: %s, Age: %d, Salary: $%.2f, Employed: %b%n",
                         name, age, salary, employed);
        
        // Different format specifiers
        System.out.println("\n--- Format Specifiers ---");
        System.out.printf("Integer: %d, Hex: %x, Octal: %o%n", 255, 255, 255);
        System.out.printf("Float: %f, Scientific: %e, Compact: %g%n", 123.456, 123.456, 123.456);
        System.out.printf("Percentage: %.1f%%%n", 85.7);
        
        // Width and alignment
        System.out.println("\n--- Width and Alignment ---");
        System.out.printf("Right-aligned: '%10s'%n", "Hello");
        System.out.printf("Left-aligned: '%-10s'%n", "Hello");
        System.out.printf("Zero-padded: '%05d'%n", 42);
        
        // Date formatting
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        System.out.printf("Current time: %tF %tT%n", now, now);
        
        System.out.println();
    }
    
    public static void demonstrateJoining() {
        System.out.println("=== String Joining ===");
        
        String[] fruits = {"apple", "banana", "cherry", "date"};
        
        // Using String.join()
        String joined1 = String.join(", ", fruits);
        System.out.println("Comma separated: " + joined1);
        
        String joined2 = String.join(" | ", fruits);
        System.out.println("Pipe separated: " + joined2);
        
        // Using StringJoiner (Java 8+)
        java.util.StringJoiner joiner = new java.util.StringJoiner(", ", "[", "]");
        for (String fruit : fruits) {
            joiner.add(fruit);
        }
        System.out.println("StringJoiner with brackets: " + joiner.toString());
        
        // Building CSV format
        StringBuilder csvBuilder = new StringBuilder();
        for (int i = 0; i < fruits.length; i++) {
            csvBuilder.append("\"").append(fruits[i]).append("\"");
            if (i < fruits.length - 1) {
                csvBuilder.append(",");
            }
        }
        System.out.println("CSV format: " + csvBuilder.toString());
        
        System.out.println();
    }
    
    public static void comparePerformance() {
        System.out.println("=== Performance Comparison ===");
        
        int iterations = 10000;
        
        // String concatenation with + (inefficient for many operations)
        long start1 = System.nanoTime();
        String result1 = "";
        for (int i = 0; i < iterations; i++) {
            result1 += "a";
        }
        long time1 = System.nanoTime() - start1;
        
        // StringBuilder (efficient)
        long start2 = System.nanoTime();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < iterations; i++) {
            sb.append("a");
        }
        String result2 = sb.toString();
        long time2 = System.nanoTime() - start2;
        
        System.out.printf("String + operator: %,d ns%n", time1);
        System.out.printf("StringBuilder: %,d ns%n", time2);
        System.out.printf("StringBuilder is %.1fx faster%n", (double) time1 / time2);
        
        System.out.println("Final lengths - String: " + result1.length() + 
                          ", StringBuilder: " + result2.length());
        
        System.out.println();
    }
}
```

## 🔍 Advanced String Operations

### String Validation and Parsing
```java
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class StringValidation {
    public static void main(String[] args) {
        // Input validation examples
        validateEmailAddresses();
        validatePhoneNumbers();
        validatePasswords();
        parseNumericStrings();
        
        // Text analysis
        analyzeText();
    }
    
    public static void validateEmailAddresses() {
        System.out.println("=== Email Validation ===");
        
        String[] emails = {
            "user@example.com",
            "test.email+tag@example.co.uk", 
            "invalid.email",
            "@example.com",
            "user@",
            "user@example.",
            "user@example.c"
        };
        
        String emailRegex = "^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$";
        Pattern emailPattern = Pattern.compile(emailRegex);
        
        for (String email : emails) {
            boolean isValid = emailPattern.matcher(email).matches();
            System.out.printf("%-30s: %s%n", email, isValid ? "Valid" : "Invalid");
        }
        System.out.println();
    }
    
    public static void validatePhoneNumbers() {
        System.out.println("=== Phone Number Validation ===");
        
        String[] phones = {
            "123-456-7890",
            "(123) 456-7890",
            "123.456.7890",
            "1234567890",
            "+1-123-456-7890",
            "123-45-67890", // Invalid format
            "abc-def-ghij"  // Invalid characters
        };
        
        // Multiple phone formats
        String[] phoneRegexes = {
            "\\d{3}-\\d{3}-\\d{4}",           // 123-456-7890
            "\\(\\d{3}\\) \\d{3}-\\d{4}",     // (123) 456-7890
            "\\d{3}\\.\\d{3}\\.\\d{4}",       // 123.456.7890
            "\\d{10}",                        // 1234567890
            "\\+1-\\d{3}-\\d{3}-\\d{4}"       // +1-123-456-7890
        };
        
        for (String phone : phones) {
            boolean isValid = false;
            for (String regex : phoneRegexes) {
                if (phone.matches(regex)) {
                    isValid = true;
                    break;
                }
            }
            System.out.printf("%-20s: %s%n", phone, isValid ? "Valid" : "Invalid");
        }
        System.out.println();
    }
    
    public static void validatePasswords() {
        System.out.println("=== Password Validation ===");
        
        String[] passwords = {
            "Password123!",
            "weakpass",
            "STRONGPASS123!",
            "NoNumbers!",
            "nonumbers123",
            "Short1!",
            "VeryStrongPassword123!"
        };
        
        for (String password : passwords) {
            PasswordStrength strength = analyzePassword(password);
            System.out.printf("%-25s: %s%n", password, strength);
        }
        System.out.println();
    }
    
    enum PasswordStrength {
        WEAK, MEDIUM, STRONG
    }
    
    public static PasswordStrength analyzePassword(String password) {
        if (password == null || password.length() < 8) {
            return PasswordStrength.WEAK;
        }
        
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasDigit = password.matches(".*\\d.*");
        boolean hasSpecial = password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
        
        int criteria = 0;
        if (hasUpper) criteria++;
        if (hasLower) criteria++;
        if (hasDigit) criteria++;
        if (hasSpecial) criteria++;
        
        if (criteria >= 3 && password.length() >= 12) {
            return PasswordStrength.STRONG;
        } else if (criteria >= 2 && password.length() >= 8) {
            return PasswordStrength.MEDIUM;
        } else {
            return PasswordStrength.WEAK;
        }
    }
    
    public static void parseNumericStrings() {
        System.out.println("=== Numeric String Parsing ===");
        
        String[] numericStrings = {
            "123",
            "123.45",
            "1,234.56",
            "$1,234.56",
            "123.45%",
            "not a number",
            "123abc",
            ""
        };
        
        for (String str : numericStrings) {
            System.out.printf("%-15s: ", str);
            
            // Try to parse as integer
            try {
                int intValue = Integer.parseInt(str);
                System.out.printf("Integer: %d", intValue);
            } catch (NumberFormatException e) {
                // Try to parse as double
                try {
                    double doubleValue = Double.parseDouble(str);
                    System.out.printf("Double: %.2f", doubleValue);
                } catch (NumberFormatException e2) {
                    // Try to extract numbers
                    String numbersOnly = str.replaceAll("[^0-9.]", "");
                    if (!numbersOnly.isEmpty()) {
                        try {
                            double extracted = Double.parseDouble(numbersOnly);
                            System.out.printf("Extracted: %.2f", extracted);
                        } catch (NumberFormatException e3) {
                            System.out.print("No valid number");
                        }
                    } else {
                        System.out.print("No valid number");
                    }
                }
            }
            System.out.println();
        }
        System.out.println();
    }
    
    public static void analyzeText() {
        System.out.println("=== Text Analysis ===");
        
        String text = "The quick brown fox jumps over the lazy dog. " +
                     "This sentence contains all letters of the alphabet.";
        
        System.out.println("Text: " + text);
        System.out.println("Length: " + text.length());
        System.out.println("Word count: " + countWords(text));
        System.out.println("Sentence count: " + countSentences(text));
        System.out.println("Unique characters: " + countUniqueCharacters(text));
        
        // Most frequent character
        char mostFrequent = findMostFrequentCharacter(text);
        System.out.println("Most frequent character: '" + mostFrequent + "'");
        
        // Check for palindrome
        String palindromeTest = "A man a plan a canal Panama";
        System.out.println("\"" + palindromeTest + "\" is palindrome: " + 
                          isPalindrome(palindromeTest));
    }
    
    public static int countWords(String text) {
        return text.trim().split("\\s+").length;
    }
    
    public static int countSentences(String text) {
        return text.split("[.!?]+").length;
    }
    
    public static int countUniqueCharacters(String text) {
        return (int) text.toLowerCase().chars()
                         .filter(Character::isLetter)
                         .distinct()
                         .count();
    }
    
    public static char findMostFrequentCharacter(String text) {
        int[] frequency = new int[256]; // ASCII characters
        
        for (char c : text.toLowerCase().toCharArray()) {
            if (Character.isLetter(c)) {
                frequency[c]++;
            }
        }
        
        int maxFreq = 0;
        char mostFrequent = 'a';
        for (int i = 0; i < frequency.length; i++) {
            if (frequency[i] > maxFreq) {
                maxFreq = frequency[i];
                mostFrequent = (char) i;
            }
        }
        
        return mostFrequent;
    }
    
    public static boolean isPalindrome(String text) {
        String cleaned = text.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
        int left = 0;
        int right = cleaned.length() - 1;
        
        while (left < right) {
            if (cleaned.charAt(left) != cleaned.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
}
```

## 💡 Practical String Applications

### Text Processing Utilities
```java
import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class TextProcessingUtils {
    public static void main(String[] args) {
        // Word frequency analysis
        analyzeWordFrequency();
        
        // Text cleaning and normalization
        demonstrateTextCleaning();
        
        // CSV processing
        processCsvData();
        
        // Template processing
        processTemplates();
    }
    
    public static void analyzeWordFrequency() {
        System.out.println("=== Word Frequency Analysis ===");
        
        String text = "The quick brown fox jumps over the lazy dog. " +
                     "The dog was lazy but the fox was quick and brown.";
        
        Map<String, Integer> wordCount = new HashMap<>();
        
        // Clean and split text
        String[] words = text.toLowerCase()
                            .replaceAll("[^a-zA-Z0-9\\s]", "")
                            .split("\\s+");
        
        // Count word frequencies
        for (String word : words) {
            if (!word.isEmpty()) {
                wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
            }
        }
        
        // Sort by frequency (descending)
        wordCount.entrySet().stream()
                 .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                 .forEach(entry -> System.out.printf("%-10s: %d%n", 
                                                    entry.getKey(), entry.getValue()));
        
        System.out.println();
    }
    
    public static void demonstrateTextCleaning() {
        System.out.println("=== Text Cleaning and Normalization ===");
        
        String messyText = "  Hello,    WORLD!!!   This   is   MESSY text...  ";
        
        System.out.println("Original: \"" + messyText + "\"");
        
        // Basic cleaning
        String cleaned = messyText.trim()                          // Remove leading/trailing spaces
                                 .replaceAll("\\s+", " ")          // Replace multiple spaces with single
                                 .replaceAll("[.]{2,}", ".")       // Replace multiple dots
                                 .replaceAll("[!]{2,}", "!");      // Replace multiple exclamations
        
        System.out.println("Cleaned: \"" + cleaned + "\"");
        
        // Normalize case
        String titleCase = toTitleCase(cleaned);
        System.out.println("Title case: \"" + titleCase + "\"");
        
        // Remove special characters
        String alphanumericOnly = cleaned.replaceAll("[^a-zA-Z0-9\\s]", "");
        System.out.println("Alphanumeric only: \"" + alphanumericOnly + "\"");
        
        // Extract sentences
        String[] sentences = cleaned.split("[.!?]+");
        System.out.println("Sentences:");
        for (int i = 0; i < sentences.length; i++) {
            String sentence = sentences[i].trim();
            if (!sentence.isEmpty()) {
                System.out.println("  " + (i + 1) + ": " + sentence);
            }
        }
        
        System.out.println();
    }
    
    public static String toTitleCase(String text) {
        StringBuilder result = new StringBuilder();
        boolean capitalizeNext = true;
        
        for (char c : text.toCharArray()) {
            if (Character.isWhitespace(c)) {
                result.append(c);
                capitalizeNext = true;
            } else if (capitalizeNext) {
                result.append(Character.toUpperCase(c));
                capitalizeNext = false;
            } else {
                result.append(Character.toLowerCase(c));
            }
        }
        
        return result.toString();
    }
    
    public static void processCsvData() {
        System.out.println("=== CSV Processing ===");
        
        String csvData = "Name,Age,City,Salary\n" +
                        "\"John Doe\",30,\"New York\",50000\n" +
                        "\"Jane Smith\",25,\"Los Angeles\",55000\n" +
                        "\"Bob Johnson\",35,\"Chicago\",60000";
        
        String[] lines = csvData.split("\n");
        String[] headers = parseCSVLine(lines[0]);
        
        System.out.println("Headers: " + Arrays.toString(headers));
        System.out.println("\nData:");
        
        for (int i = 1; i < lines.length; i++) {
            String[] values = parseCSVLine(lines[i]);
            for (int j = 0; j < headers.length && j < values.length; j++) {
                System.out.printf("%-10s: %-15s", headers[j], values[j]);
            }
            System.out.println();
        }
        
        System.out.println();
    }
    
    public static String[] parseCSVLine(String line) {
        List<String> fields = new ArrayList<>();
        boolean inQuotes = false;
        StringBuilder currentField = new StringBuilder();
        
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            
            if (c == '"') {
                inQuotes = !inQuotes;
            } else if (c == ',' && !inQuotes) {
                fields.add(currentField.toString().trim());
                currentField.setLength(0);
            } else {
                currentField.append(c);
            }
        }
        
        fields.add(currentField.toString().trim());
        return fields.toArray(new String[0]);
    }
    
    public static void processTemplates() {
        System.out.println("=== Template Processing ===");
        
        String template = "Hello {{name}}, welcome to {{company}}! " +
                         "Your account balance is ${{balance}}.";
        
        Map<String, String> variables = new HashMap<>();
        variables.put("name", "Alice Johnson");
        variables.put("company", "Tech Corp");
        variables.put("balance", "1,234.56");
        
        String processed = processTemplate(template, variables);
        
        System.out.println("Template: " + template);
        System.out.println("Variables: " + variables);
        System.out.println("Result: " + processed);
        
        // Email template example
        String emailTemplate = """
                Subject: Welcome {{name}}!
                
                Dear {{name}},
                
                Thank you for joining {{company}}. Your employee ID is {{employeeId}}.
                
                Best regards,
                HR Team
                """;
        
        Map<String, String> emailVars = new HashMap<>();
        emailVars.put("name", "Bob Smith");
        emailVars.put("company", "Innovation Inc");
        emailVars.put("employeeId", "EMP001");
        
        String processedEmail = processTemplate(emailTemplate, emailVars);
        System.out.println("\nEmail template result:");
        System.out.println(processedEmail);
    }
    
    public static String processTemplate(String template, Map<String, String> variables) {
        String result = template;
        
        for (Map.Entry<String, String> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            result = result.replace(placeholder, entry.getValue());
        }
        
        return result;
    }
}
```

## ⚠️ Common Pitfalls and Best Practices

### String Performance and Memory
```java
public class StringBestPractices {
    public static void main(String[] args) {
        demonstrateCommonPitfalls();
        showBestPractices();
        demonstrateMemoryUsage();
    }
    
    public static void demonstrateCommonPitfalls() {
        System.out.println("=== Common String Pitfalls ===");
        
        // Pitfall 1: Using == instead of equals()
        String str1 = new String("Hello");
        String str2 = new String("Hello");
        
        System.out.println("str1 == str2: " + (str1 == str2)); // false
        System.out.println("str1.equals(str2): " + str1.equals(str2)); // true
        
        // Pitfall 2: Null pointer exceptions
        String nullString = null;
        try {
            System.out.println(nullString.length()); // NullPointerException
        } catch (NullPointerException e) {
            System.out.println("Error: Cannot call methods on null string");
        }
        
        // Pitfall 3: Inefficient string concatenation in loops
        System.out.println("\nInefficient concatenation timing:");
        long start = System.nanoTime();
        String result = "";
        for (int i = 0; i < 1000; i++) {
            result += "a"; // Creates new String object each time
        }
        long inefficientTime = System.nanoTime() - start;
        System.out.println("Inefficient time: " + inefficientTime + " ns");
        
        // Pitfall 4: Case sensitivity in comparisons
        String email1 = "User@Example.com";
        String email2 = "user@example.com";
        System.out.println("Case sensitive comparison: " + email1.equals(email2)); // false
        System.out.println("Case insensitive comparison: " + email1.equalsIgnoreCase(email2)); // true
        
        // Pitfall 5: String interning misunderstanding
        String a = "Hello";
        String b = "Hello";
        String c = new String("Hello");
        String d = c.intern();
        
        System.out.println("a == b (literals): " + (a == b)); // true
        System.out.println("a == c (new): " + (a == c)); // false  
        System.out.println("a == d (interned): " + (a == d)); // true
        
        System.out.println();
    }
    
    public static void showBestPractices() {
        System.out.println("=== String Best Practices ===");
        
        // Best Practice 1: Use StringBuilder for multiple concatenations
        long start = System.nanoTime();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 1000; i++) {
            sb.append("a");
        }
        String result = sb.toString();
        long efficientTime = System.nanoTime() - start;
        System.out.println("Efficient StringBuilder time: " + efficientTime + " ns");
        
        // Best Practice 2: Null-safe string operations
        String possiblyNull = null;
        String safeLength = (possiblyNull != null) ? String.valueOf(possiblyNull.length()) : "null";
        System.out.println("Safe null handling: " + safeLength);
        
        // Using Objects.equals for null-safe comparison
        System.out.println("Null-safe equals: " + Objects.equals(possiblyNull, "test"));
        
        // Best Practice 3: Use String.format() for complex formatting
        String name = "Alice";
        int age = 30;
        double salary = 75000.50;
        
        // Instead of: "Name: " + name + ", Age: " + age + ", Salary: $" + salary
        String formatted = String.format("Name: %s, Age: %d, Salary: $%.2f", name, age, salary);
        System.out.println("Formatted string: " + formatted);
        
        // Best Practice 4: Use appropriate string methods
        String text = "  Hello World  ";
        
        // Check before trim if needed
        if (!text.trim().isEmpty()) {
            System.out.println("Trimmed: '" + text.trim() + "'");
        }
        
        // Use isEmpty() instead of length() == 0
        String empty = "";
        System.out.println("Is empty (good): " + empty.isEmpty());
        System.out.println("Is empty (bad): " + (empty.length() == 0));
        
        // Best Practice 5: Cache commonly used strings
        CachedStrings.demonstrateStringCaching();
        
        System.out.println();
    }
    
    public static void demonstrateMemoryUsage() {
        System.out.println("=== Memory Usage Demonstration ===");
        
        // String literal pool
        String s1 = "Hello";
        String s2 = "Hello";
        String s3 = new String("Hello");
        
        System.out.println("s1 and s2 reference same object: " + (s1 == s2)); // true
        System.out.println("s1 and s3 reference same object: " + (s1 == s3)); // false
        
        // Memory impact of string operations
        Runtime runtime = Runtime.getRuntime();
        runtime.gc(); // Suggest garbage collection
        
        long memoryBefore = runtime.totalMemory() - runtime.freeMemory();
        
        // Create many string objects
        for (int i = 0; i < 10000; i++) {
            String temp = "String" + i;
        }
        
        long memoryAfter = runtime.totalMemory() - runtime.freeMemory();
        System.out.println("Memory used for string creation: " + 
                          (memoryAfter - memoryBefore) + " bytes");
        
        System.out.println();
    }
    
    static class CachedStrings {
        private static final Map<String, String> stringCache = new HashMap<>();
        
        public static String getCachedString(String key) {
            return stringCache.computeIfAbsent(key, k -> k.toUpperCase());
        }
        
        public static void demonstrateStringCaching() {
            System.out.println("String caching example:");
            String cached1 = getCachedString("hello");
            String cached2 = getCachedString("hello");
            
            System.out.println("Cached strings are same object: " + (cached1 == cached2));
            System.out.println("Cache size: " + stringCache.size());
        }
    }
}
```

## 📋 Summary

- **String Immutability:** Strings cannot be modified after creation; operations create new objects
- **String Pool:** Literal strings are stored in a pool for memory efficiency
- **Comparison:** Use `equals()` for content comparison, `==` compares references
- **Performance:** Use StringBuilder for multiple concatenations
- **Formatting:** Use String.format() or printf() for complex string formatting
- **Validation:** Regular expressions provide powerful pattern matching capabilities
- **Best Practices:** Handle nulls safely, use appropriate methods, cache when needed

## 🔗 Related Topics

- [String Builders](./string-builders.md) - Efficient string manipulation
- [Variables and Data Types](./variables-datatypes.md) - Understanding reference types
- [Arrays](./arrays-1d.md) - Character arrays and string conversion
- [Methods](./methods.md) - String methods and parameter passing

## 🎯 Practice Exercises

1. Create a word game that validates user input and provides hints
2. Build a text-based search engine with pattern matching
3. Implement a simple markup language parser (like Markdown)
4. Create a log file analyzer that extracts specific information
5. Build a string encryption/decryption utility with multiple algorithms
