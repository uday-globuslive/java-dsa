# Module 5: Linked Lists

## 🎯 Learning Objectives
- Master linked list data structure implementations
- Learn various types of linked lists and their use cases
- Develop skills for pointer manipulation and edge case handling
- Solve classic linked list problems efficiently
- Understand when to use linked lists vs arrays

## 📚 Linked List Fundamentals

### 5.1 Introduction to Linked Lists

#### What is a Linked List?
A linked list is a linear data structure where elements (nodes) are stored in sequence, but not in contiguous memory locations. Each node contains data and a reference (pointer) to the next node.

#### Advantages and Disadvantages
```java
/*
Advantages:
✓ Dynamic size - can grow/shrink during runtime
✓ Efficient insertion/deletion at beginning - O(1)
✓ Memory efficient - allocates only needed memory
✓ No memory waste (unlike arrays with fixed size)

Disadvantages:
✗ No random access - must traverse from head - O(n)
✗ Extra memory for storing pointers
✗ Not cache-friendly due to non-contiguous memory
✗ No backward traversal (in singly linked list)
*/
```

### 5.2 Singly Linked List Implementation

#### Node Definition and Basic Structure
```java
// Node class for singly linked list
class ListNode {
    int val;
    ListNode next;
    
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }
}

// Singly Linked List implementation
public class SinglyLinkedList {
    private ListNode head;
    private int size;
    
    public SinglyLinkedList() {
        this.head = null;
        this.size = 0;
    }
    
    // Get size of the list
    public int size() {
        return size;
    }
    
    // Check if list is empty
    public boolean isEmpty() {
        return head == null;
    }
    
    // Insert at the beginning - O(1)
    public void addFirst(int val) {
        ListNode newNode = new ListNode(val);
        newNode.next = head;
        head = newNode;
        size++;
    }
    
    // Insert at the end - O(n)
    public void addLast(int val) {
        ListNode newNode = new ListNode(val);
        
        if (head == null) {
            head = newNode;
        } else {
            ListNode current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        size++;
    }
    
    // Insert at specific index - O(n)
    public void add(int index, int val) {
        if (index < 0 || index > size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }
        
        if (index == 0) {
            addFirst(val);
            return;
        }
        
        ListNode newNode = new ListNode(val);
        ListNode current = head;
        
        for (int i = 0; i < index - 1; i++) {
            current = current.next;
        }
        
        newNode.next = current.next;
        current.next = newNode;
        size++;
    }
    
    // Remove first element - O(1)
    public int removeFirst() {
        if (head == null) {
            throw new NoSuchElementException("List is empty");
        }
        
        int removedValue = head.val;
        head = head.next;
        size--;
        return removedValue;
    }
    
    // Remove last element - O(n)
    public int removeLast() {
        if (head == null) {
            throw new NoSuchElementException("List is empty");
        }
        
        if (head.next == null) {
            int removedValue = head.val;
            head = null;
            size--;
            return removedValue;
        }
        
        ListNode current = head;
        while (current.next.next != null) {
            current = current.next;
        }
        
        int removedValue = current.next.val;
        current.next = null;
        size--;
        return removedValue;
    }
    
    // Remove at specific index - O(n)
    public int remove(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }
        
        if (index == 0) {
            return removeFirst();
        }
        
        ListNode current = head;
        for (int i = 0; i < index - 1; i++) {
            current = current.next;
        }
        
        int removedValue = current.next.val;
        current.next = current.next.next;
        size--;
        return removedValue;
    }
    
    // Get element at index - O(n)
    public int get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }
        
        ListNode current = head;
        for (int i = 0; i < index; i++) {
            current = current.next;
        }
        return current.val;
    }
    
    // Find first occurrence of value - O(n)
    public int indexOf(int val) {
        ListNode current = head;
        int index = 0;
        
        while (current != null) {
            if (current.val == val) {
                return index;
            }
            current = current.next;
            index++;
        }
        return -1; // Not found
    }
    
    // Check if list contains value - O(n)
    public boolean contains(int val) {
        return indexOf(val) != -1;
    }
    
    // Display the list
    public void display() {
        ListNode current = head;
        System.out.print("[");
        while (current != null) {
            System.out.print(current.val);
            if (current.next != null) {
                System.out.print(" -> ");
            }
            current = current.next;
        }
        System.out.println("]");
    }
    
    // Convert to array
    public int[] toArray() {
        int[] arr = new int[size];
        ListNode current = head;
        int index = 0;
        
        while (current != null) {
            arr[index++] = current.val;
            current = current.next;
        }
        return arr;
    }
}
```

