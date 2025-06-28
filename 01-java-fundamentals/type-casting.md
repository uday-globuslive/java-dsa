# Type Casting and Conversion

## Overview
Type casting and conversion are fundamental concepts in Java that allow you to convert values from one data type to another. Understanding these concepts is crucial for working with different data types, preventing data loss, and ensuring type compatibility in your programs.

## Types of Type Conversion

### 1. Implicit Type Conversion (Widening)
Implicit conversion happens automatically when converting from a smaller to a larger data type without any risk of data loss.

```java
public class ImplicitConversion {
    public static void main(String[] args) {
        // Automatic widening conversions (no data loss)
        
        // byte → short → int → long → float → double
        byte byteValue = 100;
        short shortValue = byteValue;  // byte to short (automatic)
        int intValue = shortValue;     // short to int (automatic)
        long longValue = intValue;     // int to long (automatic)
        float floatValue = longValue;  // long to float (automatic)
        double doubleValue = floatValue; // float to double (automatic)
        
        System.out.println("Original byte value: " + byteValue);
        System.out.println("Converted to short: " + shortValue);
        System.out.println("Converted to int: " + intValue);
        System.out.println("Converted to long: " + longValue);
        System.out.println("Converted to float: " + floatValue);
        System.out.println("Converted to double: " + doubleValue);
        
        // char can be converted to int and larger types
        char charValue = 'A';
        int charAsInt = charValue;     // char to int (ASCII value)
        long charAsLong = charValue;   // char to long
        
        System.out.println("Character 'A': " + charValue);
        System.out.println("ASCII value: " + charAsInt);
        System.out.println("As long: " + charAsLong);
        
        // Mixed arithmetic with implicit conversion
        int intNum = 10;
        double doubleNum = 3.14;
        double result = intNum + doubleNum; // int promoted to double
        
        System.out.println("Mixed arithmetic: " + intNum + " + " + doubleNum + " = " + result);
    }
}
```

### 2. Explicit Type Conversion (Narrowing/Casting)
Explicit conversion is required when converting from a larger to a smaller data type, as it may result in data loss.

```java
public class ExplicitConversion {
    public static void main(String[] args) {
        // Explicit casting (potential data loss)
        
        // double → float → long → int → short → byte
        double doubleValue = 123.456;
        float floatValue = (float) doubleValue;   // Explicit cast required
        long longValue = (long) floatValue;       // Decimal part lost
        int intValue = (int) longValue;           // Potential data loss
        short shortValue = (short) intValue;      // Potential data loss
        byte byteValue = (byte) shortValue;       // Potential data loss
        
        System.out.println("Original double: " + doubleValue);
        System.out.println("Cast to float: " + floatValue);
        System.out.println("Cast to long: " + longValue);
        System.out.println("Cast to int: " + intValue);
        System.out.println("Cast to short: " + shortValue);
        System.out.println("Cast to byte: " + byteValue);
        
        // Demonstrating data loss
        int largeInt = 300;
        byte smallByte = (byte) largeInt;  // 300 doesn't fit in byte (-128 to 127)
        System.out.println("Large int (300) cast to byte: " + smallByte); // Will be 44
        
        // Casting with overflow
        int maxInt = Integer.MAX_VALUE;
        System.out.println("Max int value: " + maxInt);
        
        maxInt = maxInt + 1; // Overflow occurs
        System.out.println("Max int + 1 (overflow): " + maxInt); // Will be negative
        
        // Character casting
        int asciiValue = 65;
        char character = (char) asciiValue;
        System.out.println("ASCII 65 as character: " + character); // 'A'
        
        // Floating point to integer (truncation, not rounding)
        double decimal = 9.99;
        int truncated = (int) decimal;
        System.out.println("9.99 truncated to int: " + truncated); // 9, not 10
    }
}
```

## String Conversions

