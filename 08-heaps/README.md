# Module 8: Heaps and Priority Queues

## Learning Objectives
By the end of this module, you will:
- Understand heap data structure and heap properties
- Implement min-heap and max-heap from scratch
- Master heap operations: insert, extract, heapify
- Solve problems using heaps and priority queues
- Apply heap-based algorithms for optimization problems

## Module Content

### 8.1 Heap Fundamentals

#### What is a Heap?
```java
/*
Heap Properties:
1. Complete Binary Tree: All levels filled except possibly the last
2. Heap Property:
   - Min Heap: Parent ≤ Children
   - Max Heap: Parent ≥ Children

Array Representation:
- Parent of node i: (i-1)/2
- Left child of node i: 2*i + 1
- Right child of node i: 2*i + 2

Time Complexities:
- Insert: O(log n)
- Extract Min/Max: O(log n)
- Peek: O(1)
- Build Heap: O(n)
- Heapify: O(log n)
*/
```

#### Min Heap Implementation
```java
import java.util.*;

public class MinHeap {
    private ArrayList<Integer> heap;
    
    public MinHeap() {
        heap = new ArrayList<>();
    }
    
    public MinHeap(int[] array) {
        heap = new ArrayList<>();
        for (int val : array) {
            heap.add(val);
        }
        buildHeap();
    }
    
    // Build heap from array - O(n)
    private void buildHeap() {
        // Start from last non-leaf node and heapify down
        for (int i = parent(heap.size() - 1); i >= 0; i--) {
            heapifyDown(i);
        }
    }
    
    // Insert element - O(log n)
    public void insert(int value) {
        heap.add(value);
        heapifyUp(heap.size() - 1);
    }
    
    // Extract minimum - O(log n)
    public int extractMin() {
        if (isEmpty()) {
            throw new RuntimeException("Heap is empty");
        }
        
        int min = heap.get(0);
        int lastElement = heap.remove(heap.size() - 1);
        
        if (!isEmpty()) {
            heap.set(0, lastElement);
            heapifyDown(0);
        }
        
        return min;
    }
    
    // Peek minimum - O(1)
    public int peek() {
        if (isEmpty()) {
            throw new RuntimeException("Heap is empty");
        }
        return heap.get(0);
    }
    
    // Remove specific element - O(log n)
    public void remove(int value) {
        int index = heap.indexOf(value);
        if (index == -1) return;
        
        int lastElement = heap.remove(heap.size() - 1);
        
        if (index < heap.size()) {
            heap.set(index, lastElement);
            
            // Try both directions
            int parent = parent(index);
            if (parent >= 0 && heap.get(index) < heap.get(parent)) {
                heapifyUp(index);
            } else {
                heapifyDown(index);
            }
        }
    }
    
    // Update element - O(log n)
    public void update(int oldValue, int newValue) {
        int index = heap.indexOf(oldValue);
        if (index == -1) return;
        
        heap.set(index, newValue);
        
        int parent = parent(index);
        if (parent >= 0 && heap.get(index) < heap.get(parent)) {
            heapifyUp(index);
        } else {
            heapifyDown(index);
        }
    }
    
    // Heapify up (bubble up)
    private void heapifyUp(int index) {
        while (index > 0) {
            int parentIndex = parent(index);
            if (heap.get(index) >= heap.get(parentIndex)) {
                break;
            }
            swap(index, parentIndex);
            index = parentIndex;
        }
    }
    
    // Heapify down (bubble down)
    private void heapifyDown(int index) {
        while (leftChild(index) < heap.size()) {
            int smallerChildIndex = leftChild(index);
            
            // Find smaller child
            if (rightChild(index) < heap.size() && 
                heap.get(rightChild(index)) < heap.get(leftChild(index))) {
                smallerChildIndex = rightChild(index);
            }
            
            // If current element is smaller than both children, stop
            if (heap.get(index) <= heap.get(smallerChildIndex)) {
                break;
            }
            
            swap(index, smallerChildIndex);
            index = smallerChildIndex;
        }
    }
    
    // Utility methods
    private int parent(int index) { return (index - 1) / 2; }
    private int leftChild(int index) { return 2 * index + 1; }
    private int rightChild(int index) { return 2 * index + 2; }
    
    private void swap(int i, int j) {
        int temp = heap.get(i);
        heap.set(i, heap.get(j));
        heap.set(j, temp);
    }
    
    public boolean isEmpty() { return heap.isEmpty(); }
    public int size() { return heap.size(); }
    
    public void printHeap() {
        System.out.println(heap);
    }
}
```

