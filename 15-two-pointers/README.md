# Module 15: Two Pointers & Sliding Window

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master the two pointers technique for array and string problems
- ✅ Implement sliding window algorithms for substring and subarray problems
- ✅ Recognize when to apply these techniques for optimal solutions
- ✅ Solve complex problems involving multiple pointers and windows
- ✅ Optimize brute force solutions using pointer-based approaches

## 🎯 Module Overview
Two pointers and sliding window are optimization techniques that reduce time complexity from O(n²) to O(n) for many problems involving:
- **Array processing** - Finding pairs, triplets, subarrays
- **String manipulation** - Substring problems, palindromes
- **Sorted array operations** - Two sum, three sum variations
- **Subarray/substring optimization** - Maximum/minimum window problems

**Time Investment:** 6-8 hours
**Difficulty Level:** Intermediate
**Prerequisites:** Arrays, Strings, Sorting

## 📖 Core Concepts

### 1. Two Pointers Technique

#### Basic Two Pointers (Opposite Ends)
```java
// Pattern: Start from both ends, move towards center
public boolean isPalindrome(String s) {
    int left = 0, right = s.length() - 1;
    
    while (left < right) {
        // Skip non-alphanumeric characters
        while (left < right && !Character.isAlphanumeric(s.charAt(left))) {
            left++;
        }
        while (left < right && !Character.isAlphanumeric(s.charAt(right))) {
            right--;
        }
        
        // Compare characters
        if (Character.toLowerCase(s.charAt(left)) != 
            Character.toLowerCase(s.charAt(right))) {
            return false;
        }
        
        left++;
        right--;
    }
    
    return true;
}

// Two Sum in Sorted Array
public int[] twoSum(int[] numbers, int target) {
    int left = 0, right = numbers.length - 1;
    
    while (left < right) {
        int sum = numbers[left] + numbers[right];
        
        if (sum == target) {
            return new int[]{left + 1, right + 1}; // 1-indexed
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }
    
    return new int[]{-1, -1}; // Not found
}
```

#### Fast-Slow Pointers (Floyd's Algorithm)
```java
// Detect cycle in linked list
public boolean hasCycle(ListNode head) {
    if (head == null || head.next == null) return false;
    
    ListNode slow = head;
    ListNode fast = head.next;
    
    while (slow != fast) {
        if (fast == null || fast.next == null) {
            return false;
        }
        slow = slow.next;
        fast = fast.next.next;
    }
    
    return true;
}

// Find middle of linked list
public ListNode findMiddle(ListNode head) {
    ListNode slow = head;
    ListNode fast = head;
    
    while (fast != null && fast.next != null) {
        slow = slow.next;
        fast = fast.next.next;
    }
    
    return slow; // slow is at middle
}

// Remove nth node from end
public ListNode removeNthFromEnd(ListNode head, int n) {
    ListNode dummy = new ListNode(0);
    dummy.next = head;
    
    ListNode first = dummy;
    ListNode second = dummy;
    
    // Move first pointer n+1 steps ahead
    for (int i = 0; i <= n; i++) {
        first = first.next;
    }
    
    // Move both pointers until first reaches end
    while (first != null) {
        first = first.next;
        second = second.next;
    }
    
    // Remove the nth node
    second.next = second.next.next;
    
    return dummy.next;
}
```

#### Same Direction Two Pointers
```java
// Remove duplicates from sorted array
public int removeDuplicates(int[] nums) {
    if (nums.length == 0) return 0;
    
    int writePointer = 1;
    
    for (int readPointer = 1; readPointer < nums.length; readPointer++) {
        if (nums[readPointer] != nums[readPointer - 1]) {
            nums[writePointer] = nums[readPointer];
            writePointer++;
        }
    }
    
    return writePointer;
}

// Move zeros to end
public void moveZeroes(int[] nums) {
    int writePointer = 0;
    
    // Move all non-zero elements to front
    for (int readPointer = 0; readPointer < nums.length; readPointer++) {
        if (nums[readPointer] != 0) {
            nums[writePointer] = nums[readPointer];
            writePointer++;
        }
    }
    
    // Fill remaining positions with zeros
    while (writePointer < nums.length) {
        nums[writePointer] = 0;
        writePointer++;
    }
}
```

### 2. Sliding Window Technique