### Converting Primitives to Strings
```java
public class PrimitiveToString {
    public static void main(String[] args) {
        // Method 1: String concatenation (automatic conversion)
        int number = 42;
        String str1 = number + "";  // Simple but not efficient
        System.out.println("Concatenation method: '" + str1 + "'");
        
        // Method 2: String.valueOf() - most versatile
        boolean flag = true;
        double decimal = 3.14159;
        char letter = 'Z';
        
        String boolStr = String.valueOf(flag);
        String doubleStr = String.valueOf(decimal);
        String charStr = String.valueOf(letter);
        
        System.out.println("Boolean to string: " + boolStr);
        System.out.println("Double to string: " + doubleStr);
        System.out.println("Char to string: " + charStr);
        
        // Method 3: Using wrapper class toString() methods
        Integer intWrapper = 100;
        Double doubleWrapper = 2.71828;
        
        String intStr = intWrapper.toString();
        String doubleStr2 = doubleWrapper.toString();
        
        System.out.println("Integer wrapper to string: " + intStr);
        System.out.println("Double wrapper to string: " + doubleStr2);
        
        // Method 4: Static toString() methods
        String staticIntStr = Integer.toString(500);
        String staticDoubleStr = Double.toString(1.414);
        String binaryStr = Integer.toBinaryString(15);
        String hexStr = Integer.toHexString(255);
        
        System.out.println("Static int to string: " + staticIntStr);
        System.out.println("Static double to string: " + staticDoubleStr);
        System.out.println("15 in binary: " + binaryStr);
        System.out.println("255 in hex: " + hexStr);
        
        // Formatted string conversion
        String formatted = String.format("Number: %d, Decimal: %.2f, Scientific: %.2e", 
                                        42, 3.14159, 12345.67);
        System.out.println("Formatted: " + formatted);
    }
}
```

### Converting Strings to Primitives
```java
public class StringToPrimitive {
    public static void main(String[] args) {
        // String to numeric types using wrapper class parse methods
        String intString = "123";
        String doubleString = "456.789";
        String boolString = "true";
        
        try {
            // Basic parsing
            int parsedInt = Integer.parseInt(intString);
            double parsedDouble = Double.parseDouble(doubleString);
            boolean parsedBool = Boolean.parseBoolean(boolString);
            
            System.out.println("Parsed int: " + parsedInt);
            System.out.println("Parsed double: " + parsedDouble);
            System.out.println("Parsed boolean: " + parsedBool);
            
            // Parsing with different bases
            String binaryString = "1010";
            String hexString = "FF";
            String octalString = "777";
            
            int fromBinary = Integer.parseInt(binaryString, 2);   // Base 2
            int fromHex = Integer.parseInt(hexString, 16);        // Base 16
            int fromOctal = Integer.parseInt(octalString, 8);     // Base 8
            
            System.out.println("Binary '1010' to decimal: " + fromBinary);
            System.out.println("Hex 'FF' to decimal: " + fromHex);
            System.out.println("Octal '777' to decimal: " + fromOctal);
            
            // Parsing floating point numbers
            String scientificNotation = "1.23e-4";
            String infinityString = "Infinity";
            String nanString = "NaN";
            
            double scientific = Double.parseDouble(scientificNotation);
            double infinity = Double.parseDouble(infinityString);
            double notANumber = Double.parseDouble(nanString);
            
            System.out.println("Scientific notation: " + scientific);
            System.out.println("Infinity: " + infinity);
            System.out.println("NaN: " + notANumber);
            
        } catch (NumberFormatException e) {
            System.out.println("Error parsing number: " + e.getMessage());
        }
        
        // Safe parsing with error handling
        String[] testStrings = {"123", "abc", "45.67", "true", "false", "maybe"};
        
        for (String str : testStrings) {
            System.out.println("\nTesting string: '" + str + "'");
            
            // Safe integer parsing
            try {
                int value = Integer.parseInt(str);
                System.out.println("  As integer: " + value);
            } catch (NumberFormatException e) {
                System.out.println("  Cannot parse as integer");
            }
            
            // Safe double parsing
            try {
                double value = Double.parseDouble(str);
                System.out.println("  As double: " + value);
            } catch (NumberFormatException e) {
                System.out.println("  Cannot parse as double");
            }
            
            // Boolean parsing (always succeeds, returns false for non-"true")
            boolean boolValue = Boolean.parseBoolean(str);
            System.out.println("  As boolean: " + boolValue);
        }
    }
}
```

