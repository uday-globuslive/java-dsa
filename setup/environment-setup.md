# Development Environment Setup Guide

## 🎯 Complete Development Environment

This guide will help you set up a professional Java development environment optimized for data structures and algorithms practice.

## 🔧 Core Requirements

### 1. Java Development Kit (JDK)
**Recommended:** JDK 17 LTS or JDK 21 LTS

#### Windows Installation
```powershell
# Option 1: Download from Oracle/OpenJDK
# Visit: https://adoptium.net/temurin/releases/
# Download: Eclipse Temurin JDK 17+ (LTS)

# Option 2: Using Chocolatey (if installed)
choco install openjdk17

# Option 3: Using Scoop (if installed)
scoop install openjdk17
```

#### Verify Installation
```powershell
java -version
javac -version
```

Expected output:
```
openjdk version "17.0.x" 
OpenJDK Runtime Environment Temurin-17.0.x
javac 17.0.x
```

### 2. Environment Variables Setup

#### Windows Environment Variables
```powershell
# Set JAVA_HOME (replace with your actual JDK path)
setx JAVA_HOME "C:\Program Files\Eclipse Adoptium\jdk-17.0.x-hotspot"

# Add to PATH
setx PATH "%PATH%;%JAVA_HOME%\bin"

# Verify (restart command prompt first)
echo %JAVA_HOME%
echo %PATH%
```

#### Permanent Setup via System Properties
1. Right-click "This PC" → Properties
2. Advanced System Settings → Environment Variables
3. System Variables → New:
   - Variable name: `JAVA_HOME`
   - Variable value: `C:\Program Files\Eclipse Adoptium\jdk-17.0.x-hotspot`
4. Edit PATH variable → Add: `%JAVA_HOME%\bin`

## 💻 IDE Setup Options

### Option 1: IntelliJ IDEA (Recommended)

