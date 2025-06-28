# Module 7: Trees and Binary Search Trees

## Learning Objectives
By the end of this module, you will:
- Understand tree terminology and binary tree properties
- Master binary search tree operations and balancing concepts
- Implement tree traversal algorithms (DFS and BFS)
- Solve classic tree problems like lowest common ancestor, tree validation
- Apply tree patterns to solve complex algorithmic challenges

## Module Content

### 7.1 Tree Fundamentals

#### Basic Tree Structure
```java
// Binary Tree Node
class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

// Tree with parent pointers
class TreeNodeWithParent {
    int val;
    TreeNodeWithParent left, right, parent;
    
    TreeNodeWithParent(int val) {
        this.val = val;
    }
}
```

#### Tree Terminology
```java
public class TreeTerminology {
    /*
    Tree Properties:
    - Root: Top node with no parent
    - Leaf: Node with no children
    - Height: Longest path from root to leaf
    - Depth: Distance from root to node
    - Level: All nodes at same depth
    - Subtree: Tree consisting of node and its descendants
    
    Binary Tree Properties:
    - Each node has at most 2 children
    - Left subtree < root < right subtree (BST)
    - Complete: All levels filled except possibly last
    - Full: Every node has 0 or 2 children
    - Perfect: All internal nodes have 2 children, all leaves at same level
    */
    
    // Calculate height of tree
    public int height(TreeNode root) {
        if (root == null) return -1; // Height of empty tree is -1
        return 1 + Math.max(height(root.left), height(root.right));
    }
    
    // Count nodes in tree
    public int countNodes(TreeNode root) {
        if (root == null) return 0;
        return 1 + countNodes(root.left) + countNodes(root.right);
    }
    
    // Check if tree is complete
    public boolean isCompleteTree(TreeNode root) {
        if (root == null) return true;
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean nullFound = false;
        
        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();
            
            if (node == null) {
                nullFound = true;
            } else {
                if (nullFound) return false; // Non-null after null
                queue.offer(node.left);
                queue.offer(node.right);
            }
        }
        
        return true;
    }
}
```

### 7.2 Tree Traversals

#### Depth-First Search (DFS) Traversals
```java
import java.util.*;

public class TreeTraversals {
    
    // 1. Inorder Traversal (Left -> Root -> Right)
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        inorderHelper(root, result);
        return result;
    }
    
    private void inorderHelper(TreeNode root, List<Integer> result) {
        if (root != null) {
            inorderHelper(root.left, result);
            result.add(root.val);
            inorderHelper(root.right, result);
        }
    }
    
    // Iterative inorder using stack
    public List<Integer> inorderIterative(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        Stack<TreeNode> stack = new Stack<>();
        TreeNode current = root;
        
        while (current != null || !stack.isEmpty()) {
            // Go to leftmost node
            while (current != null) {
                stack.push(current);
                current = current.left;
            }
            
            // Process node
            current = stack.pop();
            result.add(current.val);
            
            // Move to right subtree
            current = current.right;
        }
        
        return result;
    }
    
    // 2. Preorder Traversal (Root -> Left -> Right)
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        preorderHelper(root, result);
        return result;
    }
    
    private void preorderHelper(TreeNode root, List<Integer> result) {
        if (root != null) {
            result.add(root.val);
            preorderHelper(root.left, result);
            preorderHelper(root.right, result);
        }
    }
    
    // Iterative preorder
    public List<Integer> preorderIterative(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) return result;
        
        Stack<TreeNode> stack = new Stack<>();
        stack.push(root);
        
        while (!stack.isEmpty()) {
            TreeNode node = stack.pop();
            result.add(node.val);
            
            // Push right first, then left (stack is LIFO)
            if (node.right != null) stack.push(node.right);
            if (node.left != null) stack.push(node.left);
        }
        
        return result;
    }
    
    // 3. Postorder Traversal (Left -> Right -> Root)
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        postorderHelper(root, result);
        return result;
    }
    
    private void postorderHelper(TreeNode root, List<Integer> result) {
        if (root != null) {
            postorderHelper(root.left, result);
            postorderHelper(root.right, result);
            result.add(root.val);
        }
    }
    
    // Iterative postorder (using two stacks)
    public List<Integer> postorderIterative(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) return result;
        
        Stack<TreeNode> stack1 = new Stack<>();
        Stack<TreeNode> stack2 = new Stack<>();
        stack1.push(root);
        
        while (!stack1.isEmpty()) {
            TreeNode node = stack1.pop();
            stack2.push(node);
            
            if (node.left != null) stack1.push(node.left);
            if (node.right != null) stack1.push(node.right);
        }
        
        while (!stack2.isEmpty()) {
            result.add(stack2.pop().val);
        }
        
        return result;
    }
}
```

