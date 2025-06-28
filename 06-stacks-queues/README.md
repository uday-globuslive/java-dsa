# Module 6: Stacks and Queues

## Learning Objectives
By the end of this module, you will:
- Master stack and queue data structures and their implementations
- Solve classic stack/queue problems like balanced parentheses, nearest greater element
- Understand monotonic stacks and queues for optimization problems
- Apply stack/queue patterns to solve complex algorithmic challenges

## Module Content

### 6.1 Stack Fundamentals

#### Stack Implementation
```java
// Array-based stack implementation
public class ArrayStack<T> {
    private T[] stack;
    private int top;
    private int capacity;
    
    @SuppressWarnings("unchecked")
    public ArrayStack(int capacity) {
        this.capacity = capacity;
        this.stack = (T[]) new Object[capacity];
        this.top = -1;
    }
    
    public void push(T item) {
        if (isFull()) {
            throw new RuntimeException("Stack overflow");
        }
        stack[++top] = item;
    }
    
    public T pop() {
        if (isEmpty()) {
            throw new RuntimeException("Stack underflow");
        }
        T item = stack[top];
        stack[top--] = null; // Help GC
        return item;
    }
    
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Stack is empty");
        }
        return stack[top];
    }
    
    public boolean isEmpty() {
        return top == -1;
    }
    
    public boolean isFull() {
        return top == capacity - 1;
    }
    
    public int size() {
        return top + 1;
    }
}
```

```java
// LinkedList-based stack implementation
public class LinkedStack<T> {
    private Node<T> top;
    private int size;
    
    private static class Node<T> {
        T data;
        Node<T> next;
        
        Node(T data) {
            this.data = data;
        }
    }
    
    public void push(T item) {
        Node<T> newNode = new Node<>(item);
        newNode.next = top;
        top = newNode;
        size++;
    }
    
    public T pop() {
        if (isEmpty()) {
            throw new RuntimeException("Stack underflow");
        }
        T data = top.data;
        top = top.next;
        size--;
        return data;
    }
    
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Stack is empty");
        }
        return top.data;
    }
    
    public boolean isEmpty() {
        return top == null;
    }
    
    public int size() {
        return size;
    }
}
```

### 6.2 Queue Fundamentals

#### Queue Implementation
```java
// Array-based circular queue implementation
public class CircularQueue<T> {
    private T[] queue;
    private int front, rear, size, capacity;
    
    @SuppressWarnings("unchecked")
    public CircularQueue(int capacity) {
        this.capacity = capacity;
        this.queue = (T[]) new Object[capacity];
        this.front = 0;
        this.rear = -1;
        this.size = 0;
    }
    
    public void enqueue(T item) {
        if (isFull()) {
            throw new RuntimeException("Queue overflow");
        }
        rear = (rear + 1) % capacity;
        queue[rear] = item;
        size++;
    }
    
    public T dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Queue underflow");
        }
        T item = queue[front];
        queue[front] = null; // Help GC
        front = (front + 1) % capacity;
        size--;
        return item;
    }
    
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }
        return queue[front];
    }
    
    public boolean isEmpty() {
        return size == 0;
    }
    
    public boolean isFull() {
        return size == capacity;
    }
    
    public int size() {
        return size;
    }
}
```

```java
// LinkedList-based queue implementation
public class LinkedQueue<T> {
    private Node<T> front, rear;
    private int size;
    
    private static class Node<T> {
        T data;
        Node<T> next;
        
        Node(T data) {
            this.data = data;
        }
    }
    
    public void enqueue(T item) {
        Node<T> newNode = new Node<>(item);
        if (isEmpty()) {
            front = rear = newNode;
        } else {
            rear.next = newNode;
            rear = newNode;
        }
        size++;
    }
    
    public T dequeue() {
        if (isEmpty()) {
            throw new RuntimeException("Queue underflow");
        }
        T data = front.data;
        front = front.next;
        if (front == null) {
            rear = null;
        }
        size--;
        return data;
    }
    
    public T peek() {
        if (isEmpty()) {
            throw new RuntimeException("Queue is empty");
        }
        return front.data;
    }
    
    public boolean isEmpty() {
        return front == null;
    }
    
    public int size() {
        return size;
    }
}
```