#### Max Heap Implementation
```java
public class MaxHeap {
    private ArrayList<Integer> heap;
    
    public MaxHeap() {
        heap = new ArrayList<>();
    }
    
    public void insert(int value) {
        heap.add(value);
        heapifyUp(heap.size() - 1);
    }
    
    public int extractMax() {
        if (isEmpty()) {
            throw new RuntimeException("Heap is empty");
        }
        
        int max = heap.get(0);
        int lastElement = heap.remove(heap.size() - 1);
        
        if (!isEmpty()) {
            heap.set(0, lastElement);
            heapifyDown(0);
        }
        
        return max;
    }
    
    public int peek() {
        if (isEmpty()) {
            throw new RuntimeException("Heap is empty");
        }
        return heap.get(0);
    }
    
    private void heapifyUp(int index) {
        while (index > 0) {
            int parentIndex = (index - 1) / 2;
            if (heap.get(index) <= heap.get(parentIndex)) {
                break;
            }
            swap(index, parentIndex);
            index = parentIndex;
        }
    }
    
    private void heapifyDown(int index) {
        while (2 * index + 1 < heap.size()) {
            int largerChildIndex = 2 * index + 1;
            
            // Find larger child
            if (2 * index + 2 < heap.size() && 
                heap.get(2 * index + 2) > heap.get(2 * index + 1)) {
                largerChildIndex = 2 * index + 2;
            }
            
            // If current element is larger than both children, stop
            if (heap.get(index) >= heap.get(largerChildIndex)) {
                break;
            }
            
            swap(index, largerChildIndex);
            index = largerChildIndex;
        }
    }
    
    private void swap(int i, int j) {
        int temp = heap.get(i);
        heap.set(i, heap.get(j));
        heap.set(j, temp);
    }
    
    public boolean isEmpty() { return heap.isEmpty(); }
    public int size() { return heap.size(); }
}
```

### 8.2 Java PriorityQueue

#### Using Built-in PriorityQueue
```java
import java.util.*;

public class PriorityQueueDemo {
    public static void main(String[] args) {
        // Min heap (default)
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        minHeap.offer(10);
        minHeap.offer(5);
        minHeap.offer(15);
        
        System.out.println("Min heap: ");
        while (!minHeap.isEmpty()) {
            System.out.println(minHeap.poll()); // 5, 10, 15
        }
        
        // Max heap using custom comparator
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        maxHeap.offer(10);
        maxHeap.offer(5);
        maxHeap.offer(15);
        
        System.out.println("Max heap: ");
        while (!maxHeap.isEmpty()) {
            System.out.println(maxHeap.poll()); // 15, 10, 5
        }
        
        // Custom objects with comparator
        PriorityQueue<Student> studentHeap = new PriorityQueue<>((a, b) -> a.grade - b.grade);
        studentHeap.offer(new Student("Alice", 85));
        studentHeap.offer(new Student("Bob", 92));
        studentHeap.offer(new Student("Charlie", 78));
        
        while (!studentHeap.isEmpty()) {
            Student s = studentHeap.poll();
            System.out.println(s.name + ": " + s.grade);
        }
    }
}

class Student {
    String name;
    int grade;
    
    Student(String name, int grade) {
        this.name = name;
        this.grade = grade;
    }
}
```

### 8.3 Heap-based Algorithms