#### Breadth-First Search (BFS) Traversal
```java
import java.util.*;

public class BFSTraversal {
    
    // Level order traversal
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) return result;
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> currentLevel = new ArrayList<>();
            
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                currentLevel.add(node.val);
                
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            
            result.add(currentLevel);
        }
        
        return result;
    }
    
    // Zigzag level order traversal
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) return result;
        
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean leftToRight = true;
        
        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> currentLevel = new ArrayList<>();
            
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                
                if (leftToRight) {
                    currentLevel.add(node.val);
                } else {
                    currentLevel.add(0, node.val); // Add to beginning
                }
                
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            
            result.add(currentLevel);
            leftToRight = !leftToRight;
        }
        
        return result;
    }
    
    // Vertical order traversal
    public List<List<Integer>> verticalTraversal(TreeNode root) {
        if (root == null) return new ArrayList<>();
        
        // TreeMap to maintain order, inner map for levels
        TreeMap<Integer, TreeMap<Integer, PriorityQueue<Integer>>> map = new TreeMap<>();
        dfs(root, 0, 0, map);
        
        List<List<Integer>> result = new ArrayList<>();
        for (TreeMap<Integer, PriorityQueue<Integer>> levelMap : map.values()) {
            List<Integer> column = new ArrayList<>();
            for (PriorityQueue<Integer> pq : levelMap.values()) {
                while (!pq.isEmpty()) {
                    column.add(pq.poll());
                }
            }
            result.add(column);
        }
        
        return result;
    }
    
    private void dfs(TreeNode node, int x, int y, 
                     TreeMap<Integer, TreeMap<Integer, PriorityQueue<Integer>>> map) {
        if (node == null) return;
        
        map.computeIfAbsent(x, k -> new TreeMap<>())
           .computeIfAbsent(y, k -> new PriorityQueue<>())
           .offer(node.val);
        
        dfs(node.left, x - 1, y + 1, map);
        dfs(node.right, x + 1, y + 1, map);
    }
}
```

### 7.3 Binary Search Tree (BST)

#### BST Implementation
```java
public class BinarySearchTree {
    private TreeNode root;
    
    // Insert into BST
    public TreeNode insert(TreeNode root, int val) {
        if (root == null) {
            return new TreeNode(val);
        }
        
        if (val < root.val) {
            root.left = insert(root.left, val);
        } else if (val > root.val) {
            root.right = insert(root.right, val);
        }
        // Duplicate values not allowed
        
        return root;
    }
    
    // Search in BST
    public boolean search(TreeNode root, int val) {
        if (root == null) return false;
        
        if (val == root.val) return true;
        else if (val < root.val) return search(root.left, val);
        else return search(root.right, val);
    }
    
    // Delete from BST
    public TreeNode deleteNode(TreeNode root, int key) {
        if (root == null) return null;
        
        if (key < root.val) {
            root.left = deleteNode(root.left, key);
        } else if (key > root.val) {
            root.right = deleteNode(root.right, key);
        } else {
            // Node to be deleted found
            if (root.left == null) return root.right;
            if (root.right == null) return root.left;
            
            // Node has two children
            // Find inorder successor (smallest in right subtree)
            TreeNode successor = findMin(root.right);
            root.val = successor.val;
            root.right = deleteNode(root.right, successor.val);
        }
        
        return root;
    }
    
    private TreeNode findMin(TreeNode root) {
        while (root.left != null) {
            root = root.left;
        }
        return root;
    }
    
    // Validate BST
    public boolean isValidBST(TreeNode root) {
        return validate(root, null, null);
    }
    
    private boolean validate(TreeNode node, Integer min, Integer max) {
        if (node == null) return true;
        
        if ((min != null && node.val <= min) || 
            (max != null && node.val >= max)) {
            return false;
        }
        
        return validate(node.left, min, node.val) && 
               validate(node.right, node.val, max);
    }
    
    // Find kth smallest element in BST
    public int kthSmallest(TreeNode root, int k) {
        Stack<TreeNode> stack = new Stack<>();
        TreeNode current = root;
        
        while (current != null || !stack.isEmpty()) {
            while (current != null) {
                stack.push(current);
                current = current.left;
            }
            
            current = stack.pop();
            k--;
            if (k == 0) return current.val;
            
            current = current.right;
        }
        
        return -1; // k is invalid
    }
}
```