### 6.3 Stack Problems

#### Problem: Balanced Parentheses
```java
import java.util.*;

public class BalancedParentheses {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        Map<Character, Character> mapping = new HashMap<>();
        mapping.put(')', '(');
        mapping.put('}', '{');
        mapping.put(']', '[');
        
        for (char c : s.toCharArray()) {
            if (mapping.containsKey(c)) {
                // Closing bracket
                if (stack.isEmpty() || stack.pop() != mapping.get(c)) {
                    return false;
                }
            } else {
                // Opening bracket
                stack.push(c);
            }
        }
        
        return stack.isEmpty();
    }
    
    public static void main(String[] args) {
        BalancedParentheses bp = new BalancedParentheses();
        System.out.println(bp.isValid("()"));     // true
        System.out.println(bp.isValid("()[]{}"));  // true
        System.out.println(bp.isValid("(]"));     // false
        System.out.println(bp.isValid("([)]"));   // false
    }
}
```

#### Problem: Next Greater Element
```java
import java.util.*;

public class NextGreaterElement {
    // Next greater element to the right
    public int[] nextGreaterElements(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        Stack<Integer> stack = new Stack<>(); // Store indices
        
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] < nums[i]) {
                result[stack.pop()] = nums[i];
            }
            stack.push(i);
        }
        
        return result;
    }
    
    // Next greater element in circular array
    public int[] nextGreaterElementsCircular(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        Stack<Integer> stack = new Stack<>();
        
        // Process array twice for circular behavior
        for (int i = 0; i < 2 * n; i++) {
            int current = nums[i % n];
            while (!stack.isEmpty() && nums[stack.peek()] < current) {
                result[stack.pop()] = current;
            }
            if (i < n) {
                stack.push(i);
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        NextGreaterElement nge = new NextGreaterElement();
        int[] nums = {2, 1, 2, 4, 3, 1};
        System.out.println(Arrays.toString(nge.nextGreaterElements(nums)));
        // Output: [4, 2, 4, -1, -1, -1]
        
        int[] circular = {1, 2, 1};
        System.out.println(Arrays.toString(nge.nextGreaterElementsCircular(circular)));
        // Output: [2, -1, 2]
    }
}
```

#### Problem: Largest Rectangle in Histogram
```java
import java.util.*;

public class LargestRectangle {
    public int largestRectangleArea(int[] heights) {
        Stack<Integer> stack = new Stack<>();
        int maxArea = 0;
        int n = heights.length;
        
        for (int i = 0; i <= n; i++) {
            int currentHeight = (i == n) ? 0 : heights[i];
            
            while (!stack.isEmpty() && heights[stack.peek()] > currentHeight) {
                int height = heights[stack.pop()];
                int width = stack.isEmpty() ? i : i - stack.peek() - 1;
                maxArea = Math.max(maxArea, height * width);
            }
            
            stack.push(i);
        }
        
        return maxArea;
    }
    
    public static void main(String[] args) {
        LargestRectangle lr = new LargestRectangle();
        int[] heights = {2, 1, 5, 6, 2, 3};
        System.out.println(lr.largestRectangleArea(heights)); // Output: 10
    }
}
```

#### Problem: Evaluate Reverse Polish Notation
```java
import java.util.*;

public class EvaluateRPN {
    public int evalRPN(String[] tokens) {
        Stack<Integer> stack = new Stack<>();
        Set<String> operators = Set.of("+", "-", "*", "/");
        
        for (String token : tokens) {
            if (operators.contains(token)) {
                int b = stack.pop();
                int a = stack.pop();
                int result = calculate(a, b, token);
                stack.push(result);
            } else {
                stack.push(Integer.parseInt(token));
            }
        }
        
        return stack.pop();
    }
    
    private int calculate(int a, int b, String operator) {
        switch (operator) {
            case "+": return a + b;
            case "-": return a - b;
            case "*": return a * b;
            case "/": return a / b;
            default: throw new IllegalArgumentException("Invalid operator");
        }
    }
    
    public static void main(String[] args) {
        EvaluateRPN rpn = new EvaluateRPN();
        String[] tokens1 = {"2", "1", "+", "3", "*"};
        System.out.println(rpn.evalRPN(tokens1)); // Output: 9 ((2+1)*3)
        
        String[] tokens2 = {"4", "13", "5", "/", "+"};
        System.out.println(rpn.evalRPN(tokens2)); // Output: 6 (4+(13/5))
    }
}
```

