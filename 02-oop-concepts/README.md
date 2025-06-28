# Module 2: Object-Oriented Programming

## 🎯 Learning Objectives
- Master the four pillars of OOP: Encapsulation, Inheritance, Polymorphism, Abstraction
- Learn to design and implement classes and objects effectively
- Understand access modifiers and their proper usage
- Master method overriding, overloading, and constructor concepts
- Apply OOP principles to solve real-world problems

## 📚 OOP Fundamentals

### 2.1 Classes and Objects

#### What are Classes and Objects?
```java
/*
Class: A blueprint or template for creating objects
Object: An instance of a class with specific values

Think of it like:
- Class = House Blueprint
- Object = Actual House built from that blueprint
*/

// Class definition
public class Car {
    // Instance variables (attributes/properties)
    private String brand;
    private String model;
    private int year;
    private double price;
    
    // Constructor
    public Car(String brand, String model, int year, double price) {
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.price = price;
    }
    
    // Methods (behaviors)
    public void start() {
        System.out.println(brand + " " + model + " is starting...");
    }
    
    public void stop() {
        System.out.println(brand + " " + model + " has stopped.");
    }
    
    public void displayInfo() {
        System.out.println(year + " " + brand + " " + model + " - $" + price);
    }
}

// Creating and using objects
public class CarDemo {
    public static void main(String[] args) {
        // Creating objects (instances)
        Car car1 = new Car("Toyota", "Camry", 2023, 25000);
        Car car2 = new Car("Honda", "Civic", 2022, 22000);
        
        // Using objects
        car1.start();           // Toyota Camry is starting...
        car1.displayInfo();     // 2023 Toyota Camry - $25000.0
        car1.stop();           // Toyota Camry has stopped.
        
        car2.displayInfo();     // 2022 Honda Civic - $22000.0
    }
}
```

#### Instance vs Class Members
```java
public class Student {
    // Instance variables - each object has its own copy
    private String name;
    private int age;
    private double gpa;
    
    // Class variable (static) - shared by all instances
    private static int totalStudents = 0;
    private static final String SCHOOL_NAME = "Tech University";
    
    // Constructor
    public Student(String name, int age, double gpa) {
        this.name = name;
        this.age = age;
        this.gpa = gpa;
        totalStudents++; // Increment for each new student
    }
    
    // Instance method - operates on specific object
    public void study() {
        System.out.println(name + " is studying...");
    }
    
    // Static method - belongs to class, not specific object
    public static int getTotalStudents() {
        return totalStudents;
    }
    
    public static String getSchoolName() {
        return SCHOOL_NAME;
    }
    
    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public int getAge() { return age; }
    public void setAge(int age) { 
        if (age > 0) this.age = age; 
    }
    
    public double getGpa() { return gpa; }
    public void setGpa(double gpa) { 
        if (gpa >= 0.0 && gpa <= 4.0) this.gpa = gpa; 
    }
}

// Usage example
public class StudentDemo {
    public static void main(String[] args) {
        System.out.println("School: " + Student.getSchoolName());
        System.out.println("Total students: " + Student.getTotalStudents());
        
        Student student1 = new Student("Alice", 20, 3.8);
        Student student2 = new Student("Bob", 21, 3.6);
        
        System.out.println("Total students: " + Student.getTotalStudents()); // 2
        
        student1.study(); // Alice is studying...
        student2.study(); // Bob is studying...
    }
}
```

### 2.2 Encapsulation

