# Module 21: String Algorithms

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master advanced string matching and pattern search algorithms
- ✅ Implement efficient string processing techniques (KMP, Rabin-Karp, Z-algorithm)
- ✅ Solve complex string manipulation and analysis problems
- ✅ Apply string algorithms to text processing and bioinformatics problems
- ✅ Understand suffix arrays, suffix trees, and their applications

## 🎯 Module Overview
String algorithms are fundamental for text processing, search engines, bioinformatics, and data compression:
- **Pattern Matching** - Find occurrences of patterns in text
- **String Manipulation** - Transform and analyze strings efficiently
- **Text Processing** - Indexing, searching, and compression
- **Bioinformatics** - DNA sequence analysis and alignment

**Time Investment:** 8-10 hours
**Difficulty Level:** Advanced
**Prerequisites:** Strings, Arrays, Basic Math, Hashing

## 📖 Core Concepts

### 1. Pattern Matching Algorithms

#### Knuth-Morris-Pratt (KMP) Algorithm
```java
public class KMPAlgorithm {
    
    // Build failure function (LPS array)
    private int[] buildLPS(String pattern) {
        int m = pattern.length();
        int[] lps = new int[m];
        int len = 0; // Length of previous longest prefix suffix
        int i = 1;
        
        while (i < m) {
            if (pattern.charAt(i) == pattern.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1]; // Use previous LPS value
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        
        return lps;
    }
    
    // KMP search algorithm
    public List<Integer> search(String text, String pattern) {
        List<Integer> result = new ArrayList<>();
        int n = text.length();
        int m = pattern.length();
        
        if (m == 0) return result;
        
        int[] lps = buildLPS(pattern);
        int i = 0; // Index for text
        int j = 0; // Index for pattern
        
        while (i < n) {
            if (text.charAt(i) == pattern.charAt(j)) {
                i++;
                j++;
            }
            
            if (j == m) {
                result.add(i - j); // Found match at position i-j
                j = lps[j - 1]; // Get next position to check
            } else if (i < n && text.charAt(i) != pattern.charAt(j)) {
                if (j != 0) {
                    j = lps[j - 1]; // Use LPS to skip characters
                } else {
                    i++;
                }
            }
        }
        
        return result;
    }
    
    // Check if pattern exists in text
    public boolean contains(String text, String pattern) {
        return !search(text, pattern).isEmpty();
    }
    
    // Find first occurrence
    public int indexOf(String text, String pattern) {
        List<Integer> matches = search(text, pattern);
        return matches.isEmpty() ? -1 : matches.get(0);
    }
}
```

#### Rabin-Karp Algorithm (Rolling Hash)
```java
public class RabinKarpAlgorithm {
    private static final int PRIME = 101;
    private static final int BASE = 256;
    
    public List<Integer> search(String text, String pattern) {
        List<Integer> result = new ArrayList<>();
        int n = text.length();
        int m = pattern.length();
        
        if (m > n) return result;
        
        // Calculate hash values
        long patternHash = calculateHash(pattern, m);
        long textHash = calculateHash(text, m);
        
        // Precompute BASE^(m-1) for rolling hash
        long h = 1;
        for (int i = 0; i < m - 1; i++) {
            h = (h * BASE) % PRIME;
        }
        
        // Check first window
        if (patternHash == textHash && checkEqual(text, 0, pattern, 0, m)) {
            result.add(0);
        }
        
        // Roll the hash for remaining windows
        for (int i = 1; i <= n - m; i++) {
            // Remove leading character and add trailing character
            textHash = (BASE * (textHash - text.charAt(i - 1) * h) + text.charAt(i + m - 1)) % PRIME;
            
            // Handle negative hash
            if (textHash < 0) {
                textHash += PRIME;
            }
            
            // Check if hash matches and verify character by character
            if (patternHash == textHash && checkEqual(text, i, pattern, 0, m)) {
                result.add(i);
            }
        }
        
        return result;
    }
    
    private long calculateHash(String str, int length) {
        long hash = 0;
        for (int i = 0; i < length; i++) {
            hash = (hash * BASE + str.charAt(i)) % PRIME;
        }
        return hash;
    }
    
    private boolean checkEqual(String text, int textStart, String pattern, int patternStart, int length) {
        for (int i = 0; i < length; i++) {
            if (text.charAt(textStart + i) != pattern.charAt(patternStart + i)) {
                return false;
            }
        }
        return true;
    }
    
    // Multiple pattern search
    public Map<String, List<Integer>> searchMultiple(String text, List<String> patterns) {
        Map<String, List<Integer>> results = new HashMap<>();
        
        for (String pattern : patterns) {
            results.put(pattern, search(text, pattern));
        }
        
        return results;
    }
}
```

