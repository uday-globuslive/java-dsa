# Understanding JVM, JRE, and JDK

## Overview
Understanding the Java platform architecture is crucial for every Java developer. This guide explains the relationship between JVM, JRE, and JDK.

## Java Platform Components

### JVM (Java Virtual Machine)
The **Java Virtual Machine** is the runtime environment that executes Java bytecode.

**Key Features:**
- Platform-independent execution
- Memory management and garbage collection
- Security and isolation
- Just-In-Time (JIT) compilation

```java
// Java source code
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

**Compilation and Execution Process:**
1. **Source Code** (.java) → **Compiler (javac)** → **Bytecode** (.class)
2. **Bytecode** → **JVM** → **Machine Code** → **Execution**

### JRE (Java Runtime Environment)
The **Java Runtime Environment** provides the libraries and JVM needed to run Java applications.

**Components:**
- JVM (Java Virtual Machine)
- Core Libraries (java.lang, java.util, etc.)
- Supporting files and tools

**When to use JRE:**
- Running Java applications
- End-user machines
- Production servers (runtime only)

### JDK (Java Development Kit)
The **Java Development Kit** includes everything needed to develop Java applications.

**Components:**
- JRE (complete runtime environment)
- Development tools (javac, javadoc, jar, etc.)
- Debugging tools
- Documentation

**When to use JDK:**
- Developing Java applications
- Developer machines
- Build servers

## Architecture Diagram

```
┌─────────────────────────────────────┐
│                JDK                  │
│  ┌─────────────────────────────────┐│
│  │              JRE                ││
│  │  ┌─────────────────────────────┐││
│  │  │            JVM              │││
│  │  │  ┌─────────────────────────┐│││
│  │  │  │     Class Loader        ││││
│  │  │  │     Memory Areas        ││││
│  │  │  │     Execution Engine    ││││
│  │  │  └─────────────────────────┘│││
│  │  │                             │││
│  │  │     Java Libraries          │││
│  │  │     (java.lang, java.util)  │││
│  │  └─────────────────────────────┘││
│  └─────────────────────────────────┘│
│                                     │
│  Development Tools:                 │
│  • javac (compiler)                 │
│  • jar (archiver)                   │
│  • javadoc (documentation)          │
│  • debugger                         │
└─────────────────────────────────────┘
```

## JVM Memory Structure

### Method Area
- Stores class-level data
- Method definitions
- Constant pool

### Heap Memory
- Object storage
- Divided into Young and Old generations
- Garbage collection occurs here

### Stack Memory
- Method call frames
- Local variables
- Thread-specific

### PC Register
- Program Counter
- Tracks current instruction

### Native Method Stack
- Native method calls
- JNI (Java Native Interface)

## Platform Independence

### Write Once, Run Anywhere (WORA)
```java
// Same Java code runs on all platforms
public class PlatformDemo {
    public static void main(String[] args) {
        System.out.println("Operating System: " + 
                          System.getProperty("os.name"));
        System.out.println("Java Version: " + 
                          System.getProperty("java.version"));
    }
}
```

### Bytecode Example
```
// Java source
int x = 5;
int y = 10;
int sum = x + y;

// Corresponding bytecode (simplified)
bipush 5        // Push 5 onto stack
istore_1        // Store in local variable 1 (x)
bipush 10       // Push 10 onto stack
istore_2        // Store in local variable 2 (y)
iload_1         // Load x
iload_2         // Load y
iadd            // Add
istore_3        // Store result in sum
```

## Version History

### Major Java Versions
- **Java 8 (LTS):** Lambda expressions, Stream API
- **Java 11 (LTS):** String methods, HTTP Client
- **Java 17 (LTS):** Sealed classes, Pattern matching
- **Java 21 (LTS):** Virtual threads, String templates

### Checking Your Version
```bash
# Check Java runtime version
java -version

# Check compiler version
javac -version

# Check detailed version info
java -XshowSettings:properties -version
```

## JVM Arguments and Tuning

### Memory Settings
```bash
# Set heap size
java -Xms512m -Xmx2g MyApplication

# Set stack size
java -Xss256k MyApplication

