# Module 16: Recursion & Backtracking

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master recursive thinking and problem decomposition
- ✅ Implement efficient backtracking algorithms for constraint satisfaction
- ✅ Solve complex combinatorial and optimization problems
- ✅ Optimize recursive solutions with memoization and pruning
- ✅ Recognize recursive patterns in tree, graph, and array problems

## 🎯 Module Overview
Recursion and backtracking are fundamental problem-solving paradigms essential for:
- **Tree and graph traversal** - DFS, path finding, tree problems
- **Combinatorial problems** - Permutations, combinations, subsets
- **Constraint satisfaction** - N-Queens, Sudoku, maze solving
- **Optimization problems** - Finding optimal paths or configurations

**Time Investment:** 8-10 hours
**Difficulty Level:** Intermediate to Advanced
**Prerequisites:** Basic programming, Trees, Arrays

## 📖 Core Concepts

### 1. Recursion Fundamentals

#### Basic Recursive Structure
```java
public ReturnType recursiveFunction(parameters) {
    // Base case - stopping condition
    if (baseCondition) {
        return baseValue;
    }
    
    // Recursive case - self-reference with modified parameters
    // Do some work
    ReturnType result = recursiveFunction(modifiedParameters);
    
    // Process result and return
    return processedResult;
}
```

#### Classic Recursion Examples
```java
// Factorial
public int factorial(int n) {
    if (n <= 1) return 1; // Base case
    return n * factorial(n - 1); // Recursive case
}

// Fibonacci with memoization
public class Fibonacci {
    private Map<Integer, Integer> memo = new HashMap<>();
    
    public int fib(int n) {
        if (n <= 1) return n;
        
        if (memo.containsKey(n)) {
            return memo.get(n);
        }
        
        int result = fib(n - 1) + fib(n - 2);
        memo.put(n, result);
        return result;
    }
}

// Binary tree height
public int maxDepth(TreeNode root) {
    if (root == null) return 0; // Base case
    
    int leftDepth = maxDepth(root.left);
    int rightDepth = maxDepth(root.right);
    
    return 1 + Math.max(leftDepth, rightDepth);
}

// Power calculation
public double power(double x, int n) {
    if (n == 0) return 1.0;
    
    if (n < 0) {
        return 1.0 / power(x, -n);
    }
    
    // Optimize with divide and conquer
    if (n % 2 == 0) {
        double half = power(x, n / 2);
        return half * half;
    } else {
        return x * power(x, n - 1);
    }
}
```

#### Tail Recursion Optimization
```java
// Non-tail recursive (less efficient)
public int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1); // Operation after recursive call
}

// Tail recursive (more efficient)
public int factorialTail(int n, int accumulator) {
    if (n <= 1) return accumulator;
    return factorialTail(n - 1, n * accumulator); // Recursive call is last operation
}

public int factorial(int n) {
    return factorialTail(n, 1);
}
```

### 2. Backtracking Framework

#### General Backtracking Template
```java
public class BacktrackingSolution {
    private List<SolutionType> result = new ArrayList<>();
    
    public List<SolutionType> solve(ProblemInput input) {
        List<ChoiceType> currentSolution = new ArrayList<>();
        backtrack(input, currentSolution, startState);
        return result;
    }
    
    private void backtrack(ProblemInput input, List<ChoiceType> currentSolution, StateType state) {
        // Base case - solution found
        if (isSolutionComplete(currentSolution, state)) {
            result.add(new ArrayList<>(currentSolution)); // Make copy
            return;
        }
        
        // Try all possible choices
        for (ChoiceType choice : getPossibleChoices(input, currentSolution, state)) {
            if (isValidChoice(choice, currentSolution, state)) {
                // Make choice
                currentSolution.add(choice);
                StateType newState = updateState(state, choice);
                
                // Recurse
                backtrack(input, currentSolution, newState);
                
                // Backtrack - undo choice
                currentSolution.remove(currentSolution.size() - 1);
                // Restore state if needed
            }
        }
    }
    
    private boolean isSolutionComplete(List<ChoiceType> solution, StateType state) {
        // Define completion criteria
        return false;
    }
    
    private List<ChoiceType> getPossibleChoices(ProblemInput input, List<ChoiceType> current, StateType state) {
        // Return available choices at current state
        return new ArrayList<>();
    }
    
    private boolean isValidChoice(ChoiceType choice, List<ChoiceType> current, StateType state) {
        // Check if choice satisfies constraints
        return true;
    }
    
    private StateType updateState(StateType state, ChoiceType choice) {
        // Update state after making choice
        return state;
    }
}
```

