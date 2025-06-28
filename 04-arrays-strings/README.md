# Module 4: Arrays and Strings

## 🎯 Learning Objectives
- Master array manipulation techniques and algorithms
- Understand string processing and optimization
- Learn pattern recognition for array/string problems
- Develop efficient solutions for common interview questions

## 📚 Arrays Fundamentals

### 4.1 Array Basics and Operations

#### Declaration and Initialization
```java
public class ArrayBasics {
    
    public static void arrayDeclaration() {
        // Different ways to declare arrays
        int[] arr1 = new int[5];                    // Size 5, all zeros
        int[] arr2 = {1, 2, 3, 4, 5};              // Literal initialization
        int[] arr3 = new int[]{1, 2, 3, 4, 5};     // Explicit initialization
        
        // Multi-dimensional arrays
        int[][] matrix = new int[3][4];             // 3x4 matrix
        int[][] matrix2 = {{1,2}, {3,4}, {5,6}};   // Literal 2D array
        
        // Array properties
        System.out.println("Length: " + arr1.length);
        System.out.println("2D rows: " + matrix.length);
        System.out.println("2D cols: " + matrix[0].length);
    }
    
    public static void basicOperations() {
        int[] arr = {10, 20, 30, 40, 50};
        
        // Access elements
        int first = arr[0];        // 10
        int last = arr[arr.length - 1];  // 50
        
        // Modify elements
        arr[2] = 35;              // arr becomes {10, 20, 35, 40, 50}
        
        // Iterate through array
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        
        // Enhanced for loop
        for (int element : arr) {
            System.out.print(element + " ");
        }
    }
}
```

#### Common Array Algorithms
```java
public class ArrayAlgorithms {
    
    // Linear Search - O(n)
    public static int linearSearch(int[] arr, int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1; // Not found
    }
    
    // Binary Search - O(log n) - requires sorted array
    public static int binarySearch(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;  // Avoid overflow
            
            if (arr[mid] == target) {
                return mid;
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1; // Not found
    }
    
    // Find maximum element
    public static int findMax(int[] arr) {
        if (arr.length == 0) throw new IllegalArgumentException("Empty array");
        
        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) {
                max = arr[i];
            }
        }
        return max;
    }
    
    // Reverse array in-place
    public static void reverse(int[] arr) {
        int left = 0, right = arr.length - 1;
        
        while (left < right) {
            // Swap elements
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            
            left++;
            right--;
        }
    }
    
    // Rotate array right by k positions
    public static void rotateRight(int[] arr, int k) {
        int n = arr.length;
        k = k % n; // Handle k > n
        
        // Reverse entire array
        reverse(arr, 0, n - 1);
        // Reverse first k elements
        reverse(arr, 0, k - 1);
        // Reverse remaining elements
        reverse(arr, k, n - 1);
    }
    
    private static void reverse(int[] arr, int start, int end) {
        while (start < end) {
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}
```

### 4.2 Two Pointers Technique

#### Basic Two Pointers
```java
public class TwoPointers {
    
    // Two Sum in sorted array
    public static int[] twoSumSorted(int[] arr, int target) {
        int left = 0, right = arr.length - 1;
        
        while (left < right) {
            int sum = arr[left] + arr[right];
            
            if (sum == target) {
                return new int[]{left, right};
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        return new int[]{-1, -1}; // Not found
    }
    
    // Three Sum - find triplets that sum to target
    public static List<List<Integer>> threeSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 2; i++) {
            // Skip duplicates for first element
            if (i > 0 && nums[i] == nums[i - 1]) continue;
            
            int left = i + 1, right = nums.length - 1;
            int remainingTarget = target - nums[i];
            
            while (left < right) {
                int sum = nums[left] + nums[right];
                
                if (sum == remainingTarget) {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    
                    // Skip duplicates
                    while (left < right && nums[left] == nums[left + 1]) left++;
                    while (left < right && nums[right] == nums[right - 1]) right--;
                    
                    left++;
                    right--;
                } else if (sum < remainingTarget) {
                    left++;
                } else {
                    right--;
                }
            }
        }
        return result;
    }
    
    // Container with most water
    public static int maxArea(int[] height) {
        int left = 0, right = height.length - 1;
        int maxWater = 0;
        
        while (left < right) {
            int width = right - left;
            int currentHeight = Math.min(height[left], height[right]);
            int currentWater = width * currentHeight;
            
            maxWater = Math.max(maxWater, currentWater);
            
            // Move pointer with smaller height
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        return maxWater;
    }
}
```