#### Data Hiding and Access Control
```java
public class BankAccount {
    // Private fields - cannot be accessed directly from outside
    private String accountNumber;
    private String ownerName;
    private double balance;
    private static final double MIN_BALANCE = 100.0;
    
    // Constructor
    public BankAccount(String accountNumber, String ownerName, double initialBalance) {
        this.accountNumber = accountNumber;
        this.ownerName = ownerName;
        setBalance(initialBalance); // Use setter for validation
    }
    
    // Public methods to access private data (getters)
    public String getAccountNumber() {
        return accountNumber;
    }
    
    public String getOwnerName() {
        return ownerName;
    }
    
    public double getBalance() {
        return balance;
    }
    
    // Controlled access to modify data (setters with validation)
    public void setOwnerName(String ownerName) {
        if (ownerName != null && !ownerName.trim().isEmpty()) {
            this.ownerName = ownerName;
        }
    }
    
    private void setBalance(double balance) {
        if (balance >= MIN_BALANCE) {
            this.balance = balance;
        } else {
            throw new IllegalArgumentException("Balance must be at least $" + MIN_BALANCE);
        }
    }
    
    // Business methods
    public boolean deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("Deposited $" + amount + ". New balance: $" + balance);
            return true;
        }
        return false;
    }
    
    public boolean withdraw(double amount) {
        if (amount > 0 && (balance - amount) >= MIN_BALANCE) {
            balance -= amount;
            System.out.println("Withdrew $" + amount + ". New balance: $" + balance);
            return true;
        }
        System.out.println("Insufficient funds or invalid amount");
        return false;
    }
    
    public void transfer(BankAccount targetAccount, double amount) {
        if (this.withdraw(amount)) {
            targetAccount.deposit(amount);
            System.out.println("Transfer successful");
        } else {
            System.out.println("Transfer failed");
        }
    }
    
    @Override
    public String toString() {
        return "Account: " + accountNumber + ", Owner: " + ownerName + ", Balance: $" + balance;
    }
}
```

#### Access Modifiers in Detail
```java
public class AccessModifiersDemo {
    
    public int publicVar = 1;        // Accessible everywhere
    protected int protectedVar = 2;  // Accessible in same package and subclasses
    int packageVar = 3;              // Accessible in same package (default)
    private int privateVar = 4;      // Accessible only within this class
    
    public void publicMethod() {
        System.out.println("Public method - accessible everywhere");
    }
    
    protected void protectedMethod() {
        System.out.println("Protected method - accessible in package and subclasses");
    }
    
    void packageMethod() {
        System.out.println("Package method - accessible in same package");
    }
    
    private void privateMethod() {
        System.out.println("Private method - accessible only in this class");
    }
    
    public void demonstrateAccess() {
        // All access levels work within the same class
        System.out.println("From same class:");
        System.out.println("Public: " + publicVar);
        System.out.println("Protected: " + protectedVar);
        System.out.println("Package: " + packageVar);
        System.out.println("Private: " + privateVar);
        
        publicMethod();
        protectedMethod();
        packageMethod();
        privateMethod();
    }
}

// In same package
class SamePackageTest {
    public void testAccess() {
        AccessModifiersDemo demo = new AccessModifiersDemo();
        
        System.out.println("From same package:");
        System.out.println("Public: " + demo.publicVar);      // ✓ Works
        System.out.println("Protected: " + demo.protectedVar); // ✓ Works
        System.out.println("Package: " + demo.packageVar);     // ✓ Works
        // System.out.println("Private: " + demo.privateVar);  // ✗ Compile error
        
        demo.publicMethod();     // ✓ Works
        demo.protectedMethod();  // ✓ Works
        demo.packageMethod();    // ✓ Works
        // demo.privateMethod(); // ✗ Compile error
    }
}
```

### 2.3 Inheritance

