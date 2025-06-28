# Palindrome Checker

## 🎯 Problem Statement

A palindrome is a word, phrase, number, or other sequence of characters that reads the same forward and backward. Create a program that determines whether a given string is a palindrome, considering various cases and constraints.

**Examples:**
```
"racecar" → true
"A man a plan a canal Panama" → true (ignoring spaces and case)
"race a car" → false
"12321" → true
"hello" → false
```

## 🎓 Learning Objectives

- Practice string manipulation and analysis
- Understand different approaches to problem solving
- Learn about two-pointer technique
- Master character comparison and iteration
- Handle edge cases and input validation
- Practice with StringBuilder and string methods
- Explore case sensitivity and special character handling

## 🛠️ Java Implementation

### Basic Palindrome Checker

```java
public class PalindromeChecker {
    
    /**
     * Simple palindrome check using two pointers
     * Time Complexity: O(n)
     * Space Complexity: O(1)
     */
    public static boolean isPalindrome(String str) {
        if (str == null) {
            return false;
        }
        
        if (str.length() <= 1) {
            return true;
        }
        
        int left = 0;
        int right = str.length() - 1;
        
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    /**
     * Case-insensitive palindrome check
     */
    public static boolean isPalindromeCaseInsensitive(String str) {
        if (str == null) {
            return false;
        }
        
        String lowerStr = str.toLowerCase();
        return isPalindrome(lowerStr);
    }
    
    /**
     * Palindrome check with detailed step-by-step output
     */
    public static boolean isPalindromeWithDetails(String str) {
        if (str == null) {
            System.out.println("Input is null - not a palindrome");
            return false;
        }
        
        if (str.length() <= 1) {
            System.out.println("String with length <= 1 is always a palindrome");
            return true;
        }
        
        System.out.println("Checking if \"" + str + "\" is a palindrome:");
        
        int left = 0;
        int right = str.length() - 1;
        
        while (left < right) {
            char leftChar = str.charAt(left);
            char rightChar = str.charAt(right);
            
            System.out.printf("Comparing position %d ('%c') with position %d ('%c'): ", 
                            left, leftChar, right, rightChar);
            
            if (leftChar != rightChar) {
                System.out.println("Different - NOT a palindrome");
                return false;
            }
            
            System.out.println("Same - continue");
            left++;
            right--;
        }
        
        System.out.println("All characters match - IS a palindrome");
        return true;
    }
    
    /**
     * Palindrome check using string reversal
     * Time Complexity: O(n)
     * Space Complexity: O(n)
     */
    public static boolean isPalindromeReversal(String str) {
        if (str == null) {
            return false;
        }
        
        String reversed = new StringBuilder(str).reverse().toString();
        return str.equals(reversed);
    }
    
    /**
     * Recursive palindrome check
     */
    public static boolean isPalindromeRecursive(String str) {
        if (str == null) {
            return false;
        }
        
        return isPalindromeRecursiveHelper(str, 0, str.length() - 1);
    }
    
    private static boolean isPalindromeRecursiveHelper(String str, int left, int right) {
        // Base case: when pointers meet or cross
        if (left >= right) {
            return true;
        }
        
        // Check current characters
        if (str.charAt(left) != str.charAt(right)) {
            return false;
        }
        
        // Recursive call for inner substring
        return isPalindromeRecursiveHelper(str, left + 1, right - 1);
    }
}
```

### Advanced Palindrome Checker

