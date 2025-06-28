# Module 3: Java Collections Framework

## Learning Objectives
By the end of this module, you will:
- Master the Java Collections Framework hierarchy
- Understand when to use different collection types
- Implement custom collections and comparators
- Optimize collection performance for different use cases

## Module Content

### 3.1 Collections Overview
```java
// Collections Hierarchy
Collection
├── List (ArrayList, LinkedList, Vector)
├── Set (HashSet, LinkedHashSet, TreeSet)
└── Queue (PriorityQueue, ArrayDeque)

Map (HashMap, LinkedHashMap, TreeMap, Hashtable)
```

### 3.2 Lists
```java
// ArrayList - Dynamic arrays
import java.util.*;

public class ArrayListDemo {
    public static void main(String[] args) {
        List<Integer> numbers = new ArrayList<>();
        
        // Adding elements
        numbers.add(10);
        numbers.add(20);
        numbers.add(1, 15); // Insert at index 1
        
        // Accessing elements
        System.out.println(numbers.get(0)); // 10
        
        // Iterating
        for (int num : numbers) {
            System.out.println(num);
        }
        
        // Using Iterator
        Iterator<Integer> it = numbers.iterator();
        while (it.hasNext()) {
            System.out.println(it.next());
        }
    }
}
```

```java
// LinkedList - Doubly linked list
import java.util.*;

public class LinkedListDemo {
    public static void main(String[] args) {
        LinkedList<String> list = new LinkedList<>();
        
        // Adding elements
        list.addFirst("First");
        list.addLast("Last");
        list.add(1, "Middle");
        
        // Queue operations
        list.offer("Queue Add");
        String first = list.poll(); // Remove and return first
        
        // Stack operations
        list.push("Stack Push");
        String top = list.pop(); // Remove and return last
        
        System.out.println(list);
    }
}
```

### 3.3 Sets
```java
// HashSet - No duplicates, no order
import java.util.*;

public class HashSetDemo {
    public static void main(String[] args) {
        Set<String> colors = new HashSet<>();
        colors.add("Red");
        colors.add("Blue");
        colors.add("Red"); // Duplicate - won't be added
        
        System.out.println(colors); // [Red, Blue] (order not guaranteed)
        
        // Checking membership
        if (colors.contains("Red")) {
            System.out.println("Red is present");
        }
    }
}
```

```java
// TreeSet - Sorted set
import java.util.*;

public class TreeSetDemo {
    public static void main(String[] args) {
        TreeSet<Integer> numbers = new TreeSet<>();
        numbers.add(30);
        numbers.add(10);
        numbers.add(20);
        
        System.out.println(numbers); // [10, 20, 30] - always sorted
        
        // Range operations
        System.out.println(numbers.headSet(20)); // [10]
        System.out.println(numbers.tailSet(20)); // [20, 30]
        System.out.println(numbers.subSet(10, 30)); // [10, 20]
    }
}
```

### 3.4 Maps
```java
// HashMap - Key-value pairs
import java.util.*;

public class HashMapDemo {
    public static void main(String[] args) {
        Map<String, Integer> scores = new HashMap<>();
        
        // Adding entries
        scores.put("Alice", 95);
        scores.put("Bob", 87);
        scores.put("Charlie", 92);
        
        // Accessing values
        Integer aliceScore = scores.get("Alice");
        Integer defaultScore = scores.getOrDefault("David", 0);
        
        // Iterating
        for (Map.Entry<String, Integer> entry : scores.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
        
        // Lambda iteration (Java 8+)
        scores.forEach((name, score) -> 
            System.out.println(name + ": " + score));
    }
}
```

```java
// TreeMap - Sorted map
import java.util.*;

public class TreeMapDemo {
    public static void main(String[] args) {
        TreeMap<String, Integer> sortedMap = new TreeMap<>();
        sortedMap.put("Zebra", 1);
        sortedMap.put("Apple", 2);
        sortedMap.put("Banana", 3);
        
        System.out.println(sortedMap); // {Apple=2, Banana=3, Zebra=1}
        
        // Navigation methods
        System.out.println(sortedMap.firstKey()); // Apple
        System.out.println(sortedMap.lastKey());  // Zebra
        System.out.println(sortedMap.lowerKey("Banana")); // Apple
        System.out.println(sortedMap.higherKey("Banana")); // Zebra
    }
}
```