#### Fast and Slow Pointers
```java
public class FastSlowPointers {
    
    // Remove duplicates from sorted array
    public static int removeDuplicates(int[] nums) {
        if (nums.length == 0) return 0;
        
        int slow = 0; // Points to last unique element
        
        for (int fast = 1; fast < nums.length; fast++) {
            if (nums[fast] != nums[slow]) {
                slow++;
                nums[slow] = nums[fast];
            }
        }
        return slow + 1; // Number of unique elements
    }
    
    // Move zeros to end
    public static void moveZeros(int[] nums) {
        int slow = 0; // Points to next position for non-zero element
        
        // Move all non-zero elements to front
        for (int fast = 0; fast < nums.length; fast++) {
            if (nums[fast] != 0) {
                nums[slow] = nums[fast];
                slow++;
            }
        }
        
        // Fill remaining positions with zeros
        while (slow < nums.length) {
            nums[slow] = 0;
            slow++;
        }
    }
    
    // Partition array (like in QuickSort)
    public static int partition(int[] arr, int pivot) {
        int slow = 0; // Points to next position for elements ≤ pivot
        
        for (int fast = 0; fast < arr.length; fast++) {
            if (arr[fast] <= pivot) {
                // Swap elements
                int temp = arr[slow];
                arr[slow] = arr[fast];
                arr[fast] = temp;
                slow++;
            }
        }
        return slow; // Index where elements > pivot start
    }
}
```

### 4.3 Sliding Window Technique

#### Fixed Size Window
```java
public class SlidingWindow {
    
    // Maximum sum of subarray of size k
    public static int maxSumSubarray(int[] arr, int k) {
        if (arr.length < k) return -1;
        
        // Calculate sum of first window
        int windowSum = 0;
        for (int i = 0; i < k; i++) {
            windowSum += arr[i];
        }
        
        int maxSum = windowSum;
        
        // Slide the window
        for (int i = k; i < arr.length; i++) {
            windowSum = windowSum - arr[i - k] + arr[i];
            maxSum = Math.max(maxSum, windowSum);
        }
        
        return maxSum;
    }
    
    // Average of all subarrays of size k
    public static double[] findAverages(int[] arr, int k) {
        double[] result = new double[arr.length - k + 1];
        
        double windowSum = 0;
        // Calculate first window
        for (int i = 0; i < k; i++) {
            windowSum += arr[i];
        }
        result[0] = windowSum / k;
        
        // Slide window and calculate averages
        for (int i = k; i < arr.length; i++) {
            windowSum = windowSum - arr[i - k] + arr[i];
            result[i - k + 1] = windowSum / k;
        }
        
        return result;
    }
}
```