#### Fixed Size Window
```java
// Maximum sum of subarray of size k
public int maxSumSubarray(int[] nums, int k) {
    if (nums.length < k) return -1;
    
    // Calculate sum of first window
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
        windowSum += nums[i];
    }
    
    int maxSum = windowSum;
    
    // Slide the window
    for (int i = k; i < nums.length; i++) {
        windowSum = windowSum - nums[i - k] + nums[i];
        maxSum = Math.max(maxSum, windowSum);
    }
    
    return maxSum;
}

// Find all anagrams in string
public List<Integer> findAnagrams(String s, String p) {
    List<Integer> result = new ArrayList<>();
    if (s.length() < p.length()) return result;
    
    // Count characters in pattern
    int[] pCount = new int[26];
    int[] windowCount = new int[26];
    
    for (char c : p.toCharArray()) {
        pCount[c - 'a']++;
    }
    
    int windowSize = p.length();
    
    // Initialize first window
    for (int i = 0; i < windowSize; i++) {
        windowCount[s.charAt(i) - 'a']++;
    }
    
    if (Arrays.equals(pCount, windowCount)) {
        result.add(0);
    }
    
    // Slide the window
    for (int i = windowSize; i < s.length(); i++) {
        // Add new character
        windowCount[s.charAt(i) - 'a']++;
        
        // Remove character going out of window
        windowCount[s.charAt(i - windowSize) - 'a']--;
        
        if (Arrays.equals(pCount, windowCount)) {
            result.add(i - windowSize + 1);
        }
    }
    
    return result;
}
```

#### Variable Size Window
```java
// Longest substring without repeating characters
public int lengthOfLongestSubstring(String s) {
    Set<Character> window = new HashSet<>();
    int left = 0, maxLength = 0;
    
    for (int right = 0; right < s.length(); right++) {
        char rightChar = s.charAt(right);
        
        // Shrink window until no duplicates
        while (window.contains(rightChar)) {
            window.remove(s.charAt(left));
            left++;
        }
        
        window.add(rightChar);
        maxLength = Math.max(maxLength, right - left + 1);
    }
    
    return maxLength;
}

// Minimum window substring
public String minWindow(String s, String t) {
    if (s.length() < t.length()) return "";
    
    Map<Character, Integer> need = new HashMap<>();
    Map<Character, Integer> window = new HashMap<>();
    
    for (char c : t.toCharArray()) {
        need.put(c, need.getOrDefault(c, 0) + 1);
    }
    
    int left = 0, right = 0;
    int valid = 0; // Number of satisfied characters
    int start = 0, len = Integer.MAX_VALUE;
    
    while (right < s.length()) {
        char c = s.charAt(right);
        right++;
        
        // Update window
        if (need.containsKey(c)) {
            window.put(c, window.getOrDefault(c, 0) + 1);
            if (window.get(c).equals(need.get(c))) {
                valid++;
            }
        }
        
        // Try to shrink window
        while (valid == need.size()) {
            // Update result if current window is smaller
            if (right - left < len) {
                start = left;
                len = right - left;
            }
            
            char d = s.charAt(left);
            left++;
            
            if (need.containsKey(d)) {
                if (window.get(d).equals(need.get(d))) {
                    valid--;
                }
                window.put(d, window.get(d) - 1);
            }
        }
    }
    
    return len == Integer.MAX_VALUE ? "" : s.substring(start, start + len);
}

// Longest subarray with at most K distinct characters
public int lengthOfLongestSubstringKDistinct(String s, int k) {
    if (k == 0) return 0;
    
    Map<Character, Integer> window = new HashMap<>();
    int left = 0, maxLength = 0;
    
    for (int right = 0; right < s.length(); right++) {
        char rightChar = s.charAt(right);
        window.put(rightChar, window.getOrDefault(rightChar, 0) + 1);
        
        // Shrink window if more than k distinct characters
        while (window.size() > k) {
            char leftChar = s.charAt(left);
            window.put(leftChar, window.get(leftChar) - 1);
            if (window.get(leftChar) == 0) {
                window.remove(leftChar);
            }
            left++;
        }
        
        maxLength = Math.max(maxLength, right - left + 1);
    }
    
    return maxLength;
}
```

### 3. Advanced Two Pointers