### 3. Classic Backtracking Problems

#### Generate All Subsets
```java
public List<List<Integer>> subsets(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    generateSubsets(nums, 0, new ArrayList<>(), result);
    return result;
}

private void generateSubsets(int[] nums, int index, List<Integer> current, List<List<Integer>> result) {
    // Base case - processed all elements
    if (index == nums.length) {
        result.add(new ArrayList<>(current));
        return;
    }
    
    // Choice 1: Don't include current element
    generateSubsets(nums, index + 1, current, result);
    
    // Choice 2: Include current element
    current.add(nums[index]);
    generateSubsets(nums, index + 1, current, result);
    current.remove(current.size() - 1); // Backtrack
}
```

#### Generate All Permutations
```java
public List<List<Integer>> permute(int[] nums) {
    List<List<Integer>> result = new ArrayList<>();
    generatePermutations(nums, new ArrayList<>(), new boolean[nums.length], result);
    return result;
}

private void generatePermutations(int[] nums, List<Integer> current, boolean[] used, List<List<Integer>> result) {
    // Base case - permutation complete
    if (current.size() == nums.length) {
        result.add(new ArrayList<>(current));
        return;
    }
    
    // Try each unused number
    for (int i = 0; i < nums.length; i++) {
        if (!used[i]) {
            // Make choice
            current.add(nums[i]);
            used[i] = true;
            
            // Recurse
            generatePermutations(nums, current, used, result);
            
            // Backtrack
            current.remove(current.size() - 1);
            used[i] = false;
        }
    }
}
```

#### N-Queens Problem
```java
public List<List<String>> solveNQueens(int n) {
    List<List<String>> result = new ArrayList<>();
    char[][] board = new char[n][n];
    
    // Initialize board
    for (int i = 0; i < n; i++) {
        Arrays.fill(board[i], '.');
    }
    
    solveNQueens(board, 0, result);
    return result;
}

private void solveNQueens(char[][] board, int row, List<List<String>> result) {
    int n = board.length;
    
    // Base case - all queens placed
    if (row == n) {
        result.add(buildSolution(board));
        return;
    }
    
    // Try placing queen in each column of current row
    for (int col = 0; col < n; col++) {
        if (isSafe(board, row, col)) {
            // Place queen
            board[row][col] = 'Q';
            
            // Recurse to next row
            solveNQueens(board, row + 1, result);
            
            // Backtrack
            board[row][col] = '.';
        }
    }
}

private boolean isSafe(char[][] board, int row, int col) {
    int n = board.length;
    
    // Check column
    for (int i = 0; i < row; i++) {
        if (board[i][col] == 'Q') return false;
    }
    
    // Check diagonal (top-left to bottom-right)
    for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; i--, j--) {
        if (board[i][j] == 'Q') return false;
    }
    
    // Check anti-diagonal (top-right to bottom-left)
    for (int i = row - 1, j = col + 1; i >= 0 && j < n; i--, j++) {
        if (board[i][j] == 'Q') return false;
    }
    
    return true;
}

private List<String> buildSolution(char[][] board) {
    List<String> solution = new ArrayList<>();
    for (char[] row : board) {
        solution.add(new String(row));
    }
    return solution;
}
```

#### Sudoku Solver
```java
public void solveSudoku(char[][] board) {
    solve(board);
}

private boolean solve(char[][] board) {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (board[i][j] == '.') {
                // Try digits 1-9
                for (char c = '1'; c <= '9'; c++) {
                    if (isValid(board, i, j, c)) {
                        board[i][j] = c;
                        
                        if (solve(board)) {
                            return true; // Solution found
                        }
                        
                        board[i][j] = '.'; // Backtrack
                    }
                }
                return false; // No valid digit found
            }
        }
    }
    return true; // Board complete
}

private boolean isValid(char[][] board, int row, int col, char c) {
    for (int i = 0; i < 9; i++) {
        // Check row
        if (board[row][i] == c) return false;
        
        // Check column
        if (board[i][col] == c) return false;
        
        // Check 3x3 box
        if (board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c) {
            return false;
        }
    }
    return true;
}
```

### 4. Advanced Recursion Patterns