```java
public class AdvancedPalindromeChecker {
    
    /**
     * Palindrome check ignoring spaces, punctuation, and case
     */
    public static boolean isPalindromeAlphanumeric(String str) {
        if (str == null) {
            return false;
        }
        
        int left = 0;
        int right = str.length() - 1;
        
        while (left < right) {
            // Skip non-alphanumeric characters from the left
            while (left < right && !Character.isLetterOrDigit(str.charAt(left))) {
                left++;
            }
            
            // Skip non-alphanumeric characters from the right
            while (left < right && !Character.isLetterOrDigit(str.charAt(right))) {
                right--;
            }
            
            // Compare characters (case-insensitive)
            if (Character.toLowerCase(str.charAt(left)) != 
                Character.toLowerCase(str.charAt(right))) {
                return false;
            }
            
            left++;
            right--;
        }
        
        return true;
    }
    
    /**
     * Palindrome check with custom character filter
     */
    public static boolean isPalindromeWithFilter(String str, java.util.function.Predicate<Character> filter) {
        if (str == null || filter == null) {
            return false;
        }
        
        // Extract only characters that pass the filter
        StringBuilder filtered = new StringBuilder();
        for (char c : str.toCharArray()) {
            if (filter.test(c)) {
                filtered.append(Character.toLowerCase(c));
            }
        }
        
        return isPalindrome(filtered.toString());
    }
    
    /**
     * Find the longest palindromic substring
     */
    public static String longestPalindromicSubstring(String str) {
        if (str == null || str.length() == 0) {
            return "";
        }
        
        if (str.length() == 1) {
            return str;
        }
        
        String longest = "";
        
        for (int i = 0; i < str.length(); i++) {
            // Check for odd-length palindromes (center at i)
            String oddPalindrome = expandAroundCenter(str, i, i);
            if (oddPalindrome.length() > longest.length()) {
                longest = oddPalindrome;
            }
            
            // Check for even-length palindromes (center between i and i+1)
            String evenPalindrome = expandAroundCenter(str, i, i + 1);
            if (evenPalindrome.length() > longest.length()) {
                longest = evenPalindrome;
            }
        }
        
        return longest;
    }
    
    private static String expandAroundCenter(String str, int left, int right) {
        while (left >= 0 && right < str.length() && str.charAt(left) == str.charAt(right)) {
            left--;
            right++;
        }
        
        // Return the palindrome found
        return str.substring(left + 1, right);
    }
    
    /**
     * Count all palindromic substrings
     */
    public static int countPalindromicSubstrings(String str) {
        if (str == null || str.length() == 0) {
            return 0;
        }
        
        int count = 0;
        
        for (int i = 0; i < str.length(); i++) {
            // Count odd-length palindromes
            count += countPalindromes(str, i, i);
            
            // Count even-length palindromes
            count += countPalindromes(str, i, i + 1);
        }
        
        return count;
    }
    
    private static int countPalindromes(String str, int left, int right) {
        int count = 0;
        
        while (left >= 0 && right < str.length() && str.charAt(left) == str.charAt(right)) {
            count++;
            left--;
            right++;
        }
        
        return count;
    }
    
    /**
     * Check if a string can be rearranged to form a palindrome
     */
    public static boolean canFormPalindrome(String str) {
        if (str == null) {
            return false;
        }
        
        // Count frequency of each character
        java.util.Map<Character, Integer> charCount = new java.util.HashMap<>();
        for (char c : str.toCharArray()) {
            charCount.put(c, charCount.getOrDefault(c, 0) + 1);
        }
        
        // Count characters with odd frequency
        int oddCount = 0;
        for (int count : charCount.values()) {
            if (count % 2 == 1) {
                oddCount++;
            }
        }
        
        // For a palindrome, at most one character can have odd frequency
        return oddCount <= 1;
    }
    
    /**
     * Generate the shortest palindrome by adding characters at the beginning
     */
    public static String shortestPalindrome(String str) {
        if (str == null || str.length() <= 1) {
            return str;
        }
        
        // Find the longest prefix that is also a suffix when reversed
        String reversed = new StringBuilder(str).reverse().toString();
        String combined = str + "#" + reversed;
        
        // Use KMP algorithm's failure function concept
        int[] lps = computeLPS(combined);
        int overlap = lps[combined.length() - 1];
        
        // Add the necessary characters at the beginning
        String toAdd = reversed.substring(0, str.length() - overlap);
        return toAdd + str;
    }
    
    private static int[] computeLPS(String str) {
        int[] lps = new int[str.length()];
        int len = 0;
        int i = 1;
        
        while (i < str.length()) {
            if (str.charAt(i) == str.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        
        return lps;
    }
}
```