### 6.4 Queue Problems

#### Problem: Sliding Window Maximum
```java
import java.util.*;

public class SlidingWindowMaximum {
    public int[] maxSlidingWindow(int[] nums, int k) {
        if (nums == null || nums.length == 0) return new int[0];
        
        int n = nums.length;
        int[] result = new int[n - k + 1];
        Deque<Integer> deque = new ArrayDeque<>(); // Store indices
        
        for (int i = 0; i < n; i++) {
            // Remove indices outside current window
            while (!deque.isEmpty() && deque.peekFirst() < i - k + 1) {
                deque.pollFirst();
            }
            
            // Remove indices with smaller values (maintain decreasing order)
            while (!deque.isEmpty() && nums[deque.peekLast()] < nums[i]) {
                deque.pollLast();
            }
            
            deque.offerLast(i);
            
            // Add to result if window is complete
            if (i >= k - 1) {
                result[i - k + 1] = nums[deque.peekFirst()];
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        SlidingWindowMaximum swm = new SlidingWindowMaximum();
        int[] nums = {1, 3, -1, -3, 5, 3, 6, 7};
        int k = 3;
        System.out.println(Arrays.toString(swm.maxSlidingWindow(nums, k)));
        // Output: [3, 3, 5, 5, 6, 7]
    }
}
```

#### Problem: Design Circular Queue
```java
public class MyCircularQueue {
    private int[] queue;
    private int front, rear, size, capacity;
    
    public MyCircularQueue(int k) {
        this.capacity = k;
        this.queue = new int[k];
        this.front = 0;
        this.rear = -1;
        this.size = 0;
    }
    
    public boolean enQueue(int value) {
        if (isFull()) return false;
        rear = (rear + 1) % capacity;
        queue[rear] = value;
        size++;
        return true;
    }
    
    public boolean deQueue() {
        if (isEmpty()) return false;
        front = (front + 1) % capacity;
        size--;
        return true;
    }
    
    public int Front() {
        return isEmpty() ? -1 : queue[front];
    }
    
    public int Rear() {
        return isEmpty() ? -1 : queue[rear];
    }
    
    public boolean isEmpty() {
        return size == 0;
    }
    
    public boolean isFull() {
        return size == capacity;
    }
}
```

### 6.5 Monotonic Stack/Queue

#### Monotonic Stack Pattern
```java
import java.util.*;

public class MonotonicStack {
    // Find previous smaller element for each position
    public int[] previousSmallerElement(int[] arr) {
        int n = arr.length;
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>(); // Monotonic increasing stack
        
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && stack.peek() >= arr[i]) {
                stack.pop();
            }
            result[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(arr[i]);
        }
        
        return result;
    }
    
    // Find next smaller element for each position
    public int[] nextSmallerElement(int[] arr) {
        int n = arr.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        Stack<Integer> stack = new Stack<>(); // Store indices
        
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && arr[stack.peek()] > arr[i]) {
                result[stack.pop()] = arr[i];
            }
            stack.push(i);
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        MonotonicStack ms = new MonotonicStack();
        int[] arr = {4, 2, 1, 3, 5};
        
        System.out.println("Previous smaller: " + 
            Arrays.toString(ms.previousSmallerElement(arr)));
        // Output: [-1, -1, -1, 1, 3]
        
        System.out.println("Next smaller: " + 
            Arrays.toString(ms.nextSmallerElement(arr)));
        // Output: [2, 1, -1, -1, -1]
    }
}
```

