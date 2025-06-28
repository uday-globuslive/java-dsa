# Module 11: Tries (Prefix Trees)

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Understand the structure and purpose of Trie data structures
- ✅ Implement Trie from scratch in Java
- ✅ Master prefix-based operations and search algorithms
- ✅ Solve complex string matching and autocomplete problems
- ✅ Optimize space usage with compressed tries

## 🎯 Module Overview
Tries are specialized tree structures optimized for storing and searching strings efficiently. They're essential for problems involving:
- **Prefix matching** - Autocomplete features
- **Word search** - Dictionary lookups
- **Pattern matching** - String algorithms
- **IP address validation** - Network programming

**Time Investment:** 6-8 hours
**Difficulty Level:** Intermediate
**Prerequisites:** Trees, Strings, Hash Tables

## 📖 Core Concepts

### 1. Trie Fundamentals
```java
// Basic Trie Node Structure
class TrieNode {
    TrieNode[] children;
    boolean isEndOfWord;
    
    public TrieNode() {
        children = new TrieNode[26]; // for lowercase a-z
        isEndOfWord = false;
    }
}

class Trie {
    private TrieNode root;
    
    public Trie() {
        root = new TrieNode();
    }
    
    // Insert word into trie
    public void insert(String word) {
        TrieNode current = root;
        for (char c : word.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                current.children[index] = new TrieNode();
            }
            current = current.children[index];
        }
        current.isEndOfWord = true;
    }
    
    // Search for word in trie
    public boolean search(String word) {
        TrieNode node = searchPrefix(word);
        return node != null && node.isEndOfWord;
    }
    
    // Check if any word starts with prefix
    public boolean startsWith(String prefix) {
        return searchPrefix(prefix) != null;
    }
    
    private TrieNode searchPrefix(String prefix) {
        TrieNode current = root;
        for (char c : prefix.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                return null;
            }
            current = current.children[index];
        }
        return current;
    }
}
```

### 2. Advanced Trie Operations

#### Auto-Complete Implementation
```java
public List<String> autoComplete(String prefix) {
    List<String> results = new ArrayList<>();
    TrieNode prefixNode = searchPrefix(prefix);
    
    if (prefixNode != null) {
        dfsCollectWords(prefixNode, prefix, results);
    }
    return results;
}

private void dfsCollectWords(TrieNode node, String prefix, List<String> results) {
    if (node.isEndOfWord) {
        results.add(prefix);
    }
    
    for (int i = 0; i < 26; i++) {
        if (node.children[i] != null) {
            char nextChar = (char) ('a' + i);
            dfsCollectWords(node.children[i], prefix + nextChar, results);
        }
    }
}
```

#### Word Search in 2D Grid
```java
public List<String> findWords(char[][] board, String[] words) {
    // Build trie from words
    Trie trie = new Trie();
    for (String word : words) {
        trie.insert(word);
    }
    
    List<String> result = new ArrayList<>();
    int m = board.length, n = board[0].length;
    boolean[][] visited = new boolean[m][n];
    
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dfs(board, i, j, trie.root, "", result, visited);
        }
    }
    
    return result;
}

private void dfs(char[][] board, int i, int j, TrieNode node, 
                String path, List<String> result, boolean[][] visited) {
    if (i < 0 || i >= board.length || j < 0 || j >= board[0].length 
        || visited[i][j]) {
        return;
    }
    
    char c = board[i][j];
    int index = c - 'a';
    if (node.children[index] == null) return;
    
    visited[i][j] = true;
    path += c;
    node = node.children[index];
    
    if (node.isEndOfWord) {
        result.add(path);
        node.isEndOfWord = false; // Avoid duplicates
    }
    
    // Explore all 4 directions
    int[][] dirs = {{-1,0}, {1,0}, {0,-1}, {0,1}};
    for (int[] dir : dirs) {
        dfs(board, i + dir[0], j + dir[1], node, path, result, visited);
    }
    
    visited[i][j] = false;
}
```

### 3. Space-Optimized Tries