### Specialized Palindrome Checkers

```java
public class SpecializedPalindromeCheckers {
    
    /**
     * Check if a number is a palindrome
     */
    public static boolean isNumberPalindrome(int number) {
        // Handle negative numbers
        if (number < 0) {
            return false;
        }
        
        // Single digit numbers are palindromes
        if (number < 10) {
            return true;
        }
        
        // Reverse the number and compare
        int original = number;
        int reversed = 0;
        
        while (number > 0) {
            reversed = reversed * 10 + number % 10;
            number /= 10;
        }
        
        return original == reversed;
    }
    
    /**
     * Check if a number is palindrome without converting to string
     */
    public static boolean isNumberPalindromeOptimized(int number) {
        if (number < 0) {
            return false;
        }
        
        if (number < 10) {
            return true;
        }
        
        // Find the number of digits
        int temp = number;
        int digits = 0;
        while (temp > 0) {
            digits++;
            temp /= 10;
        }
        
        // Check palindrome by comparing first and last digits
        for (int i = 0; i < digits / 2; i++) {
            int leftDigit = (number / (int) Math.pow(10, digits - 1 - i)) % 10;
            int rightDigit = (number / (int) Math.pow(10, i)) % 10;
            
            if (leftDigit != rightDigit) {
                return false;
            }
        }
        
        return true;
    }
    
    /**
     * Check if an array is a palindrome
     */
    public static <T> boolean isArrayPalindrome(T[] array) {
        if (array == null) {
            return false;
        }
        
        if (array.length <= 1) {
            return true;
        }
        
        int left = 0;
        int right = array.length - 1;
        
        while (left < right) {
            if (!java.util.Objects.equals(array[left], array[right])) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    /**
     * Check if an integer array is palindrome
     */
    public static boolean isIntArrayPalindrome(int[] array) {
        if (array == null) {
            return false;
        }
        
        if (array.length <= 1) {
            return true;
        }
        
        int left = 0;
        int right = array.length - 1;
        
        while (left < right) {
            if (array[left] != array[right]) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    /**
     * Check palindrome for linked list representation
     */
    public static boolean isLinkedListPalindrome(java.util.List<Character> list) {
        if (list == null || list.size() <= 1) {
            return true;
        }
        
        int left = 0;
        int right = list.size() - 1;
        
        while (left < right) {
            if (!list.get(left).equals(list.get(right))) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    /**
     * Word-level palindrome checker
     */
    public static boolean isWordLevelPalindrome(String sentence) {
        if (sentence == null || sentence.trim().isEmpty()) {
            return true;
        }
        
        // Split into words and remove empty strings
        String[] words = sentence.trim().split("\\s+");
        
        int left = 0;
        int right = words.length - 1;
        
        while (left < right) {
            if (!words[left].equalsIgnoreCase(words[right])) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
}
```

## 🎮 Interactive Palindrome Program