#### Heap Sort
```java
public class HeapSort {
    public void heapSort(int[] arr) {
        int n = arr.length;
        
        // Build max heap
        for (int i = n / 2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }
        
        // Extract elements one by one
        for (int i = n - 1; i > 0; i--) {
            // Move current root to end
            swap(arr, 0, i);
            
            // Heapify reduced heap
            heapify(arr, i, 0);
        }
    }
    
    private void heapify(int[] arr, int n, int i) {
        int largest = i;
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        
        // Find largest among root, left, and right
        if (left < n && arr[left] > arr[largest]) {
            largest = left;
        }
        
        if (right < n && arr[right] > arr[largest]) {
            largest = right;
        }
        
        // If largest is not root
        if (largest != i) {
            swap(arr, i, largest);
            heapify(arr, n, largest);
        }
    }
    
    private void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    
    public static void main(String[] args) {
        HeapSort hs = new HeapSort();
        int[] arr = {12, 11, 13, 5, 6, 7};
        
        System.out.println("Original array: " + Arrays.toString(arr));
        hs.heapSort(arr);
        System.out.println("Sorted array: " + Arrays.toString(arr));
    }
}
```

### 8.4 Classic Heap Problems

#### Problem: Top K Frequent Elements
```java
import java.util.*;

public class TopKFrequent {
    public int[] topKFrequent(int[] nums, int k) {
        // Count frequencies
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        
        // Use min heap to keep top k elements
        PriorityQueue<int[]> heap = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            heap.offer(new int[]{entry.getKey(), entry.getValue()});
            if (heap.size() > k) {
                heap.poll();
            }
        }
        
        // Extract result
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = heap.poll()[0];
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        TopKFrequent tkf = new TopKFrequent();
        int[] nums = {1, 1, 1, 2, 2, 3};
        int k = 2;
        System.out.println(Arrays.toString(tkf.topKFrequent(nums, k))); // [1, 2]
    }
}
```

#### Problem: Kth Largest Element
```java
import java.util.*;

public class KthLargest {
    
    // Using min heap - O(n log k)
    public int findKthLargest(int[] nums, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        
        for (int num : nums) {
            minHeap.offer(num);
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }
        
        return minHeap.peek();
    }
    
    // Using quickselect - O(n) average
    public int findKthLargestQuickSelect(int[] nums, int k) {
        return quickSelect(nums, 0, nums.length - 1, nums.length - k);
    }
    
    private int quickSelect(int[] nums, int left, int right, int kSmallest) {
        if (left == right) return nums[left];
        
        Random random = new Random();
        int pivotIndex = left + random.nextInt(right - left + 1);
        
        pivotIndex = partition(nums, left, right, pivotIndex);
        
        if (kSmallest == pivotIndex) {
            return nums[kSmallest];
        } else if (kSmallest < pivotIndex) {
            return quickSelect(nums, left, pivotIndex - 1, kSmallest);
        } else {
            return quickSelect(nums, pivotIndex + 1, right, kSmallest);
        }
    }
    
    private int partition(int[] nums, int left, int right, int pivotIndex) {
        int pivot = nums[pivotIndex];
        
        // Move pivot to end
        swap(nums, pivotIndex, right);
        
        int storeIndex = left;
        for (int i = left; i <= right; i++) {
            if (nums[i] < pivot) {
                swap(nums, storeIndex, i);
                storeIndex++;
            }
        }
        
        // Move pivot to final place
        swap(nums, storeIndex, right);
        return storeIndex;
    }
    
    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
    
    public static void main(String[] args) {
        KthLargest kl = new KthLargest();
        int[] nums = {3, 2, 1, 5, 6, 4};
        int k = 2;
        System.out.println(kl.findKthLargest(nums, k)); // 5
        System.out.println(kl.findKthLargestQuickSelect(nums, k)); // 5
    }
}
```