### 5.3 Doubly Linked List Implementation

#### Doubly Linked List Node and Implementation
```java
// Node class for doubly linked list
class DoublyListNode {
    int val;
    DoublyListNode prev;
    DoublyListNode next;
    
    DoublyListNode() {}
    DoublyListNode(int val) { this.val = val; }
    DoublyListNode(int val, DoublyListNode prev, DoublyListNode next) {
        this.val = val;
        this.prev = prev;
        this.next = next;
    }
}

// Doubly Linked List implementation
public class DoublyLinkedList {
    private DoublyListNode head;
    private DoublyListNode tail;
    private int size;
    
    public DoublyLinkedList() {
        this.head = null;
        this.tail = null;
        this.size = 0;
    }
    
    // Insert at the beginning - O(1)
    public void addFirst(int val) {
        DoublyListNode newNode = new DoublyListNode(val);
        
        if (head == null) {
            head = tail = newNode;
        } else {
            newNode.next = head;
            head.prev = newNode;
            head = newNode;
        }
        size++;
    }
    
    // Insert at the end - O(1)
    public void addLast(int val) {
        DoublyListNode newNode = new DoublyListNode(val);
        
        if (tail == null) {
            head = tail = newNode;
        } else {
            tail.next = newNode;
            newNode.prev = tail;
            tail = newNode;
        }
        size++;
    }
    
    // Remove first element - O(1)
    public int removeFirst() {
        if (head == null) {
            throw new NoSuchElementException("List is empty");
        }
        
        int removedValue = head.val;
        
        if (head == tail) { // Only one element
            head = tail = null;
        } else {
            head = head.next;
            head.prev = null;
        }
        
        size--;
        return removedValue;
    }
    
    // Remove last element - O(1)
    public int removeLast() {
        if (tail == null) {
            throw new NoSuchElementException("List is empty");
        }
        
        int removedValue = tail.val;
        
        if (head == tail) { // Only one element
            head = tail = null;
        } else {
            tail = tail.prev;
            tail.next = null;
        }
        
        size--;
        return removedValue;
    }
    
    // Display forward
    public void displayForward() {
        DoublyListNode current = head;
        System.out.print("Forward: [");
        while (current != null) {
            System.out.print(current.val);
            if (current.next != null) {
                System.out.print(" <-> ");
            }
            current = current.next;
        }
        System.out.println("]");
    }
    
    // Display backward
    public void displayBackward() {
        DoublyListNode current = tail;
        System.out.print("Backward: [");
        while (current != null) {
            System.out.print(current.val);
            if (current.prev != null) {
                System.out.print(" <-> ");
            }
            current = current.prev;
        }
        System.out.println("]");
    }
}
```

### 5.4 Classic Linked List Problems