#### Basic Inheritance
```java
// Base class (Parent/Superclass)
public class Animal {
    protected String name;
    protected int age;
    protected String species;
    
    public Animal(String name, int age, String species) {
        this.name = name;
        this.age = age;
        this.species = species;
    }
    
    public void eat() {
        System.out.println(name + " is eating...");
    }
    
    public void sleep() {
        System.out.println(name + " is sleeping...");
    }
    
    public void makeSound() {
        System.out.println(name + " makes a sound...");
    }
    
    public void displayInfo() {
        System.out.println("Name: " + name + ", Age: " + age + ", Species: " + species);
    }
    
    // Getters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getSpecies() { return species; }
}

// Derived class (Child/Subclass)
public class Dog extends Animal {
    private String breed;
    private boolean isTrained;
    
    public Dog(String name, int age, String breed, boolean isTrained) {
        super(name, age, "Canine"); // Call parent constructor
        this.breed = breed;
        this.isTrained = isTrained;
    }
    
    // Method overriding
    @Override
    public void makeSound() {
        System.out.println(name + " barks: Woof! Woof!");
    }
    
    // Additional methods specific to Dog
    public void wagTail() {
        System.out.println(name + " is wagging tail happily!");
    }
    
    public void fetch() {
        if (isTrained) {
            System.out.println(name + " fetches the ball!");
        } else {
            System.out.println(name + " doesn't know how to fetch yet.");
        }
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo(); // Call parent method
        System.out.println("Breed: " + breed + ", Trained: " + isTrained);
    }
    
    // Getters
    public String getBreed() { return breed; }
    public boolean isTrained() { return isTrained; }
    public void setTrained(boolean trained) { this.isTrained = trained; }
}

// Another derived class
public class Cat extends Animal {
    private boolean isIndoor;
    private int livesRemaining;
    
    public Cat(String name, int age, boolean isIndoor) {
        super(name, age, "Feline");
        this.isIndoor = isIndoor;
        this.livesRemaining = 9; // Cats have 9 lives!
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " meows: Meow! Meow!");
    }
    
    public void purr() {
        System.out.println(name + " is purring contentedly...");
    }
    
    public void scratch() {
        System.out.println(name + " is scratching the furniture!");
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Indoor: " + isIndoor + ", Lives remaining: " + livesRemaining);
    }
}

// Usage example
public class InheritanceDemo {
    public static void main(String[] args) {
        // Create objects
        Animal genericAnimal = new Animal("Generic", 5, "Unknown");
        Dog myDog = new Dog("Buddy", 3, "Golden Retriever", true);
        Cat myCat = new Cat("Whiskers", 2, true);
        
        // Demonstrate inheritance
        System.out.println("=== Generic Animal ===");
        genericAnimal.displayInfo();
        genericAnimal.eat();
        genericAnimal.makeSound();
        
        System.out.println("\n=== Dog ===");
        myDog.displayInfo();
        myDog.eat();        // Inherited method
        myDog.makeSound();  // Overridden method
        myDog.wagTail();    // Dog-specific method
        myDog.fetch();      // Dog-specific method
        
        System.out.println("\n=== Cat ===");
        myCat.displayInfo();
        myCat.sleep();      // Inherited method
        myCat.makeSound();  // Overridden method
        myCat.purr();       // Cat-specific method
        myCat.scratch();    // Cat-specific method
    }
}
```

#### Multi-level Inheritance
```java
// Base class
public class Vehicle {
    protected String make;
    protected String model;
    protected int year;
    protected double maxSpeed;
    
    public Vehicle(String make, String model, int year, double maxSpeed) {
        this.make = make;
        this.model = model;
        this.year = year;
        this.maxSpeed = maxSpeed;
    }
    
    public void start() {
        System.out.println(make + " " + model + " is starting...");
    }
    
    public void stop() {
        System.out.println(make + " " + model + " has stopped.");
    }
    
    public void displayInfo() {
        System.out.println(year + " " + make + " " + model + " (Max Speed: " + maxSpeed + " mph)");
    }
}

// Intermediate class
public class Car extends Vehicle {
    protected int numberOfDoors;
    protected String fuelType;
    
    public Car(String make, String model, int year, double maxSpeed, int numberOfDoors, String fuelType) {
        super(make, model, year, maxSpeed);
        this.numberOfDoors = numberOfDoors;
        this.fuelType = fuelType;
    }
    
    public void honk() {
        System.out.println(make + " " + model + " is honking: Beep! Beep!");
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Doors: " + numberOfDoors + ", Fuel: " + fuelType);
    }
}

// Final derived class
public class ElectricCar extends Car {
    private double batteryCapacity;
    private double currentCharge;
    
    public ElectricCar(String make, String model, int year, double maxSpeed, 
                      int numberOfDoors, double batteryCapacity) {
        super(make, model, year, maxSpeed, numberOfDoors, "Electric");
        this.batteryCapacity = batteryCapacity;
        this.currentCharge = batteryCapacity; // Start fully charged
    }
    
    public void charge() {
        currentCharge = batteryCapacity;
        System.out.println(make + " " + model + " is fully charged!");
    }
    
    public void checkBattery() {
        double percentage = (currentCharge / batteryCapacity) * 100;
        System.out.println("Battery: " + String.format("%.1f", percentage) + "%");
    }
    
    @Override
    public void start() {
        if (currentCharge > 0) {
            System.out.println(make + " " + model + " is starting silently...");
        } else {
            System.out.println("Cannot start - battery is empty!");
        }
    }
    
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Battery: " + currentCharge + "/" + batteryCapacity + " kWh");
    }
}
```

### 2.4 Polymorphism

