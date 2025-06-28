# StringBuilder and StringBuffer in Java

## 🎯 Overview

StringBuilder and StringBuffer are mutable sequence classes in Java that provide an efficient way to manipulate strings. Unlike the immutable String class, these classes allow you to modify the character sequence without creating new objects, making them essential for performance-critical string operations.

## 🔍 Why StringBuilder and StringBuffer?

### The Problem with String Concatenation

```java
// Inefficient - Creates multiple String objects
String result = "";
for (int i = 0; i < 1000; i++) {
    result += "Item " + i + " ";  // Creates new String object each time
}
```

**Memory Impact:**
- Each concatenation creates a new String object
- Original strings become eligible for garbage collection
- Time complexity: O(n²) for n concatenations
- Memory overhead increases exponentially

### The Solution: Mutable String Classes

```java
// Efficient - Modifies existing buffer
StringBuilder sb = new StringBuilder();
for (int i = 0; i < 1000; i++) {
    sb.append("Item ").append(i).append(" ");  // Modifies existing buffer
}
String result = sb.toString();
```

## 📚 StringBuilder vs StringBuffer

| Feature | StringBuilder | StringBuffer |
|---------|---------------|--------------|
| **Thread Safety** | Not synchronized (faster) | Synchronized (thread-safe) |
| **Performance** | Better in single-threaded | Slower due to synchronization |
| **Introduced** | Java 5 | Java 1.0 |
| **Use Case** | Single-threaded applications | Multi-threaded applications |

## 🛠️ StringBuilder Fundamentals

### Creating StringBuilder Objects

```java
// Different ways to create StringBuilder
StringBuilder sb1 = new StringBuilder();                    // Empty, capacity 16
StringBuilder sb2 = new StringBuilder(50);                  // Empty, capacity 50
StringBuilder sb3 = new StringBuilder("Hello");             // With initial string
StringBuilder sb4 = new StringBuilder(anotherStringBuilder); // Copy constructor
```

### Capacity vs Length

```java
StringBuilder sb = new StringBuilder("Hello");
System.out.println("Length: " + sb.length());     // 5 (actual characters)
System.out.println("Capacity: " + sb.capacity()); // 21 (16 + 5)

// Capacity grows automatically when needed
sb.append("This is a very long string that exceeds current capacity");
System.out.println("New Capacity: " + sb.capacity()); // Automatically increased
```

## 🔧 Essential StringBuilder Methods

### 1. Append Operations

```java
StringBuilder sb = new StringBuilder();

// Append different data types
sb.append("Hello");              // String
sb.append(' ');                  // char
sb.append(123);                  // int
sb.append(45.67);               // double
sb.append(true);                // boolean
sb.append(new char[]{'!', '!'});// char array

System.out.println(sb.toString()); // "Hello 12345.67true!!"
```

#### Method Chaining
```java
StringBuilder sb = new StringBuilder();
String result = sb.append("Name: ")
                  .append("John")
                  .append(", Age: ")
                  .append(25)
                  .append(", Score: ")
                  .append(95.5)
                  .toString();
```

### 2. Insert Operations

```java
StringBuilder sb = new StringBuilder("Hello World");

sb.insert(5, " Beautiful");      // Insert at index 5
System.out.println(sb);          // "Hello Beautiful World"

sb.insert(0, ">>> ");           // Insert at beginning
System.out.println(sb);          // ">>> Hello Beautiful World"

sb.insert(sb.length(), " <<<"); // Insert at end
System.out.println(sb);          // ">>> Hello Beautiful World <<<"
```

### 3. Delete Operations

```java
StringBuilder sb = new StringBuilder("Hello Beautiful World");

// Delete range [start, end)
sb.delete(5, 15);               // Remove " Beautiful"
System.out.println(sb);         // "Hello World"

// Delete single character
sb.deleteCharAt(5);             // Remove 'W'
System.out.println(sb);         // "Hello orld"
```