#### Problem 1: Reverse a Linked List
```java
public class LinkedListReversal {
    
    // Iterative approach - O(n) time, O(1) space
    public ListNode reverseListIterative(ListNode head) {
        ListNode prev = null;
        ListNode current = head;
        
        while (current != null) {
            ListNode nextTemp = current.next;
            current.next = prev;
            prev = current;
            current = nextTemp;
        }
        
        return prev; // New head
    }
    
    // Recursive approach - O(n) time, O(n) space
    public ListNode reverseListRecursive(ListNode head) {
        // Base case
        if (head == null || head.next == null) {
            return head;
        }
        
        // Recursively reverse the rest
        ListNode newHead = reverseListRecursive(head.next);
        
        // Reverse the current connection
        head.next.next = head;
        head.next = null;
        
        return newHead;
    }
    
    // Reverse between positions m and n
    public ListNode reverseBetween(ListNode head, int left, int right) {
        if (head == null || left == right) return head;
        
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        
        // Move to position before left
        for (int i = 0; i < left - 1; i++) {
            prev = prev.next;
        }
        
        ListNode current = prev.next;
        
        // Reverse the sublist
        for (int i = 0; i < right - left; i++) {
            ListNode nextNode = current.next;
            current.next = nextNode.next;
            nextNode.next = prev.next;
            prev.next = nextNode;
        }
        
        return dummy.next;
    }
}
```

#### Problem 2: Detecting Cycles
```java
public class CycleDetection {
    
    // Floyd's Cycle Detection (Tortoise and Hare) - O(n) time, O(1) space
    public boolean hasCycle(ListNode head) {
        if (head == null || head.next == null) {
            return false;
        }
        
        ListNode slow = head;
        ListNode fast = head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;        // Move one step
            fast = fast.next.next;   // Move two steps
            
            if (slow == fast) {
                return true; // Cycle detected
            }
        }
        
        return false; // No cycle
    }
    
    // Find the start of the cycle
    public ListNode detectCycle(ListNode head) {
        if (head == null || head.next == null) {
            return null;
        }
        
        // Phase 1: Detect if cycle exists
        ListNode slow = head;
        ListNode fast = head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            
            if (slow == fast) {
                break; // Cycle found
            }
        }
        
        // No cycle found
        if (fast == null || fast.next == null) {
            return null;
        }
        
        // Phase 2: Find cycle start
        slow = head;
        while (slow != fast) {
            slow = slow.next;
            fast = fast.next;
        }
        
        return slow; // Start of cycle
    }
    
    // Find cycle length
    public int cycleLength(ListNode head) {
        if (!hasCycle(head)) return 0;
        
        ListNode slow = head;
        ListNode fast = head;
        
        // Find meeting point
        do {
            slow = slow.next;
            fast = fast.next.next;
        } while (slow != fast);
        
        // Count cycle length
        int length = 1;
        fast = fast.next;
        while (slow != fast) {
            fast = fast.next;
            length++;
        }
        
        return length;
    }
}
```

#### Problem 3: Finding Middle and Nth Nodes
```java
public class LinkedListNavigation {
    
    // Find middle node - O(n) time, O(1) space
    public ListNode findMiddle(ListNode head) {
        if (head == null) return null;
        
        ListNode slow = head;
        ListNode fast = head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        
        return slow; // Middle node
    }
    
    // Find nth node from end - O(n) time, O(1) space
    public ListNode findNthFromEnd(ListNode head, int n) {
        if (head == null || n <= 0) return null;
        
        ListNode first = head;
        ListNode second = head;
        
        // Move first pointer n steps ahead
        for (int i = 0; i < n; i++) {
            if (first == null) return null; // n is larger than list length
            first = first.next;
        }
        
        // Move both pointers until first reaches end
        while (first != null) {
            first = first.next;
            second = second.next;
        }
        
        return second;
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
    
    // Check if linked list is palindrome
    public boolean isPalindrome(ListNode head) {
        if (head == null || head.next == null) return true;
        
        // Find middle
        ListNode slow = head;
        ListNode fast = head;
        
        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        
        // Reverse second half
        ListNode secondHalf = reverseList(slow.next);
        
        // Compare first and second half
        ListNode firstHalf = head;
        while (secondHalf != null) {
            if (firstHalf.val != secondHalf.val) {
                return false;
            }
            firstHalf = firstHalf.next;
            secondHalf = secondHalf.next;
        }
        
        return true;
    }
    
    private ListNode reverseList(ListNode head) {
        ListNode prev = null;
        while (head != null) {
            ListNode next = head.next;
            head.next = prev;
            prev = head;
            head = next;
        }
        return prev;
    }
}
```