#### Divide and Conquer
```java
// Merge Sort
public void mergeSort(int[] arr, int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        
        // Divide
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);
        
        // Conquer
        merge(arr, left, mid, right);
    }
}

private void merge(int[] arr, int left, int mid, int right) {
    int[] temp = new int[right - left + 1];
    int i = left, j = mid + 1, k = 0;
    
    while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
        }
    }
    
    while (i <= mid) temp[k++] = arr[i++];
    while (j <= right) temp[k++] = arr[j++];
    
    for (i = left; i <= right; i++) {
        arr[i] = temp[i - left];
    }
}

// Quick Sort
public void quickSort(int[] arr, int low, int high) {
    if (low < high) {
        int pivotIndex = partition(arr, low, high);
        
        quickSort(arr, low, pivotIndex - 1);
        quickSort(arr, pivotIndex + 1, high);
    }
}

private int partition(int[] arr, int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
        if (arr[j] <= pivot) {
            i++;
            swap(arr, i, j);
        }
    }
    
    swap(arr, i + 1, high);
    return i + 1;
}
```

#### Tree Recursion
```java
// Path Sum in Binary Tree
public boolean hasPathSum(TreeNode root, int targetSum) {
    if (root == null) return false;
    
    // Leaf node check
    if (root.left == null && root.right == null) {
        return root.val == targetSum;
    }
    
    // Recurse with reduced target
    return hasPathSum(root.left, targetSum - root.val) ||
           hasPathSum(root.right, targetSum - root.val);
}

// All Root-to-Leaf Paths
public List<String> binaryTreePaths(TreeNode root) {
    List<String> result = new ArrayList<>();
    if (root != null) {
        dfsPath(root, "", result);
    }
    return result;
}

private void dfsPath(TreeNode node, String path, List<String> result) {
    if (node.left == null && node.right == null) {
        // Leaf node - add complete path
        result.add(path + node.val);
        return;
    }
    
    // Continue path building
    if (node.left != null) {
        dfsPath(node.left, path + node.val + "->", result);
    }
    if (node.right != null) {
        dfsPath(node.right, path + node.val + "->", result);
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Generate All Combinations/Permutations
- **Use Case:** Find all possible arrangements or selections
- **Key Insight:** Use backtracking with choice/unchoice paradigm
- **Example Problems:** Subsets, Permutations, Combinations

### Pattern 2: Constraint Satisfaction
- **Use Case:** Find solutions that satisfy multiple constraints
- **Key Insight:** Check constraints early and prune invalid paths
- **Example Problems:** N-Queens, Sudoku, Word Search

### Pattern 3: Tree/Graph Path Finding
- **Use Case:** Find paths or solutions in tree/graph structures
- **Key Insight:** Use DFS with path tracking and backtracking
- **Example Problems:** Binary Tree Paths, Word Ladder

### Pattern 4: Divide and Conquer Optimization
- **Use Case:** Break problem into smaller subproblems
- **Key Insight:** Combine solutions from subproblems
- **Example Problems:** Merge Sort, Quick Sort, Maximum Subarray

## 💻 Practice Problems

### Easy Level
1. **Factorial (Basic)**
   - Simple recursion with base case
   - Time: O(n), Space: O(n) call stack

2. **Fibonacci Numbers (LeetCode 509)**
   - Classic recursion, optimize with memoization
   - Time: O(n) with memo, O(2^n) without

3. **Power of Two (LeetCode 231)**
   - Recursive checking with divide by 2
   - Can also solve iteratively

### Medium Level
4. **Generate Parentheses (LeetCode 22)**
   - Backtracking with constraints (open/close count)
   - Generate all valid parentheses combinations

5. **Letter Combinations of Phone Number (LeetCode 17)**
   - Backtracking through phone digit mappings
   - Build all possible letter combinations

6. **Subsets (LeetCode 78)**
   - Generate all possible subsets
   - Choice: include or exclude each element

7. **Word Search (LeetCode 79)**
   - 2D grid backtracking with visited tracking
   - Find if word exists in grid

8. **Combination Sum (LeetCode 39)**
   - Backtracking with sum constraint
   - Allow reuse of elements

### Hard Level
9. **N-Queens (LeetCode 51)**
   - Classic constraint satisfaction problem
   - Complex validity checking for queen placement

10. **Sudoku Solver (LeetCode 37)**
    - Constraint satisfaction with multiple rules
    - Efficient pruning and validation

11. **Word Search II (LeetCode 212)**
    - Combine trie and backtracking
    - Find multiple words in grid efficiently

## 🧠 Problem-Solving Templates

### Template 1: Simple Recursion
```java
public ReturnType recursiveSolution(Input input) {
    // Base case
    if (baseCondition(input)) {
        return baseResult;
    }
    
    // Recursive case
    Input reducedInput = reduceInput(input);
    ReturnType subResult = recursiveSolution(reducedInput);
    
    // Combine results
    return combineResults(subResult, input);
}
```

### Template 2: Backtracking with State
```java
public List<Solution> backtrackingSolution(Input input) {
    List<Solution> result = new ArrayList<>();
    List<Choice> currentSolution = new ArrayList<>();
    
    backtrack(input, currentSolution, result);
    return result;
}