### 7.4 Tree Construction

#### Construct Tree from Traversals
```java
import java.util.*;

public class TreeConstruction {
    
    // Build tree from preorder and inorder
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        Map<Integer, Integer> inorderMap = new HashMap<>();
        for (int i = 0; i < inorder.length; i++) {
            inorderMap.put(inorder[i], i);
        }
        
        return buildTreeHelper(preorder, 0, preorder.length - 1,
                              inorder, 0, inorder.length - 1, inorderMap);
    }
    
    private TreeNode buildTreeHelper(int[] preorder, int preStart, int preEnd,
                                   int[] inorder, int inStart, int inEnd,
                                   Map<Integer, Integer> inorderMap) {
        if (preStart > preEnd || inStart > inEnd) return null;
        
        TreeNode root = new TreeNode(preorder[preStart]);
        int rootIndex = inorderMap.get(root.val);
        int leftSubtreeSize = rootIndex - inStart;
        
        root.left = buildTreeHelper(preorder, preStart + 1, 
                                   preStart + leftSubtreeSize,
                                   inorder, inStart, rootIndex - 1, inorderMap);
        
        root.right = buildTreeHelper(preorder, preStart + leftSubtreeSize + 1, 
                                    preEnd,
                                    inorder, rootIndex + 1, inEnd, inorderMap);
        
        return root;
    }
    
    // Build tree from postorder and inorder
    public TreeNode buildTreeFromPostIn(int[] postorder, int[] inorder) {
        Map<Integer, Integer> inorderMap = new HashMap<>();
        for (int i = 0; i < inorder.length; i++) {
            inorderMap.put(inorder[i], i);
        }
        
        return buildPostInHelper(postorder, 0, postorder.length - 1,
                                inorder, 0, inorder.length - 1, inorderMap);
    }
    
    private TreeNode buildPostInHelper(int[] postorder, int postStart, int postEnd,
                                      int[] inorder, int inStart, int inEnd,
                                      Map<Integer, Integer> inorderMap) {
        if (postStart > postEnd || inStart > inEnd) return null;
        
        TreeNode root = new TreeNode(postorder[postEnd]);
        int rootIndex = inorderMap.get(root.val);
        int leftSubtreeSize = rootIndex - inStart;
        
        root.left = buildPostInHelper(postorder, postStart, 
                                     postStart + leftSubtreeSize - 1,
                                     inorder, inStart, rootIndex - 1, inorderMap);
        
        root.right = buildPostInHelper(postorder, postStart + leftSubtreeSize, 
                                      postEnd - 1,
                                      inorder, rootIndex + 1, inEnd, inorderMap);
        
        return root;
    }
}
```

### 7.5 Advanced Tree Problems

#### Lowest Common Ancestor
```java
public class LowestCommonAncestor {
    
    // LCA in binary tree
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null || root == p || root == q) {
            return root;
        }
        
        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        
        if (left != null && right != null) {
            return root; // Current node is LCA
        }
        
        return left != null ? left : right;
    }
    
    // LCA in BST
    public TreeNode lowestCommonAncestorBST(TreeNode root, TreeNode p, TreeNode q) {
        while (root != null) {
            if (p.val < root.val && q.val < root.val) {
                root = root.left;
            } else if (p.val > root.val && q.val > root.val) {
                root = root.right;
            } else {
                return root;
            }
        }
        return null;
    }
}
```