#### Problem 4: Merging and Intersection
```java
public class LinkedListMerging {
    
    // Merge two sorted linked lists
    public ListNode mergeTwoLists(ListNode list1, ListNode list2) {
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (list1 != null && list2 != null) {
            if (list1.val <= list2.val) {
                current.next = list1;
                list1 = list1.next;
            } else {
                current.next = list2;
                list2 = list2.next;
            }
            current = current.next;
        }
        
        // Attach remaining nodes
        current.next = (list1 != null) ? list1 : list2;
        
        return dummy.next;
    }
    
    // Merge k sorted linked lists
    public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        
        // Use priority queue for efficient merging
        PriorityQueue<ListNode> pq = new PriorityQueue<>((a, b) -> a.val - b.val);
        
        // Add all list heads to priority queue
        for (ListNode list : lists) {
            if (list != null) {
                pq.offer(list);
            }
        }
        
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        
        while (!pq.isEmpty()) {
            ListNode node = pq.poll();
            current.next = node;
            current = current.next;
            
            if (node.next != null) {
                pq.offer(node.next);
            }
        }
        
        return dummy.next;
    }
    
    // Find intersection of two linked lists
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if (headA == null || headB == null) return null;
        
        ListNode pointerA = headA;
        ListNode pointerB = headB;
        
        // When one pointer reaches end, redirect to other list's head
        while (pointerA != pointerB) {
            pointerA = (pointerA == null) ? headB : pointerA.next;
            pointerB = (pointerB == null) ? headA : pointerB.next;
        }
        
        return pointerA; // Intersection node (or null if no intersection)
    }
    
    // Alternative approach using lengths
    public ListNode getIntersectionNodeV2(ListNode headA, ListNode headB) {
        int lenA = getLength(headA);
        int lenB = getLength(headB);
        
        // Align the starting points
        while (lenA > lenB) {
            headA = headA.next;
            lenA--;
        }
        while (lenB > lenA) {
            headB = headB.next;
            lenB--;
        }
        
        // Find intersection
        while (headA != null && headB != null) {
            if (headA == headB) {
                return headA;
            }
            headA = headA.next;
            headB = headB.next;
        }
        
        return null;
    }
    
    private int getLength(ListNode head) {
        int length = 0;
        while (head != null) {
            length++;
            head = head.next;
        }
        return length;
    }
}
```

### 5.5 Advanced Linked List Problems

#### Problem 5: Sorting Linked Lists
```java
public class LinkedListSorting {
    
    // Merge Sort for linked list - O(n log n) time, O(log n) space
    public ListNode sortList(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        
        // Find middle and split
        ListNode mid = getMiddle(head);
        ListNode secondHalf = mid.next;
        mid.next = null;
        
        // Recursively sort both halves
        ListNode left = sortList(head);
        ListNode right = sortList(secondHalf);
        
        // Merge sorted halves
        return merge(left, right);
    }
    
    private ListNode getMiddle(ListNode head) {
        ListNode slow = head;
        ListNode fast = head;
        ListNode prev = null;
        
        while (fast != null && fast.next != null) {
            prev = slow;
            slow = slow.next;
            fast = fast.next.next;
        }
        
        return prev;
    }
    
    private ListNode merge(ListNode l1, ListNode l2) {
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
    
    // Insertion sort for linked list - O(n²) time, O(1) space
    public ListNode insertionSortList(ListNode head) {
        if (head == null || head.next == null) return head;
        
        ListNode dummy = new ListNode(0);
        ListNode current = head;
        
        while (current != null) {
            ListNode next = current.next;
            
            // Find position to insert current node
            ListNode prev = dummy;
            while (prev.next != null && prev.next.val < current.val) {
                prev = prev.next;
            }
            
            // Insert current node
            current.next = prev.next;
            prev.next = current;
            
            current = next;
        }
        
        return dummy.next;
    }
}
```