## Wrapper Classes and Boxing

### Autoboxing and Unboxing
```java
public class BoxingUnboxing {
    public static void main(String[] args) {
        // Autoboxing: automatic conversion from primitive to wrapper
        Integer integerWrapper = 42;        // int → Integer (autoboxing)
        Double doubleWrapper = 3.14;        // double → Double (autoboxing)
        Boolean booleanWrapper = true;      // boolean → Boolean (autoboxing)
        Character charWrapper = 'A';        // char → Character (autoboxing)
        
        System.out.println("Autoboxed values:");
        System.out.println("Integer: " + integerWrapper);
        System.out.println("Double: " + doubleWrapper);
        System.out.println("Boolean: " + booleanWrapper);
        System.out.println("Character: " + charWrapper);
        
        // Unboxing: automatic conversion from wrapper to primitive
        int primitiveInt = integerWrapper;      // Integer → int (unboxing)
        double primitiveDouble = doubleWrapper; // Double → double (unboxing)
        boolean primitiveBool = booleanWrapper; // Boolean → boolean (unboxing)
        char primitiveChar = charWrapper;       // Character → char (unboxing)
        
        System.out.println("\nUnboxed values:");
        System.out.println("int: " + primitiveInt);
        System.out.println("double: " + primitiveDouble);
        System.out.println("boolean: " + primitiveBool);
        System.out.println("char: " + primitiveChar);
        
        // Mixed operations with autoboxing/unboxing
        Integer a = 10;
        Integer b = 20;
        Integer sum = a + b;  // Unbox, add, then autobox result
        
        System.out.println("Wrapper arithmetic: " + a + " + " + b + " = " + sum);
        
        // Collections require wrapper classes (can't store primitives)
        java.util.List<Integer> numbers = new java.util.ArrayList<>();
        numbers.add(1);    // int → Integer (autoboxing)
        numbers.add(2);    // int → Integer (autoboxing)
        numbers.add(3);    // int → Integer (autoboxing)
        
        for (Integer num : numbers) {
            int value = num;  // Integer → int (unboxing)
            System.out.println("List value: " + value);
        }
        
        // Performance considerations
        long startTime = System.nanoTime();
        
        // Inefficient: Creates many Integer objects
        Integer inefficientSum = 0;
        for (int i = 0; i < 10000; i++) {
            inefficientSum += i;  // Repeated boxing/unboxing
        }
        
        long inefficientTime = System.nanoTime() - startTime;
        
        startTime = System.nanoTime();
        
        // Efficient: Uses primitive int
        int efficientSum = 0;
        for (int i = 0; i < 10000; i++) {
            efficientSum += i;
        }
        
        long efficientTime = System.nanoTime() - startTime;
        
        System.out.println("Inefficient sum: " + inefficientSum + " (Time: " + inefficientTime + " ns)");
        System.out.println("Efficient sum: " + efficientSum + " (Time: " + efficientTime + " ns)");
    }
}
```