```java
import java.util.Scanner;

public class InteractivePalindromeChecker {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Interactive Palindrome Checker ===");
        
        while (true) {
            System.out.println("\nChoose an option:");
            System.out.println("1. Basic palindrome check");
            System.out.println("2. Case-insensitive palindrome check");
            System.out.println("3. Alphanumeric-only palindrome check");
            System.out.println("4. Number palindrome check");
            System.out.println("5. Find longest palindromic substring");
            System.out.println("6. Count palindromic substrings");
            System.out.println("7. Check if string can form palindrome");
            System.out.println("8. Generate shortest palindrome");
            System.out.println("9. Palindrome learning mode");
            System.out.println("0. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = getIntInput(scanner);
            
            switch (choice) {
                case 0:
                    System.out.println("Thanks for using the Palindrome Checker!");
                    scanner.close();
                    return;
                    
                case 1:
                    checkBasicPalindrome(scanner);
                    break;
                    
                case 2:
                    checkCaseInsensitivePalindrome(scanner);
                    break;
                    
                case 3:
                    checkAlphanumericPalindrome(scanner);
                    break;
                    
                case 4:
                    checkNumberPalindrome(scanner);
                    break;
                    
                case 5:
                    findLongestPalindrome(scanner);
                    break;
                    
                case 6:
                    countPalindromes(scanner);
                    break;
                    
                case 7:
                    checkCanFormPalindrome(scanner);
                    break;
                    
                case 8:
                    generateShortestPalindrome(scanner);
                    break;
                    
                case 9:
                    learningMode(scanner);
                    break;
                    
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
    
    private static void checkBasicPalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        boolean result = PalindromeChecker.isPalindromeWithDetails(input);
        System.out.println("Result: " + (result ? "IS" : "is NOT") + " a palindrome");
    }
    
    private static void checkCaseInsensitivePalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        boolean result = PalindromeChecker.isPalindromeCaseInsensitive(input);
        System.out.println("\"" + input + "\" " + (result ? "IS" : "is NOT") + 
                         " a palindrome (case-insensitive)");
    }
    
    private static void checkAlphanumericPalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        boolean result = AdvancedPalindromeChecker.isPalindromeAlphanumeric(input);
        System.out.println("\"" + input + "\" " + (result ? "IS" : "is NOT") + 
                         " a palindrome (ignoring spaces and punctuation)");
    }
    
    private static void checkNumberPalindrome(Scanner scanner) {
        System.out.print("Enter a number: ");
        int number = getIntInput(scanner);
        
        boolean result = SpecializedPalindromeCheckers.isNumberPalindrome(number);
        System.out.println(number + " " + (result ? "IS" : "is NOT") + " a palindrome number");
    }
    
    private static void findLongestPalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        String longest = AdvancedPalindromeChecker.longestPalindromicSubstring(input);
        System.out.println("Longest palindromic substring: \"" + longest + "\"");
        System.out.println("Length: " + longest.length());
    }
    
    private static void countPalindromes(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        int count = AdvancedPalindromeChecker.countPalindromicSubstrings(input);
        System.out.println("Number of palindromic substrings: " + count);
    }
    
    private static void checkCanFormPalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        boolean canForm = AdvancedPalindromeChecker.canFormPalindrome(input);
        System.out.println("\"" + input + "\" " + (canForm ? "CAN" : "CANNOT") + 
                         " be rearranged to form a palindrome");
    }
    
    private static void generateShortestPalindrome(Scanner scanner) {
        System.out.print("Enter a string: ");
        String input = scanner.nextLine();
        
        String shortest = AdvancedPalindromeChecker.shortestPalindrome(input);
        System.out.println("Shortest palindrome by adding characters at the beginning:");
        System.out.println("\"" + shortest + "\"");
        System.out.println("Added characters: " + (shortest.length() - input.length()));
    }
    
    private static void learningMode(Scanner scanner) {
        System.out.println("\n=== Palindrome Learning Mode ===");
        
        String[] examples = {
            "racecar",
            "A man a plan a canal Panama",
            "race a car",
            "Madam",
            "Was it a car or a cat I saw?",
            "hello",
            "12321",
            "12345"
        };
        
        System.out.println("Let's explore some palindrome examples:");
        
        for (String example : examples) {
            System.out.println("\n--- Analyzing: \"" + example + "\" ---");
            
            // Basic check
            boolean basic = PalindromeChecker.isPalindrome(example);
            System.out.println("Basic check: " + basic);
            
            // Case-insensitive check
            boolean caseInsensitive = PalindromeChecker.isPalindromeCaseInsensitive(example);
            System.out.println("Case-insensitive: " + caseInsensitive);
            
            // Alphanumeric only
            boolean alphanumeric = AdvancedPalindromeChecker.isPalindromeAlphanumeric(example);
            System.out.println("Alphanumeric only: " + alphanumeric);
            
            // Can form palindrome
            boolean canForm = AdvancedPalindromeChecker.canFormPalindrome(example.replaceAll("[^a-zA-Z0-9]", "").toLowerCase());
            System.out.println("Can be rearranged to form palindrome: " + canForm);
            
            System.out.print("Press Enter to continue...");
            scanner.nextLine();
        }
    }
    
    private static int getIntInput(Scanner scanner) {
        while (true) {
            try {
                String input = scanner.nextLine().trim();
                return Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.print("Please enter a valid integer: ");
            }
        }
    }
}
```