#### Z-Algorithm
```java
public class ZAlgorithm {
    
    // Build Z-array
    public int[] buildZArray(String s) {
        int n = s.length();
        int[] z = new int[n];
        int l = 0, r = 0;
        
        for (int i = 1; i < n; i++) {
            if (i <= r) {
                z[i] = Math.min(r - i + 1, z[i - l]);
            }
            
            // Extend match
            while (i + z[i] < n && s.charAt(z[i]) == s.charAt(i + z[i])) {
                z[i]++;
            }
            
            // Update window
            if (i + z[i] - 1 > r) {
                l = i;
                r = i + z[i] - 1;
            }
        }
        
        return z;
    }
    
    // Pattern matching using Z-algorithm
    public List<Integer> search(String text, String pattern) {
        List<Integer> result = new ArrayList<>();
        String combined = pattern + "$" + text; // Use separator
        int[] z = buildZArray(combined);
        int patternLength = pattern.length();
        
        for (int i = patternLength + 1; i < combined.length(); i++) {
            if (z[i] == patternLength) {
                result.add(i - patternLength - 1); // Adjust for separator
            }
        }
        
        return result;
    }
    
    // Find longest common prefix
    public int longestCommonPrefix(String s1, String s2) {
        String combined = s1 + "$" + s2;
        int[] z = buildZArray(combined);
        
        // Find maximum Z-value in the second part
        int maxLCP = 0;
        for (int i = s1.length() + 1; i < combined.length(); i++) {
            maxLCP = Math.max(maxLCP, z[i]);
        }
        
        return maxLCP;
    }
}
```

### 2. String Manipulation Algorithms

#### Manacher's Algorithm (Longest Palindromic Substring)
```java
public class ManacherAlgorithm {
    
    public String longestPalindrome(String s) {
        if (s == null || s.length() == 0) return "";
        
        // Preprocess string: "abc" -> "^#a#b#c#$"
        String processed = preprocess(s);
        int n = processed.length();
        int[] P = new int[n]; // P[i] = radius of palindrome centered at i
        int center = 0, right = 0; // Current center and right boundary
        
        for (int i = 1; i < n - 1; i++) {
            int mirror = 2 * center - i; // Mirror of i with respect to center
            
            if (right > i) {
                P[i] = Math.min(right - i, P[mirror]);
            }
            
            // Try to expand palindrome centered at i
            try {
                while (processed.charAt(i + (1 + P[i])) == processed.charAt(i - (1 + P[i]))) {
                    P[i]++;
                }
            } catch (StringIndexOutOfBoundsException e) {
                // Reached boundary
            }
            
            // If palindrome centered at i extends past right, update center and right
            if (i + P[i] > right) {
                center = i;
                right = i + P[i];
            }
        }
        
        // Find longest palindrome
        int maxLength = 0;
        int centerIndex = 0;
        for (int i = 1; i < n - 1; i++) {
            if (P[i] > maxLength) {
                maxLength = P[i];
                centerIndex = i;
            }
        }
        
        // Extract result from original string
        int start = (centerIndex - maxLength) / 2;
        return s.substring(start, start + maxLength);
    }
    
    private String preprocess(String s) {
        StringBuilder sb = new StringBuilder();
        sb.append("^");
        for (char c : s.toCharArray()) {
            sb.append("#").append(c);
        }
        sb.append("#$");
        return sb.toString();
    }
    
    // Get all palindromic substrings
    public List<String> getAllPalindromes(String s) {
        List<String> result = new ArrayList<>();
        String processed = preprocess(s);
        int n = processed.length();
        int[] P = new int[n];
        int center = 0, right = 0;
        
        for (int i = 1; i < n - 1; i++) {
            int mirror = 2 * center - i;
            
            if (right > i) {
                P[i] = Math.min(right - i, P[mirror]);
            }
            
            try {
                while (processed.charAt(i + (1 + P[i])) == processed.charAt(i - (1 + P[i]))) {
                    P[i]++;
                }
            } catch (StringIndexOutOfBoundsException e) {
                // Reached boundary
            }
            
            if (i + P[i] > right) {
                center = i;
                right = i + P[i];
            }
            
            // Extract all palindromes centered at i
            for (int radius = 1; radius <= P[i]; radius++) {
                int start = (i - radius) / 2;
                int length = radius;
                if (length > 0) {
                    result.add(s.substring(start, start + length));
                }
            }
        }
        
        return result;
    }
}
```

