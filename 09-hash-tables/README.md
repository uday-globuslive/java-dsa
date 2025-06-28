# Module 9: Hash Tables and Hash Maps

## Learning Objectives
By the end of this module, you will:
- Understand hash table concepts: hash functions, collisions, load factor
- Master HashMap operations and implementation details
- Solve problems using hash-based data structures
- Handle collision resolution techniques
- Apply hashing patterns to optimize algorithms

## Module Content

### 9.1 Hash Table Fundamentals

#### Hash Table Concepts
```java
/*
Hash Table Properties:
1. Key-Value Storage: Maps keys to values using hash function
2. Average O(1) operations: insert, delete, search
3. Hash Function: Converts key to array index
4. Collision Handling: Multiple keys map to same index
5. Load Factor: ratio of filled slots to total slots

Hash Function Requirements:
- Deterministic: Same key always produces same hash
- Uniform Distribution: Spreads keys evenly
- Fast Computation: Quick to calculate

Collision Resolution:
1. Chaining: Store multiple items in same slot (linked list)
2. Open Addressing: Find next available slot
   - Linear Probing: Check next slot
   - Quadratic Probing: Check i^2 slots away
   - Double Hashing: Use second hash function
*/
```

#### Simple Hash Table Implementation
```java
import java.util.*;

public class SimpleHashTable<K, V> {
    private static class HashEntry<K, V> {
        K key;
        V value;
        HashEntry<K, V> next;
        
        HashEntry(K key, V value) {
            this.key = key;
            this.value = value;
        }
    }
    
    private HashEntry<K, V>[] table;
    private int capacity;
    private int size;
    private static final double LOAD_FACTOR_THRESHOLD = 0.75;
    
    @SuppressWarnings("unchecked")
    public SimpleHashTable(int capacity) {
        this.capacity = capacity;
        this.table = new HashEntry[capacity];
        this.size = 0;
    }
    
    public SimpleHashTable() {
        this(16); // Default capacity
    }
    
    // Hash function
    private int hash(K key) {
        return Math.abs(key.hashCode() % capacity);
    }
    
    // Put key-value pair
    public void put(K key, V value) {
        if (key == null) return;
        
        if ((double) size / capacity >= LOAD_FACTOR_THRESHOLD) {
            resize();
        }
        
        int index = hash(key);
        HashEntry<K, V> entry = table[index];
        
        // Check if key already exists
        while (entry != null) {
            if (entry.key.equals(key)) {
                entry.value = value; // Update existing
                return;
            }
            entry = entry.next;
        }
        
        // Add new entry at beginning of chain
        HashEntry<K, V> newEntry = new HashEntry<>(key, value);
        newEntry.next = table[index];
        table[index] = newEntry;
        size++;
    }
    
    // Get value by key
    public V get(K key) {
        if (key == null) return null;
        
        int index = hash(key);
        HashEntry<K, V> entry = table[index];
        
        while (entry != null) {
            if (entry.key.equals(key)) {
                return entry.value;
            }
            entry = entry.next;
        }
        
        return null; // Key not found
    }
    
    // Remove key-value pair
    public V remove(K key) {
        if (key == null) return null;
        
        int index = hash(key);
        HashEntry<K, V> entry = table[index];
        HashEntry<K, V> prev = null;
        
        while (entry != null) {
            if (entry.key.equals(key)) {
                if (prev == null) {
                    table[index] = entry.next; // Remove first in chain
                } else {
                    prev.next = entry.next; // Remove from middle/end
                }
                size--;
                return entry.value;
            }
            prev = entry;
            entry = entry.next;
        }
        
        return null; // Key not found
    }
    
    // Check if key exists
    public boolean containsKey(K key) {
        return get(key) != null;
    }
    
    // Resize when load factor exceeds threshold
    @SuppressWarnings("unchecked")
    private void resize() {
        HashEntry<K, V>[] oldTable = table;
        capacity *= 2;
        table = new HashEntry[capacity];
        size = 0;
        
        // Rehash all entries
        for (HashEntry<K, V> head : oldTable) {
            while (head != null) {
                put(head.key, head.value);
                head = head.next;
            }
        }
    }
    
    public int size() { return size; }
    public boolean isEmpty() { return size == 0; }
    
    // Get all keys
    public Set<K> keySet() {
        Set<K> keys = new HashSet<>();
        for (HashEntry<K, V> head : table) {
            while (head != null) {
                keys.add(head.key);
                head = head.next;
            }
        }
        return keys;
    }
}
```

### 9.2 Java HashMap Deep Dive