### 4. Replace Operations

```java
StringBuilder sb = new StringBuilder("Hello World");

// Replace substring
sb.replace(6, 11, "Java");      // Replace "World" with "Java"
System.out.println(sb);         // "Hello Java"

// Replace character at specific index
sb.setCharAt(6, 'j');          // Change 'J' to 'j'
System.out.println(sb);         // "Hello java"
```

### 5. Reverse Operation

```java
StringBuilder sb = new StringBuilder("Hello World");
sb.reverse();
System.out.println(sb);         // "dlroW olleH"

// Useful for palindrome checking
public static boolean isPalindrome(String str) {
    StringBuilder sb = new StringBuilder(str.toLowerCase());
    return str.toLowerCase().equals(sb.reverse().toString());
}
```

### 6. Substring Operations

```java
StringBuilder sb = new StringBuilder("Hello World");

// Get substring (doesn't modify original)
String sub1 = sb.substring(6);      // "World"
String sub2 = sb.substring(0, 5);   // "Hello"

// Get character at index
char ch = sb.charAt(6);             // 'W'

// Find index of substring
int index = sb.indexOf("World");    // 6
int lastIndex = sb.lastIndexOf("o"); // 7
```

## 🎯 Performance Optimization

### Capacity Management

```java
// Pre-allocate capacity for better performance
public static String buildLargeString() {
    StringBuilder sb = new StringBuilder(10000); // Pre-allocate
    
    for (int i = 0; i < 1000; i++) {
        sb.append("Item ").append(i).append(" - ");
    }
    
    return sb.toString();
}
```

### Memory Efficiency

```java
// Trim capacity to actual size
StringBuilder sb = new StringBuilder(1000);
sb.append("Small string");

// Before trimming
System.out.println("Capacity: " + sb.capacity()); // 1000

// Trim to actual size
sb.trimToSize();
System.out.println("Capacity: " + sb.capacity()); // Reduced to fit content
```

## 🛡️ StringBuffer for Thread Safety

```java
public class ThreadSafeStringBuilder {
    private StringBuffer buffer = new StringBuffer();
    
    public synchronized void appendSafely(String str) {
        buffer.append(str);
    }
    
    public String getResult() {
        return buffer.toString();
    }
}

// Alternative: Use StringBuilder with external synchronization
public class ExternalSync {
    private StringBuilder sb = new StringBuilder();
    private Object lock = new Object();
    
    public void appendSafely(String str) {
        synchronized(lock) {
            sb.append(str);
        }
    }
}
```

## 🏁 Practical Examples

### 1. CSV Builder

```java
public class CSVBuilder {
    private StringBuilder csv;
    private String delimiter;
    
    public CSVBuilder(String delimiter) {
        this.csv = new StringBuilder();
        this.delimiter = delimiter;
    }
    
    public CSVBuilder addField(String field) {
        if (csv.length() > 0) {
            csv.append(delimiter);
        }
        
        // Escape fields containing delimiter
        if (field.contains(delimiter)) {
            csv.append("\"").append(field.replace("\"", "\"\"")).append("\"");
        } else {
            csv.append(field);
        }
        
        return this;
    }
    
    public CSVBuilder newRow() {
        csv.append("\n");
        return this;
    }
    
    public String build() {
        return csv.toString();
    }
}

// Usage
CSVBuilder builder = new CSVBuilder(",");
String csv = builder
    .addField("Name").addField("Age").addField("City").newRow()
    .addField("John").addField("25").addField("New York").newRow()
    .addField("Jane").addField("30").addField("Los Angeles")
    .build();
```

### 2. SQL Query Builder