## 🧪 Comprehensive Testing

```java
public class PalindromeTester {
    
    public static void main(String[] args) {
        testBasicFunctionality();
        testEdgeCases();
        testSpecialCases();
        testPerformance();
        testAdvancedFeatures();
    }
    
    private static void testBasicFunctionality() {
        System.out.println("=== Testing Basic Functionality ===");
        
        String[] testCases = {
            "racecar",
            "hello",
            "madam",
            "A",
            "",
            "abcba",
            "abccba"
        };
        
        for (String test : testCases) {
            boolean result = PalindromeChecker.isPalindrome(test);
            System.out.printf("'%s' -> %s%n", test, result);
        }
    }
    
    private static void testEdgeCases() {
        System.out.println("\n=== Testing Edge Cases ===");
        
        // Null string
        System.out.println("Null string: " + PalindromeChecker.isPalindrome(null));
        
        // Empty string
        System.out.println("Empty string: " + PalindromeChecker.isPalindrome(""));
        
        // Single character
        System.out.println("Single character: " + PalindromeChecker.isPalindrome("a"));
        
        // Very long palindrome
        StringBuilder longPalindrome = new StringBuilder();
        for (int i = 0; i < 1000; i++) {
            longPalindrome.append("a");
        }
        boolean longResult = PalindromeChecker.isPalindrome(longPalindrome.toString());
        System.out.println("Long palindrome (1000 'a's): " + longResult);
    }
    
    private static void testSpecialCases() {
        System.out.println("\n=== Testing Special Cases ===");
        
        // Case sensitivity
        System.out.println("'Aaa' (case-sensitive): " + 
                         PalindromeChecker.isPalindrome("Aaa"));
        System.out.println("'Aaa' (case-insensitive): " + 
                         PalindromeChecker.isPalindromeCaseInsensitive("Aaa"));
        
        // Alphanumeric only
        String phrase = "A man a plan a canal Panama";
        System.out.println("'" + phrase + "' (alphanumeric): " + 
                         AdvancedPalindromeChecker.isPalindromeAlphanumeric(phrase));
        
        // Number palindromes
        int[] numbers = {121, 1234, 12321, -121, 0, 7};
        for (int num : numbers) {
            System.out.println("Number " + num + ": " + 
                             SpecializedPalindromeCheckers.isNumberPalindrome(num));
        }
        
        // Array palindromes
        Integer[] array1 = {1, 2, 3, 2, 1};
        Integer[] array2 = {1, 2, 3, 4, 5};
        System.out.println("Array [1,2,3,2,1]: " + 
                         SpecializedPalindromeCheckers.isArrayPalindrome(array1));
        System.out.println("Array [1,2,3,4,5]: " + 
                         SpecializedPalindromeCheckers.isArrayPalindrome(array2));
    }
    
    private static void testPerformance() {
        System.out.println("\n=== Testing Performance ===");
        
        // Create a large palindrome
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 50000; i++) {
            sb.append("ab");
        }
        for (int i = 0; i < 50000; i++) {
            sb.append("ba");
        }
        String largePalindrome = sb.toString();
        
        // Test different approaches
        long startTime = System.nanoTime();
        boolean result1 = PalindromeChecker.isPalindrome(largePalindrome);
        long time1 = System.nanoTime() - startTime;
        
        startTime = System.nanoTime();
        boolean result2 = PalindromeChecker.isPalindromeReversal(largePalindrome);
        long time2 = System.nanoTime() - startTime;
        
        startTime = System.nanoTime();
        boolean result3 = PalindromeChecker.isPalindromeRecursive(largePalindrome);
        long time3 = System.nanoTime() - startTime;
        
        System.out.printf("Two-pointer approach: %d ns (result: %s)%n", time1, result1);
        System.out.printf("Reversal approach: %d ns (result: %s)%n", time2, result2);
        System.out.printf("Recursive approach: %d ns (result: %s)%n", time3, result3);
    }
    
    private static void testAdvancedFeatures() {
        System.out.println("\n=== Testing Advanced Features ===");
        
        // Longest palindromic substring
        String test = "babad";
        String longest = AdvancedPalindromeChecker.longestPalindromicSubstring(test);
        System.out.println("Longest palindrome in '" + test + "': '" + longest + "'");
        
        // Count palindromic substrings
        String countTest = "aaa";
        int count = AdvancedPalindromeChecker.countPalindromicSubstrings(countTest);
        System.out.println("Palindromic substrings in '" + countTest + "': " + count);
        
        // Can form palindrome
        String[] canFormTests = {"aab", "abc", "aabbcc", "aabbc"};
        for (String s : canFormTests) {
            boolean canForm = AdvancedPalindromeChecker.canFormPalindrome(s);
            System.out.println("'" + s + "' can form palindrome: " + canForm);
        }
        
        // Shortest palindrome
        String shortestTest = "aacecaaa";
        String shortest = AdvancedPalindromeChecker.shortestPalindrome(shortestTest);
        System.out.println("Shortest palindrome from '" + shortestTest + "': '" + shortest + "'");
    }
}
```

