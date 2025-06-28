# Palindrome Number

## Problem Statement

Given an integer `x`, return `true` if `x` is a palindrome integer.

An integer is a palindrome when it reads the same backward as forward.

**Examples:**
- `121` is a palindrome
- `-121` is not a palindrome (reads as `121-`)
- `10` is not a palindrome (reads as `01`)

## Constraints
- `-2^31 <= x <= 2^31 - 1`

## Java Solution

### Approach 1: String Conversion
```java
public class PalindromeNumber {
    public static boolean isPalindrome(int x) {
        // Negative numbers are not palindromes
        if (x < 0) {
            return false;
        }
        
        String str = String.valueOf(x);
        int left = 0, right = str.length() - 1;
        
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        
        return true;
    }
    
    public static void main(String[] args) {
        // Test cases
        System.out.println(isPalindrome(121));   // true
        System.out.println(isPalindrome(-121));  // false
        System.out.println(isPalindrome(10));    // false
        System.out.println(isPalindrome(0));     // true
    }
}
```

### Approach 2: Mathematical Reversal (Space Efficient)
```java
public class PalindromeNumberOptimal {
    public static boolean isPalindrome(int x) {
        // Negative numbers and numbers ending with 0 (except 0) are not palindromes
        if (x < 0 || (x % 10 == 0 && x != 0)) {
            return false;
        }
        
        int reversedHalf = 0;
        while (x > reversedHalf) {
            reversedHalf = reversedHalf * 10 + x % 10;
            x /= 10;
        }
        
        // For even length: x == reversedHalf
        // For odd length: x == reversedHalf / 10
        return x == reversedHalf || x == reversedHalf / 10;
    }
    
    public static void main(String[] args) {
        // Test cases
        System.out.println(isPalindrome(121));   // true
        System.out.println(isPalindrome(-121));  // false
        System.out.println(isPalindrome(10));    // false
        System.out.println(isPalindrome(1221));  // true
    }
}
```

## Algorithm Analysis

### Approach 1: String Conversion
- **Time Complexity**: O(log n) where n is the input number
- **Space Complexity**: O(log n) for string storage
- **Pros**: Easy to understand and implement
- **Cons**: Uses extra space for string conversion

### Approach 2: Mathematical Reversal
- **Time Complexity**: O(log n)
- **Space Complexity**: O(1)
- **Pros**: Space efficient, no string conversion
- **Cons**: Slightly more complex logic

## Key Insights

1. **Edge Cases**: Handle negative numbers and numbers ending with 0
2. **Optimization**: Only reverse half the number to save time and space
3. **Mathematical Approach**: More efficient than string conversion
4. **Early Termination**: Stop when we've processed half the digits

## Common Pitfalls

1. **Overflow**: When reversing the entire number, it might overflow
2. **Negative Numbers**: Always return false for negative numbers
3. **Trailing Zeros**: Numbers ending with 0 (except 0 itself) cannot be palindromes
4. **Single Digit**: All single-digit numbers are palindromes

## Practice Variations

1. Check if a string is a palindrome
2. Find the largest palindrome product of two n-digit numbers
3. Check if a linked list is a palindrome
4. Find the next palindrome number

## Related Topics
- [String Manipulation](../strings.md)
- [Mathematical Operations](../operators.md)
- [Two Pointers Technique](../../15-two-pointers/README.md)

## LeetCode Links
- [LeetCode Problem 9](https://leetcode.com/problems/palindrome-number/)