```java
public class SQLQueryBuilder {
    private StringBuilder query;
    
    public SQLQueryBuilder() {
        this.query = new StringBuilder();
    }
    
    public SQLQueryBuilder select(String... columns) {
        query.append("SELECT ");
        for (int i = 0; i < columns.length; i++) {
            if (i > 0) query.append(", ");
            query.append(columns[i]);
        }
        return this;
    }
    
    public SQLQueryBuilder from(String table) {
        query.append(" FROM ").append(table);
        return this;
    }
    
    public SQLQueryBuilder where(String condition) {
        query.append(" WHERE ").append(condition);
        return this;
    }
    
    public SQLQueryBuilder and(String condition) {
        query.append(" AND ").append(condition);
        return this;
    }
    
    public SQLQueryBuilder orderBy(String column) {
        query.append(" ORDER BY ").append(column);
        return this;
    }
    
    public String build() {
        return query.toString();
    }
}

// Usage
String sql = new SQLQueryBuilder()
    .select("name", "age", "email")
    .from("users")
    .where("age > 18")
    .and("status = 'active'")
    .orderBy("name")
    .build();
```

### 3. HTML Generator

```java
public class HTMLBuilder {
    private StringBuilder html;
    private int indentLevel;
    
    public HTMLBuilder() {
        this.html = new StringBuilder();
        this.indentLevel = 0;
    }
    
    public HTMLBuilder openTag(String tag) {
        addIndent();
        html.append("<").append(tag).append(">\n");
        indentLevel++;
        return this;
    }
    
    public HTMLBuilder openTag(String tag, String attributes) {
        addIndent();
        html.append("<").append(tag).append(" ").append(attributes).append(">\n");
        indentLevel++;
        return this;
    }
    
    public HTMLBuilder closeTag(String tag) {
        indentLevel--;
        addIndent();
        html.append("</").append(tag).append(">\n");
        return this;
    }
    
    public HTMLBuilder addContent(String content) {
        addIndent();
        html.append(content).append("\n");
        return this;
    }
    
    private void addIndent() {
        for (int i = 0; i < indentLevel; i++) {
            html.append("  ");
        }
    }
    
    public String build() {
        return html.toString();
    }
}

// Usage
String htmlPage = new HTMLBuilder()
    .openTag("html")
        .openTag("head")
            .openTag("title")
                .addContent("My Page")
            .closeTag("title")
        .closeTag("head")
        .openTag("body")
            .openTag("h1")
                .addContent("Welcome!")
            .closeTag("h1")
        .closeTag("body")
    .closeTag("html")
    .build();
```

## ⚠️ Common Pitfalls and Best Practices

### 1. Unnecessary toString() Calls

```java
// Bad - Multiple toString() calls
StringBuilder sb = new StringBuilder();
sb.append("Hello");
String temp = sb.toString();  // Unnecessary
sb.append(" World");
return sb.toString();

// Good - Single toString() call at the end
StringBuilder sb = new StringBuilder();
sb.append("Hello");
sb.append(" World");
return sb.toString();
```

### 2. Using StringBuilder for Simple Concatenation

```java
// Bad - Overkill for simple concatenation
StringBuilder sb = new StringBuilder();
sb.append(firstName).append(" ").append(lastName);
return sb.toString();

// Good - Direct concatenation for simple cases
return firstName + " " + lastName;

// StringBuilder beneficial for multiple operations
StringBuilder sb = new StringBuilder();
for (String item : items) {
    sb.append(item).append(", ");
}
```

### 3. Not Considering Initial Capacity

```java
// Bad - May cause multiple buffer expansions
StringBuilder sb = new StringBuilder();
for (int i = 0; i < 10000; i++) {
    sb.append("data");
}

// Good - Pre-allocate appropriate capacity
StringBuilder sb = new StringBuilder(40000); // 4 chars * 10000
for (int i = 0; i < 10000; i++) {
    sb.append("data");
}
```

### 4. Thread Safety Misconceptions

```java
// Bad - False assumption about thread safety
StringBuilder sb = new StringBuilder();
// Multiple threads accessing sb concurrently - UNSAFE!

// Good - Use StringBuffer for thread safety
StringBuffer sb = new StringBuffer();
// Or use StringBuilder with external synchronization
```