#### HashMap Internal Working
```java
import java.util.*;

public class HashMapDemo {
    public static void main(String[] args) {
        /*
        HashMap Internal Structure (Java 8+):
        1. Array of Node/TreeNode (buckets)
        2. Default capacity: 16
        3. Load factor: 0.75
        4. Collision handling: Chaining with linked list
        5. Tree conversion: When chain length > 8 (becomes Red-Black tree)
        6. Hash function: key.hashCode() ^ (h >>> 16)
        */
        
        Map<String, Integer> map = new HashMap<>();
        
        // Basic operations
        map.put("Alice", 25);
        map.put("Bob", 30);
        map.put("Charlie", 35);
        
        System.out.println(map.get("Alice")); // 25
        System.out.println(map.getOrDefault("David", 0)); // 0
        
        // Iteration methods
        System.out.println("Keys: " + map.keySet());
        System.out.println("Values: " + map.values());
        System.out.println("Entries: " + map.entrySet());
        
        // Java 8+ forEach
        map.forEach((key, value) -> System.out.println(key + ": " + value));
        
        // Compute methods
        map.compute("Alice", (key, val) -> val + 1); // Alice: 26
        map.computeIfAbsent("David", key -> 40); // Add David: 40
        map.computeIfPresent("Bob", (key, val) -> val * 2); // Bob: 60
        
        // Merge method
        map.merge("Alice", 5, Integer::sum); // Alice: 31 (26 + 5)
        
        System.out.println(map);
    }
}
```

#### HashMap Performance Analysis
```java
public class HashMapPerformance {
    
    // Demonstrate hash collision impact
    public static void demonstrateCollisions() {
        // Custom class with poor hash function
        class BadHash {
            int value;
            BadHash(int value) { this.value = value; }
            
            @Override
            public int hashCode() {
                return 1; // All objects have same hash - terrible!
            }
            
            @Override
            public boolean equals(Object obj) {
                if (this == obj) return true;
                if (obj == null || getClass() != obj.getClass()) return false;
                BadHash badHash = (BadHash) obj;
                return value == badHash.value;
            }
        }
        
        Map<BadHash, String> badMap = new HashMap<>();
        long start = System.nanoTime();
        
        // Insert 1000 elements - all will go to same bucket!
        for (int i = 0; i < 1000; i++) {
            badMap.put(new BadHash(i), "Value" + i);
        }
        
        long insertTime = System.nanoTime() - start;
        
        start = System.nanoTime();
        // Search for element - will require O(n) time
        badMap.get(new BadHash(500));
        long searchTime = System.nanoTime() - start;
        
        System.out.println("Bad hash insert time: " + insertTime + " ns");
        System.out.println("Bad hash search time: " + searchTime + " ns");
        
        // Compare with good hash
        Map<Integer, String> goodMap = new HashMap<>();
        start = System.nanoTime();
        
        for (int i = 0; i < 1000; i++) {
            goodMap.put(i, "Value" + i);
        }
        
        insertTime = System.nanoTime() - start;
        
        start = System.nanoTime();
        goodMap.get(500);
        searchTime = System.nanoTime() - start;
        
        System.out.println("Good hash insert time: " + insertTime + " ns");
        System.out.println("Good hash search time: " + searchTime + " ns");
    }
}
```

### 9.3 Hash-based Problem Patterns

#### Pattern 1: Two Sum and Variants
```java
import java.util.*;

public class TwoSumProblems {
    
    // Two Sum - Return indices
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            map.put(nums[i], i);
        }
        
        return new int[]{}; // No solution
    }
    
    // Two Sum - Return values (sorted array)
    public int[] twoSumSorted(int[] nums, int target) {
        int left = 0, right = nums.length - 1;
        
        while (left < right) {
            int sum = nums[left] + nums[right];
            if (sum == target) {
                return new int[]{nums[left], nums[right]};
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        
        return new int[]{}; // No solution
    }
    
    // Three Sum - Find all unique triplets
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 2; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) continue; // Skip duplicates
            
            int left = i + 1, right = nums.length - 1;
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                if (sum == 0) {
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    
                    // Skip duplicates
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
    
    // Four Sum
    public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        
        for (int i = 0; i < nums.length - 3; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) continue;
            
            for (int j = i + 1; j < nums.length - 2; j++) {
                if (j > i + 1 && nums[j] == nums[j - 1]) continue;
                
                int left = j + 1, right = nums.length - 1;
                while (left < right) {
                    long sum = (long) nums[i] + nums[j] + nums[left] + nums[right];
                    if (sum == target) {
                        result.add(Arrays.asList(nums[i], nums[j], nums[left], nums[right]));
                        
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
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        TwoSumProblems tsp = new TwoSumProblems();
        
        int[] nums = {2, 7, 11, 15};
        System.out.println(Arrays.toString(tsp.twoSum(nums, 9))); // [0, 1]
        
        int[] nums3 = {-1, 0, 1, 2, -1, -4};
        System.out.println(tsp.threeSum(nums3)); // [[-1, -1, 2], [-1, 0, 1]]
    }
}
```