### 3.5 Queues and Deques
```java
// PriorityQueue - Heap-based priority queue
import java.util.*;

public class PriorityQueueDemo {
    public static void main(String[] args) {
        // Min heap by default
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        minHeap.offer(30);
        minHeap.offer(10);
        minHeap.offer(20);
        
        while (!minHeap.isEmpty()) {
            System.out.println(minHeap.poll()); // 10, 20, 30
        }
        
        // Max heap using comparator
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        maxHeap.offer(30);
        maxHeap.offer(10);
        maxHeap.offer(20);
        
        while (!maxHeap.isEmpty()) {
            System.out.println(maxHeap.poll()); // 30, 20, 10
        }
    }
}
```

```java
// ArrayDeque - Double-ended queue
import java.util.*;

public class ArrayDequeDemo {
    public static void main(String[] args) {
        Deque<String> deque = new ArrayDeque<>();
        
        // Add to both ends
        deque.addFirst("First");
        deque.addLast("Last");
        
        // Use as stack
        deque.push("Top");
        String top = deque.pop();
        
        // Use as queue
        deque.offer("Queue Item");
        String first = deque.poll();
        
        System.out.println(deque);
    }
}
```

### 3.6 Custom Comparators
```java
// Sorting with custom comparators
import java.util.*;

class Student {
    String name;
    int grade;
    
    Student(String name, int grade) {
        this.name = name;
        this.grade = grade;
    }
    
    @Override
    public String toString() {
        return name + "(" + grade + ")";
    }
}

public class ComparatorDemo {
    public static void main(String[] args) {
        List<Student> students = Arrays.asList(
            new Student("Alice", 85),
            new Student("Bob", 92),
            new Student("Charlie", 78)
        );
        
        // Sort by grade (ascending)
        Collections.sort(students, (s1, s2) -> s1.grade - s2.grade);
        System.out.println("By grade: " + students);
        
        // Sort by name
        Collections.sort(students, (s1, s2) -> s1.name.compareTo(s2.name));
        System.out.println("By name: " + students);
        
        // Sort by grade (descending)
        students.sort(Comparator.comparingInt((Student s) -> s.grade).reversed());
        System.out.println("By grade desc: " + students);
    }
}
```

### 3.7 Performance Characteristics
```java
// Time complexity comparison
public class PerformanceDemo {
    public static void main(String[] args) {
        /*
        ArrayList:
        - get(i): O(1)
        - add(item): O(1) amortized
        - add(i, item): O(n)
        - remove(i): O(n)
        
        LinkedList:
        - get(i): O(n)
        - add(item): O(1)
        - add(i, item): O(n)
        - remove(i): O(n)
        
        HashSet/HashMap:
        - add/put: O(1) average
        - contains/get: O(1) average
        - remove: O(1) average
        
        TreeSet/TreeMap:
        - add/put: O(log n)
        - contains/get: O(log n)
        - remove: O(log n)
        */
        
        // Choose the right collection
        demonstratePerformance();
    }
    
    static void demonstratePerformance() {
        int n = 100000;
        
        // ArrayList vs LinkedList for random access
        List<Integer> arrayList = new ArrayList<>();
        List<Integer> linkedList = new LinkedList<>();
        
        // Fill both lists
        for (int i = 0; i < n; i++) {
            arrayList.add(i);
            linkedList.add(i);
        }
        
        // Random access test
        long start = System.nanoTime();
        for (int i = 0; i < 1000; i++) {
            arrayList.get(n/2);
        }
        long arrayTime = System.nanoTime() - start;
        
        start = System.nanoTime();
        for (int i = 0; i < 1000; i++) {
            linkedList.get(n/2);
        }
        long linkedTime = System.nanoTime() - start;
        
        System.out.println("ArrayList random access: " + arrayTime + " ns");
        System.out.println("LinkedList random access: " + linkedTime + " ns");
    }
}
```