#### Problem: Merge K Sorted Lists
```java
import java.util.*;

class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

public class MergeKSortedLists {
    
    // Using min heap - O(n log k)
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        
        PriorityQueue<ListNode> heap = new PriorityQueue<>((a, b) -> a.val - b.val);
        
        // Add first node of each list to heap
        for (ListNode list : lists) {
            if (list != null) {
                heap.offer(list);
            }
        }
        
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (!heap.isEmpty()) {
            ListNode smallest = heap.poll();
            current.next = smallest;
            current = current.next;
            
            if (smallest.next != null) {
                heap.offer(smallest.next);
            }
        }
        
        return dummy.next;
    }
    
    // Using divide and conquer - O(n log k)
    public ListNode mergeKListsDivideConquer(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        
        while (lists.length > 1) {
            List<ListNode> mergedLists = new ArrayList<>();
            
            for (int i = 0; i < lists.length; i += 2) {
                ListNode l1 = lists[i];
                ListNode l2 = (i + 1 < lists.length) ? lists[i + 1] : null;
                mergedLists.add(mergeTwoLists(l1, l2));
            }
            
            lists = mergedLists.toArray(new ListNode[0]);
        }
        
        return lists[0];
    }
    
    private ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (l1 != null && l2 != null) {
            if (l1.val <= l2.val) {
                current.next = l1;
                l1 = l1.next;
            } else {
                current.next = l2;
                l2 = l2.next;
            }
            current = current.next;
        }
        
        current.next = (l1 != null) ? l1 : l2;
        return dummy.next;
    }
}
```

#### Problem: Sliding Window Median
```java
import java.util.*;

public class SlidingWindowMedian {
    
    public double[] medianSlidingWindow(int[] nums, int k) {
        double[] result = new double[nums.length - k + 1];
        
        // Max heap for smaller half
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        // Min heap for larger half
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        
        for (int i = 0; i < nums.length; i++) {
            // Remove element going out of window
            if (i >= k) {
                int outgoing = nums[i - k];
                if (outgoing <= maxHeap.peek()) {
                    maxHeap.remove(outgoing);
                } else {
                    minHeap.remove(outgoing);
                }
            }
            
            // Add new element
            if (maxHeap.isEmpty() || nums[i] <= maxHeap.peek()) {
                maxHeap.offer(nums[i]);
            } else {
                minHeap.offer(nums[i]);
            }
            
            // Balance heaps
            balanceHeaps(maxHeap, minHeap);
            
            // Calculate median
            if (i >= k - 1) {
                if (k % 2 == 1) {
                    result[i - k + 1] = maxHeap.peek();
                } else {
                    result[i - k + 1] = ((long) maxHeap.peek() + minHeap.peek()) / 2.0;
                }
            }
        }
        
        return result;
    }
    
    private void balanceHeaps(PriorityQueue<Integer> maxHeap, PriorityQueue<Integer> minHeap) {
        if (maxHeap.size() > minHeap.size() + 1) {
            minHeap.offer(maxHeap.poll());
        } else if (minHeap.size() > maxHeap.size()) {
            maxHeap.offer(minHeap.poll());
        }
    }
    
    public static void main(String[] args) {
        SlidingWindowMedian swm = new SlidingWindowMedian();
        int[] nums = {1, 3, -1, -3, 5, 3, 6, 7};
        int k = 3;
        double[] result = swm.medianSlidingWindow(nums, k);
        System.out.println(Arrays.toString(result)); // [1.0, -1.0, -1.0, 3.0, 5.0, 6.0]
    }
}
```

### 8.5 Advanced Heap Applications