#### Variable Size Window
```java
public class VariableSlidingWindow {
    
    // Longest substring without repeating characters
    public static int lengthOfLongestSubstring(String s) {
        Map<Character, Integer> charIndex = new HashMap<>();
        int maxLength = 0;
        int left = 0;
        
        for (int right = 0; right < s.length(); right++) {
            char rightChar = s.charAt(right);
            
            // If character is repeated, move left pointer
            if (charIndex.containsKey(rightChar)) {
                left = Math.max(left, charIndex.get(rightChar) + 1);
            }
            
            charIndex.put(rightChar, right);
            maxLength = Math.max(maxLength, right - left + 1);
        }
        
        return maxLength;
    }
    
    // Minimum window substring
    public static String minWindow(String s, String t) {
        Map<Character, Integer> targetCount = new HashMap<>();
        for (char c : t.toCharArray()) {
            targetCount.put(c, targetCount.getOrDefault(c, 0) + 1);
        }
        
        int left = 0, minStart = 0, minLength = Integer.MAX_VALUE;
        int matched = 0;
        Map<Character, Integer> windowCount = new HashMap<>();
        
        for (int right = 0; right < s.length(); right++) {
            char rightChar = s.charAt(right);
            windowCount.put(rightChar, windowCount.getOrDefault(rightChar, 0) + 1);
            
            if (targetCount.containsKey(rightChar) && 
                windowCount.get(rightChar).equals(targetCount.get(rightChar))) {
                matched++;
            }
            
            // Try to shrink window
            while (matched == targetCount.size()) {
                if (right - left + 1 < minLength) {
                    minLength = right - left + 1;
                    minStart = left;
                }
                
                char leftChar = s.charAt(left);
                windowCount.put(leftChar, windowCount.get(leftChar) - 1);
                
                if (targetCount.containsKey(leftChar) && 
                    windowCount.get(leftChar) < targetCount.get(leftChar)) {
                    matched--;
                }
                left++;
            }
        }
        
        return minLength == Integer.MAX_VALUE ? "" : s.substring(minStart, minStart + minLength);
    }
}
```

## 📝 Strings Fundamentals

### 4.4 String Manipulation

#### Basic String Operations
```java
public class StringBasics {
    
    public static void stringOperations() {
        String str = "Hello World";
        
        // Basic properties
        int length = str.length();                    // 11
        boolean isEmpty = str.isEmpty();              // false
        char charAt = str.charAt(0);                  // 'H'
        
        // Search operations
        int indexOf = str.indexOf('o');               // 4 (first occurrence)
        int lastIndexOf = str.lastIndexOf('o');       // 7 (last occurrence)
        boolean contains = str.contains("World");     // true
        boolean startsWith = str.startsWith("Hello"); // true
        boolean endsWith = str.endsWith("World");     // true
        
        // Substring operations
        String sub1 = str.substring(6);               // "World"
        String sub2 = str.substring(0, 5);            // "Hello"
        
        // Case operations
        String upper = str.toUpperCase();             // "HELLO WORLD"
        String lower = str.toLowerCase();             // "hello world"
        
        // Trim whitespace
        String trimmed = "  hello  ".trim();          // "hello"
        
        // Replace operations
        String replaced = str.replace('o', 'a');      // "Hella Warld"
        String replacedAll = str.replaceAll("o", "a"); // "Hella Warld"
        
        // Split string
        String[] words = str.split(" ");              // ["Hello", "World"]
    }
    
    // Check if string is palindrome
    public static boolean isPalindrome(String s) {
        // Clean string: remove non-alphanumeric, convert to lowercase
        StringBuilder cleaned = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (Character.isAlphaNumeric(c)) {
                cleaned.append(Character.toLowerCase(c));
            }
        }
        
        String cleanStr = cleaned.toString();
        int left = 0, right = cleanStr.length() - 1;
        
        while (left < right) {
            if (cleanStr.charAt(left) != cleanStr.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
    
    // Check if two strings are anagrams
    public static boolean areAnagrams(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        
        // Method 1: Sort characters
        char[] chars1 = s1.toCharArray();
        char[] chars2 = s2.toCharArray();
        Arrays.sort(chars1);
        Arrays.sort(chars2);
        return Arrays.equals(chars1, chars2);
    }
    
    public static boolean areAnagramsOptimal(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        
        // Method 2: Character frequency count
        int[] charCount = new int[26]; // Assuming lowercase letters only
        
        for (int i = 0; i < s1.length(); i++) {
            charCount[s1.charAt(i) - 'a']++;
            charCount[s2.charAt(i) - 'a']--;
        }
        
        for (int count : charCount) {
            if (count != 0) return false;
        }
        return true;
    }
}
```

