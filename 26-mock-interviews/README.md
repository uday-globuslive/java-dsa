# Module 26: Mock Interviews

## Overview
This module provides a comprehensive mock interview system to simulate real technical interviews. Practice with various formats, difficulty levels, and company-specific scenarios to build confidence and interview skills.

## Learning Objectives
- Experience realistic interview scenarios
- Practice time management under pressure
- Develop communication skills for technical problems
- Build confidence through repeated practice
- Learn to handle various interview formats

## Interview Formats

### 1. Phone/Video Screening
**Duration:** 30-45 minutes
**Focus:** Basic problem-solving, communication

```java
// Sample Phone Screen Problem
public class PhoneScreen {
    /**
     * Problem: Two Sum
     * Given an array and target, find two numbers that add up to target
     * Time: O(n), Space: O(n)
     */
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (map.containsKey(complement)) {
                return new int[]{map.get(complement), i};
            }
            map.put(nums[i], i);
        }
        
        throw new IllegalArgumentException("No solution found");
    }
}
```

### 2. Technical Deep Dive
**Duration:** 45-60 minutes
**Focus:** Complex algorithms, system design basics

```java
// Sample Technical Interview Problem
public class TechnicalInterview {
    /**
     * Problem: LRU Cache Implementation
     * Design and implement an LRU (Least Recently Used) cache
     */
    class LRUCache {
        class Node {
            int key, value;
            Node prev, next;
            
            Node(int key, int value) {
                this.key = key;
                this.value = value;
            }
        }
        
        private int capacity;
        private Map<Integer, Node> map;
        private Node head, tail;
        
        public LRUCache(int capacity) {
            this.capacity = capacity;
            this.map = new HashMap<>();
            
            // Create dummy head and tail
            head = new Node(-1, -1);
            tail = new Node(-1, -1);
            head.next = tail;
            tail.prev = head;
        }
        
        public int get(int key) {
            if (map.containsKey(key)) {
                Node node = map.get(key);
                moveToHead(node);
                return node.value;
            }
            return -1;
        }
        
        public void put(int key, int value) {
            if (map.containsKey(key)) {
                Node node = map.get(key);
                node.value = value;
                moveToHead(node);
            } else {
                if (map.size() >= capacity) {
                    removeLast();
                }
                Node newNode = new Node(key, value);
                addToHead(newNode);
                map.put(key, newNode);
            }
        }
        
        private void addToHead(Node node) {
            node.next = head.next;
            head.next.prev = node;
            head.next = node;
            node.prev = head;
        }
        
        private void removeNode(Node node) {
            node.prev.next = node.next;
            node.next.prev = node.prev;
        }
        
        private void moveToHead(Node node) {
            removeNode(node);
            addToHead(node);
        }
        
        private void removeLast() {
            Node last = tail.prev;
            map.remove(last.key);
            removeNode(last);
        }
    }
}
```

### 3. System Design Interview
**Duration:** 45-60 minutes
**Focus:** Architecture, scalability, trade-offs

```java
// Sample System Design Discussion Points
public class SystemDesignInterview {
    /**
     * Design a URL Shortener (like bit.ly)
     * 
     * Requirements:
     * - Shorten long URLs
     * - Redirect short URLs to original
     * - Custom aliases (optional)
     * - Analytics (optional)
     * 
     * Components:
     * 1. URL Encoding Service
     * 2. Database (URL mappings)
     * 3. Cache Layer (Redis)
     * 4. Load Balancer
     * 5. Analytics Service
     */
    
    class URLShortener {
        private static final String BASE62 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private Map<String, String> urlMap; // short -> long
        private Map<String, String> reverseMap; // long -> short
        private long counter;
        
        public URLShortener() {
            this.urlMap = new HashMap<>();
            this.reverseMap = new HashMap<>();
            this.counter = 1;
        }
        
        public String encode(String longUrl) {
            if (reverseMap.containsKey(longUrl)) {
                return reverseMap.get(longUrl);
            }
            
            String shortUrl = "http://tinyurl.com/" + base62Encode(counter++);
            urlMap.put(shortUrl, longUrl);
            reverseMap.put(longUrl, shortUrl);
            return shortUrl;
        }
        
        public String decode(String shortUrl) {
            return urlMap.get(shortUrl);
        }
        
        private String base62Encode(long num) {
            StringBuilder sb = new StringBuilder();
            while (num > 0) {
                sb.append(BASE62.charAt((int)(num % 62)));
                num /= 62;
            }
            return sb.reverse().toString();
        }
    }
}
```