### Wrapper Class Utility Methods
```java
public class WrapperUtilities {
    public static void main(String[] args) {
        // Integer wrapper utilities
        System.out.println("=== Integer Utilities ===");
        System.out.println("Max int value: " + Integer.MAX_VALUE);
        System.out.println("Min int value: " + Integer.MIN_VALUE);
        System.out.println("Integer size in bits: " + Integer.SIZE);
        System.out.println("Integer size in bytes: " + (Integer.SIZE / 8));
        
        int number = 42;
        System.out.println("Binary representation of " + number + ": " + Integer.toBinaryString(number));
        System.out.println("Octal representation: " + Integer.toOctalString(number));
        System.out.println("Hex representation: " + Integer.toHexString(number));
        
        // Comparing integers
        Integer num1 = 100;
        Integer num2 = 200;
        System.out.println("Compare 100 and 200: " + Integer.compare(num1, num2));
        
        // Double wrapper utilities
        System.out.println("\n=== Double Utilities ===");
        System.out.println("Max double value: " + Double.MAX_VALUE);
        System.out.println("Min positive double: " + Double.MIN_VALUE);
        System.out.println("Positive infinity: " + Double.POSITIVE_INFINITY);
        System.out.println("Negative infinity: " + Double.NEGATIVE_INFINITY);
        System.out.println("NaN: " + Double.NaN);
        
        double testDouble = 3.14159;
        System.out.println("Is " + testDouble + " finite? " + Double.isFinite(testDouble));
        System.out.println("Is NaN a number? " + Double.isNaN(Double.NaN));
        System.out.println("Is infinity infinite? " + Double.isInfinite(Double.POSITIVE_INFINITY));
        
        // Character wrapper utilities
        System.out.println("\n=== Character Utilities ===");
        char testChar = 'A';
        System.out.println("'" + testChar + "' is letter: " + Character.isLetter(testChar));
        System.out.println("'" + testChar + "' is digit: " + Character.isDigit(testChar));
        System.out.println("'" + testChar + "' is uppercase: " + Character.isUpperCase(testChar));
        System.out.println("'" + testChar + "' lowercase: " + Character.toLowerCase(testChar));
        
        char digit = '5';
        System.out.println("Numeric value of '" + digit + "': " + Character.getNumericValue(digit));
        
        // Boolean wrapper utilities
        System.out.println("\n=== Boolean Utilities ===");
        Boolean bool1 = true;
        Boolean bool2 = false;
        System.out.println("Logical AND: " + Boolean.logicalAnd(bool1, bool2));
        System.out.println("Logical OR: " + Boolean.logicalOr(bool1, bool2));
        System.out.println("Logical XOR: " + Boolean.logicalXor(bool1, bool2));
        
        // String to wrapper conversions with validation
        System.out.println("\n=== Safe Conversions ===");
        String[] testValues = {"123", "abc", "45.67", "true", "2147483648"}; // Last one exceeds int range
        
        for (String value : testValues) {
            System.out.println("Testing: '" + value + "'");
            
            // Safe Integer parsing
            try {
                Integer intValue = Integer.valueOf(value);
                System.out.println("  Integer: " + intValue);
            } catch (NumberFormatException e) {
                System.out.println("  Cannot parse as Integer: " + e.getMessage());
            }
            
            // Safe Double parsing
            try {
                Double doubleValue = Double.valueOf(value);
                System.out.println("  Double: " + doubleValue);
            } catch (NumberFormatException e) {
                System.out.println("  Cannot parse as Double: " + e.getMessage());
            }
            
            // Boolean parsing (never throws exception)
            Boolean boolValue = Boolean.valueOf(value);
            System.out.println("  Boolean: " + boolValue);
        }
    }
}
```

## Practical Type Conversion Examples

### Data Input and Conversion
```java
import java.util.Scanner;

public class DataInputConversion {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=== Multi-Type Calculator ===");
        
        // Get string input and convert to numbers
        System.out.print("Enter first number: ");
        String input1 = scanner.nextLine();
        
        System.out.print("Enter second number: ");
        String input2 = scanner.nextLine();
        
        try {
            // Try to parse as integers first
            if (isInteger(input1) && isInteger(input2)) {
                int num1 = Integer.parseInt(input1);
                int num2 = Integer.parseInt(input2);
                
                System.out.println("Detected integers:");
                System.out.println("Sum: " + (num1 + num2));
                System.out.println("Product: " + (num1 * num2));
                System.out.println("Integer division: " + (num1 / num2));
                System.out.println("Remainder: " + (num1 % num2));
            } else {
                // Parse as doubles
                double num1 = Double.parseDouble(input1);
                double num2 = Double.parseDouble(input2);
                
                System.out.println("Detected decimal numbers:");
                System.out.println("Sum: " + (num1 + num2));
                System.out.println("Product: " + (num1 * num2));
                System.out.println("Division: " + (num1 / num2));
                System.out.println("Power: " + Math.pow(num1, num2));
            }
            
        } catch (NumberFormatException e) {
            System.out.println("Error: Please enter valid numbers");
        }
        
        // Character to ASCII conversion
        System.out.print("\nEnter a character: ");
        String charInput = scanner.nextLine();
        
        if (charInput.length() == 1) {
            char character = charInput.charAt(0);
            int asciiValue = (int) character;  // Explicit cast
            
            System.out.println("Character: '" + character + "'");
            System.out.println("ASCII value: " + asciiValue);
            System.out.println("Next character: '" + (char)(asciiValue + 1) + "'");
            System.out.println("Previous character: '" + (char)(asciiValue - 1) + "'");
        }
        
        scanner.close();
    }
    
    // Helper method to check if string represents an integer
    public static boolean isInteger(String str) {
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
```