## 🔍 Performance Comparison

```java
public class StringPerformanceTest {
    private static final int ITERATIONS = 10000;
    
    public static void testStringConcatenation() {
        long start = System.currentTimeMillis();
        String result = "";
        for (int i = 0; i < ITERATIONS; i++) {
            result += "test" + i;
        }
        long end = System.currentTimeMillis();
        System.out.println("String concatenation: " + (end - start) + "ms");
    }
    
    public static void testStringBuilder() {
        long start = System.currentTimeMillis();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < ITERATIONS; i++) {
            sb.append("test").append(i);
        }
        String result = sb.toString();
        long end = System.currentTimeMillis();
        System.out.println("StringBuilder: " + (end - start) + "ms");
    }
    
    public static void testStringBuffer() {
        long start = System.currentTimeMillis();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < ITERATIONS; i++) {
            sb.append("test").append(i);
        }
        String result = sb.toString();
        long end = System.currentTimeMillis();
        System.out.println("StringBuffer: " + (end - start) + "ms");
    }
}
```

## 🎯 Advanced Techniques

### 1. Custom StringBuilder Extensions

```java
public class EnhancedStringBuilder {
    private StringBuilder sb;
    
    public EnhancedStringBuilder() {
        this.sb = new StringBuilder();
    }
    
    public EnhancedStringBuilder appendLine(String str) {
        sb.append(str).append(System.lineSeparator());
        return this;
    }
    
    public EnhancedStringBuilder appendIf(boolean condition, String str) {
        if (condition) {
            sb.append(str);
        }
        return this;
    }
    
    public EnhancedStringBuilder appendFormat(String format, Object... args) {
        sb.append(String.format(format, args));
        return this;
    }
    
    public EnhancedStringBuilder repeat(String str, int times) {
        for (int i = 0; i < times; i++) {
            sb.append(str);
        }
        return this;
    }
    
    public String build() {
        return sb.toString();
    }
}
```

### 2. Memory-Efficient Large String Processing

```java
public class LargeStringProcessor {
    private static final int CHUNK_SIZE = 1024;
    
    public static String processLargeData(List<String> data) {
        // Calculate approximate final size
        int estimatedSize = data.size() * 50; // Estimate average string length
        StringBuilder sb = new StringBuilder(estimatedSize);
        
        for (String item : data) {
            sb.append(processItem(item));
            
            // Prevent excessive memory usage
            if (sb.length() > 1000000) { // 1MB threshold
                String partial = sb.toString();
                sb = new StringBuilder();
                // Process partial result or write to file
                writeToFile(partial);
            }
        }
        
        return sb.toString();
    }
    
    private static String processItem(String item) {
        return item.toUpperCase() + " | ";
    }
    
    private static void writeToFile(String content) {
        // Implementation for writing large content to file
    }
}
```

## 📋 Summary

StringBuilder and StringBuffer are essential tools for efficient string manipulation in Java:

### Key Takeaways:
1. **Use StringBuilder** for single-threaded string building operations
2. **Use StringBuffer** only when thread safety is required
3. **Pre-allocate capacity** when the approximate final size is known
4. **Avoid unnecessary toString()** calls during building process
5. **Method chaining** makes code more readable and fluent
6. **Consider memory implications** for very large string operations

### When to Use:
- ✅ Multiple string concatenations in loops
- ✅ Building complex strings dynamically
- ✅ Performance-critical string operations
- ✅ Creating formatted output (CSV, HTML, SQL)

### When NOT to Use:
- ❌ Simple concatenation of 2-3 strings
- ❌ One-time string operations
- ❌ When the String concatenation is more readable

Understanding StringBuilder and StringBuffer is crucial for writing efficient Java applications, especially when dealing with large amounts of text processing or frequent string manipulations.