#### Method Overriding and Runtime Polymorphism
```java
// Demonstrating polymorphism with shapes
public abstract class Shape {
    protected String color;
    
    public Shape(String color) {
        this.color = color;
    }
    
    // Abstract method - must be implemented by subclasses
    public abstract double calculateArea();
    public abstract double calculatePerimeter();
    
    // Concrete method that can be overridden
    public void display() {
        System.out.println("This is a " + color + " shape");
        System.out.println("Area: " + calculateArea());
        System.out.println("Perimeter: " + calculatePerimeter());
    }
    
    public String getColor() { return color; }
}

public class Circle extends Shape {
    private double radius;
    
    public Circle(String color, double radius) {
        super(color);
        this.radius = radius;
    }
    
    @Override
    public double calculateArea() {
        return Math.PI * radius * radius;
    }
    
    @Override
    public double calculatePerimeter() {
        return 2 * Math.PI * radius;
    }
    
    @Override
    public void display() {
        System.out.println("Circle with radius " + radius);
        super.display();
    }
}

public class Rectangle extends Shape {
    private double length;
    private double width;
    
    public Rectangle(String color, double length, double width) {
        super(color);
        this.length = length;
        this.width = width;
    }
    
    @Override
    public double calculateArea() {
        return length * width;
    }
    
    @Override
    public double calculatePerimeter() {
        return 2 * (length + width);
    }
    
    @Override
    public void display() {
        System.out.println("Rectangle " + length + "x" + width);
        super.display();
    }
}

public class Triangle extends Shape {
    private double side1, side2, side3;
    
    public Triangle(String color, double side1, double side2, double side3) {
        super(color);
        this.side1 = side1;
        this.side2 = side2;
        this.side3 = side3;
    }
    
    @Override
    public double calculateArea() {
        // Using Heron's formula
        double s = calculatePerimeter() / 2;
        return Math.sqrt(s * (s - side1) * (s - side2) * (s - side3));
    }
    
    @Override
    public double calculatePerimeter() {
        return side1 + side2 + side3;
    }
    
    @Override
    public void display() {
        System.out.println("Triangle with sides " + side1 + ", " + side2 + ", " + side3);
        super.display();
    }
}

// Polymorphism demonstration
public class PolymorphismDemo {
    public static void main(String[] args) {
        // Array of Shape references pointing to different objects
        Shape[] shapes = {
            new Circle("Red", 5.0),
            new Rectangle("Blue", 4.0, 6.0),
            new Triangle("Green", 3.0, 4.0, 5.0),
            new Circle("Yellow", 3.0),
            new Rectangle("Purple", 2.0, 8.0)
        };
        
        // Polymorphic behavior - same method call, different implementations
        System.out.println("=== Demonstrating Polymorphism ===");
        for (Shape shape : shapes) {
            shape.display(); // Calls the appropriate overridden method
            System.out.println();
        }
        
        // Calculate total area
        double totalArea = 0;
        for (Shape shape : shapes) {
            totalArea += shape.calculateArea();
        }
        System.out.println("Total area of all shapes: " + String.format("%.2f", totalArea));
        
        // Method that accepts any Shape
        processShape(new Circle("Orange", 7.0));
        processShape(new Rectangle("Pink", 3.0, 9.0));
    }
    
    // Method demonstrating polymorphic parameters
    public static void processShape(Shape shape) {
        System.out.println("Processing a shape:");
        shape.display();
        
        if (shape.calculateArea() > 50) {
            System.out.println("This is a large shape!");
        } else {
            System.out.println("This is a small to medium shape.");
        }
        System.out.println();
    }
}
```