#### StringBuilder for Efficient String Building
```java
public class StringBuilderExamples {
    
    // Inefficient string concatenation - O(n²)
    public static String inefficientConcat(String[] words) {
        String result = "";
        for (String word : words) {
            result += word + " "; // Creates new string each time
        }
        return result.trim();
    }
    
    // Efficient string building - O(n)
    public static String efficientConcat(String[] words) {
        StringBuilder sb = new StringBuilder();
        for (String word : words) {
            sb.append(word).append(" ");
        }
        return sb.toString().trim();
    }
    
    // Reverse string using StringBuilder
    public static String reverseString(String str) {
        return new StringBuilder(str).reverse().toString();
    }
    
    // Remove specific characters
    public static String removeCharacters(String str, Set<Character> toRemove) {
        StringBuilder result = new StringBuilder();
        for (char c : str.toCharArray()) {
            if (!toRemove.contains(c)) {
                result.append(c);
            }
        }
        return result.toString();
    }
    
    // Compress string (aabcccccaaa -> a2b1c5a3)
    public static String compressString(String str) {
        StringBuilder compressed = new StringBuilder();
        int count = 1;
        
        for (int i = 1; i < str.length(); i++) {
            if (str.charAt(i) == str.charAt(i - 1)) {
                count++;
            } else {
                compressed.append(str.charAt(i - 1)).append(count);
                count = 1;
            }
        }
        compressed.append(str.charAt(str.length() - 1)).append(count);
        
        // Return original if compressed is not shorter
        return compressed.length() < str.length() ? compressed.toString() : str;
    }
}
```

### 4.5 Advanced String Algorithms

#### Pattern Matching
```java
public class PatternMatching {
    
    // Naive pattern search - O(nm)
    public static List<Integer> naiveSearch(String text, String pattern) {
        List<Integer> matches = new ArrayList<>();
        int n = text.length(), m = pattern.length();
        
        for (int i = 0; i <= n - m; i++) {
            int j;
            for (j = 0; j < m; j++) {
                if (text.charAt(i + j) != pattern.charAt(j)) {
                    break;
                }
            }
            if (j == m) {
                matches.add(i);
            }
        }
        return matches;
    }
    
    // KMP Algorithm - O(n + m)
    public static List<Integer> kmpSearch(String text, String pattern) {
        List<Integer> matches = new ArrayList<>();
        int[] lps = computeLPS(pattern);
        
        int i = 0, j = 0; // i for text, j for pattern
        while (i < text.length()) {
            if (text.charAt(i) == pattern.charAt(j)) {
                i++;
                j++;
            }
            
            if (j == pattern.length()) {
                matches.add(i - j);
                j = lps[j - 1];
            } else if (i < text.length() && text.charAt(i) != pattern.charAt(j)) {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return matches;
    }
    
    // Compute Longest Prefix Suffix array for KMP
    private static int[] computeLPS(String pattern) {
        int[] lps = new int[pattern.length()];
        int len = 0;
        int i = 1;
        
        while (i < pattern.length()) {
            if (pattern.charAt(i) == pattern.charAt(len)) {
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

#### String Transformation
```java
public class StringTransformation {
    