#### Three Sum Problem
```java
public List<List<Integer>> threeSum(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    Arrays.sort(nums);
    
    for (int i = 0; i < nums.length - 2; i++) {
        // Skip duplicates for first number
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        
        int left = i + 1, right = nums.length - 1;
        int target = -nums[i];
        
        while (left < right) {
            int sum = nums[left] + nums[right];
            
            if (sum == target) {
                result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                
                // Skip duplicates for second and third numbers
                while (left < right && nums[left] == nums[left + 1]) left++;
                while (left < right && nums[right] == nums[right - 1]) right--;
                
                left++;
                right--;
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
    }
    
    return result;
}

// Four Sum
public List<List<Integer>> fourSum(int[] nums, int target) {
    List<List<Integer>> result = new ArrayList<>();
    Arrays.sort(nums);
    
    for (int i = 0; i < nums.length - 3; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        
        for (int j = i + 1; j < nums.length - 2; j++) {
            if (j > i + 1 && nums[j] == nums[j - 1]) continue;
            
            int left = j + 1, right = nums.length - 1;
            long twoSum = (long)target - nums[i] - nums[j];
            
            while (left < right) {
                int sum = nums[left] + nums[right];
                
                if (sum == twoSum) {
                    result.add(Arrays.asList(nums[i], nums[j], nums[left], nums[right]));
                    
                    while (left < right && nums[left] == nums[left + 1]) left++;
                    while (left < right && nums[right] == nums[right - 1]) right--;
                    
                    left++;
                    right--;
                } else if (sum < twoSum) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }
    
    return result;
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Target Sum in Sorted Array
- **Use Case:** Find pairs/triplets that sum to target
- **Key Insight:** Use sorted property to eliminate possibilities
- **Example Problems:** Two Sum II, Three Sum, Four Sum

### Pattern 2: Palindrome Checking
- **Use Case:** Check if string/array reads same forwards/backwards
- **Key Insight:** Compare characters from both ends
- **Example Problems:** Valid Palindrome, Palindrome Linked List

### Pattern 3: Fast-Slow Pointers
- **Use Case:** Cycle detection, finding middle element
- **Key Insight:** Fast pointer moves twice as fast as slow
- **Example Problems:** Linked List Cycle, Find Duplicate Number

### Pattern 4: Sliding Window Optimization
- **Use Case:** Subarray/substring problems with constraints
- **Key Insight:** Maintain window that satisfies constraints
- **Example Problems:** Longest Substring Without Repeating Characters

### Pattern 5: Window with Character Frequency
- **Use Case:** Problems involving character counts in window
- **Key Insight:** Use HashMap to track character frequencies
- **Example Problems:** Minimum Window Substring, Find All Anagrams

## 💻 Practice Problems

### Easy Level
1. **Two Sum II (LeetCode 167)**
   - Classic two pointers on sorted array
   - Time: O(n), Space: O(1)

2. **Valid Palindrome (LeetCode 125)**
   - Two pointers from both ends
   - Handle non-alphanumeric characters

3. **Remove Duplicates from Sorted Array (LeetCode 26)**
   - Two pointers same direction
   - In-place modification

### Medium Level
4. **3Sum (LeetCode 15)**
   - Fix one element, two pointers for remaining
   - Handle duplicate triplets

5. **Longest Substring Without Repeating Characters (LeetCode 3)**
   - Sliding window with HashSet
   - Expand and contract window

6. **Minimum Window Substring (LeetCode 76)**
   - Complex sliding window with character matching
   - Use HashMap for frequency tracking

7. **Container With Most Water (LeetCode 11)**
   - Two pointers optimization
   - Greedy approach to maximize area

### Hard Level
8. **Substring with Concatenation of All Words (LeetCode 30)**
   - Sliding window with word matching
   - Multiple starting positions

9. **Minimum Window Subsequence (LeetCode 727)**
   - Two pointers with subsequence matching
   - Bidirectional search optimization

## 🧠 Problem-Solving Templates

### Template 1: Two Pointers (Opposite Directions)
```java
public boolean twoPointersOpposite(int[] arr, int target) {
    int left = 0, right = arr.length - 1;
    
    while (left < right) {
        int sum = arr[left] + arr[right];
        
        if (sum == target) {
            return true; // Found target
        } else if (sum < target) {
            left++; // Need larger sum
        } else {
            right--; // Need smaller sum
        }
    }
    
    return false;
}
```

### Template 2: Two Pointers (Same Direction)
```java
public int twoPointersSameDirection(int[] arr) {
    int slow = 0;
    
    for (int fast = 0; fast < arr.length; fast++) {
        if (shouldIncludeFast(arr[fast])) {
            arr[slow] = arr[fast];
            slow++;
        }
    }
    
    return slow; // New length or count
}