#### Problem 6: Complex Manipulations
```java
public class ComplexLinkedListOperations {
    
    // Rotate list to the right by k places
    public ListNode rotateRight(ListNode head, int k) {
        if (head == null || head.next == null || k == 0) return head;
        
        // Find length and make it circular
        int length = 1;
        ListNode tail = head;
        while (tail.next != null) {
            tail = tail.next;
            length++;
        }
        tail.next = head; // Make circular
        
        // Find new tail (length - k % length - 1) steps from head
        k = k % length;
        int stepsToNewTail = length - k;
        
        ListNode newTail = head;
        for (int i = 1; i < stepsToNewTail; i++) {
            newTail = newTail.next;
        }
        
        ListNode newHead = newTail.next;
        newTail.next = null; // Break the circle
        
        return newHead;
    }
    
    // Swap nodes in pairs
    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) return head;
        
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        
        while (prev.next != null && prev.next.next != null) {
            ListNode first = prev.next;
            ListNode second = prev.next.next;
            
            // Swap
            prev.next = second;
            first.next = second.next;
            second.next = first;
            
            prev = first;
        }
        
        return dummy.next;
    }
    
    // Remove duplicates from sorted list
    public ListNode deleteDuplicates(ListNode head) {
        ListNode current = head;
        
        while (current != null && current.next != null) {
            if (current.val == current.next.val) {
                current.next = current.next.next;
            } else {
                current = current.next;
            }
        }
        
        return head;
    }
    
    // Remove all duplicates from sorted list
    public ListNode deleteDuplicatesII(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode prev = dummy;
        
        while (head != null) {
            if (head.next != null && head.val == head.next.val) {
                // Skip all nodes with same value
                while (head.next != null && head.val == head.next.val) {
                    head = head.next;
                }
                prev.next = head.next;
            } else {
                prev = prev.next;
            }
            head = head.next;
        }
        
        return dummy.next;
    }
    
    // Partition list around value x
    public ListNode partition(ListNode head, int x) {
        ListNode beforeHead = new ListNode(0);
        ListNode before = beforeHead;
        ListNode afterHead = new ListNode(0);
        ListNode after = afterHead;
        
        while (head != null) {
            if (head.val < x) {
                before.next = head;
                before = before.next;
            } else {
                after.next = head;
                after = after.next;
            }
            head = head.next;
        }
        
        after.next = null;
        before.next = afterHead.next;
        
        return beforeHead.next;
    }
}
```

## 🧪 Practice Problems

### Easy Level Problems
```java
public class EasyLinkedListProblems {
    
    // 1. Delete Node in a Linked List (given only node reference)
    public void deleteNode(ListNode node) {
        // Copy next node's value and skip next node
        node.val = node.next.val;
        node.next = node.next.next;
    }
    
    // 2. Convert Binary Number in Linked List to Integer
    public int getDecimalValue(ListNode head) {
        int result = 0;
        while (head != null) {
            result = result * 2 + head.val;
            head = head.next;
        }
        return result;
    }
    
    // 3. Design Linked List (LeetCode 707)
    class MyLinkedList {
        private ListNode head;
        private int size;
        
        public MyLinkedList() {
            head = null;
            size = 0;
        }
        
        public int get(int index) {
            if (index < 0 || index >= size) return -1;
            
            ListNode current = head;
            for (int i = 0; i < index; i++) {
                current = current.next;
            }
            return current.val;
        }
        
        public void addAtHead(int val) {
            ListNode newNode = new ListNode(val);
            newNode.next = head;
            head = newNode;
            size++;
        }
        
        public void addAtTail(int val) {
            if (head == null) {
                addAtHead(val);
                return;
            }
            
            ListNode current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = new ListNode(val);
            size++;
        }
        
        public void addAtIndex(int index, int val) {
            if (index < 0 || index > size) return;
            if (index == 0) {
                addAtHead(val);
                return;
            }
            
            ListNode current = head;
            for (int i = 0; i < index - 1; i++) {
                current = current.next;
            }
            
            ListNode newNode = new ListNode(val);
            newNode.next = current.next;
            current.next = newNode;
            size++;
        }
        
        public void deleteAtIndex(int index) {
            if (index < 0 || index >= size) return;
            if (index == 0) {
                head = head.next;
                size--;
                return;
            }
            
            ListNode current = head;
            for (int i = 0; i < index - 1; i++) {
                current = current.next;
            }
            current.next = current.next.next;
            size--;
        }
    }
}
```