#### Problem: Design Twitter (Using Heap)
```java
import java.util.*;

class Tweet {
    int id;
    int time;
    Tweet next;
    
    public Tweet(int id, int time) {
        this.id = id;
        this.time = time;
    }
}

class User {
    int id;
    Set<Integer> followed;
    Tweet tweetHead;
    
    public User(int id) {
        this.id = id;
        followed = new HashSet<>();
        follow(id); // Follow self
    }
    
    public void follow(int id) {
        followed.add(id);
    }
    
    public void unfollow(int id) {
        followed.remove(id);
    }
    
    public void post(int id, int time) {
        Tweet tweet = new Tweet(id, time);
        tweet.next = tweetHead;
        tweetHead = tweet;
    }
}

public class Twitter {
    private static int timeStamp = 0;
    private Map<Integer, User> userMap;
    
    public Twitter() {
        userMap = new HashMap<>();
    }
    
    public void postTweet(int userId, int tweetId) {
        if (!userMap.containsKey(userId)) {
            userMap.put(userId, new User(userId));
        }
        userMap.get(userId).post(tweetId, timeStamp++);
    }
    
    public List<Integer> getNewsFeed(int userId) {
        List<Integer> result = new ArrayList<>();
        
        if (!userMap.containsKey(userId)) return result;
        
        Set<Integer> users = userMap.get(userId).followed;
        PriorityQueue<Tweet> heap = new PriorityQueue<>((a, b) -> b.time - a.time);
        
        for (int user : users) {
            Tweet tweet = userMap.get(user).tweetHead;
            if (tweet != null) {
                heap.offer(tweet);
            }
        }
        
        int n = 0;
        while (!heap.isEmpty() && n < 10) {
            Tweet tweet = heap.poll();
            result.add(tweet.id);
            n++;
            if (tweet.next != null) {
                heap.offer(tweet.next);
            }
        }
        
        return result;
    }
    
    public void follow(int followerId, int followeeId) {
        if (!userMap.containsKey(followerId)) {
            userMap.put(followerId, new User(followerId));
        }
        if (!userMap.containsKey(followeeId)) {
            userMap.put(followeeId, new User(followeeId));
        }
        userMap.get(followerId).follow(followeeId);
    }
    
    public void unfollow(int followerId, int followeeId) {
        if (!userMap.containsKey(followerId) || followerId == followeeId) {
            return;
        }
        userMap.get(followerId).unfollow(followeeId);
    }
}
```

## Practice Problems

### Easy Level
1. **Last Stone Weight** - Simulate stone collision using max heap
2. **Kth Largest Element in Stream** - Design class to find kth largest
3. **Relative Ranks** - Assign ranks using heap

### Medium Level
1. **Top K Frequent Elements** - Find k most frequent elements
2. **Kth Largest Element in Array** - Find kth largest using heap/quickselect
3. **Task Scheduler** - Schedule tasks with cooldown using heap
4. **Find Median from Data Stream** - Maintain running median using two heaps
5. **Reorganize String** - Rearrange string using max heap

### Hard Level
1. **Merge k Sorted Lists** - Merge multiple sorted linked lists
2. **Sliding Window Maximum** - Find maximum in sliding windows
3. **Find Median from Data Stream** - Two heaps approach
4. **Skyline Problem** - Building skyline using heap
5. **IPO** - Maximize capital using two heaps

## Key Patterns

1. **Two Heaps**: For finding median or dividing data
2. **Top K Elements**: Use min heap of size k
3. **K-way Merge**: Use min heap to merge k sorted sequences
4. **Interval Problems**: Use heap to track intervals
5. **Scheduling**: Use heap for priority-based scheduling

## Time/Space Complexity

| Operation | Time | Space |
|-----------|------|-------|
| Insert | O(log n) | O(1) |
| Extract Min/Max | O(log n) | O(1) |
| Peek | O(1) | O(1) |
| Build Heap | O(n) | O(1) |
| Heap Sort | O(n log n) | O(1) |
| Delete | O(log n) | O(1) |

## Common Mistakes
1. Confusing min heap vs max heap behavior
2. Not handling empty heap cases
3. Using wrong comparator for custom objects
4. Inefficient removal of arbitrary elements
5. Not maintaining heap property after updates

## Next Steps
- Implement heap from scratch
- Practice with PriorityQueue
- Solve two-heap problems
- Move to **[Module 9: Hash Tables](../09-hash-tables/README.md)**
