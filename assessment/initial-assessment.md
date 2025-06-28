# Initial Skills Assessment

## Overview
This assessment will help you identify your current skill level and choose the appropriate learning track for the DSA course.

## Instructions
- Answer all questions honestly
- Don't look up answers during the assessment
- This is for your benefit to create a personalized learning path
- Take approximately 45-60 minutes to complete

## Section 1: Java Fundamentals (25 points)

### Question 1 (3 points)
What is the output of the following code?
```java
public class Test {
    public static void main(String[] args) {
        String s1 = "Hello";
        String s2 = "Hello";
        String s3 = new String("Hello");
        
        System.out.println(s1 == s2);        // A
        System.out.println(s1 == s3);        // B
        System.out.println(s1.equals(s3));   // C
    }
}
```

**Answer Options:**
- A) true, false, true
- B) false, false, true
- C) true, true, true
- D) false, true, false

### Question 2 (4 points)
Explain the difference between `ArrayList` and `LinkedList` in Java. When would you use each?

**Your Answer:**
```
[Write your answer here]
```

### Question 3 (3 points)
What is the time complexity of accessing an element by index in:
- Array: ____
- ArrayList: ____
- LinkedList: ____

### Question 4 (5 points)
Write a method that reverses a string without using built-in reverse functions:

```java
public static String reverseString(String str) {
    // Your implementation here
}
```

### Question 5 (4 points)
What is the difference between `==` and `.equals()` in Java?

**Your Answer:**
```
[Write your answer here]
```

### Question 6 (3 points)
What will happen when this code runs?
```java
List<String> list = new ArrayList<>();
list.add("A");
list.add("B");
for (String item : list) {
    if (item.equals("A")) {
        list.remove(item);
    }
}
```

### Question 7 (3 points)
What is the difference between `HashMap` and `TreeMap`?

**Your Answer:**
```
[Write your answer here]
```

## Section 2: Basic Data Structures (25 points)

### Question 8 (5 points)
Implement a basic stack using an array:

```java
public class ArrayStack {
    private int[] arr;
    private int top;
    private int capacity;
    
    public ArrayStack(int size) {
        // Your implementation
    }
    
    public void push(int x) {
        // Your implementation
    }
    
    public int pop() {
        // Your implementation
    }
    
    public boolean isEmpty() {
        // Your implementation
    }
}
```

### Question 9 (5 points)
What is the time complexity of the following operations on different data structures?

| Operation | Array | LinkedList | HashMap | TreeMap |
|-----------|-------|------------|---------|---------|
| Insert at end | | | | |
| Insert at beginning | | | | |
| Search | | | | |
| Delete | | | | |

### Question 10 (5 points)
Implement a method to find the middle element of a linked list:

```java
public class ListNode {
    int val;
    ListNode next;
    ListNode(int val) { this.val = val; }
}

public ListNode findMiddle(ListNode head) {
    // Your implementation here
}
```

### Question 11 (5 points)
Explain when you would use a Queue vs a Stack. Give real-world examples.

**Your Answer:**
```
[Write your answer here]
```

### Question 12 (5 points)
What is a Binary Search Tree? What property must it satisfy?

**Your Answer:**
```
[Write your answer here]
```

## Section 3: Algorithm Concepts (25 points)

### Question 13 (5 points)
What is the time complexity of binary search? Why?

**Your Answer:**
```
[Write your answer here]
```

### Question 14 (5 points)
Implement binary search on a sorted array:

```java
public static int binarySearch(int[] arr, int target) {
    // Your implementation here
}
```

### Question 15 (5 points)
What is the difference between BFS and DFS? When would you use each?

**Your Answer:**
```
[Write your answer here]
```

### Question 16 (5 points)
What is Dynamic Programming? Can you give an example problem?

**Your Answer:**
```
[Write your answer here]
```

### Question 17 (5 points)
Sort the following algorithms by their average time complexity (fastest to slowest):
- Merge Sort
- Quick Sort
- Bubble Sort
- Heap Sort
- Selection Sort

**Your Answer:**
```
[Write your answer here]
```

## Section 4: Problem Solving (25 points)

### Question 18 (8 points)
**Two Sum Problem**: Given an array of integers and a target sum, return indices of two numbers that add up to the target.