    // Edit distance (Levenshtein distance)
    public static int editDistance(String s1, String s2) {
        int m = s1.length(), n = s2.length();
        int[][] dp = new int[m + 1][n + 1];
        
        // Initialize base cases
        for (int i = 0; i <= m; i++) dp[i][0] = i;
        for (int j = 0; j <= n; j++) dp[0][j] = j;
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(
                        Math.min(dp[i - 1][j], dp[i][j - 1]), // Insert/Delete
                        dp[i - 1][j - 1] // Replace
                    );
                }
            }
        }
        return dp[m][n];
    }
    
    // Longest Common Subsequence
    public static int longestCommonSubsequence(String s1, String s2) {
        int m = s1.length(), n = s2.length();
        int[][] dp = new int[m + 1][n + 1];
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }
        return dp[m][n];
    }
    
    // Check if s3 is interleaving of s1 and s2
    public static boolean isInterleave(String s1, String s2, String s3) {
        if (s1.length() + s2.length() != s3.length()) return false;
        
        boolean[][] dp = new boolean[s1.length() + 1][s2.length() + 1];
        dp[0][0] = true;
        
        // Fill first row (using only s2)
        for (int j = 1; j <= s2.length(); j++) {
            dp[0][j] = dp[0][j - 1] && s2.charAt(j - 1) == s3.charAt(j - 1);
        }
        
        // Fill first column (using only s1)
        for (int i = 1; i <= s1.length(); i++) {
            dp[i][0] = dp[i - 1][0] && s1.charAt(i - 1) == s3.charAt(i - 1);
        }
        
        // Fill the rest
        for (int i = 1; i <= s1.length(); i++) {
            for (int j = 1; j <= s2.length(); j++) {
                dp[i][j] = (dp[i - 1][j] && s1.charAt(i - 1) == s3.charAt(i + j - 1)) ||
                          (dp[i][j - 1] && s2.charAt(j - 1) == s3.charAt(i + j - 1));
            }
        }
        
        return dp[s1.length()][s2.length()];
    }
}
```

## 🧪 Practice Problems

### Easy Level Problems
```java
public class EasyProblems {
    
    // 1. Two Sum
    public static int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            map.put(nums[i], i);
        }
        return new int[0];
    }
    
    // 2. Best Time to Buy and Sell Stock
    public static int maxProfit(int[] prices) {
        int minPrice = Integer.MAX_VALUE;
        int maxProfit = 0;
        
        for (int price : prices) {
            if (price < minPrice) {
                minPrice = price;
            } else if (price - minPrice > maxProfit) {
                maxProfit = price - minPrice;
            }
        }
        return maxProfit;
    }
    
    // 3. Contains Duplicate
    public static boolean containsDuplicate(int[] nums) {
        Set<Integer> seen = new HashSet<>();
        for (int num : nums) {
            if (!seen.add(num)) {
                return true;
            }
        }
        return false;
    }
    
    // 4. Valid Anagram
    public static boolean isAnagram(String s, String t) {
        if (s.length() != t.length()) return false;
        
        int[] charCount = new int[26];
        for (int i = 0; i < s.length(); i++) {
            charCount[s.charAt(i) - 'a']++;
            charCount[t.charAt(i) - 'a']--;
        }
        
        for (int count : charCount) {
            if (count != 0) return false;
        }
        return true;
    }
    
    // 5. Group Anagrams
    public static List<List<String>> groupAnagrams(String[] strs) {
        Map<String, List<String>> map = new HashMap<>();
        
        for (String str : strs) {
            char[] chars = str.toCharArray();
            Arrays.sort(chars);
            String key = String.valueOf(chars);
            
            map.computeIfAbsent(key, k -> new ArrayList<>()).add(str);
        }
        
        return new ArrayList<>(map.values());
    }
}
```

### Medium Level Problems
```java
public class MediumProblems {
    
    // 1. Product of Array Except Self
    public static int[] productExceptSelf(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        
        // Calculate left products
        result[0] = 1;
        for (int i = 1; i < n; i++) {
            result[i] = result[i - 1] * nums[i - 1];
        }
        
        // Calculate right products and multiply
        int rightProduct = 1;
        for (int i = n - 1; i >= 0; i--) {
            result[i] *= rightProduct;
            rightProduct *= nums[i];
        }
        
        return result;
    }
    