#### Download and Install
1. Visit [JetBrains IntelliJ IDEA](https://www.jetbrains.com/idea/download/)
2. Download Community Edition (Free)
3. Run installer with default settings

#### Initial Configuration
```java
// Create first project
// File → New → Project
// Choose "Java" → Project SDK: Select your JDK
// Project template: Command Line App
```

#### Essential IntelliJ Settings
```java
// File → Settings (Ctrl+Alt+S)

// 1. Editor → General → Auto Import
// ✓ Add unambiguous imports on the fly
// ✓ Optimize imports on the fly

// 2. Editor → Code Style → Java
// Scheme: Default
// Tab size: 4
// Indent: 4
// Continuation indent: 8

// 3. Build, Execution, Deployment → Compiler
// ✓ Build project automatically
// Heap size: 2048 MB (if you have sufficient RAM)

// 4. Editor → Live Templates
// Add custom templates for competitive programming
```

#### Useful IntelliJ Plugins
```java
// File → Settings → Plugins → Marketplace

// Essential for DSA:
1. "Key Promoter X" - Learn shortcuts faster
2. "Rainbow Brackets" - Better bracket visualization
3. "CodeGlance" - Code minimap
4. "String Manipulation" - Text processing tools
5. "Competitive Programming Helper" - Contest setup
```

#### IntelliJ Live Templates for DSA
```java
// File → Settings → Editor → Live Templates → Java

// Template 1: Main method
// Abbreviation: main
// Template text:
public static void main(String[] args) {
    $END$
}

// Template 2: Fast I/O Scanner
// Abbreviation: fastscan
// Template text:
Scanner scanner = new Scanner(System.in);
int n = scanner.nextInt();
scanner.close();

// Template 3: Array input
// Abbreviation: arrin
// Template text:
int[] arr = new int[n];
for (int i = 0; i < n; i++) {
    arr[i] = scanner.nextInt();
}

// Template 4: 2D Array
// Abbreviation: arr2d
// Template text:
int[][] matrix = new int[rows][cols];
for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
        matrix[i][j] = scanner.nextInt();
    }
}
```

### Option 2: Visual Studio Code

#### Installation and Setup
```powershell
# Download VS Code from: https://code.visualstudio.com/
# Or using package manager:
winget install Microsoft.VisualStudioCode
```

#### Essential Extensions
```json
// Install these extensions for Java development:
{
  "recommendations": [
    "vscjava.vscode-java-pack",
    "redhat.java",
    "vscjava.vscode-java-debug",
    "vscjava.vscode-java-test",
    "vscjava.vscode-maven",
    "formulahendry.code-runner",
    "ms-vscode.bracket-pair-colorizer-2",
    "oderwat.indent-rainbow",
    "aaron-bond.better-comments"
  ]
}
```

#### VS Code Settings for Java
```json
// File → Preferences → Settings → Open Settings (JSON)
{
    "java.home": "C:\\Program Files\\Eclipse Adoptium\\jdk-17.0.x-hotspot",
    "java.configuration.runtimes": [
        {
            "name": "JavaSE-17",
            "path": "C:\\Program Files\\Eclipse Adoptium\\jdk-17.0.x-hotspot"
        }
    ],
    "java.compile.nullAnalysis.mode": "automatic",
    "java.inlayHints.parameterNames.enabled": "all",
    "editor.fontSize": 14,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.formatOnSave": true,
    "files.autoSave": "afterDelay",
    "code-runner.executorMap": {
        "java": "cd $dir && javac $fileName && java $fileNameWithoutExt"
    }
}
```

### Option 3: Eclipse IDE

#### Installation
```powershell
# Download Eclipse IDE for Java Developers
# From: https://www.eclipse.org/downloads/packages/
```

#### Eclipse Configuration
```java
// Window → Preferences

// 1. Java → Installed JREs
// Add your JDK installation

// 2. Java → Code Style → Formatter
// Create new profile: "DSA Style"
// Tab policy: Spaces only
// Indentation size: 4

// 3. Java → Editor → Content Assist
// Auto activation delay: 50ms
// Auto activation triggers: .abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
```

## 🛠️ Additional Tools and Setup

### 1. Git Configuration
```powershell
# Install Git for Windows
winget install Git.Git

# Global configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main

# Verify
git --version
git config --list
```

### 2. Project Structure Template
```
DSA-Learning/
├── src/
│   ├── fundamentals/
│   │   ├── arrays/
│   │   ├── strings/
│   │   └── basics/
│   ├── datastructures/
│   │   ├── linkedlist/
│   │   ├── trees/
│   │   ├── graphs/
│   │   └── heaps/
│   ├── algorithms/
│   │   ├── sorting/
│   │   ├── searching/
│   │   ├── dp/
│   │   └── greedy/
│   └── problems/
│       ├── leetcode/
│       ├── hackerrank/
│       └── practice/
├── lib/
├── test/
├── docs/
└── README.md
```

### 3. Build Configuration

#### Maven Setup (Optional)
```xml
<!-- pom.xml for Maven project -->
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.dsa</groupId>
    <artifactId>learning</artifactId>
    <version>1.0-SNAPSHOT</version>
    
    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

#### Gradle Setup (Alternative)
```gradle
// build.gradle
plugins {
    id 'java'
    id 'application'
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'junit:junit:4.13.2'
}

application {
    mainClass = 'Main'
}
```

### 4. Code Templates and Snippets

#### Competitive Programming Template
```java
// File: Template.java
import java.util.*;
import java.io.*;

public class Template {
    static class FastReader {
        BufferedReader br;
        StringTokenizer st;
        
        public FastReader() {
            br = new BufferedReader(new InputStreamReader(System.in));
        }
        
        String next() {
            while (st == null || !st.hasMoreElements()) {
                try {
                    st = new StringTokenizer(br.readLine());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return st.nextToken();
        }
        
        int nextInt() { return Integer.parseInt(next()); }
        long nextLong() { return Long.parseLong(next()); }
        double nextDouble() { return Double.parseDouble(next()); }
        String nextLine() {
            String str = "";
            try {
                str = br.readLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return str;
        }
    }
    
    static class FastWriter {
        private final BufferedWriter bw;
        
        public FastWriter() {
            this.bw = new BufferedWriter(new OutputStreamWriter(System.out));
        }
        
        public void print(Object object) throws IOException {
            bw.append("").append(String.valueOf(object));
        }
        
        public void println(Object object) throws IOException {
            print(object);
            bw.append("\n");
        }
        
        public void close() throws IOException {
            bw.close();
        }
    }
    
    public static void main(String[] args) throws IOException {
        FastReader in = new FastReader();
        FastWriter out = new FastWriter();
        
        // Your code here
        
        out.close();
    }
}
```

#### Basic Problem Template
```java
// File: Problem.java
import java.util.*;

public class Problem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        // Input
        int n = scanner.nextInt();
        
        // Processing
        int result = solve(n);
        
        // Output
        System.out.println(result);
        
        scanner.close();
    }
    
    private static int solve(int n) {
        // Solution logic here
        return 0;
    }
}
```

## 🔍 Testing Your Setup

### Compilation Test
```java
// File: SetupTest.java
import java.util.*;

public class SetupTest {
    public static void main(String[] args) {
        System.out.println("=== Java DSA Environment Test ===");
        
        // Test 1: Basic functionality
        testBasics();
        
        // Test 2: Collections
        testCollections();
        
        // Test 3: Performance
        testPerformance();
        
        System.out.println("✅ All tests passed! Environment is ready.");
    }
    
    private static void testBasics() {
        System.out.println("Testing basic Java functionality...");
        
        // Array operations
        int[] arr = {1, 2, 3, 4, 5};
        assert arr.length == 5 : "Array creation failed";
        
        // String operations
        String str = "Hello World";
        assert str.length() == 11 : "String operations failed";
        
        System.out.println("✓ Basic functionality working");
    }
    
    private static void testCollections() {
        System.out.println("Testing collections framework...");
        
        // List operations
        List<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(2);
        assert list.size() == 2 : "ArrayList failed";
        
        // Map operations
        Map<String, Integer> map = new HashMap<>();
        map.put("key", 1);
        assert map.get("key") == 1 : "HashMap failed";
        
        // Set operations
        Set<Integer> set = new HashSet<>();
        set.add(1);
        set.add(1); // Duplicate
        assert set.size() == 1 : "HashSet failed";
        
        System.out.println("✓ Collections framework working");
    }
    
    private static void testPerformance() {
        System.out.println("Testing performance...");
        
        long start = System.currentTimeMillis();
        
        // Simple performance test
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < 100000; i++) {
            list.add(i);
        }
        
        long end = System.currentTimeMillis();
        System.out.println("✓ Created 100K elements in " + (end - start) + "ms");
    }
}
```

### Compile and Run Test
```powershell
# Compile
javac SetupTest.java

# Run
java SetupTest

# Expected output:
# === Java DSA Environment Test ===
# Testing basic Java functionality...
# ✓ Basic functionality working
# Testing collections framework...
# ✓ Collections framework working  
# Testing performance...
# ✓ Created 100K elements in Xms
# ✅ All tests passed! Environment is ready.
```

## 🚀 Performance Optimization

### JVM Tuning for Development
```powershell
# Set JVM options for better performance during development
# Add to your IDE's VM options or JAVA_OPTS

# Memory settings
-Xms2g -Xmx4g

# Garbage collector (for Java 17+)
-XX:+UseG1GC

# Enable performance monitoring
-XX:+UnlockExperimentalVMOptions
-XX:+UseJVMCICompiler

# For debugging (optional)
-XX:+PrintGCDetails
-XX:+PrintGCTimeStamps
```

### IDE Performance Settings

#### IntelliJ IDEA Memory Settings
```
# Help → Change Memory Settings
Xmx: 4096m (if you have 8GB+ RAM)
Xms: 2048m
```

#### VS Code Performance
```json
{
    "java.jdt.ls.vmargs": "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx2G -Xms100m"
}
```

## ✅ Setup Checklist

### Core Environment
- [ ] JDK 17+ installed and verified
- [ ] JAVA_HOME environment variable set
- [ ] PATH variable includes Java bin directory
- [ ] IDE installed and configured
- [ ] Git installed and configured

### Development Tools
- [ ] Code formatter configured
- [ ] Auto-import enabled
- [ ] Live templates/snippets set up
- [ ] Plugin/extensions installed
- [ ] Project structure created

### Testing and Validation
- [ ] Compilation test passed
- [ ] Collections test passed
- [ ] Performance test passed
- [ ] IDE can create and run Java projects
- [ ] Git repository can be created and managed

## 🎯 Next Steps

Once your environment is ready:
1. **Create your first project** using the template structure
2. **Test with a simple algorithm** (e.g., bubble sort)
3. **Set up version control** for your learning progress
4. **Begin with Module 1** of the course

## 🔧 Troubleshooting

### Common Issues and Solutions

#### Issue: "java command not found"
```powershell
# Solution: Fix PATH variable
echo %PATH%
# Should include your JDK bin directory
# If not, re-run environment variable setup
```

#### Issue: IDE doesn't recognize JDK
```java
// IntelliJ: File → Project Structure → Project SDK
// VS Code: Settings → Java Home
// Eclipse: Window → Preferences → Java → Installed JREs
```

#### Issue: Slow compilation/execution
```powershell
# Check available memory
systeminfo | findstr Memory

# Increase heap size in IDE settings
# Close unnecessary applications
# Disable unnecessary IDE plugins
```

#### Issue: Encoding problems
```java
// Ensure UTF-8 encoding in:
// 1. IDE settings
// 2. JVM startup parameters: -Dfile.encoding=UTF-8
// 3. System locale settings
```

---

**Setup Time:** 1-2 hours  
**One-time Setup:** Yes  
**Supports:** All course modules and practice problems