## 🎯 Challenge Variations

### 1. Palindrome with Wildcards
```java
public static boolean isPalindromeWithWildcard(String str, char wildcard) {
    int left = 0, right = str.length() - 1;
    
    while (left < right) {
        char leftChar = str.charAt(left);
        char rightChar = str.charAt(right);
        
        if (leftChar != wildcard && rightChar != wildcard && leftChar != rightChar) {
            return false;
        }
        
        left++;
        right--;
    }
    
    return true;
}
```

### 2. Minimum Deletions to Make Palindrome
```java
public static int minDeletionsToMakePalindrome(String str) {
    int n = str.length();
    int[][] dp = new int[n][n];
    
    // Fill dp table using LCS approach
    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (str.charAt(i) == str.charAt(j)) {
                dp[i][j] = dp[i + 1][j - 1];
            } else {
                dp[i][j] = 1 + Math.min(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }
    
    return dp[0][n - 1];
}
```

### 3. Palindrome Partitioning
```java
public static boolean canPartitionIntoPalindromes(String str, int k) {
    // Dynamic programming solution to check if string can be 
    // partitioned into exactly k palindromic substrings
    // Implementation would use DP with memoization
    return false; // Placeholder
}
```

## ⚠️ Common Pitfalls and Solutions

### 1. Case Sensitivity Issues
```java
// Problem: Not handling case properly
"Aa".equals("aA") // false

// Solution: Convert to same case
str.toLowerCase().equals(other.toLowerCase())
```

### 2. Null Pointer Exceptions
```java
// Problem: Not checking for null
public static boolean isPalindrome(String str) {
    return str.equals(new StringBuilder(str).reverse().toString()); // NPE if str is null
}

// Solution: Null check first
public static boolean isPalindrome(String str) {
    if (str == null) return false;
    return str.equals(new StringBuilder(str).reverse().toString());
}
```

### 3. Unicode and Special Characters
```java
// Be careful with Unicode characters that might look the same but have different codes
// Consider normalization for international text
```

## 📊 Complexity Analysis

| Approach | Time Complexity | Space Complexity |
|----------|----------------|------------------|
| Two Pointers | O(n) | O(1) |
| String Reversal | O(n) | O(n) |
| Recursive | O(n) | O(n) - call stack |
| Longest Palindrome | O(n²) | O(1) |
| DP Approaches | O(n²) | O(n²) |

## 🔗 Related Concepts

- String manipulation and analysis
- Two-pointer technique
- Dynamic programming
- Recursion and iteration
- Character encoding and Unicode
- Algorithm optimization
- Pattern matching

Palindrome checking is a fundamental string problem that introduces many important algorithmic concepts and serves as a stepping stone to more complex string algorithms!
