# Java Environment Setup Guide

## 🎯 Overview
Setting up a proper Java development environment is crucial for efficient learning and programming. This guide will walk you through installing and configuring everything you need.

## 📋 Requirements
- **Operating System:** Windows 10+, macOS 10.14+, or Linux
- **RAM:** Minimum 4GB (8GB recommended)
- **Storage:** At least 2GB free space
- **Internet Connection:** For downloads and updates

## 🔧 Step 1: Install Java Development Kit (JDK)

### Option 1: Oracle JDK (Recommended for Beginners)
1. Visit [Oracle JDK Download Page](https://www.oracle.com/java/technologies/downloads/)
2. Download JDK 17 or later (LTS version recommended)
3. Run the installer with administrator privileges
4. Follow the installation wizard

### Option 2: OpenJDK (Free Alternative)
1. Visit [OpenJDK Download Page](https://adoptium.net/)
2. Select your operating system
3. Download Temurin JDK 17+
4. Install following the instructions

### Verify Installation
Open command prompt/terminal and run:
```bash
java -version
javac -version
```

Expected output:
```
java version "17.0.x" 
Java(TM) SE Runtime Environment
javac 17.0.x
```

## 💻 Step 2: Choose and Install an IDE

### Option 1: IntelliJ IDEA (Recommended)
**Best for:** Comprehensive development, intelligent code assistance

**Installation:**
1. Download [IntelliJ IDEA Community Edition](https://www.jetbrains.com/idea/download/) (Free)
2. Run the installer
3. Launch and configure:
   - Set up JDK path
   - Choose dark/light theme
   - Install recommended plugins

**First Project Setup:**
```java
// Create New Project → Java → Project SDK (select your JDK)
// Create a new Java class: HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### Option 2: Visual Studio Code (Lightweight)
**Best for:** Quick development, customizable environment

**Installation:**
1. Download [Visual Studio Code](https://code.visualstudio.com/)
2. Install the Extension Pack for Java:
   - Language Support for Java
   - Debugger for Java
   - Test Runner for Java
   - Maven for Java
   - Project Manager for Java

### Option 3: Eclipse (Traditional)
**Best for:** Enterprise development, extensive plugin ecosystem

**Installation:**
1. Download [Eclipse IDE for Java Developers](https://www.eclipse.org/downloads/)
2. Extract and run eclipse.exe
3. Set workspace location
4. Configure JDK in Preferences → Java → Installed JREs

## 🛠️ Step 3: Set Up Environment Variables

### Windows
1. Open System Properties → Advanced → Environment Variables
2. Add/Edit System Variables:
   ```
   JAVA_HOME: C:\Program Files\Java\jdk-17
   PATH: Add %JAVA_HOME%\bin
   ```
3. Restart command prompt to apply changes

### macOS/Linux
Add to your shell profile (.bashrc, .zshrc, etc.):
```bash
export JAVA_HOME=/path/to/your/jdk
export PATH=$JAVA_HOME/bin:$PATH
```

Reload your profile:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## 📁 Step 4: Project Structure Setup

### Recommended Folder Structure
```
DSA-Course/
├── src/
│   ├── fundamentals/
│   ├── datastructures/
│   ├── algorithms/
│   └── problems/
├── lib/
├── docs/
└── tests/
```

### IDE Configuration
1. **Code Style:** Configure consistent formatting
2. **Auto-Import:** Enable automatic import suggestions
3. **Live Templates:** Set up code snippets
4. **Version Control:** Configure Git integration

## 🧪 Step 5: Test Your Setup

### Create Test Program
```java
// File: TestSetup.java
import java.util.*;

public class TestSetup {
    public static void main(String[] args) {
        System.out.println("Java Setup Test");
        System.out.println("================");
        
        // Test basic functionality
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your name: ");
        String name = scanner.nextLine();
        
        // Test collections
        List<String> languages = Arrays.asList("Java", "Python", "C++");
        System.out.println("Hello " + name + "!");
        System.out.println("Languages: " + languages);
        
        // Test lambda expressions (Java 8+)
        languages.stream()
                .filter(lang -> lang.startsWith("J"))
                .forEach(System.out::println);
        
        scanner.close();
        System.out.println("Setup test completed successfully!");
    }
}
```

### Compile and Run
```bash
# Command line compilation
javac TestSetup.java
java TestSetup

# Expected: Program runs without errors and accepts input
```

## 🎯 IDE-Specific Setup

### IntelliJ IDEA Configuration
```java
// Create run configuration for easy execution
// Run → Edit Configurations → Add Application
// Main class: TestSetup
// VM options: -Xmx1024m (if needed)
```

### VS Code Configuration
Create `.vscode/launch.json`:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "java",
            "name": "Launch Current File",
            "request": "launch",
            "mainClass": "${file}"
        }
    ]
}
```

## 🔍 Troubleshooting Common Issues

### Issue 1: "java command not found"
**Solution:** Environment variables not set correctly
- Verify JAVA_HOME points to JDK installation
- Ensure PATH includes %JAVA_HOME%\bin

### Issue 2: IDE doesn't recognize JDK
**Solution:** Configure JDK path in IDE settings
- IntelliJ: File → Project Structure → Project SDK
- Eclipse: Window → Preferences → Java → Installed JREs

### Issue 3: Compilation errors
**Solution:** Check Java version compatibility
- Ensure source code targets correct Java version
- Verify IDE project settings

### Issue 4: Classpath issues
**Solution:** Verify project structure
- Source folders correctly configured
- External libraries properly added

## 📚 Useful IDE Plugins/Extensions

### IntelliJ IDEA
- **Key Promoter X:** Learn keyboard shortcuts
- **Rainbow Brackets:** Better code readability
- **CodeGlance:** Minimap for navigation
- **String Manipulation:** Text processing tools

### VS Code
- **Java Extension Pack:** Complete Java support
- **Bracket Pair Colorizer:** Visual bracket matching
- **GitLens:** Advanced Git integration
- **Code Runner:** Quick code execution

## ⚡ Performance Optimization

### JVM Tuning (For Large Projects)
```bash
# Add to VM options or JAVA_OPTS
-Xmx4g          # Maximum heap size
-Xms2g          # Initial heap size
-XX:+UseG1GC    # Garbage collector
```

### IDE Performance
- **Increase memory allocation:** Help → Change Memory Settings
- **Disable unused plugins:** File → Settings → Plugins
- **Index optimization:** File → Invalidate Caches and Restart

## ✅ Setup Checklist

- [ ] JDK 17+ installed and verified
- [ ] IDE installed and configured
- [ ] Environment variables set correctly
- [ ] Test program compiles and runs
- [ ] Project structure created
- [ ] Version control (Git) configured
- [ ] IDE plugins/extensions installed
- [ ] Code style and formatting configured

## 🎯 Next Steps

Once your environment is set up:
1. Familiarize yourself with your chosen IDE
2. Practice with the test program
3. Move to [Program Structure](./program-structure.md)

---

**Time Required:** 1-2 hours  
**Difficulty:** Beginner  
**One-time Setup:** Yes