#### Compressed Trie (Radix Tree)
```java
class CompressedTrieNode {
    Map<Character, CompressedTrieNode> children;
    String value; // stores compressed path
    boolean isEndOfWord;
    
    public CompressedTrieNode() {
        children = new HashMap<>();
        value = "";
        isEndOfWord = false;
    }
}

class CompressedTrie {
    private CompressedTrieNode root;
    
    public CompressedTrie() {
        root = new CompressedTrieNode();
    }
    
    public void insert(String word) {
        insertHelper(root, word, 0);
    }
    
    private void insertHelper(CompressedTrieNode node, String word, int index) {
        if (index == word.length()) {
            node.isEndOfWord = true;
            return;
        }
        
        char c = word.charAt(index);
        if (!node.children.containsKey(c)) {
            node.children.put(c, new CompressedTrieNode());
            node.children.get(c).value = word.substring(index);
            node.children.get(c).isEndOfWord = true;
            return;
        }
        
        CompressedTrieNode child = node.children.get(c);
        String childValue = child.value;
        
        // Find common prefix
        int commonLength = 0;
        int maxLength = Math.min(childValue.length(), word.length() - index);
        
        while (commonLength < maxLength && 
               childValue.charAt(commonLength) == word.charAt(index + commonLength)) {
            commonLength++;
        }
        
        if (commonLength == childValue.length()) {
            // Continue with remaining part
            insertHelper(child, word, index + commonLength);
        } else {
            // Split the node
            CompressedTrieNode newChild = new CompressedTrieNode();
            newChild.value = childValue.substring(commonLength);
            newChild.children = child.children;
            newChild.isEndOfWord = child.isEndOfWord;
            
            child.children.clear();
            child.children.put(childValue.charAt(commonLength), newChild);
            child.value = childValue.substring(0, commonLength);
            child.isEndOfWord = (commonLength == word.length() - index);
            
            if (commonLength < word.length() - index) {
                insertHelper(child, word, index + commonLength);
            }
        }
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Dictionary Operations
- **Use Case:** Word validation, spell checkers
- **Key Insight:** Use trie for O(m) lookup where m = word length
- **Example Problems:** Implement Dictionary, Design Search Autocomplete

### Pattern 2: Prefix Matching
- **Use Case:** Search suggestions, IP routing
- **Key Insight:** All words with same prefix share path in trie
- **Example Problems:** Word Search II, Longest Common Prefix

### Pattern 3: Pattern Matching with Wildcards
- **Use Case:** Regular expression matching
- **Key Insight:** Use DFS with backtracking for wildcard characters
- **Example Problems:** Wildcard Matching, Add and Search Word

### Pattern 4: Multiple String Processing
- **Use Case:** Finding all occurrences of multiple patterns
- **Key Insight:** Build trie of patterns, then traverse text
- **Example Problems:** Stream of Characters, Multi-String Search

## 💻 Practice Problems

### Easy Level
1. **Implement Trie (LeetCode 208)**
   - Basic trie operations: insert, search, startsWith
   - Time: O(m), Space: O(ALPHABET_SIZE * N * M)

2. **Longest Common Prefix (LeetCode 14)**
   - Find longest common prefix among strings
   - Can be solved with trie or without

### Medium Level
3. **Add and Search Word (LeetCode 211)**
   - Support wildcard '.' in search
   - Use DFS with backtracking

4. **Word Search II (LeetCode 212)**
   - Find all words from dictionary in 2D board
   - Build trie from dictionary, DFS on board

5. **Design Search Autocomplete System (LeetCode 642)**
   - Implement autocomplete with ranking
   - Combine trie with sorting/heap

### Hard Level
6. **Stream of Characters (LeetCode 1032)**
   - Query stream for any dictionary word suffix
   - Build reverse trie, clever state management

7. **Word Squares (LeetCode 425)**
   - Build k×k grid where each row/column is valid word
   - Complex trie traversal with constraints

## 🧠 Problem-Solving Templates

### Template 1: Basic Trie Operations
```java
public class TrieSolution {
    class TrieNode {
        TrieNode[] children = new TrieNode[26];
        boolean isWord = false;
    }
    