private void backtrack(Input input, List<Choice> current, List<Solution> result) {
    if (isComplete(current)) {
        result.add(buildSolution(current));
        return;
    }
    
    for (Choice choice : getChoices(input, current)) {
        if (isValid(choice, current)) {
            current.add(choice);
            backtrack(input, current, result);
            current.remove(current.size() - 1);
        }
    }
}
```

### Template 3: Tree Recursion with Path
```java
public List<PathType> findAllPaths(TreeNode root) {
    List<PathType> result = new ArrayList<>();
    List<Integer> currentPath = new ArrayList<>();
    
    dfs(root, currentPath, result);
    return result;
}

private void dfs(TreeNode node, List<Integer> path, List<PathType> result) {
    if (node == null) return;
    
    path.add(node.val);
    
    if (isLeaf(node)) {
        result.add(buildPath(path));
    } else {
        dfs(node.left, path, result);
        dfs(node.right, path, result);
    }
    
    path.remove(path.size() - 1); // Backtrack
}
```

## ⚡ Optimization Techniques

### 1. Memoization
```java
// Top-down dynamic programming
private Map<String, Integer> memo = new HashMap<>();

public int recursiveWithMemo(int n, int k) {
    String key = n + "," + k;
    if (memo.containsKey(key)) {
        return memo.get(key);
    }
    
    int result = expensiveComputation(n, k);
    memo.put(key, result);
    return result;
}
```

### 2. Pruning Invalid Paths
```java
private void backtrackWithPruning(State state, Solution current) {
    if (isInvalidState(state)) {
        return; // Prune this path
    }
    
    if (isComplete(current)) {
        addSolution(current);
        return;
    }
    
    for (Choice choice : getChoices(state)) {
        if (earlyValidation(choice, state)) { // Early pruning
            makeChoice(choice, state, current);
            backtrackWithPruning(state, current);
            undoChoice(choice, state, current);
        }
    }
}
```

### 3. Iterative Conversion
```java
// Convert tail recursion to iteration
public int factorialIterative(int n) {
    int result = 1;
    while (n > 1) {
        result *= n;
        n--;
    }
    return result;
}

// Convert tree recursion to iteration with stack
public List<Integer> inorderIterative(TreeNode root) {
    List<Integer> result = new ArrayList<>();
    Stack<TreeNode> stack = new Stack<>();
    TreeNode current = root;
    
    while (current != null || !stack.isEmpty()) {
        while (current != null) {
            stack.push(current);
            current = current.left;
        }
        current = stack.pop();
        result.add(current.val);
        current = current.right;
    }
    
    return result;
}
```

## 📈 Complexity Analysis

### Time Complexity Patterns
- **Linear Recursion:** O(n) - factorial, linked list traversal
- **Binary Recursion:** O(2^n) - naive fibonacci, subsets
- **Tree Recursion:** O(n) - tree traversal, O(4^n) - some backtracking
- **Divide and Conquer:** O(n log n) - merge sort, quick sort average

### Space Complexity
- **Call Stack:** O(depth) - maximum recursion depth
- **Auxiliary Space:** Additional space for data structures
- **Tail Recursion:** O(1) if optimized by compiler

### Backtracking Complexity
- **Time:** O(b^d) where b = branching factor, d = depth
- **Space:** O(d) for recursion stack + solution space
- **Pruning:** Can significantly reduce effective branching factor

## 🎯 Key Takeaways

1. **When to Use Recursion:**
   - Problem has recursive structure (trees, graphs)
   - Can be broken into similar subproblems
   - Natural base cases exist

2. **When to Use Backtracking:**
   - Need to find all solutions
   - Constraint satisfaction problems
   - Optimization problems with search space

3. **Common Pitfalls:**
   - Missing base cases (infinite recursion)
   - Not handling edge cases (null inputs)
   - Inefficient recursion without memoization
   - Forgetting to backtrack (not undoing choices)

4. **Best Practices:**
   - Always define clear base cases
   - Use memoization for overlapping subproblems
   - Implement early pruning in backtracking
   - Consider iterative alternatives for deep recursion

## 🚀 Next Steps
- Practice implementing recursive solutions from scratch
- Master the backtracking template and apply to various problems
- Study advanced topics like dynamic programming
- Move to **Module 17: Dynamic Programming** for optimization techniques

---
*Recursion and backtracking are powerful paradigms that unlock solutions to complex problems. Master the thinking patterns and templates to tackle any recursive or combinatorial challenge with confidence.*