#### Method Overloading (Compile-time Polymorphism)
```java
public class Calculator {
    
    // Overloaded methods with different parameters
    public int add(int a, int b) {
        System.out.println("Adding two integers");
        return a + b;
    }
    
    public double add(double a, double b) {
        System.out.println("Adding two doubles");
        return a + b;
    }
    
    public int add(int a, int b, int c) {
        System.out.println("Adding three integers");
        return a + b + c;
    }
    
    public String add(String a, String b) {
        System.out.println("Concatenating two strings");
        return a + b;
    }
    
    // Variable arguments (varargs)
    public int add(int... numbers) {
        System.out.println("Adding " + numbers.length + " integers using varargs");
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        return sum;
    }
    
    // Overloaded constructors
    public static class Person {
        private String name;
        private int age;
        private String email;
        
        // Default constructor
        public Person() {
            this("Unknown", 0, "no-email");
        }
        
        // Constructor with name only
        public Person(String name) {
            this(name, 0, "no-email");
        }
        
        // Constructor with name and age
        public Person(String name, int age) {
            this(name, age, "no-email");
        }
        
        // Full constructor
        public Person(String name, int age, String email) {
            this.name = name;
            this.age = age;
            this.email = email;
        }
        
        @Override
        public String toString() {
            return "Person{name='" + name + "', age=" + age + ", email='" + email + "'}";
        }
    }
    
    public static void main(String[] args) {
        Calculator calc = new Calculator();
        
        // Method overloading demonstration
        System.out.println("Result: " + calc.add(5, 3));           // int version
        System.out.println("Result: " + calc.add(5.5, 3.2));      // double version
        System.out.println("Result: " + calc.add(1, 2, 3));       // three int version
        System.out.println("Result: " + calc.add("Hello", "World")); // String version
        System.out.println("Result: " + calc.add(1, 2, 3, 4, 5)); // varargs version
        
        // Constructor overloading demonstration
        Person p1 = new Person();
        Person p2 = new Person("Alice");
        Person p3 = new Person("Bob", 25);
        Person p4 = new Person("Charlie", 30, "charlie@email.com");
        
        System.out.println(p1);
        System.out.println(p2);
        System.out.println(p3);
        System.out.println(p4);
    }
}
```

### 2.5 Abstraction

#### Abstract Classes
```java
// Abstract class defining a contract
public abstract class Employee {
    protected String name;
    protected int employeeId;
    protected double baseSalary;
    
    public Employee(String name, int employeeId, double baseSalary) {
        this.name = name;
        this.employeeId = employeeId;
        this.baseSalary = baseSalary;
    }
    
    // Abstract methods - must be implemented by subclasses
    public abstract double calculateSalary();
    public abstract String getJobTitle();
    public abstract void performWork();
    
    // Concrete methods - can be used by all subclasses
    public void clockIn() {
        System.out.println(name + " (" + getJobTitle() + ") has clocked in.");
    }
    
    public void clockOut() {
        System.out.println(name + " (" + getJobTitle() + ") has clocked out.");
    }
    
    public void displayInfo() {
        System.out.println("Employee: " + name);
        System.out.println("ID: " + employeeId);
        System.out.println("Job Title: " + getJobTitle());
        System.out.println("Salary: $" + String.format("%.2f", calculateSalary()));
    }
    
    // Getters
    public String getName() { return name; }
    public int getEmployeeId() { return employeeId; }
    public double getBaseSalary() { return baseSalary; }
}

// Concrete implementation
public class SoftwareDeveloper extends Employee {
    private String[] programmingLanguages;
    private int projectsCompleted;
    
    public SoftwareDeveloper(String name, int employeeId, double baseSalary, String[] languages) {
        super(name, employeeId, baseSalary);
        this.programmingLanguages = languages;
        this.projectsCompleted = 0;
    }
    
    @Override
    public double calculateSalary() {
        // Base salary + bonus for completed projects
        return baseSalary + (projectsCompleted * 1000);
    }
    
    @Override
    public String getJobTitle() {
        return "Software Developer";
    }
    
    @Override
    public void performWork() {
        System.out.println(name + " is writing code...");
        // Simulate completing a project
        projectsCompleted++;
        System.out.println("Project completed! Total projects: " + projectsCompleted);
    }
    
    public void debugCode() {
        System.out.println(name + " is debugging code...");
    }
    
    public void listSkills() {
        System.out.println(name + " knows: " + String.join(", ", programmingLanguages));
    }
}

public class Manager extends Employee {
    private int teamSize;
    private double bonusPercentage;
    
    public Manager(String name, int employeeId, double baseSalary, int teamSize, double bonusPercentage) {
        super(name, employeeId, baseSalary);
        this.teamSize = teamSize;
        this.bonusPercentage = bonusPercentage;
    }
    
    @Override
    public double calculateSalary() {
        // Base salary + percentage bonus + team size bonus
        return baseSalary * (1 + bonusPercentage) + (teamSize * 500);
    }
    
    @Override
    public String getJobTitle() {
        return "Manager";
    }
    
    @Override
    public void performWork() {
        System.out.println(name + " is managing the team and planning projects...");
    }
    
    public void conductMeeting() {
        System.out.println(name + " is conducting a team meeting with " + teamSize + " members.");
    }
    
    public void reviewPerformance() {
        System.out.println(name + " is reviewing team performance.");
    }
}
```