private boolean shouldIncludeFast(int val) {
    // Define condition based on problem
    return val != 0; // Example: remove zeros
}
```

### Template 3: Fixed Size Sliding Window
```java
public int fixedSlidingWindow(int[] arr, int k) {
    if (arr.length < k) return -1;
    
    // Initialize first window
    int windowSum = 0;
    for (int i = 0; i < k; i++) {
        windowSum += arr[i];
    }
    
    int result = windowSum;
    
    // Slide the window
    for (int i = k; i < arr.length; i++) {
        windowSum = windowSum - arr[i - k] + arr[i];
        result = Math.max(result, windowSum); // Or other operation
    }
    
    return result;
}
```

### Template 4: Variable Size Sliding Window
```java
public int variableSlidingWindow(int[] arr) {
    int left = 0, result = 0;
    // Add additional state as needed (HashMap, Set, etc.)
    
    for (int right = 0; right < arr.length; right++) {
        // Expand window: add arr[right] to window
        addToWindow(arr[right]);
        
        // Contract window while invalid
        while (windowInvalid()) {
            removeFromWindow(arr[left]);
            left++;
        }
        
        // Update result with current valid window
        result = Math.max(result, right - left + 1);
    }
    
    return result;
}

private void addToWindow(int val) {
    // Implementation depends on problem
}

private void removeFromWindow(int val) {
    // Implementation depends on problem
}

private boolean windowInvalid() {
    // Define window validity condition
    return false;
}
```

## ⚡ Optimization Techniques

### 1. Early Termination
- **Sorted Arrays:** Stop when impossible to find target
- **Palindromes:** Stop at middle for odd-length strings
- **Window Problems:** Break when window cannot be improved

### 2. Skip Duplicates
- **Three Sum:** Skip duplicate values to avoid duplicate triplets
- **Implementation:** `while (i < n && arr[i] == arr[i-1]) i++;`

### 3. Bidirectional Search
- **Minimum Window:** Search from both ends when applicable
- **Palindrome Expansion:** Expand around center for optimization

### 4. State Compression
- **Character Frequency:** Use arrays instead of HashMap when possible
- **Boolean Flags:** Use bit manipulation for multiple flags

## 📈 Complexity Analysis

### Two Pointers
- **Time:** O(n) for single pass problems
- **Space:** O(1) additional space (not counting input)
- **Optimization:** Reduces O(n²) brute force to O(n)

### Sliding Window
- **Fixed Size:** O(n) time, O(1) or O(k) space
- **Variable Size:** O(n) time, depends on auxiliary data structures
- **Amortized Analysis:** Each element added and removed at most once

### Comparison with Brute Force
| Problem Type | Brute Force | Two Pointers/Sliding Window |
|--------------|-------------|----------------------------|
| Two Sum (sorted) | O(n²) | O(n) |
| Longest Substring | O(n³) | O(n) |
| Subarray Sum | O(n²) | O(n) |

## 🎯 Key Takeaways

1. **When to Use Two Pointers:**
   - Sorted arrays with target conditions
   - Palindrome-related problems
   - Cycle detection in linked lists
   - In-place array modifications

2. **When to Use Sliding Window:**
   - Substring/subarray optimization problems
   - Problems with size or character constraints
   - Maximum/minimum window problems

3. **Common Pitfalls:**
   - Off-by-one errors in window boundaries
   - Not handling edge cases (empty arrays, single elements)
   - Forgetting to skip duplicates in sum problems
   - Incorrect window expansion/contraction logic

4. **Best Practices:**
   - Clearly define window validity conditions
   - Handle edge cases first
   - Use appropriate data structures for window state
   - Test with small examples before implementing

## 🚀 Next Steps
- Practice both techniques systematically
- Master the templates and adapt them to new problems
- Focus on identifying when each technique applies
- Move to **Module 16: Recursion and Backtracking** for recursive problem solving

---
*Two pointers and sliding window are essential optimization techniques that can dramatically improve the efficiency of array and string problems. Master these patterns to solve complex problems with elegant, linear-time solutions.*