    // 2. Longest Consecutive Sequence
    public static int longestConsecutive(int[] nums) {
        Set<Integer> numSet = new HashSet<>();
        for (int num : nums) {
            numSet.add(num);
        }
        
        int longestStreak = 0;
        
        for (int num : numSet) {
            // Check if this is the start of a sequence
            if (!numSet.contains(num - 1)) {
                int currentNum = num;
                int currentStreak = 1;
                
                while (numSet.contains(currentNum + 1)) {
                    currentNum++;
                    currentStreak++;
                }
                
                longestStreak = Math.max(longestStreak, currentStreak);
            }
        }
        
        return longestStreak;
    }
    
    // 3. 3Sum
    public static List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 2; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) continue;
            
            int left = i + 1, right = nums.length - 1;
            
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                
                if (sum == 0) {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    
                    while (left < right && nums[left] == nums[left + 1]) left++;
                    while (left < right && nums[right] == nums[right - 1]) right--;
                    
                    left++;
                    right--;
                } else if (sum < 0) {
                    left++;
                } else {
                    right--;
                }
            }
        }
        
        return result;
    }
    
    // 4. Container With Most Water
    public static int maxArea(int[] height) {
        int left = 0, right = height.length - 1;
        int maxWater = 0;
        
        while (left < right) {
            int width = right - left;
            int currentHeight = Math.min(height[left], height[right]);
            int currentWater = width * currentHeight;
            
            maxWater = Math.max(maxWater, currentWater);
            
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        
        return maxWater;
    }
}
```

## 📊 Complexity Analysis Guide

### Time Complexity Patterns
```java
/*
Common Time Complexities for Array/String Problems:

O(1) - Constant Time:
- Access array element by index
- Hash table lookup/insert

O(log n) - Logarithmic Time:
- Binary search in sorted array
- Operations on balanced trees

O(n) - Linear Time:
- Single pass through array
- Most optimal string problems

O(n log n) - Linearithmic Time:
- Sorting algorithms
- Divide and conquer approaches

O(n²) - Quadratic Time:
- Nested loops through array
- Brute force approaches

O(2^n) - Exponential Time:
- Generate all subsets
- Some recursive approaches without memoization
*/
```

### Space Complexity Patterns
```java
/*
Space Complexity Considerations:

O(1) - Constant Space:
- Two pointers technique
- In-place modifications
- Mathematical calculations

O(n) - Linear Space:
- Hash tables for frequency counting
- Additional arrays for preprocessing
- Recursion stack depth

O(n²) - Quadratic Space:
- 2D dynamic programming tables
- Storing all pairs/combinations

Optimization Techniques:
1. Use two pointers instead of extra arrays
2. Modify input array in-place when possible
3. Use mathematical relationships to avoid storage
4. Rolling array technique for DP problems
*/
```

## ✅ Mastery Checklist

### Array Fundamentals
- [ ] Implement all basic array operations
- [ ] Master two pointers technique
- [ ] Apply sliding window efficiently
- [ ] Handle edge cases (empty, single element)
- [ ] Optimize space complexity when possible

### String Fundamentals
- [ ] Efficient string building with StringBuilder
- [ ] Pattern matching algorithms
- [ ] String transformation problems
- [ ] Character frequency analysis
- [ ] Handle Unicode and special characters

### Problem-Solving Skills
- [ ] Recognize common patterns quickly
- [ ] Choose optimal algorithms for constraints
- [ ] Handle multiple solutions gracefully
- [ ] Write clean, readable code
- [ ] Test thoroughly with edge cases

## 🎯 Next Steps

After mastering arrays and strings:
1. Practice 50+ problems from LeetCode/HackerRank
2. Focus on optimizing brute force solutions
3. Learn to recognize patterns in new problems
4. Move to [Module 5: Linked Lists](../05-linked-lists/)

---

**Estimated Time:** 2-3 weeks  
**Practice Problems:** 50+ problems  
**Key Skills:** Pattern recognition, optimization, clean implementation