### Temperature Conversion System
```java
public class TemperatureConverter {
    public static void main(String[] args) {
        // Comprehensive temperature conversion with type casting
        
        // Input temperatures as different types
        int celsiusInt = 25;                    // Integer Celsius
        double fahrenheitDouble = 98.6;         // Double Fahrenheit
        float kelvinFloat = 273.15f;           // Float Kelvin
        
        System.out.println("=== Temperature Conversions ===");
        
        // Convert integer Celsius to other scales
        System.out.println("Starting with Celsius (int): " + celsiusInt + "°C");
        
        double fahrenheitFromCelsius = (celsiusInt * 9.0 / 5.0) + 32; // int promoted to double
        double kelvinFromCelsius = celsiusInt + 273.15;               // int promoted to double
        
        System.out.println("To Fahrenheit: " + fahrenheitFromCelsius + "°F");
        System.out.println("To Kelvin: " + kelvinFromCelsius + "K");
        
        // Convert double Fahrenheit to other scales
        System.out.println("\nStarting with Fahrenheit (double): " + fahrenheitDouble + "°F");
        
        double celsiusFromFahrenheit = (fahrenheitDouble - 32) * 5.0 / 9.0;
        double kelvinFromFahrenheit = celsiusFromFahrenheit + 273.15;
        
        System.out.println("To Celsius: " + celsiusFromFahrenheit + "°C");
        System.out.println("To Kelvin: " + kelvinFromFahrenheit + "K");
        
        // Convert float Kelvin to other scales
        System.out.println("\nStarting with Kelvin (float): " + kelvinFloat + "K");
        
        double celsiusFromKelvin = kelvinFloat - 273.15;              // float promoted to double
        double fahrenheitFromKelvin = (celsiusFromKelvin * 9.0 / 5.0) + 32;
        
        System.out.println("To Celsius: " + celsiusFromKelvin + "°C");
        System.out.println("To Fahrenheit: " + fahrenheitFromKelvin + "°F");
        
        // Demonstrate precision issues and casting
        System.out.println("\n=== Precision and Casting Examples ===");
        
        double preciseTemp = 23.456789;
        float lessPreciseTemp = (float) preciseTemp;    // Explicit cast, loss of precision
        int roundedTemp = (int) preciseTemp;            // Truncation, not rounding
        int properlyRounded = (int) Math.round(preciseTemp); // Proper rounding
        
        System.out.println("Original double: " + preciseTemp);
        System.out.println("Cast to float: " + lessPreciseTemp);
        System.out.println("Truncated to int: " + roundedTemp);
        System.out.println("Properly rounded: " + properlyRounded);
        
        // Working with different input formats
        String[] temperatureInputs = {"25", "98.6", "273.15", "invalid"};
        
        System.out.println("\n=== Processing String Inputs ===");
        for (String input : temperatureInputs) {
            System.out.println("Processing: '" + input + "'");
            
            try {
                double temp = Double.parseDouble(input);
                String formatted = String.format("%.2f", temp);
                System.out.println("  Parsed as: " + formatted);
                
                // Determine if it's likely Celsius, Fahrenheit, or Kelvin based on range
                if (temp > 200) {
                    System.out.println("  Likely Kelvin (high value)");
                } else if (temp > 50) {
                    System.out.println("  Likely Fahrenheit (moderate-high value)");
                } else {
                    System.out.println("  Likely Celsius (typical range)");
                }
                
            } catch (NumberFormatException e) {
                System.out.println("  Invalid temperature format");
            }
        }
    }
}
```