### Medium Level Problems
```java
public class MediumLinkedListProblems {
    
    // 1. Add Two Numbers
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode dummy = new ListNode(0);
        ListNode current = dummy;
        int carry = 0;
        
        while (l1 != null || l2 != null || carry != 0) {
            int sum = carry;
            
            if (l1 != null) {
                sum += l1.val;
                l1 = l1.next;
            }
            
            if (l2 != null) {
                sum += l2.val;
                l2 = l2.next;
            }
            
            carry = sum / 10;
            current.next = new ListNode(sum % 10);
            current = current.next;
        }
        
        return dummy.next;
    }
    
    // 2. Reorder List
    public void reorderList(ListNode head) {
        if (head == null || head.next == null) return;
        
        // Find middle
        ListNode slow = head;
        ListNode fast = head;
        
        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }
        
        // Reverse second half
        ListNode secondHalf = reverse(slow.next);
        slow.next = null;
        
        // Merge two halves
        ListNode first = head;
        while (secondHalf != null) {
            ListNode temp1 = first.next;
            ListNode temp2 = secondHalf.next;
            
            first.next = secondHalf;
            secondHalf.next = temp1;
            
            first = temp1;
            secondHalf = temp2;
        }
    }
    
    private ListNode reverse(ListNode head) {
        ListNode prev = null;
        while (head != null) {
            ListNode next = head.next;
            head.next = prev;
            prev = head;
            head = next;
        }
        return prev;
    }
    
    // 3. Copy List with Random Pointer
    public Node copyRandomList(Node head) {
        if (head == null) return null;
        
        Map<Node, Node> map = new HashMap<>();
        
        // First pass: create all nodes
        Node current = head;
        while (current != null) {
            map.put(current, new Node(current.val));
            current = current.next;
        }
        
        // Second pass: set next and random pointers
        current = head;
        while (current != null) {
            Node copy = map.get(current);
            copy.next = map.get(current.next);
            copy.random = map.get(current.random);
            current = current.next;
        }
        
        return map.get(head);
    }
}
```

## ✅ Linked List Mastery Checklist

### Implementation Skills
- [ ] Implement singly linked list from scratch
- [ ] Implement doubly linked list with all operations
- [ ] Handle edge cases (null, single node, empty list)
- [ ] Manage memory and prevent memory leaks
- [ ] Write clean, readable linked list code

### Problem-Solving Patterns
- [ ] Master two-pointer technique (slow/fast pointers)
- [ ] Handle cycle detection and removal
- [ ] Reverse linked lists iteratively and recursively
- [ ] Merge sorted linked lists efficiently
- [ ] Find middle, nth node, and intersections

### Advanced Techniques
- [ ] Sort linked lists using merge sort
- [ ] Handle complex manipulations (rotation, partitioning)
- [ ] Work with dummy nodes for edge case handling
- [ ] Optimize space complexity when possible
- [ ] Debug pointer manipulation errors

### Time Complexity Understanding
- [ ] Know when operations are O(1) vs O(n)
- [ ] Understand trade-offs vs arrays
- [ ] Choose appropriate data structure for use case
- [ ] Optimize algorithms for linked list constraints

## 🎯 Next Steps

After mastering Linked Lists:
1. Practice 25+ linked list problems
2. Focus on pointer manipulation confidence
3. Learn to visualize operations
4. Move to [Module 6: Stacks and Queues](../06-stacks-queues/)

---

**Estimated Time:** 2-3 weeks  
**Practice Problems:** 30+ problems  
**Key Skills:** Pointer manipulation, edge case handling, pattern recognition