```java
public int[] twoSum(int[] nums, int target) {
    // Your implementation here
}
```

**What is the time and space complexity of your solution?**
```
[Your analysis here]
```

### Question 19 (8 points)
**Valid Parentheses**: Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

```java
public boolean isValid(String s) {
    // Your implementation here
}
```

### Question 20 (9 points)
**Maximum Subarray**: Find the contiguous subarray with the largest sum.

```java
public int maxSubArray(int[] nums) {
    // Your implementation here
}
```

**Explain your approach:**
```
[Your explanation here]
```

## Assessment Scoring

### Scoring Guide
- **90-100 points:** Advanced Track - Skip to Module 4
- **70-89 points:** Intermediate Track - Quick review of Modules 1-3
- **50-69 points:** Beginner+ Track - Standard progression with extra practice
- **Below 50 points:** Beginner Track - Start from Module 1 with extended timeline

### Detailed Breakdown

#### Java Fundamentals (25 points)
- **23-25:** Excellent Java knowledge
- **18-22:** Good Java foundation
- **13-17:** Basic Java understanding
- **Below 13:** Need significant Java review

#### Data Structures (25 points)
- **23-25:** Strong DS knowledge
- **18-22:** Good DS foundation
- **13-17:** Basic DS understanding
- **Below 13:** Need DS fundamentals

#### Algorithms (25 points)
- **23-25:** Strong algorithmic thinking
- **18-22:** Good algorithm foundation
- **13-17:** Basic algorithm understanding
- **Below 13:** Need algorithm fundamentals

#### Problem Solving (25 points)
- **23-25:** Excellent problem-solving skills
- **18-22:** Good problem-solving ability
- **13-17:** Basic problem-solving skills
- **Below 13:** Need problem-solving practice

## Answer Key and Explanations

### Section 1 Answers
1. **A) true, false, true** - String literals are interned, new String() creates new object
2. **ArrayList vs LinkedList:** ArrayList uses dynamic array (O(1) access, O(n) insertion), LinkedList uses doubly-linked list (O(n) access, O(1) insertion at known position)
3. **Time Complexities:** Array: O(1), ArrayList: O(1), LinkedList: O(n)
4. **String Reverse:**
```java
public static String reverseString(String str) {
    StringBuilder sb = new StringBuilder();
    for (int i = str.length() - 1; i >= 0; i--) {
        sb.append(str.charAt(i));
    }
    return sb.toString();
}
```
5. **== vs equals():** == compares references, equals() compares content
6. **ConcurrentModificationException** - Cannot modify collection during iteration
7. **HashMap vs TreeMap:** HashMap: O(1) operations, no ordering; TreeMap: O(log n) operations, sorted keys

### Recommended Learning Paths

#### Score 90-100: Advanced Track
- **Duration:** 12 weeks
- **Start:** Module 4 (Arrays and Strings)
- **Focus:** Advanced algorithms, optimization, hard problems
- **Daily:** 2-3 hours, 8-12 problems/week

#### Score 70-89: Intermediate Track
- **Duration:** 16 weeks
- **Start:** Quick review Modules 1-3, then Module 4
- **Focus:** Solid foundation, medium problems
- **Daily:** 2 hours, 5-8 problems/week

#### Score 50-69: Beginner+ Track
- **Duration:** 18 weeks
- **Start:** Module 1 with accelerated pace
- **Focus:** Strong fundamentals, easy to medium problems
- **Daily:** 1.5 hours, 3-5 problems/week

#### Score Below 50: Beginner Track
- **Duration:** 20 weeks
- **Start:** Module 1 with extended practice
- **Focus:** Solid fundamentals, lots of easy problems
- **Daily:** 1 hour theory + 1 hour practice, 2-3 problems/week

## Next Steps

1. **Calculate your score** using the answer key
2. **Identify weak areas** for focused improvement
3. **Choose your track** based on your score
4. **Set up your environment** using the setup guide
5. **Begin your learning journey!**

## Assessment Review

After completing the course, retake this assessment to measure your improvement. Most students see:
- **50+ point improvement** after completing their track
- **Ability to solve all problems** within time limits
- **Clear explanations** of all concepts

Good luck on your DSA mastery journey!
