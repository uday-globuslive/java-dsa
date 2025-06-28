# Valid Parentheses

## Problem Statement

Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets
2. Open brackets must be closed in the correct order
3. Every close bracket has a corresponding open bracket of the same type

**Examples:**
- Input: `s = "()"`, Output: `true`
- Input: `s = "()[]{}"`, Output: `true`
- Input: `s = "(]"`, Output: `false`
- Input: `s = "([)]"`, Output: `false`
- Input: `s = "{[]}"`, Output: `true`

## Constraints
- `1 <= s.length <= 10^4`
- `s` consists of parentheses only `'()[]{}'`

## Java Solution

### Approach 1: Stack-based Solution
```java
import java.util.Stack;

public class ValidParentheses {
    public static boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        
        for (char c : s.toCharArray()) {
            // Push opening brackets onto stack
            if (c == '(' || c == '{' || c == '[') {
                stack.push(c);
            }
            // Process closing brackets
            else if (c == ')' || c == '}' || c == ']') {
                // If stack is empty, no matching opening bracket
                if (stack.isEmpty()) {
                    return false;
                }
                
                char top = stack.pop();
                
                // Check if brackets match
                if ((c == ')' && top != '(') ||
                    (c == '}' && top != '{') ||
                    (c == ']' && top != '[')) {
                    return false;
                }
            }
        }
        
        // Stack should be empty for valid parentheses
        return stack.isEmpty();
    }
    
    public static void main(String[] args) {
        System.out.println(isValid("()"));     // true
        System.out.println(isValid("()[]{}")); // true
        System.out.println(isValid("(]"));     // false
        System.out.println(isValid("([)]"));   // false
        System.out.println(isValid("{[]}"));   // true
    }
}
```

### Approach 2: Optimized with Character Mapping
```java
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

public class ValidParenthesesOptimized {
    public static boolean isValid(String s) {
        // Map closing brackets to opening brackets
        Map<Character, Character> mapping = new HashMap<>();
        mapping.put(')', '(');
        mapping.put('}', '{');
        mapping.put(']', '[');
        
        Stack<Character> stack = new Stack<>();
        
        for (char c : s.toCharArray()) {
            if (mapping.containsKey(c)) {
                // It's a closing bracket
                char topElement = stack.isEmpty() ? '#' : stack.pop();
                
                if (topElement != mapping.get(c)) {
                    return false;
                }
            } else {
                // It's an opening bracket
                stack.push(c);
            }
        }
        
        return stack.isEmpty();
    }
    
    public static void main(String[] args) {
        System.out.println(isValid("()"));     // true
        System.out.println(isValid("()[]{}")); // true
        System.out.println(isValid("(]"));     // false
        System.out.println(isValid("([)]"));   // false
        System.out.println(isValid("{[]}"));   // true
    }
}
```

### Approach 3: Array-based Stack (Space Optimized)
```java
public class ValidParenthesesArray {
    public static boolean isValid(String s) {
        char[] stack = new char[s.length()];
        int top = -1;
        
        for (char c : s.toCharArray()) {
            if (c == '(' || c == '{' || c == '[') {
                stack[++top] = c;
            } else {
                if (top == -1) return false;
                
                char openBracket = stack[top--];
                if ((c == ')' && openBracket != '(') ||
                    (c == '}' && openBracket != '{') ||
                    (c == ']' && openBracket != '[')) {
                    return false;
                }
            }
        }
        
        return top == -1;
    }
    
    public static void main(String[] args) {
        System.out.println(isValid("()"));     // true
        System.out.println(isValid("()[]{}")); // true
        System.out.println(isValid("(]"));     // false
        System.out.println(isValid("([)]"));   // false
        System.out.println(isValid("{[]}"));   // true
    }
}
```

## Algorithm Analysis

### All Approaches
- **Time Complexity**: O(n) where n is the length of the string
- **Space Complexity**: O(n) in worst case (all opening brackets)

### Comparison
1. **Stack-based**: Most readable, uses built-in Stack
2. **HashMap-based**: Cleaner code with mapping, slightly more memory
3. **Array-based**: Most space-efficient, avoids Stack object overhead

## Key Insights

1. **LIFO Property**: Last opening bracket should match first closing bracket
2. **Stack Usage**: Perfect data structure for this matching problem
3. **Early Termination**: Return false immediately when mismatch found
4. **Complete Matching**: All brackets must be matched (empty stack at end)

## Edge Cases

1. **Empty String**: Should return true (vacuously valid)
2. **Only Opening Brackets**: "(((" → false
3. **Only Closing Brackets**: ")))" → false
4. **Mismatched Types**: "(]" → false
5. **Wrong Order**: "([)]" → false

## Common Pitfalls

1. **Empty Stack Check**: Always verify stack isn't empty before popping
2. **Character Comparison**: Ensure correct bracket type matching
3. **Final State**: Check if stack is empty at the end
4. **Input Validation**: Handle edge cases like empty strings

## Step-by-Step Example

For string `"([])"``:

1. `(` → Push to stack: `['(']`
2. `[` → Push to stack: `['(', '[']`
3. `]` → Pop `[`, matches ✓: `['(']`
4. `)` → Pop `(`, matches ✓: `[]`
5. Stack empty → Return `true`

## Practice Variations

1. Generate all valid parentheses combinations
2. Remove invalid parentheses
3. Longest valid parentheses substring
4. Check balanced parentheses with wildcards

## Related Topics
- [Stacks](../../06-stacks-queues/README.md)
- [String Processing](../strings.md)
- [HashMap Usage](../../09-hash-tables/README.md)
- [Character Arrays](../arrays-1d.md)

## LeetCode Links
- [LeetCode Problem 20](https://leetcode.com/problems/valid-parentheses/)