### Number Base Conversion System
```java
public class NumberBaseConverter {
    public static void main(String[] args) {
        int decimalNumber = 255;
        
        System.out.println("=== Number Base Conversions ===");
        System.out.println("Decimal number: " + decimalNumber);
        
        // Convert to different bases using built-in methods
        String binaryString = Integer.toBinaryString(decimalNumber);
        String octalString = Integer.toOctalString(decimalNumber);
        String hexString = Integer.toHexString(decimalNumber);
        
        System.out.println("Binary: " + binaryString);
        System.out.println("Octal: " + octalString);
        System.out.println("Hexadecimal: " + hexString.toUpperCase());
        
        // Convert from different bases back to decimal
        System.out.println("\n=== Converting Back to Decimal ===");
        
        String binaryInput = "11111111";
        String octalInput = "377";
        String hexInput = "FF";
        
        int fromBinary = Integer.parseInt(binaryInput, 2);
        int fromOctal = Integer.parseInt(octalInput, 8);
        int fromHex = Integer.parseInt(hexInput, 16);
        
        System.out.println("Binary '" + binaryInput + "' = " + fromBinary);
        System.out.println("Octal '" + octalInput + "' = " + fromOctal);
        System.out.println("Hex '" + hexInput + "' = " + fromHex);
        
        // Custom base conversion method
        System.out.println("\n=== Custom Base Conversion ===");
        
        int number = 42;
        for (int base = 2; base <= 16; base++) {
            String converted = convertToBase(number, base);
            System.out.println("Base " + base + ": " + converted);
        }
        
        // Demonstrate type casting in base conversions
        System.out.println("\n=== Type Casting in Base Conversions ===");
        
        double doubleValue = 123.75;
        int intPart = (int) doubleValue;                    // Get integer part
        double fracPart = doubleValue - intPart;            // Get fractional part
        
        System.out.println("Original double: " + doubleValue);
        System.out.println("Integer part: " + intPart);
        System.out.println("Integer part in binary: " + Integer.toBinaryString(intPart));
        System.out.println("Fractional part: " + fracPart);
        
        // Convert fractional part to binary (simplified)
        String fracBinary = convertFractionToBinary(fracPart, 8);
        System.out.println("Fractional part in binary: 0." + fracBinary);
        System.out.println("Complete binary: " + Integer.toBinaryString(intPart) + "." + fracBinary);
    }
    
    // Custom method to convert number to any base (2-36)
    public static String convertToBase(int number, int base) {
        if (base < 2 || base > 36) {
            throw new IllegalArgumentException("Base must be between 2 and 36");
        }
        
        if (number == 0) {
            return "0";
        }
        
        StringBuilder result = new StringBuilder();
        String digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        
        boolean negative = number < 0;
        number = Math.abs(number);
        
        while (number > 0) {
            int remainder = number % base;
            result.insert(0, digits.charAt(remainder));
            number /= base;
        }
        
        if (negative) {
            result.insert(0, '-');
        }
        
        return result.toString();
    }
    
    // Convert fractional part to binary (limited precision)
    public static String convertFractionToBinary(double fraction, int precision) {
        StringBuilder binary = new StringBuilder();
        
        for (int i = 0; i < precision; i++) {
            fraction *= 2;
            int bit = (int) fraction;  // Cast to int to get the integer part
            binary.append(bit);
            fraction -= bit;           // Remove the integer part
            
            if (fraction == 0) {
                break; // Exact representation found
            }
        }
        
        return binary.toString();
    }
}
```

## Common Type Conversion Pitfalls