## Practice Problems

### Problem 1: Design a LRU Cache
```java
// Implement an LRU (Least Recently Used) cache
import java.util.*;

class LRUCache {
    private int capacity;
    private Map<Integer, Node> cache;
    private Node head, tail;
    
    class Node {
        int key, value;
        Node prev, next;
        
        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }
    
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

### Problem 2: Design Twitter Feed
```java
// Design a simplified Twitter feed system
import java.util.*;

class TwitterFeed {
    private Map<Integer, Set<Integer>> followers;
    private Map<Integer, List<Tweet>> userTweets;
    private int timestamp;
    
    class Tweet {
        int tweetId;
        int time;
        
        Tweet(int tweetId, int time) {
            this.tweetId = tweetId;
            this.time = time;
        }
    }
    
    public TwitterFeed() {
        followers = new HashMap<>();
        userTweets = new HashMap<>();
        timestamp = 0;
    }
    
    public void postTweet(int userId, int tweetId) {
        userTweets.computeIfAbsent(userId, k -> new ArrayList<>())
                  .add(new Tweet(tweetId, timestamp++));
    }
    
    public List<Integer> getNewsFeed(int userId) {
        PriorityQueue<Tweet> heap = new PriorityQueue<>((a, b) -> b.time - a.time);
        
        // Add user's own tweets
        if (userTweets.containsKey(userId)) {
            for (Tweet tweet : userTweets.get(userId)) {
                heap.offer(tweet);
            }
        }
        
        // Add followed users' tweets
        if (followers.containsKey(userId)) {
            for (int followeeId : followers.get(userId)) {
                if (userTweets.containsKey(followeeId)) {
                    for (Tweet tweet : userTweets.get(followeeId)) {
                        heap.offer(tweet);
                    }
                }
            }
        }
        
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < 10 && !heap.isEmpty(); i++) {
            result.add(heap.poll().tweetId);
        }
        
        return result;
    }
    
    public void follow(int followerId, int followeeId) {
        if (followerId != followeeId) {
            followers.computeIfAbsent(followerId, k -> new HashSet<>()).add(followeeId);
        }
    }
    
    public void unfollow(int followerId, int followeeId) {
        if (followers.containsKey(followerId)) {
            followers.get(followerId).remove(followeeId);
        }
    }
}
```

### Problem 3: Group Anagrams
```java
// Group strings that are anagrams of each other
import java.util.*;

public class GroupAnagrams {
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
    
    public static void main(String[] args) {
        GroupAnagrams ga = new GroupAnagrams();
        String[] strs = {"eat", "tea", "tan", "ate", "nat", "bat"};
        System.out.println(ga.groupAnagrams(strs));
        // Output: [[eat, tea, ate], [tan, nat], [bat]]
    }
}
```

## Key Takeaways

1. **Choose the right collection**: Consider time complexity and use case
2. **ArrayList vs LinkedList**: ArrayList for random access, LinkedList for frequent insertions/deletions
3. **HashMap vs TreeMap**: HashMap for O(1) operations, TreeMap for sorted keys
4. **HashSet vs TreeSet**: HashSet for O(1) operations, TreeSet for sorted elements
5. **Use generics**: Always specify type parameters for type safety
6. **Understand iterators**: Use enhanced for-loops or streams when possible
7. **Custom comparators**: Essential for sorting custom objects

## Next Steps
- Complete the practice problems
- Experiment with different collection types
- Measure performance differences
- Move to **[Module 4: Arrays and Strings](../04-arrays-strings/README.md)**

## Quick Reference
```java
// Common operations cheat sheet
List<String> list = new ArrayList<>();    // Dynamic array
Set<String> set = new HashSet<>();        // No duplicates
Map<String, Integer> map = new HashMap<>(); // Key-value pairs
Queue<Integer> queue = new PriorityQueue<>(); // Min heap
Deque<String> deque = new ArrayDeque<>();  // Double-ended queue
```