### 3. Advanced String Structures

#### Suffix Array
```java
public class SuffixArray {
    
    public int[] buildSuffixArray(String s) {
        int n = s.length();
        Integer[] suffixes = new Integer[n];
        
        // Initialize suffix array with starting indices
        for (int i = 0; i < n; i++) {
            suffixes[i] = i;
        }
        
        // Sort suffixes lexicographically
        Arrays.sort(suffixes, (a, b) -> s.substring(a).compareTo(s.substring(b)));
        
        // Convert to int array
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = suffixes[i];
        }
        
        return result;
    }
    
    // Optimized suffix array construction using radix sort
    public int[] buildSuffixArrayOptimized(String s) {
        int n = s.length();
        int[] suffixArray = new int[n];
        int[] rank = new int[n];
        int[] tempRank = new int[n];
        
        // Initialize ranks with character values
        for (int i = 0; i < n; i++) {
            suffixArray[i] = i;
            rank[i] = s.charAt(i);
        }
        
        // Sort by increasing length: 1, 2, 4, 8, ...
        for (int k = 1; k < n; k *= 2) {
            // Sort by second key (rank[i + k])
            Arrays.sort(suffixArray, 0, n, (a, b) -> {
                if (rank[a] != rank[b]) {
                    return Integer.compare(rank[a], rank[b]);
                }
                int rankA = (a + k < n) ? rank[a + k] : -1;
                int rankB = (b + k < n) ? rank[b + k] : -1;
                return Integer.compare(rankA, rankB);
            });
            
            // Update ranks
            tempRank[suffixArray[0]] = 0;
            for (int i = 1; i < n; i++) {
                int curr = suffixArray[i];
                int prev = suffixArray[i - 1];
                
                boolean sameFirstHalf = (rank[curr] == rank[prev]);
                boolean sameSecondHalf = ((curr + k >= n ? -1 : rank[curr + k]) == 
                                       (prev + k >= n ? -1 : rank[prev + k]));
                
                if (sameFirstHalf && sameSecondHalf) {
                    tempRank[curr] = tempRank[prev];
                } else {
                    tempRank[curr] = tempRank[prev] + 1;
                }
            }
            
            // Copy temp ranks to rank array
            System.arraycopy(tempRank, 0, rank, 0, n);
        }
        
        return suffixArray;
    }
    
    // Build LCP (Longest Common Prefix) array
    public int[] buildLCPArray(String s, int[] suffixArray) {
        int n = s.length();
        int[] lcp = new int[n];
        int[] rank = new int[n];
        
        // Build rank array (inverse of suffix array)
        for (int i = 0; i < n; i++) {
            rank[suffixArray[i]] = i;
        }
        
        int h = 0; // Height of LCP
        for (int i = 0; i < n; i++) {
            if (rank[i] > 0) {
                int j = suffixArray[rank[i] - 1];
                
                while (i + h < n && j + h < n && s.charAt(i + h) == s.charAt(j + h)) {
                    h++;
                }
                
                lcp[rank[i]] = h;
                
                if (h > 0) {
                    h--;
                }
            }
        }
        
        return lcp;
    }
    
    // Pattern matching using suffix array
    public List<Integer> searchPattern(String text, String pattern, int[] suffixArray) {
        List<Integer> result = new ArrayList<>();
        int n = text.length();
        
        // Binary search for first occurrence
        int left = 0, right = n - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            String suffix = text.substring(suffixArray[mid]);
            
            if (suffix.startsWith(pattern)) {
                // Found one occurrence, find all occurrences
                int start = mid;
                while (start >= 0 && text.substring(suffixArray[start]).startsWith(pattern)) {
                    result.add(suffixArray[start]);
                    start--;
                }
                
                int end = mid + 1;
                while (end < n && text.substring(suffixArray[end]).startsWith(pattern)) {
                    result.add(suffixArray[end]);
                    end++;
                }
                
                Collections.sort(result);
                return result;
            } else if (suffix.compareTo(pattern) < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return result;
    }
}
```