### Data Loss and Overflow
```java
public class TypeConversionPitfalls {
    public static void main(String[] args) {
        System.out.println("=== Common Type Conversion Pitfalls ===");
        
        // Pitfall 1: Narrowing conversion data loss
        System.out.println("1. Narrowing Conversion Data Loss:");
        long largeLong = 123456789012345L;
        int narrowedInt = (int) largeLong;  // Data loss!
        
        System.out.println("Original long: " + largeLong);
        System.out.println("Narrowed to int: " + narrowedInt);
        System.out.println("Data lost: " + (largeLong != narrowedInt));
        
        // Pitfall 2: Floating point precision loss
        System.out.println("\n2. Floating Point Precision Loss:");
        double preciseDouble = 1.23456789012345;
        float lessReciseFloat = (float) preciseDouble;
        
        System.out.println("Original double: " + preciseDouble);
        System.out.println("Cast to float: " + lessReciseFloat);
        System.out.println("Precision lost: " + (preciseDouble != lessReciseFloat));
        
        // Pitfall 3: Integer overflow
        System.out.println("\n3. Integer Overflow:");
        int maxInt = Integer.MAX_VALUE;
        int overflowed = maxInt + 1;  // Overflow!
        
        System.out.println("Max int: " + maxInt);
        System.out.println("Max int + 1: " + overflowed);
        System.out.println("Overflow occurred: " + (overflowed < 0));
        
        // Safe overflow detection
        System.out.println("\n3a. Safe Addition Check:");
        if (maxInt > 0 && 1 > Integer.MAX_VALUE - maxInt) {
            System.out.println("Addition would cause overflow!");
        }
        
        // Pitfall 4: Truncation vs Rounding
        System.out.println("\n4. Truncation vs Rounding:");
        double[] testValues = {9.1, 9.5, 9.9, -9.1, -9.5, -9.9};
        
        for (double value : testValues) {
            int truncated = (int) value;                    // Truncation
            int rounded = (int) Math.round(value);          // Rounding
            int floored = (int) Math.floor(value);          // Floor
            int ceiled = (int) Math.ceil(value);            // Ceiling
            
            System.out.printf("%.1f -> Truncated: %d, Rounded: %d, Floor: %d, Ceil: %d\n",
                            value, truncated, rounded, floored, ceiled);
        }
        
        // Pitfall 5: Character conversion confusion
        System.out.println("\n5. Character Conversion Confusion:");
        char digit = '5';
        int wrongConversion = (int) digit;          // ASCII value, not numeric value!
        int correctConversion = Character.getNumericValue(digit);
        
        System.out.println("Character '5':");
        System.out.println("Cast to int (ASCII): " + wrongConversion);
        System.out.println("Numeric value: " + correctConversion);
        
        // Pitfall 6: String to number conversion errors
        System.out.println("\n6. String Conversion Errors:");
        String[] problematicStrings = {
            "123abc",    // Contains non-numeric characters
            "1.23.45",   // Multiple decimal points
            "1,234",     // Contains comma
            " 123 ",     // Leading/trailing spaces (actually works for most parse methods)
            "",          // Empty string
            "2147483648" // Exceeds int range
        };
        
        for (String str : problematicStrings) {
            System.out.println("Testing: '" + str + "'");
            
            try {
                int value = Integer.parseInt(str);
                System.out.println("  Success: " + value);
            } catch (NumberFormatException e) {
                System.out.println("  Error: " + e.getMessage());
            }
            
            // Show trim() solution for spaces
            if (str.trim().equals(str.trim()) && !str.trim().isEmpty()) {
                try {
                    int value = Integer.parseInt(str.trim());
                    System.out.println("  After trim: " + value);
                } catch (NumberFormatException e) {
                    // Still can't parse
                }
            }
        }
        
        // Pitfall 7: Boolean conversion assumptions
        System.out.println("\n7. Boolean Conversion Assumptions:");
        String[] booleanStrings = {"true", "True", "TRUE", "false", "False", "1", "0", "yes", "no"};
        
        for (String str : booleanStrings) {
            boolean parsed = Boolean.parseBoolean(str);
            boolean correct = "true".equalsIgnoreCase(str);
            
            System.out.printf("'%s' -> parseBoolean: %b, case-insensitive 'true': %b\n",
                            str, parsed, correct);
        }
    }
}
```

## Best Practices and Guidelines