### 6.6 Advanced Applications

#### Problem: Basic Calculator
```java
import java.util.*;

public class BasicCalculator {
    public int calculate(String s) {
        Stack<Integer> stack = new Stack<>();
        int result = 0;
        int number = 0;
        int sign = 1; // 1 for positive, -1 for negative
        
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                number = number * 10 + (c - '0');
            } else if (c == '+') {
                result += sign * number;
                number = 0;
                sign = 1;
            } else if (c == '-') {
                result += sign * number;
                number = 0;
                sign = -1;
            } else if (c == '(') {
                // Push result and sign to stack
                stack.push(result);
                stack.push(sign);
                result = 0;
                sign = 1;
            } else if (c == ')') {
                result += sign * number;
                number = 0;
                result *= stack.pop(); // Pop sign
                result += stack.pop(); // Pop previous result
            }
        }
        
        result += sign * number;
        return result;
    }
    
    public static void main(String[] args) {
        BasicCalculator bc = new BasicCalculator();
        System.out.println(bc.calculate("1 + 1")); // 2
        System.out.println(bc.calculate(" 2-1 + 2 ")); // 3
        System.out.println(bc.calculate("(1+(4+5+2)-3)+(6+8)")); // 23
    }
}
```

#### Problem: Trapping Rain Water (Stack Approach)
```java
import java.util.*;

public class TrappingRainWater {
    public int trap(int[] height) {
        if (height.length <= 2) return 0;
        
        Stack<Integer> stack = new Stack<>();
        int waterTrapped = 0;
        
        for (int i = 0; i < height.length; i++) {
            while (!stack.isEmpty() && height[i] > height[stack.peek()]) {
                int top = stack.pop();
                
                if (stack.isEmpty()) break;
                
                int distance = i - stack.peek() - 1;
                int boundedHeight = Math.min(height[i], height[stack.peek()]) - height[top];
                waterTrapped += distance * boundedHeight;
            }
            
            stack.push(i);
        }
        
        return waterTrapped;
    }
    
    public static void main(String[] args) {
        TrappingRainWater trw = new TrappingRainWater();
        int[] height = {0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1};
        System.out.println(trw.trap(height)); // Output: 6
    }
}
```

## Practice Problems

### Easy Level
1. **Valid Parentheses** - Check if string has valid parentheses
2. **Implement Stack using Queues** - Use queues to implement stack
3. **Implement Queue using Stacks** - Use stacks to implement queue
4. **Baseball Game** - Calculate score using stack operations

### Medium Level
1. **Daily Temperatures** - Find next warmer temperature using monotonic stack
2. **Top K Frequent Elements** - Use heap (priority queue) to find top k elements
3. **Decode String** - Use stack to decode nested encoded strings
4. **Remove K Digits** - Use monotonic stack to remove k digits

### Hard Level
1. **Basic Calculator III** - Implement calculator with +, -, *, /, ()
2. **Sliding Window Maximum** - Find maximum in all sliding windows
3. **Largest Rectangle in Histogram** - Find largest rectangular area
4. **Maximal Rectangle** - Extend histogram problem to 2D

## Key Patterns

1. **Monotonic Stack**: For "next/previous greater/smaller" problems
2. **Expression Evaluation**: Use stack for operators and operands
3. **Sliding Window**: Use deque for window maximum/minimum
4. **Balanced Symbols**: Use stack to match opening/closing symbols
5. **Function Call Stack**: Implement recursion iteratively using stack

## Time/Space Complexity

| Operation | Stack | Queue |
|-----------|-------|-------|
| Push/Enqueue | O(1) | O(1) |
| Pop/Dequeue | O(1) | O(1) |
| Peek/Front | O(1) | O(1) |
| Search | O(n) | O(n) |
| Space | O(n) | O(n) |

## Next Steps
- Practice the problems above
- Implement stack and queue from scratch
- Solve monotonic stack problems
- Move to **[Module 7: Trees and Binary Search Trees](../07-trees-bst/README.md)**