### 4. String Processing Applications

#### Edit Distance (Levenshtein Distance)
```java
public class EditDistance {
    
    // Calculate minimum edit distance
    public int minDistance(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();
        
        // dp[i][j] = edit distance between word1[0..i-1] and word2[0..j-1]
        int[][] dp = new int[m + 1][n + 1];
        
        // Initialize base cases
        for (int i = 0; i <= m; i++) {
            dp[i][0] = i; // Delete all characters from word1
        }
        for (int j = 0; j <= n; j++) {
            dp[0][j] = j; // Insert all characters to make word2
        }
        
        // Fill DP table
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1]; // No operation needed
                } else {
                    dp[i][j] = 1 + Math.min(
                        dp[i - 1][j],     // Delete
                        Math.min(
                            dp[i][j - 1],     // Insert
                            dp[i - 1][j - 1]  // Replace
                        )
                    );
                }
            }
        }
        
        return dp[m][n];
    }
    
    // Get actual sequence of operations
    public List<String> getEditOperations(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();
        int[][] dp = new int[m + 1][n + 1];
        
        // Build DP table
        for (int i = 0; i <= m; i++) dp[i][0] = i;
        for (int j = 0; j <= n; j++) dp[0][j] = j;
        
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(dp[i - 1][j], 
                                          Math.min(dp[i][j - 1], dp[i - 1][j - 1]));
                }
            }
        }
        
        // Backtrack to find operations
        List<String> operations = new ArrayList<>();
        int i = m, j = n;
        
        while (i > 0 || j > 0) {
            if (i > 0 && j > 0 && word1.charAt(i - 1) == word2.charAt(j - 1)) {
                i--;
                j--;
            } else if (i > 0 && j > 0 && dp[i][j] == dp[i - 1][j - 1] + 1) {
                operations.add("Replace " + word1.charAt(i - 1) + " with " + word2.charAt(j - 1));
                i--;
                j--;
            } else if (i > 0 && dp[i][j] == dp[i - 1][j] + 1) {
                operations.add("Delete " + word1.charAt(i - 1));
                i--;
            } else {
                operations.add("Insert " + word2.charAt(j - 1));
                j--;
            }
        }
        
        Collections.reverse(operations);
        return operations;
    }
    
    // Space-optimized version (O(min(m,n)) space)
    public int minDistanceOptimized(String word1, String word2) {
        int m = word1.length();
        int n = word2.length();
        
        // Ensure word1 is shorter for space optimization
        if (m > n) {
            return minDistanceOptimized(word2, word1);
        }
        
        int[] prev = new int[m + 1];
        int[] curr = new int[m + 1];
        
        // Initialize first row
        for (int i = 0; i <= m; i++) {
            prev[i] = i;
        }
        
        for (int j = 1; j <= n; j++) {
            curr[0] = j;
            
            for (int i = 1; i <= m; i++) {
                if (word1.charAt(i - 1) == word2.charAt(j - 1)) {
                    curr[i] = prev[i - 1];
                } else {
                    curr[i] = 1 + Math.min(prev[i], Math.min(curr[i - 1], prev[i - 1]));
                }
            }
            
            // Swap arrays
            int[] temp = prev;
            prev = curr;
            curr = temp;
        }
        
        return prev[m];
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Pattern Matching
- **Use Case:** Find all occurrences of pattern in text
- **Key Insight:** Choose algorithm based on pattern characteristics
- **Example Problems:** Implement strStr(), Repeated Substring Pattern

### Pattern 2: String Transformation
- **Use Case:** Convert one string to another with minimum operations
- **Key Insight:** Use dynamic programming for optimal solutions
- **Example Problems:** Edit Distance, One Edit Distance

### Pattern 3: Palindrome Detection
- **Use Case:** Find palindromic substrings efficiently
- **Key Insight:** Use Manacher's algorithm for linear time
- **Example Problems:** Longest Palindromic Substring, Palindromic Substrings

### Pattern 4: Suffix Processing
- **Use Case:** Analyze string properties using suffixes
- **Key Insight:** Build suffix arrays for efficient queries
- **Example Problems:** Longest Repeated Substring, Suffix Queries

## 💻 Practice Problems

### Medium Level
1. **Implement strStr() (LeetCode 28)**
   - Basic pattern matching using KMP or Rabin-Karp
   - Handle edge cases with empty strings

2. **Longest Palindromic Substring (LeetCode 5)**
   - Use Manacher's algorithm for O(n) solution
   - Alternative: expand around centers approach

3. **Edit Distance (LeetCode 72)**
   - Classic dynamic programming problem
   - Optimize space complexity

4. **Repeated Substring Pattern (LeetCode 459)**
   - Use KMP failure function properties
   - Check if string can be formed by repeating substring

### Hard Level
5. **Shortest Palindrome (LeetCode 214)**
   - Use KMP to find longest palindromic prefix
   - Complex application of failure function

6. **Regular Expression Matching (LeetCode 10)**
   - Advanced pattern matching with wildcards
   - Dynamic programming with state transitions

## 🧠 Problem-Solving Templates

### Template 1: KMP Pattern Matching
```java
public List<Integer> kmpSearch(String text, String pattern) {
    int[] lps = buildLPS(pattern);
    List<Integer> matches = new ArrayList<>();
    int i = 0, j = 0;
    
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
```

### Template 2: Rolling Hash
```java
public boolean rabinKarpMatch(String text, String pattern) {
    int n = text.length(), m = pattern.length();
    if (m > n) return false;
    
    long patternHash = 0, textHash = 0, h = 1;
    
    for (int i = 0; i < m - 1; i++) {
        h = (h * BASE) % PRIME;
    }
    
    for (int i = 0; i < m; i++) {
        patternHash = (patternHash * BASE + pattern.charAt(i)) % PRIME;
        textHash = (textHash * BASE + text.charAt(i)) % PRIME;
    }
    
    for (int i = 0; i <= n - m; i++) {
        if (patternHash == textHash && text.substring(i, i + m).equals(pattern)) {
            return true;
        }
        
        if (i < n - m) {
            textHash = (BASE * (textHash - text.charAt(i) * h) + text.charAt(i + m)) % PRIME;
            if (textHash < 0) textHash += PRIME;
        }
    }
    
    return false;
}
```

## ⚡ Optimization Techniques

### 1. Algorithm Selection
- **KMP:** Good for small alphabets, preprocessing pattern once
- **Rabin-Karp:** Good for multiple pattern search
- **Z-algorithm:** Simple implementation, good for prefix-based problems

### 2. Space Optimization
- **Rolling Hash:** Constant space for pattern matching
- **In-place Algorithms:** Modify strings without extra space
- **Streaming:** Process strings character by character

### 3. Early Termination
- **Short-circuit Evaluation:** Stop when answer is found
- **Pruning:** Skip unnecessary computations
- **Bounds Checking:** Avoid out-of-bounds access

## 📈 Complexity Analysis

### Time Complexities
- **KMP:** O(n + m) for pattern matching
- **Rabin-Karp:** O(n) average, O(nm) worst case
- **Manacher:** O(n) for longest palindrome
- **Suffix Array:** O(n log n) construction

### Space Complexities
- **KMP:** O(m) for LPS array
- **Rabin-Karp:** O(1) additional space
- **Suffix Array:** O(n) space
- **Edit Distance:** O(mn) or O(min(m,n)) optimized

## 🎯 Key Takeaways

1. **Algorithm Selection:**
   - Consider pattern characteristics (length, alphabet size)
   - Choose based on use case (single vs multiple patterns)
   - Balance preprocessing time vs query time

2. **Implementation Tips:**
   - Handle edge cases (empty strings, single characters)
   - Use appropriate data types for large inputs
   - Consider Unicode and special characters

3. **Common Applications:**
   - Text editors and search engines
   - Bioinformatics and DNA analysis
   - Data compression and encoding
   - Natural language processing

## 🚀 Next Steps
- Practice implementing algorithms from scratch
- Study advanced topics like suffix trees and Aho-Corasick
- Apply to bioinformatics and text processing problems
- Move to **Module 22: Mathematical Algorithms** for number theory

---
*String algorithms are essential for text processing and pattern recognition. Master these techniques to handle complex string manipulation tasks efficiently in competitive programming and real-world applications.*