## Mock Interview Templates

### Template 1: Behavioral + Coding (60 minutes)
```
1. Introductions (5 minutes)
2. Behavioral Questions (15 minutes)
   - Tell me about yourself
   - Describe a challenging project
   - How do you handle conflicts?
3. Coding Problem (35 minutes)
   - Problem explanation (5 minutes)
   - Solution development (25 minutes)
   - Testing and optimization (5 minutes)
4. Questions for interviewer (5 minutes)
```

### Template 2: Multiple Coding Problems (45 minutes)
```
1. Warm-up Problem (10 minutes)
   - Easy array/string manipulation
2. Main Problem (25 minutes)
   - Medium difficulty algorithm
3. Follow-up Questions (10 minutes)
   - Optimization discussions
   - Edge cases
   - Alternative approaches
```

### Template 3: System Design Focus (60 minutes)
```
1. Problem Introduction (10 minutes)
2. Requirements Gathering (10 minutes)
3. High-level Design (15 minutes)
4. Detailed Component Design (15 minutes)
5. Scale and Optimization (10 minutes)
```

## Company-Specific Mock Interviews

### Google Style
**Focus:** Algorithmic thinking, clean code
**Sample Problems:**
- Array manipulations with optimal time/space complexity
- Tree and graph traversals
- Dynamic programming with optimization

```java
// Google-style problem
public class GoogleInterview {
    /**
     * Problem: Maximum Subarray Product
     * Find the contiguous subarray with the largest product
     */
    public int maxProduct(int[] nums) {
        int maxSoFar = nums[0];
        int minSoFar = nums[0];
        int result = nums[0];
        
        for (int i = 1; i < nums.length; i++) {
            int temp = maxSoFar;
            maxSoFar = Math.max(nums[i], Math.max(maxSoFar * nums[i], minSoFar * nums[i]));
            minSoFar = Math.min(nums[i], Math.min(temp * nums[i], minSoFar * nums[i]));
            result = Math.max(result, maxSoFar);
        }
        
        return result;
    }
}
```

### Amazon Style
**Focus:** Leadership principles, scalable solutions
**Sample Problems:**
- Working backwards from customer needs
- Optimization and efficiency focus

```java
// Amazon-style problem
public class AmazonInterview {
    /**
     * Problem: Design a recommendation system
     * Consider scalability and customer obsession
     */
    class RecommendationSystem {
        private Map<String, Set<String>> userPurchases;
        private Map<String, Map<String, Integer>> itemSimilarity;
        
        public List<String> recommend(String userId, int count) {
            Set<String> purchased = userPurchases.get(userId);
            Map<String, Double> scores = new HashMap<>();
            
            // Calculate recommendation scores
            for (String item : purchased) {
                Map<String, Integer> similar = itemSimilarity.get(item);
                if (similar != null) {
                    for (Map.Entry<String, Integer> entry : similar.entrySet()) {
                        if (!purchased.contains(entry.getKey())) {
                            scores.merge(entry.getKey(), entry.getValue().doubleValue(), Double::sum);
                        }
                    }
                }
            }
            
            // Return top recommendations
            return scores.entrySet().stream()
                .sorted(Map.Entry.<String, Double>comparingByValue().reversed())
                .limit(count)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
        }
    }
}
```

### Microsoft Style
**Focus:** Problem-solving approach, collaboration
**Sample Problems:**
- Object-oriented design
- API design considerations

### Meta (Facebook) Style
**Focus:** Product thinking, user impact
**Sample Problems:**
- Social network algorithms
- Feed ranking systems

## Interview Evaluation Criteria