### Safe Type Conversion Practices
```java
public class SafeConversionPractices {
    
    // Safe integer conversion with range checking
    public static int safeIntegerConversion(long value) {
        if (value > Integer.MAX_VALUE) {
            throw new IllegalArgumentException("Value too large for int: " + value);
        }
        if (value < Integer.MIN_VALUE) {
            throw new IllegalArgumentException("Value too small for int: " + value);
        }
        return (int) value;
    }
    
    // Safe string to number conversion
    public static Integer safeParseInt(String str) {
        if (str == null || str.trim().isEmpty()) {
            return null;
        }
        
        try {
            return Integer.parseInt(str.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }
    
    // Safe string to number with default value
    public static int parseIntWithDefault(String str, int defaultValue) {
        Integer result = safeParseInt(str);
        return result != null ? result : defaultValue;
    }
    
    // Proper rounding for type conversion
    public static int roundToInt(double value) {
        if (value > Integer.MAX_VALUE) {
            return Integer.MAX_VALUE;
        }
        if (value < Integer.MIN_VALUE) {
            return Integer.MIN_VALUE;
        }
        return (int) Math.round(value);
    }
    
    // Safe division with type conversion
    public static double safeDivision(int dividend, int divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("Division by zero");
        }
        return (double) dividend / divisor;  // Explicit cast for precision
    }
    
    public static void main(String[] args) {
        System.out.println("=== Safe Conversion Practices ===");
        
        // Test safe integer conversion
        long[] testLongs = {100L, Integer.MAX_VALUE + 1L, Integer.MIN_VALUE - 1L};
        
        for (long value : testLongs) {
            try {
                int result = safeIntegerConversion(value);
                System.out.println("Safe conversion of " + value + ": " + result);
            } catch (IllegalArgumentException e) {
                System.out.println("Conversion failed for " + value + ": " + e.getMessage());
            }
        }
        
        // Test safe string parsing
        String[] testStrings = {"123", "abc", null, "  456  ", ""};
        
        System.out.println("\nSafe string parsing:");
        for (String str : testStrings) {
            Integer result = safeParseInt(str);
            System.out.println("'" + str + "' -> " + result);
            
            int withDefault = parseIntWithDefault(str, -1);
            System.out.println("'" + str + "' with default -> " + withDefault);
        }
        
        // Test proper rounding
        double[] testDoubles = {9.1, 9.5, 9.9, -9.1, -9.5, -9.9};
        
        System.out.println("\nProper rounding:");
        for (double value : testDoubles) {
            int rounded = roundToInt(value);
            System.out.println(value + " rounded to int: " + rounded);
        }
        
        // Test safe division
        int[][] divisionTests = {{10, 3}, {15, 4}, {7, 0}};
        
        System.out.println("\nSafe division:");
        for (int[] test : divisionTests) {
            try {
                double result = safeDivision(test[0], test[1]);
                System.out.println(test[0] + " / " + test[1] + " = " + result);
            } catch (IllegalArgumentException e) {
                System.out.println(test[0] + " / " + test[1] + " -> " + e.getMessage());
            }
        }
    }
}
```

## Key Takeaways

1. **Understand the difference** between implicit (widening) and explicit (narrowing) conversions
2. **Be aware of data loss** when casting from larger to smaller types
3. **Use appropriate methods** for string-to-primitive conversions
4. **Handle NumberFormatException** when parsing strings to numbers
5. **Understand autoboxing/unboxing** and its performance implications
6. **Use Math.round()** for proper rounding instead of casting for truncation
7. **Validate input ranges** before type conversions to prevent overflow
8. **Choose the right data type** from the beginning to minimize conversions
9. **Use wrapper class utilities** for safe conversions and validations
10. **Test edge cases** like null values, empty strings, and boundary values

## Next Steps

Now that you understand type casting and conversion:
1. Practice with different conversion scenarios and edge cases
2. Experiment with wrapper classes and their utility methods
3. Learn about [Loops (for, while, do-while)](./loops.md) to use conversions in iterative contexts
4. Study [Arrays and String manipulation](./strings.md) where type conversions are frequently used
5. Explore [Exception Handling](./exception-handling.md) to properly handle conversion errors