#### Interfaces
```java
// Interface defining a contract
public interface Drawable {
    // All interface methods are implicitly public and abstract
    void draw();
    void setColor(String color);
    String getColor();
    
    // Default method (Java 8+)
    default void displayInfo() {
        System.out.println("This is a drawable object with color: " + getColor());
    }
    
    // Static method (Java 8+)
    static void printDrawingInstructions() {
        System.out.println("Remember to set color before drawing!");
    }
}

// Interface for movable objects
public interface Movable {
    void move(int x, int y);
    void rotate(double angle);
    
    default void resetPosition() {
        move(0, 0);
        rotate(0);
        System.out.println("Position reset to origin");
    }
}

// Class implementing multiple interfaces
public class GraphicsCircle implements Drawable, Movable {
    private double radius;
    private String color;
    private int x, y;
    private double rotation;
    
    public GraphicsCircle(double radius) {
        this.radius = radius;
        this.color = "Black";
        this.x = 0;
        this.y = 0;
        this.rotation = 0;
    }
    
    // Implementing Drawable interface
    @Override
    public void draw() {
        System.out.println("Drawing a " + color + " circle with radius " + radius + 
                          " at position (" + x + ", " + y + ") rotated " + rotation + "°");
    }
    
    @Override
    public void setColor(String color) {
        this.color = color;
    }
    
    @Override
    public String getColor() {
        return color;
    }
    
    // Implementing Movable interface
    @Override
    public void move(int x, int y) {
        this.x = x;
        this.y = y;
        System.out.println("Circle moved to (" + x + ", " + y + ")");
    }
    
    @Override
    public void rotate(double angle) {
        this.rotation = angle;
        System.out.println("Circle rotated to " + angle + "°");
    }
    
    // Additional methods
    public void resize(double newRadius) {
        this.radius = newRadius;
        System.out.println("Circle resized to radius " + newRadius);
    }
}

// Another implementation
public class GraphicsRectangle implements Drawable, Movable {
    private double width, height;
    private String color;
    private int x, y;
    private double rotation;
    
    public GraphicsRectangle(double width, double height) {
        this.width = width;
        this.height = height;
        this.color = "Black";
        this.x = 0;
        this.y = 0;
        this.rotation = 0;
    }
    
    @Override
    public void draw() {
        System.out.println("Drawing a " + color + " rectangle " + width + "x" + height + 
                          " at position (" + x + ", " + y + ") rotated " + rotation + "°");
    }
    
    @Override
    public void setColor(String color) {
        this.color = color;
    }
    
    @Override
    public String getColor() {
        return color;
    }
    
    @Override
    public void move(int x, int y) {
        this.x = x;
        this.y = y;
        System.out.println("Rectangle moved to (" + x + ", " + y + ")");
    }
    
    @Override
    public void rotate(double angle) {
        this.rotation = angle;
        System.out.println("Rectangle rotated to " + angle + "°");
    }
}

// Demonstration of interfaces
public class InterfaceDemo {
    public static void main(String[] args) {
        // Create objects
        GraphicsCircle circle = new GraphicsCircle(5.0);
        GraphicsRectangle rectangle = new GraphicsRectangle(10.0, 6.0);
        
        // Use as Drawable objects
        Drawable[] drawables = {circle, rectangle};
        
        System.out.println("=== Drawing Objects ===");
        for (Drawable drawable : drawables) {
            drawable.setColor("Blue");
            drawable.displayInfo(); // Default method
            drawable.draw();
            System.out.println();
        }
        
        // Use as Movable objects
        Movable[] movables = {circle, rectangle};
        
        System.out.println("=== Moving Objects ===");
        for (Movable movable : movables) {
            movable.move(10, 20);
            movable.rotate(45);
            movable.resetPosition(); // Default method
            System.out.println();
        }
        
        // Static method call
        Drawable.printDrawingInstructions();
    }
}
```

## 🧪 Practice Problems

