# Reverse Integer

## Problem Statement

Given a signed 32-bit integer `x`, return `x` with its digits reversed. If reversing `x` causes the value to go outside the signed 32-bit integer range `[-2^31, 2^31 - 1]`, then return `0`.

**Examples:**
- Input: `x = 123`, Output: `321`
- Input: `x = -123`, Output: `-321`
- Input: `x = 120`, Output: `21`

## Constraints
- `-2^31 <= x <= 2^31 - 1`

## Java Solution

### Approach 1: String Manipulation
```java
public class ReverseInteger {
    public static int reverse(int x) {
        boolean isNegative = x < 0;
        String str = String.valueOf(Math.abs(x));
        StringBuilder reversed = new StringBuilder(str).reverse();
        
        try {
            int result = Integer.parseInt(reversed.toString());
            return isNegative ? -result : result;
        } catch (NumberFormatException e) {
            // Overflow occurred
            return 0;
        }
    }
    
    public static void main(String[] args) {
        System.out.println(reverse(123));   // 321
        System.out.println(reverse(-123));  // -321
        System.out.println(reverse(120));   // 21
        System.out.println(reverse(0));     // 0
    }
}
```

### Approach 2: Mathematical Approach (Optimal)
```java
public class ReverseIntegerOptimal {
    public static int reverse(int x) {
        int result = 0;
        
        while (x != 0) {
            int digit = x % 10;
            x /= 10;
            
            // Check for overflow before multiplying by 10
            if (result > Integer.MAX_VALUE / 10 || 
                (result == Integer.MAX_VALUE / 10 && digit > 7)) {
                return 0;
            }
            if (result < Integer.MIN_VALUE / 10 || 
                (result == Integer.MIN_VALUE / 10 && digit < -8)) {
                return 0;
            }
            
            result = result * 10 + digit;
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println(reverse(123));        // 321
        System.out.println(reverse(-123));       // -321
        System.out.println(reverse(120));        // 21
        System.out.println(reverse(1534236469)); // 0 (overflow)
    }
}
```

### Approach 3: With Overflow Detection Using Long
```java
public class ReverseIntegerLong {
    public static int reverse(int x) {
        long result = 0;
        
        while (x != 0) {
            result = result * 10 + x % 10;
            x /= 10;
        }
        
        // Check if result is within 32-bit integer range
        if (result > Integer.MAX_VALUE || result < Integer.MIN_VALUE) {
            return 0;
        }
        
        return (int) result;
    }
    
    public static void main(String[] args) {
        System.out.println(reverse(123));        // 321
        System.out.println(reverse(-123));       // -321
        System.out.println(reverse(1534236469)); // 0 (overflow)
    }
}
```

## Algorithm Analysis

### Approach 1: String Manipulation
- **Time Complexity**: O(log n) where n is the input number
- **Space Complexity**: O(log n) for string storage
- **Pros**: Easy to understand, built-in overflow detection
- **Cons**: Uses extra space, slower due to string operations

### Approach 2: Mathematical Approach
- **Time Complexity**: O(log n)
- **Space Complexity**: O(1)
- **Pros**: Space efficient, fast
- **Cons**: Manual overflow detection required

### Approach 3: Using Long
- **Time Complexity**: O(log n)
- **Space Complexity**: O(1)
- **Pros**: Simpler overflow detection
- **Cons**: Uses more memory for long variable

## Key Insights

1. **Overflow Detection**: Critical to handle 32-bit integer overflow
2. **Mathematical Reversal**: Extract digits using modulo and division
3. **Sign Handling**: Negative numbers maintain their sign
4. **Edge Cases**: Zero and single-digit numbers

## Overflow Conditions

For 32-bit signed integers:
- **Maximum**: 2,147,483,647 (2^31 - 1)
- **Minimum**: -2,147,483,648 (-2^31)

Check overflow before multiplication:
```java
// For positive overflow
if (result > Integer.MAX_VALUE / 10 || 
    (result == Integer.MAX_VALUE / 10 && digit > 7))

// For negative overflow  
if (result < Integer.MIN_VALUE / 10 || 
    (result == Integer.MIN_VALUE / 10 && digit < -8))
```

## Common Pitfalls

1. **Integer Overflow**: Not checking for overflow before multiplication
2. **Sign Handling**: Forgetting to preserve the sign of negative numbers
3. **Trailing Zeros**: Understanding that trailing zeros disappear (120 → 21)
4. **Edge Cases**: Not handling Integer.MIN_VALUE correctly

## Practice Variations

1. Reverse bits of an integer
2. Reverse words in a string
3. Reverse a linked list
4. Palindrome number (related problem)

## Related Topics
- [Mathematical Operations](../operators.md)
- [Integer Overflow](../type-casting.md)
- [Exception Handling](../exception-handling.md)
- [String Manipulation](../strings.md)

## LeetCode Links
- [LeetCode Problem 7](https://leetcode.com/problems/reverse-integer/)