# Enable garbage collection logging
java -XX:+PrintGC -XX:+PrintGCDetails MyApplication
```

### Common JVM Arguments
```java
// Example application
public class MemoryDemo {
    public static void main(String[] args) {
        // Get runtime information
        Runtime runtime = Runtime.getRuntime();
        
        long maxMemory = runtime.maxMemory();
        long totalMemory = runtime.totalMemory();
        long freeMemory = runtime.freeMemory();
        
        System.out.println("Max memory: " + (maxMemory / 1024 / 1024) + " MB");
        System.out.println("Total memory: " + (totalMemory / 1024 / 1024) + " MB");
        System.out.println("Free memory: " + (freeMemory / 1024 / 1024) + " MB");
    }
}
```

## Practical Examples

### Environment Information
```java
public class EnvironmentInfo {
    public static void main(String[] args) {
        // Java version information
        System.out.println("Java Version: " + System.getProperty("java.version"));
        System.out.println("Java Vendor: " + System.getProperty("java.vendor"));
        System.out.println("Java Home: " + System.getProperty("java.home"));
        
        // JVM information
        System.out.println("JVM Name: " + System.getProperty("java.vm.name"));
        System.out.println("JVM Version: " + System.getProperty("java.vm.version"));
        
        // Operating system
        System.out.println("OS Name: " + System.getProperty("os.name"));
        System.out.println("OS Version: " + System.getProperty("os.version"));
        System.out.println("OS Architecture: " + System.getProperty("os.arch"));
        
        // User information
        System.out.println("User Name: " + System.getProperty("user.name"));
        System.out.println("User Home: " + System.getProperty("user.home"));
        System.out.println("Working Directory: " + System.getProperty("user.dir"));
    }
}
```

### Class Loading Example
```java
public class ClassLoadingDemo {
    public static void main(String[] args) {
        // Get class loader information
        ClassLoader classLoader = ClassLoadingDemo.class.getClassLoader();
        
        System.out.println("Class Loader: " + classLoader);
        System.out.println("Parent Class Loader: " + classLoader.getParent());
        
        // Load a class dynamically
        try {
            Class<?> stringClass = classLoader.loadClass("java.lang.String");
            System.out.println("Loaded class: " + stringClass.getName());
        } catch (ClassNotFoundException e) {
            System.out.println("Class not found: " + e.getMessage());
        }
    }
}
```

## Installation Verification

### Verify Installation
```java
public class InstallationCheck {
    public static void main(String[] args) {
        try {
            // Check if we can compile and run
            System.out.println("✓ Java installation successful!");
            System.out.println("✓ JDK version: " + System.getProperty("java.version"));
            System.out.println("✓ Compiler available: javac");
            System.out.println("✓ Runtime available: java");
            
            // Test basic functionality
            testBasicFeatures();
            
        } catch (Exception e) {
            System.out.println("✗ Installation issue: " + e.getMessage());
        }
    }
    
    private static void testBasicFeatures() {
        // Test collections
        java.util.List<String> list = new java.util.ArrayList<>();
        list.add("Java");
        list.add("is");
        list.add("working!");
        
        System.out.println("✓ Collections working: " + String.join(" ", list));
        
        // Test lambda (Java 8+)
        list.stream()
            .map(String::toUpperCase)
            .forEach(s -> System.out.println("✓ Lambda working: " + s));
    }
}
```

## Common Issues and Solutions

### Issue 1: JAVA_HOME not set
```bash
# Windows
set JAVA_HOME=C:\Program Files\Java\jdk-17

# Linux/Mac
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

### Issue 2: PATH not configured
```bash
# Add to PATH
export PATH=$JAVA_HOME/bin:$PATH
```

### Issue 3: Version conflicts
```bash
# Check which java is being used
which java
whereis java

# Use specific version
/path/to/specific/java/bin/java -version
```

## Best Practices

### Development Environment
1. **Use LTS versions** for production
2. **Keep JDK updated** for latest features
3. **Configure IDE properly** with correct JDK
4. **Use build tools** (Maven, Gradle) for dependency management

### Runtime Environment
1. **Monitor memory usage** and tune JVM parameters
2. **Enable logging** for troubleshooting
3. **Use appropriate garbage collector** for your use case
4. **Profile applications** to identify bottlenecks

## Next Steps

Now that you understand the Java platform:
1. Verify your installation with the provided examples
2. Experiment with JVM arguments
3. Move to [Program Structure](./program-structure.md)
4. Start writing your first Java programs

## Key Takeaways

- **JDK** contains everything needed for development
- **JRE** is sufficient for running Java applications
- **JVM** provides platform independence
- **Bytecode** enables "write once, run anywhere"
- **Memory management** is handled automatically
- **Version compatibility** is important for deployment