#### Pattern 2: Frequency Counting
```java
import java.util.*;

public class FrequencyProblems {
    
    // Group Anagrams
    public List<List<String>> groupAnagrams(String[] strs) {
        Map<String, List<String>> groups = new HashMap<>();
        
        for (String str : strs) {
            char[] chars = str.toCharArray();
            Arrays.sort(chars);
            String key = new String(chars);
            
            groups.computeIfAbsent(key, k -> new ArrayList<>()).add(str);
        }
        
        return new ArrayList<>(groups.values());
    }
    
    // Valid Anagram
    public boolean isAnagram(String s, String t) {
        if (s.length() != t.length()) return false;
        
        Map<Character, Integer> count = new HashMap<>();
        
        // Count characters in s
        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }
        
        // Decrease count for characters in t
        for (char c : t.toCharArray()) {
            if (!count.containsKey(c)) return false;
            count.put(c, count.get(c) - 1);
            if (count.get(c) == 0) {
                count.remove(c);
            }
        }
        
        return count.isEmpty();
    }
    
    // First Unique Character
    public int firstUniqChar(String s) {
        Map<Character, Integer> count = new HashMap<>();
        
        // Count frequencies
        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }
        
        // Find first unique
        for (int i = 0; i < s.length(); i++) {
            if (count.get(s.charAt(i)) == 1) {
                return i;
            }
        }
        
        return -1;
    }
    
    // Longest Substring Without Repeating Characters
    public int lengthOfLongestSubstring(String s) {
        Map<Character, Integer> seen = new HashMap<>();
        int left = 0, maxLength = 0;
        
        for (int right = 0; right < s.length(); right++) {
            char c = s.charAt(right);
            
            if (seen.containsKey(c) && seen.get(c) >= left) {
                left = seen.get(c) + 1;
            }
            
            seen.put(c, right);
            maxLength = Math.max(maxLength, right - left + 1);
        }
        
        return maxLength;
    }
    
    public static void main(String[] args) {
        FrequencyProblems fp = new FrequencyProblems();
        
        String[] strs = {"eat", "tea", "tan", "ate", "nat", "bat"};
        System.out.println(fp.groupAnagrams(strs));
        
        System.out.println(fp.isAnagram("anagram", "nagaram")); // true
        System.out.println(fp.firstUniqChar("leetcode")); // 0
        System.out.println(fp.lengthOfLongestSubstring("abcabcbb")); // 3
    }
}
```

#### Pattern 3: Subarray Problems
```java
import java.util.*;

public class SubarrayProblems {
    
    // Subarray Sum Equals K
    public int subarraySum(int[] nums, int k) {
        Map<Integer, Integer> prefixSumCount = new HashMap<>();
        prefixSumCount.put(0, 1); // Empty prefix
        
        int prefixSum = 0, count = 0;
        
        for (int num : nums) {
            prefixSum += num;
            
            // Check if (prefixSum - k) exists
            if (prefixSumCount.containsKey(prefixSum - k)) {
                count += prefixSumCount.get(prefixSum - k);
            }
            
            prefixSumCount.put(prefixSum, prefixSumCount.getOrDefault(prefixSum, 0) + 1);
        }
        
        return count;
    }
    
    // Longest Subarray with Sum K
    public int longestSubarrayWithSumK(int[] nums, int k) {
        Map<Integer, Integer> prefixSumIndex = new HashMap<>();
        prefixSumIndex.put(0, -1); // Empty prefix at index -1
        
        int prefixSum = 0, maxLength = 0;
        
        for (int i = 0; i < nums.length; i++) {
            prefixSum += nums[i];
            
            if (prefixSumIndex.containsKey(prefixSum - k)) {
                maxLength = Math.max(maxLength, i - prefixSumIndex.get(prefixSum - k));
            }
            
            // Only store first occurrence for maximum length
            if (!prefixSumIndex.containsKey(prefixSum)) {
                prefixSumIndex.put(prefixSum, i);
            }
        }
        
        return maxLength;
    }
    
    // Contiguous Array (equal 0s and 1s)
    public int findMaxLength(int[] nums) {
        Map<Integer, Integer> sumIndex = new HashMap<>();
        sumIndex.put(0, -1);
        
        int sum = 0, maxLength = 0;
        
        for (int i = 0; i < nums.length; i++) {
            sum += (nums[i] == 1) ? 1 : -1;
            
            if (sumIndex.containsKey(sum)) {
                maxLength = Math.max(maxLength, i - sumIndex.get(sum));
            } else {
                sumIndex.put(sum, i);
            }
        }
        
        return maxLength;
    }
    
    public static void main(String[] args) {
        SubarrayProblems sp = new SubarrayProblems();
        
        int[] nums1 = {1, 1, 1};
        System.out.println(sp.subarraySum(nums1, 2)); // 2
        
        int[] nums2 = {1, -1, 0};
        System.out.println(sp.longestSubarrayWithSumK(nums2, 0)); // 2
        
        int[] nums3 = {0, 1, 0, 0, 1, 1, 0};
        System.out.println(sp.findMaxLength(nums3)); // 6
    }
}
```