#### Tree Diameter and Paths
```java
public class TreePaths {
    private int maxDiameter = 0;
    
    // Diameter of binary tree
    public int diameterOfBinaryTree(TreeNode root) {
        maxDiameter = 0;
        diameterHelper(root);
        return maxDiameter;
    }
    
    private int diameterHelper(TreeNode node) {
        if (node == null) return 0;
        
        int leftHeight = diameterHelper(node.left);
        int rightHeight = diameterHelper(node.right);
        
        // Update diameter (longest path through current node)
        maxDiameter = Math.max(maxDiameter, leftHeight + rightHeight);
        
        // Return height of current node
        return 1 + Math.max(leftHeight, rightHeight);
    }
    
    // Binary tree paths (root to leaf)
    public List<String> binaryTreePaths(TreeNode root) {
        List<String> result = new ArrayList<>();
        if (root != null) {
            pathsHelper(root, "", result);
        }
        return result;
    }
    
    private void pathsHelper(TreeNode node, String path, List<String> result) {
        if (node.left == null && node.right == null) {
            // Leaf node
            result.add(path + node.val);
            return;
        }
        
        if (node.left != null) {
            pathsHelper(node.left, path + node.val + "->", result);
        }
        
        if (node.right != null) {
            pathsHelper(node.right, path + node.val + "->", result);
        }
    }
    
    // Maximum path sum
    private int maxPathSum = Integer.MIN_VALUE;
    
    public int maxPathSum(TreeNode root) {
        maxPathSum = Integer.MIN_VALUE;
        maxPathSumHelper(root);
        return maxPathSum;
    }
    
    private int maxPathSumHelper(TreeNode node) {
        if (node == null) return 0;
        
        // Get maximum sum from left and right subtrees (ignore negative)
        int leftSum = Math.max(0, maxPathSumHelper(node.left));
        int rightSum = Math.max(0, maxPathSumHelper(node.right));
        
        // Update global maximum (path through current node)
        maxPathSum = Math.max(maxPathSum, node.val + leftSum + rightSum);
        
        // Return maximum path ending at current node
        return node.val + Math.max(leftSum, rightSum);
    }
}
```

#### Tree Serialization
```java
import java.util.*;

public class TreeSerialization {
    
    // Serialize tree to string
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        serializeHelper(root, sb);
        return sb.toString();
    }
    
    private void serializeHelper(TreeNode node, StringBuilder sb) {
        if (node == null) {
            sb.append("null,");
            return;
        }
        
        sb.append(node.val).append(",");
        serializeHelper(node.left, sb);
        serializeHelper(node.right, sb);
    }
    
    // Deserialize string to tree
    public TreeNode deserialize(String data) {
        Queue<String> nodes = new LinkedList<>(Arrays.asList(data.split(",")));
        return deserializeHelper(nodes);
    }
    
    private TreeNode deserializeHelper(Queue<String> nodes) {
        String val = nodes.poll();
        if (val.equals("null")) return null;
        
        TreeNode node = new TreeNode(Integer.parseInt(val));
        node.left = deserializeHelper(nodes);
        node.right = deserializeHelper(nodes);
        
        return node;
    }
}
```

## Practice Problems

### Easy Level
1. **Same Tree** - Check if two trees are identical
2. **Symmetric Tree** - Check if tree is symmetric
3. **Maximum Depth** - Find height of binary tree
4. **Invert Binary Tree** - Mirror the tree
5. **Path Sum** - Check if root-to-leaf path exists with given sum

### Medium Level
1. **Validate Binary Search Tree** - Check if tree is valid BST
2. **Binary Tree Level Order Traversal** - Level-by-level traversal
3. **Construct Binary Tree from Preorder and Inorder** - Build tree from traversals
4. **Populating Next Right Pointers** - Connect nodes at same level
5. **Lowest Common Ancestor** - Find LCA of two nodes

### Hard Level
1. **Binary Tree Maximum Path Sum** - Find path with maximum sum
2. **Serialize and Deserialize Binary Tree** - Convert tree to/from string
3. **Recover Binary Search Tree** - Fix swapped nodes in BST
4. **Binary Tree Postorder Traversal** - Iterative postorder
5. **Vertical Order Traversal** - Print nodes in vertical columns

## Key Patterns

1. **Recursion**: Most tree problems use recursive solutions
2. **DFS vs BFS**: Choose based on problem requirements
3. **Tree Validation**: Use bounds checking for BST validation
4. **Path Problems**: Use recursion with backtracking
5. **Level Processing**: Use BFS for level-by-level operations
6. **Tree Construction**: Use hashmap for efficient index lookup

## Time/Space Complexity

| Operation | BST Average | BST Worst | Binary Tree |
|-----------|-------------|-----------|-------------|
| Search | O(log n) | O(n) | O(n) |
| Insert | O(log n) | O(n) | O(n) |
| Delete | O(log n) | O(n) | O(n) |
| Traversal | O(n) | O(n) | O(n) |
| Space | O(log n) | O(n) | O(n) |

## Next Steps
- Practice tree traversal implementations
- Solve classic tree problems
- Understand BST properties and operations
- Move to **[Module 8: Heaps](../08-heaps/README.md)**