### Easy Level OOP Problems
```java
public class EasyOOPProblems {
    
    // Problem 1: Design a Book class
    public static class Book {
        private String title;
        private String author;
        private int pages;
        private double price;
        private boolean isAvailable;
        
        public Book(String title, String author, int pages, double price) {
            this.title = title;
            this.author = author;
            this.pages = pages;
            this.price = price;
            this.isAvailable = true;
        }
        
        // Getters and setters
        public String getTitle() { return title; }
        public String getAuthor() { return author; }
        public int getPages() { return pages; }
        public double getPrice() { return price; }
        public boolean isAvailable() { return isAvailable; }
        
        public void borrowBook() {
            if (isAvailable) {
                isAvailable = false;
                System.out.println(title + " has been borrowed.");
            } else {
                System.out.println(title + " is not available.");
            }
        }
        
        public void returnBook() {
            isAvailable = true;
            System.out.println(title + " has been returned.");
        }
        
        @Override
        public String toString() {
            return title + " by " + author + " (" + pages + " pages, $" + price + ")";
        }
    }
    
    // Problem 2: Rectangle class with area and perimeter
    public static class Rectangle {
        private double length;
        private double width;
        
        public Rectangle(double length, double width) {
            setLength(length);
            setWidth(width);
        }
        
        public double getLength() { return length; }
        public void setLength(double length) {
            if (length > 0) this.length = length;
        }
        
        public double getWidth() { return width; }
        public void setWidth(double width) {
            if (width > 0) this.width = width;
        }
        
        public double calculateArea() {
            return length * width;
        }
        
        public double calculatePerimeter() {
            return 2 * (length + width);
        }
        
        public boolean isSquare() {
            return length == width;
        }
    }
}
```

### Medium Level OOP Problems
```java
public class MediumOOPProblems {
    
    // Problem 1: Library Management System
    public static class Library {
        private List<Book> books;
        private List<Member> members;
        
        public Library() {
            books = new ArrayList<>();
            members = new ArrayList<>();
        }
        
        public void addBook(Book book) {
            books.add(book);
        }
        
        public void addMember(Member member) {
            members.add(member);
        }
        
        public Book findBook(String title) {
            return books.stream()
                       .filter(book -> book.getTitle().equalsIgnoreCase(title))
                       .findFirst()
                       .orElse(null);
        }
        
        public void borrowBook(String memberName, String bookTitle) {
            Member member = findMember(memberName);
            Book book = findBook(bookTitle);
            
            if (member != null && book != null && book.isAvailable()) {
                book.borrowBook();
                member.borrowBook(book);
            }
        }
        
        private Member findMember(String name) {
            return members.stream()
                         .filter(member -> member.getName().equalsIgnoreCase(name))
                         .findFirst()
                         .orElse(null);
        }
    }
    
    public static class Member {
        private String name;
        private int memberId;
        private List<Book> borrowedBooks;
        private static final int MAX_BOOKS = 3;
        
        public Member(String name, int memberId) {
            this.name = name;
            this.memberId = memberId;
            this.borrowedBooks = new ArrayList<>();
        }
        
        public boolean borrowBook(Book book) {
            if (borrowedBooks.size() < MAX_BOOKS) {
                borrowedBooks.add(book);
                return true;
            }
            return false;
        }
        
        public void returnBook(Book book) {
            borrowedBooks.remove(book);
            book.returnBook();
        }
        
        public String getName() { return name; }
        public int getMemberId() { return memberId; }
        public List<Book> getBorrowedBooks() { return new ArrayList<>(borrowedBooks); }
    }
}
```

## ✅ OOP Mastery Checklist

### Core Concepts
- [ ] Understand classes and objects thoroughly
- [ ] Master the four pillars of OOP
- [ ] Know when to use encapsulation effectively
- [ ] Apply inheritance correctly without overusing it
- [ ] Implement polymorphism for flexible code
- [ ] Use abstraction to hide complexity

### Implementation Skills
- [ ] Write well-encapsulated classes
- [ ] Design proper inheritance hierarchies
- [ ] Create and implement interfaces
- [ ] Use abstract classes appropriately
- [ ] Handle access modifiers correctly
- [ ] Write proper constructors and methods

### Design Principles
- [ ] Follow single responsibility principle
- [ ] Prefer composition over inheritance when appropriate
- [ ] Design for extensibility and maintainability
- [ ] Use proper naming conventions
- [ ] Write clean, readable code
- [ ] Handle edge cases and validation

## 🎯 Next Steps

After mastering OOP concepts:
1. Practice designing 10+ real-world class hierarchies
2. Implement complete systems using OOP principles
3. Learn about design patterns
4. Move to [Module 3: Java Collections Framework](../03-collections-framework/)

---

**Estimated Time:** 2-3 weeks  
**Practice Problems:** 15+ OOP design problems  
**Key Skills:** Class design, inheritance, polymorphism, abstraction