    private TrieNode root = new TrieNode();
    
    public void insert(String word) {
        TrieNode node = root;
        for (char c : word.toCharArray()) {
            int i = c - 'a';
            if (node.children[i] == null) {
                node.children[i] = new TrieNode();
            }
            node = node.children[i];
        }
        node.isWord = true;
    }
    
    public boolean search(String word) {
        TrieNode node = find(word);
        return node != null && node.isWord;
    }
    
    public boolean startsWith(String prefix) {
        return find(prefix) != null;
    }
    
    private TrieNode find(String prefix) {
        TrieNode node = root;
        for (char c : prefix.toCharArray()) {
            int i = c - 'a';
            if (node.children[i] == null) return null;
            node = node.children[i];
        }
        return node;
    }
}
```

### Template 2: Trie with DFS Search
```java
public List<String> searchWithPattern(String pattern) {
    List<String> result = new ArrayList<>();
    dfs(root, pattern, 0, new StringBuilder(), result);
    return result;
}

private void dfs(TrieNode node, String pattern, int index, 
                StringBuilder path, List<String> result) {
    if (index == pattern.length()) {
        if (node.isWord) {
            result.add(path.toString());
        }
        return;
    }
    
    char c = pattern.charAt(index);
    if (c == '.') {
        // Wildcard: try all possible characters
        for (int i = 0; i < 26; i++) {
            if (node.children[i] != null) {
                path.append((char)('a' + i));
                dfs(node.children[i], pattern, index + 1, path, result);
                path.deleteCharAt(path.length() - 1);
            }
        }
    } else {
        // Regular character
        int i = c - 'a';
        if (node.children[i] != null) {
            path.append(c);
            dfs(node.children[i], pattern, index + 1, path, result);
            path.deleteCharAt(path.length() - 1);
        }
    }
}
```

## ⚡ Optimization Techniques

### 1. Memory Optimization
- **Array vs HashMap:** Use arrays for small alphabets, HashMap for large/unknown sets
- **Bit manipulation:** Use bitsets for multiple boolean flags
- **Path compression:** Implement compressed tries for sparse data

### 2. Performance Optimization
- **Early termination:** Stop search when no valid continuations exist
- **Pruning:** Remove nodes that don't lead to valid words
- **Caching:** Store frequently accessed results

### 3. Space-Time Tradeoffs
- **Suffix arrays vs Tries:** For very large datasets
- **Lazy initialization:** Create nodes only when needed
- **Memory pools:** Reuse node objects

## 📈 Complexity Analysis

### Time Complexities
- **Insert:** O(m) where m = length of word
- **Search:** O(m) where m = length of word/prefix
- **Delete:** O(m) with potential cleanup
- **Space:** O(ALPHABET_SIZE × N × M) worst case

### Space Optimizations
- **Compressed Trie:** Reduces space for sparse tries
- **Ternary Search Trie:** Better than standard trie for most datasets
- **Suffix Trees:** For advanced string processing

## 🎯 Key Takeaways

1. **When to Use Tries:**
   - Multiple string searches with common prefixes
   - Auto-complete and suggestion systems
   - Dictionary operations
   - Pattern matching with wildcards

2. **Common Pitfalls:**
   - Memory usage can be very high
   - Not suitable for single string operations
   - Cache performance may be poor due to pointer chasing

3. **Best Practices:**
   - Consider space requirements before implementation
   - Use appropriate alphabet size
   - Implement iterative versions for deep tries
   - Add proper cleanup for dynamic tries

## 🚀 Next Steps
- Practice the provided problems systematically
- Implement both array-based and HashMap-based tries
- Study advanced applications like suffix trees
- Move to **Module 12: Union-Find** for disjoint set operations

---
*Time to master tries! Start with the basic implementation and gradually work through the patterns. Tries are powerful tools for string processing - understanding them opens up many optimization opportunities.*