### Technical Skills (40%)
- **Problem Understanding:** Correctly interprets requirements
- **Algorithm Design:** Chooses appropriate approach
- **Code Quality:** Clean, readable, maintainable code
- **Optimization:** Considers time/space complexity
- **Testing:** Identifies edge cases and bugs

### Problem-Solving Process (30%)
- **Approach:** Systematic problem breakdown
- **Communication:** Explains thinking clearly
- **Iteration:** Improves solution incrementally
- **Debugging:** Identifies and fixes issues

### Communication (20%)
- **Clarity:** Explains concepts clearly
- **Questions:** Asks relevant clarifying questions
- **Collaboration:** Works well with interviewer
- **Confidence:** Demonstrates technical confidence

### Cultural Fit (10%)
- **Enthusiasm:** Shows genuine interest
- **Learning:** Demonstrates growth mindset
- **Values:** Aligns with company values

## Practice Schedule

### Week 1-2: Foundation
- Daily 30-minute mock interviews
- Focus on easy problems
- Build communication habits

### Week 3-4: Intermediate
- 45-minute sessions
- Medium difficulty problems
- Add system design basics

### Week 5-6: Advanced
- Full 60-minute interviews
- Hard problems and system design
- Company-specific practice

### Week 7-8: Polish
- Record and review sessions
- Focus on weak areas
- Stress test under pressure

## Self-Assessment Checklist

### Before Interview
- [ ] Research company and role
- [ ] Review common patterns
- [ ] Practice on whiteboard/paper
- [ ] Prepare behavioral examples
- [ ] Set up quiet environment

### During Interview
- [ ] Listen carefully to problem
- [ ] Ask clarifying questions
- [ ] Think out loud
- [ ] Start with brute force
- [ ] Optimize step by step
- [ ] Test with examples
- [ ] Handle edge cases

### After Interview
- [ ] Reflect on performance
- [ ] Note areas for improvement
- [ ] Practice missed concepts
- [ ] Update preparation strategy

## Common Mistakes to Avoid

### Technical Mistakes
1. **Jumping to code too quickly**
2. **Not considering edge cases**
3. **Poor variable naming**
4. **Inefficient algorithms**
5. **Not testing the solution**

### Communication Mistakes
1. **Silent problem solving**
2. **Not asking questions**
3. **Arguing with interviewer**
4. **Getting stuck without asking for help**
5. **Not explaining the approach**

### Behavioral Mistakes
1. **Negative comments about previous employers**
2. **Not preparing STAR examples**
3. **Being dishonest about experience**
4. **Not showing enthusiasm**
5. **Not asking thoughtful questions**

## Mock Interview Problems by Difficulty

### Easy Level (Phone Screens)
1. Two Sum
2. Valid Parentheses
3. Merge Two Sorted Lists
4. Maximum Depth of Binary Tree
5. Remove Duplicates from Sorted Array

### Medium Level (Technical Rounds)
1. LRU Cache
2. Word Search
3. Course Schedule
4. Validate Binary Search Tree
5. Group Anagrams

### Hard Level (Senior Positions)
1. Median of Two Sorted Arrays
2. Serialize and Deserialize Binary Tree
3. Word Ladder II
4. Regular Expression Matching
5. Merge k Sorted Lists

## Resources for Practice

### Mock Interview Platforms
- **Pramp:** Free peer-to-peer practice
- **Interviewing.io:** Anonymous practice with engineers
- **LeetCode Mock Interview:** Timed practice sessions
- **CodeSignal:** Company-specific practice

### Recording and Review
- **Setup:** Use screen recording software
- **Review:** Analyze communication and approach
- **Improvement:** Focus on identified weak areas
- **Progress:** Track improvement over time

## Final Tips

### Day Before Interview
1. Review key patterns and templates
2. Get good sleep
3. Prepare environment and materials
4. Do light practice (no new concepts)
5. Plan arrival/connection details

### Day of Interview
1. Arrive early or test connection
2. Stay calm and confident
3. Treat interviewer as collaborator
4. Focus on process over perfection
5. Learn from the experience

Remember: Mock interviews are practice, not performance. Use them to build skills, confidence, and interview intuition. The goal is continuous improvement, not perfection.