### 9.4 Advanced Hash Applications

#### LRU Cache Implementation
```java
import java.util.*;

public class LRUCache {
    class Node {
        int key, value;
        Node prev, next;
        
        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }
    
    private Map<Integer, Node> cache;
    private Node head, tail;
    private int capacity;
    
    public LRUCache(int capacity) {
        this.capacity = capacity;
        this.cache = new HashMap<>();
        
        // Create dummy head and tail
        head = new Node(0, 0);
        tail = new Node(0, 0);
        head.next = tail;
        tail.prev = head;
    }
    
    public int get(int key) {
        Node node = cache.get(key);
        if (node == null) return -1;
        
        // Move to head (most recently used)
        moveToHead(node);
        return node.value;
    }
    
    public void put(int key, int value) {
        Node node = cache.get(key);
        
        if (node == null) {
            Node newNode = new Node(key, value);
            cache.put(key, newNode);
            addToHead(newNode);
            
            if (cache.size() > capacity) {
                Node tail = removeTail();
                cache.remove(tail.key);
            }
        } else {
            node.value = value;
            moveToHead(node);
        }
    }
    
    private void addToHead(Node node) {
        node.prev = head;
        node.next = head.next;
        head.next.prev = node;
        head.next = node;
    }
    
    private void removeNode(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
    
    private void moveToHead(Node node) {
        removeNode(node);
        addToHead(node);
    }
    
    private Node removeTail() {
        Node lastNode = tail.prev;
        removeNode(lastNode);
        return lastNode;
    }
}
```

## Practice Problems

### Easy Level
1. **Two Sum** - Find two numbers that add up to target
2. **Valid Anagram** - Check if two strings are anagrams
3. **First Unique Character** - Find first non-repeating character
4. **Intersection of Two Arrays** - Find common elements

### Medium Level
1. **Group Anagrams** - Group strings that are anagrams
2. **Subarray Sum Equals K** - Count subarrays with sum k
3. **Longest Substring Without Repeating Characters** - Find longest unique substring
4. **Four Sum II** - Count quadruplets with sum 0
5. **Copy List with Random Pointer** - Clone linked list with random pointers

### Hard Level
1. **LRU Cache** - Implement least recently used cache
2. **Design HashMap** - Implement hash map from scratch
3. **Alien Dictionary** - Find order of characters in alien language
4. **Substring with Concatenation of All Words** - Find substrings with word concatenations

## Key Patterns

1. **Complement Pattern**: Store complement for two sum problems
2. **Frequency Counting**: Count occurrences for anagram/frequency problems
3. **Prefix Sum**: Use for subarray sum problems
4. **Sliding Window + Hash**: For substring problems
5. **Index Mapping**: Store index for duplicate/distance problems

## Hash Function Design

### Good Hash Function Properties
```java
public class HashFunctionDemo {
    
    // Simple hash for strings
    public static int simpleStringHash(String s) {
        int hash = 0;
        for (int i = 0; i < s.length(); i++) {
            hash = hash * 31 + s.charAt(i);
        }
        return hash;
    }
    
    // Better string hash (Java's approach)
    public static int betterStringHash(String s) {
        int hash = 0;
        for (int i = 0; i < s.length(); i++) {
            hash = 31 * hash + s.charAt(i);
        }
        return hash;
    }
    
    // Hash for custom objects
    static class Person {
        String name;
        int age;
        
        Person(String name, int age) {
            this.name = name;
            this.age = age;
        }
        
        @Override
        public int hashCode() {
            return Objects.hash(name, age); // Java 7+ approach
        }
        
        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (obj == null || getClass() != obj.getClass()) return false;
            Person person = (Person) obj;
            return age == person.age && Objects.equals(name, person.name);
        }
    }
}
```

## Time/Space Complexity

| Operation | Average | Worst Case | Space |
|-----------|---------|------------|-------|
| Insert | O(1) | O(n) | O(n) |
| Delete | O(1) | O(n) | O(n) |
| Search | O(1) | O(n) | O(n) |
| Space | O(n) | O(n) | O(n) |

## Common Mistakes
1. Not overriding both hashCode() and equals()
2. Using mutable objects as keys
3. Poor hash function causing many collisions
4. Not handling null keys/values properly
5. Assuming O(1) operations are always fast

## Next Steps
- Implement hash table from scratch
- Practice hash-based problem patterns
- Study collision resolution techniques
- Move to **[Module 10: Graphs](../10-graphs/README.md)**
