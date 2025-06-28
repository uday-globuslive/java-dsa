# Module 22: Mathematical Algorithms

## 📚 Learning Objectives
By the end of this module, you will:
- ✅ Master number theory algorithms and prime number techniques
- ✅ Implement efficient algorithms for GCD, LCM, and modular arithmetic
- ✅ Solve combinatorial problems using mathematical principles
- ✅ Apply matrix operations and fast exponentiation for optimization
- ✅ Handle large number computations and cryptographic applications

## 🎯 Module Overview
Mathematical algorithms combine algorithmic thinking with mathematical principles to solve:
- **Number Theory** - Prime numbers, divisibility, modular arithmetic
- **Combinatorics** - Permutations, combinations, counting problems
- **Linear Algebra** - Matrix operations, system solving
- **Cryptography** - RSA, hashing, security algorithms

**Time Investment:** 8-10 hours
**Difficulty Level:** Advanced
**Prerequisites:** Basic Math, Recursion, Arrays

## 📖 Core Concepts

### 1. Number Theory Algorithms

#### Prime Number Algorithms
```java
public class PrimeAlgorithms {
    
    // Basic primality test
    public boolean isPrime(int n) {
        if (n <= 1) return false;
        if (n <= 3) return true;
        if (n % 2 == 0 || n % 3 == 0) return false;
        
        // Check for divisors from 5 to sqrt(n)
        for (int i = 5; i * i <= n; i += 6) {
            if (n % i == 0 || n % (i + 2) == 0) {
                return false;
            }
        }
        
        return true;
    }
    
    // Sieve of Eratosthenes
    public List<Integer> sieveOfEratosthenes(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        
        for (int i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                // Mark all multiples of i as composite
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        
        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= n; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
        
        return primes;
    }
    
    // Segmented Sieve (for large ranges)
    public List<Integer> segmentedSieve(int low, int high) {
        int limit = (int) Math.sqrt(high) + 1;
        List<Integer> primes = sieveOfEratosthenes(limit);
        
        boolean[] isPrime = new boolean[high - low + 1];
        Arrays.fill(isPrime, true);
        
        for (int prime : primes) {
            // Find the minimum number in [low, high] that is a multiple of prime
            int start = Math.max(prime * prime, (low + prime - 1) / prime * prime);
            
            // Mark multiples of prime in range [low, high]
            for (int j = start; j <= high; j += prime) {
                isPrime[j - low] = false;
            }
        }
        
        List<Integer> result = new ArrayList<>();
        for (int i = Math.max(low, 2); i <= high; i++) {
            if (isPrime[i - low]) {
                result.add(i);
            }
        }
        
        return result;
    }
    
    // Prime factorization
    public List<Integer> primeFactors(int n) {
        List<Integer> factors = new ArrayList<>();
        
        // Handle factor 2
        while (n % 2 == 0) {
            factors.add(2);
            n /= 2;
        }
        
        // Handle odd factors
        for (int i = 3; i * i <= n; i += 2) {
            while (n % i == 0) {
                factors.add(i);
                n /= i;
            }
        }
        
        // If n is still > 2, it's a prime
        if (n > 2) {
            factors.add(n);
        }
        
        return factors;
    }
    
    // Count divisors
    public int countDivisors(int n) {
        int count = 0;
        for (int i = 1; i * i <= n; i++) {
            if (n % i == 0) {
                count += (i * i == n) ? 1 : 2;
            }
        }
        return count;
    }
    
    // Sum of divisors
    public int sumOfDivisors(int n) {
        int sum = 0;
        for (int i = 1; i * i <= n; i++) {
            if (n % i == 0) {
                sum += i;
                if (i * i != n) {
                    sum += n / i;
                }
            }
        }
        return sum;
    }
}
```

#### GCD and LCM Algorithms
```java
public class GCDAlgorithms {
    
    // Euclidean algorithm for GCD
    public int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    
    // Recursive GCD
    public int gcdRecursive(int a, int b) {
        if (b == 0) return a;
        return gcdRecursive(b, a % b);
    }
    
    // Extended Euclidean Algorithm
    public ExtendedGCDResult extendedGCD(int a, int b) {
        if (b == 0) {
            return new ExtendedGCDResult(a, 1, 0);
        }
        
        ExtendedGCDResult result = extendedGCD(b, a % b);
        int x = result.y;
        int y = result.x - (a / b) * result.y;
        
        return new ExtendedGCDResult(result.gcd, x, y);
    }
    
    static class ExtendedGCDResult {
        int gcd, x, y;
        ExtendedGCDResult(int gcd, int x, int y) {
            this.gcd = gcd;
            this.x = x;
            this.y = y;
        }
    }
    
    // LCM using GCD
    public int lcm(int a, int b) {
        return (a / gcd(a, b)) * b; // Avoid overflow
    }
    
    // GCD of array
    public int gcdArray(int[] arr) {
        int result = arr[0];
        for (int i = 1; i < arr.length; i++) {
            result = gcd(result, arr[i]);
            if (result == 1) break; // Early termination
        }
        return result;
    }
    
    // LCM of array
    public long lcmArray(int[] arr) {
        long result = arr[0];
        for (int i = 1; i < arr.length; i++) {
            result = lcm((int)result, arr[i]);
        }
        return result;
    }
    
    private long lcm(int a, int b) {
        return ((long)a / gcd(a, b)) * b;
    }
}
```

### 2. Modular Arithmetic

#### Modular Operations
```java
public class ModularArithmetic {
    private static final int MOD = 1_000_000_007;
    
    // Fast modular exponentiation
    public long power(long base, long exp, long mod) {
        long result = 1;
        base %= mod;
        
        while (exp > 0) {
            if (exp % 2 == 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        
        return result;
    }
    
    // Modular multiplicative inverse
    public long modInverse(long a, long mod) {
        return power(a, mod - 2, mod); // For prime modulus
    }
    
    // Modular inverse using Extended Euclidean Algorithm
    public long modInverseExtended(long a, long mod) {
        ExtendedGCDResult result = extendedGCD((int)a, (int)mod);
        if (result.gcd != 1) {
            throw new IllegalArgumentException("Modular inverse doesn't exist");
        }
        return (result.x % mod + mod) % mod;
    }
    
    private ExtendedGCDResult extendedGCD(int a, int b) {
        if (b == 0) return new ExtendedGCDResult(a, 1, 0);
        
        ExtendedGCDResult result = extendedGCD(b, a % b);
        int x = result.y;
        int y = result.x - (a / b) * result.y;
        return new ExtendedGCDResult(result.gcd, x, y);
    }
    
    static class ExtendedGCDResult {
        int gcd, x, y;
        ExtendedGCDResult(int gcd, int x, int y) {
            this.gcd = gcd; this.x = x; this.y = y;
        }
    }
    
    // Chinese Remainder Theorem
    public long chineseRemainderTheorem(int[] remainders, int[] moduli) {
        long result = 0;
        long product = 1;
        
        for (int mod : moduli) {
            product *= mod;
        }
        
        for (int i = 0; i < remainders.length; i++) {
            long partialProduct = product / moduli[i];
            long inverse = modInverseExtended(partialProduct, moduli[i]);
            result = (result + remainders[i] * partialProduct * inverse) % product;
        }
        
        return (result + product) % product;
    }
    
    // Wilson's Theorem: (p-1)! ≡ -1 (mod p) for prime p
    public boolean isWilsonPrime(int p) {
        if (p <= 1) return false;
        if (p == 2) return true;
        
        long factorial = 1;
        for (int i = 1; i < p; i++) {
            factorial = (factorial * i) % p;
        }
        
        return factorial == p - 1;
    }
}
```

### 3. Combinatorial Algorithms

#### Combinatorics and Factorials
```java
public class Combinatorics {
    private static final int MOD = 1_000_000_007;
    private long[] fact;
    private long[] invFact;
    
    public Combinatorics(int maxN) {
        precomputeFactorials(maxN);
    }
    
    private void precomputeFactorials(int n) {
        fact = new long[n + 1];
        invFact = new long[n + 1];
        
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        
        invFact[n] = modInverse(fact[n], MOD);
        for (int i = n - 1; i >= 0; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }
    
    // nCr = n! / (r! * (n-r)!)
    public long nCr(int n, int r) {
        if (r > n || r < 0) return 0;
        return (fact[n] * invFact[r] % MOD) * invFact[n - r] % MOD;
    }
    
    // nPr = n! / (n-r)!
    public long nPr(int n, int r) {
        if (r > n || r < 0) return 0;
        return fact[n] * invFact[n - r] % MOD;
    }
    
    // Catalan numbers: C(n) = (2n)! / ((n+1)! * n!)
    public long catalan(int n) {
        return nCr(2 * n, n) * modInverse(n + 1, MOD) % MOD;
    }
    
    // Stirling numbers of second kind
    public long stirlingSecond(int n, int k) {
        if (n == 0) return k == 0 ? 1 : 0;
        if (k == 0 || k > n) return 0;
        
        long[][] dp = new long[n + 1][k + 1];
        dp[0][0] = 1;
        
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                dp[i][j] = (j * dp[i - 1][j] + dp[i - 1][j - 1]) % MOD;
            }
        }
        
        return dp[n][k];
    }
    
    // Bell numbers (sum of Stirling numbers of second kind)
    public long bell(int n) {
        long sum = 0;
        for (int k = 0; k <= n; k++) {
            sum = (sum + stirlingSecond(n, k)) % MOD;
        }
        return sum;
    }
    
    // Derangement numbers
    public long derangement(int n) {
        if (n == 0) return 1;
        if (n == 1) return 0;
        
        long[] dp = new long[n + 1];
        dp[0] = 1;
        dp[1] = 0;
        
        for (int i = 2; i <= n; i++) {
            dp[i] = ((long)(i - 1) * (dp[i - 1] + dp[i - 2])) % MOD;
        }
        
        return dp[n];
    }
    
    private long modInverse(long a, long mod) {
        return power(a, mod - 2, mod);
    }
    
    private long power(long base, long exp, long mod) {
        long result = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) result = (result * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return result;
    }
}
```

### 4. Matrix Operations

#### Matrix Algorithms
```java
public class MatrixAlgorithms {
    
    // Matrix multiplication
    public long[][] multiply(long[][] A, long[][] B, long mod) {
        int n = A.length;
        int m = B[0].length;
        int p = B.length;
        
        long[][] C = new long[n][m];
        
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                for (int k = 0; k < p; k++) {
                    C[i][j] = (C[i][j] + A[i][k] * B[k][j]) % mod;
                }
            }
        }
        
        return C;
    }
    
    // Matrix exponentiation
    public long[][] matrixPower(long[][] matrix, long exp, long mod) {
        int n = matrix.length;
        long[][] result = new long[n][n];
        
        // Initialize result as identity matrix
        for (int i = 0; i < n; i++) {
            result[i][i] = 1;
        }
        
        long[][] base = cloneMatrix(matrix);
        
        while (exp > 0) {
            if (exp % 2 == 1) {
                result = multiply(result, base, mod);
            }
            base = multiply(base, base, mod);
            exp /= 2;
        }
        
        return result;
    }
    
    // Fibonacci using matrix exponentiation
    public long fibonacci(int n, long mod) {
        if (n <= 1) return n;
        
        long[][] fib = {{1, 1}, {1, 0}};
        long[][] result = matrixPower(fib, n - 1, mod);
        
        return result[0][0];
    }
    
    // Linear recurrence using matrix exponentiation
    public long solveRecurrence(int[] coeffs, int[] initial, int n, long mod) {
        int k = coeffs.length;
        if (n < k) return initial[n];
        
        // Build transformation matrix
        long[][] matrix = new long[k][k];
        
        // First row: coefficients in reverse order
        for (int i = 0; i < k; i++) {
            matrix[0][i] = coeffs[k - 1 - i];
        }
        
        // Identity part
        for (int i = 1; i < k; i++) {
            matrix[i][i - 1] = 1;
        }
        
        // Compute matrix^(n-k+1)
        long[][] result = matrixPower(matrix, n - k + 1, mod);
        
        // Multiply with initial state
        long answer = 0;
        for (int i = 0; i < k; i++) {
            answer = (answer + result[0][i] * initial[k - 1 - i]) % mod;
        }
        
        return answer;
    }
    
    // Determinant of matrix
    public long determinant(long[][] matrix, long mod) {
        int n = matrix.length;
        long[][] temp = cloneMatrix(matrix);
        long det = 1;
        
        for (int i = 0; i < n; i++) {
            // Find pivot
            int pivot = -1;
            for (int j = i; j < n; j++) {
                if (temp[j][i] != 0) {
                    pivot = j;
                    break;
                }
            }
            
            if (pivot == -1) return 0; // Singular matrix
            
            if (pivot != i) {
                // Swap rows
                long[] tempRow = temp[i];
                temp[i] = temp[pivot];
                temp[pivot] = tempRow;
                det = (mod - det) % mod; // Change sign
            }
            
            det = (det * temp[i][i]) % mod;
            long inv = modInverse(temp[i][i], mod);
            
            // Eliminate column
            for (int j = i + 1; j < n; j++) {
                long factor = (temp[j][i] * inv) % mod;
                for (int k = i; k < n; k++) {
                    temp[j][k] = (temp[j][k] - factor * temp[i][k] % mod + mod) % mod;
                }
            }
        }
        
        return det;
    }
    
    private long[][] cloneMatrix(long[][] matrix) {
        int n = matrix.length;
        int m = matrix[0].length;
        long[][] clone = new long[n][m];
        for (int i = 0; i < n; i++) {
            System.arraycopy(matrix[i], 0, clone[i], 0, m);
        }
        return clone;
    }
    
    private long modInverse(long a, long mod) {
        return power(a, mod - 2, mod);
    }
    
    private long power(long base, long exp, long mod) {
        long result = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) result = (result * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return result;
    }
}
```

### 5. Number Theory Applications

#### Advanced Number Theory
```java
public class AdvancedNumberTheory {
    
    // Euler's totient function
    public int eulerTotient(int n) {
        int result = n;
        
        // Check all prime factors
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) {
                // Remove all factors of i
                while (n % i == 0) {
                    n /= i;
                }
                result -= result / i;
            }
        }
        
        // If n is still > 1, it's a prime
        if (n > 1) {
            result -= result / n;
        }
        
        return result;
    }
    
    // Sieve for Euler's totient function
    public int[] sieveTotient(int n) {
        int[] phi = new int[n + 1];
        
        for (int i = 0; i <= n; i++) {
            phi[i] = i;
        }
        
        for (int i = 2; i <= n; i++) {
            if (phi[i] == i) { // i is prime
                for (int j = i; j <= n; j += i) {
                    phi[j] -= phi[j] / i;
                }
            }
        }
        
        return phi;
    }
    
    // Mobius function
    public int mobius(int n) {
        if (n == 1) return 1;
        
        int factors = 0;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) {
                if (n % (i * i) == 0) {
                    return 0; // Square factor exists
                }
                factors++;
                n /= i;
            }
        }
        
        if (n > 1) factors++; // n is prime
        
        return (factors % 2 == 0) ? 1 : -1;
    }
    
    // Jacobi symbol (generalization of Legendre symbol)
    public int jacobiSymbol(int a, int n) {
        if (n % 2 == 0 || n < 0) {
            throw new IllegalArgumentException("n must be positive odd");
        }
        
        a %= n;
        int result = 1;
        
        while (a != 0) {
            while (a % 2 == 0) {
                a /= 2;
                if (n % 8 == 3 || n % 8 == 5) {
                    result = -result;
                }
            }
            
            // Swap a and n
            int temp = a;
            a = n;
            n = temp;
            
            if (a % 4 == 3 && n % 4 == 3) {
                result = -result;
            }
            
            a %= n;
        }
        
        return (n == 1) ? result : 0;
    }
    
    // Miller-Rabin primality test
    public boolean isPrimeMR(long n, int k) {
        if (n <= 1) return false;
        if (n <= 3) return true;
        if (n % 2 == 0) return false;
        
        // Write n-1 as d * 2^r
        long d = n - 1;
        int r = 0;
        while (d % 2 == 0) {
            d /= 2;
            r++;
        }
        
        Random rand = new Random();
        
        for (int i = 0; i < k; i++) {
            long a = 2 + rand.nextLong() % (n - 3);
            long x = power(a, d, n);
            
            if (x == 1 || x == n - 1) continue;
            
            boolean composite = true;
            for (int j = 0; j < r - 1; j++) {
                x = power(x, 2, n);
                if (x == n - 1) {
                    composite = false;
                    break;
                }
            }
            
            if (composite) return false;
        }
        
        return true;
    }
    
    private long power(long base, long exp, long mod) {
        long result = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) result = (result * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return result;
    }
}
```

## 🔧 Common Problem Patterns

### Pattern 1: Prime Number Problems
- **Use Case:** Problems involving prime numbers, factorization
- **Key Insight:** Use appropriate sieve or primality test
- **Example Problems:** Count Primes, Prime Factorization

### Pattern 2: Modular Arithmetic
- **Use Case:** Large number calculations, combinatorics
- **Key Insight:** Use modular properties to avoid overflow
- **Example Problems:** Power of Numbers, Combinations with MOD

### Pattern 3: Mathematical Sequences
- **Use Case:** Fibonacci-like recurrences, matrix exponentiation
- **Key Insight:** Use matrix multiplication for fast computation
- **Example Problems:** Climbing Stairs, Tribonacci Numbers

### Pattern 4: Number Theory
- **Use Case:** GCD/LCM problems, Euclidean algorithm applications
- **Key Insight:** Use extended Euclidean algorithm for advanced problems
- **Example Problems:** Fraction Addition, Ugly Numbers

## 💻 Practice Problems

### Medium Level
1. **Count Primes (LeetCode 204)**
   - Use Sieve of Eratosthenes for efficient counting
   - Handle large input sizes

2. **Pow(x, n) (LeetCode 50)**
   - Implement fast exponentiation
   - Handle negative exponents and edge cases

3. **Nth Ugly Number (LeetCode 264)**
   - Use dynamic programming with multiple pointers
   - Generate sequence efficiently

### Hard Level
4. **Super Ugly Number (LeetCode 313)**
   - Generalize ugly number generation
   - Use priority queue or multiple pointers

5. **Factorial Trailing Zeroes (LeetCode 172)**
   - Count factors of 5 in factorial
   - Mathematical insight required

## 🧠 Problem-Solving Templates

### Template 1: Prime Sieve
```java
public boolean[] sieve(int n) {
    boolean[] isPrime = new boolean[n + 1];
    Arrays.fill(isPrime, true);
    isPrime[0] = isPrime[1] = false;
    
    for (int i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (int j = i * i; j <= n; j += i) {
                isPrime[j] = false;
            }
        }
    }
    
    return isPrime;
}
```

### Template 2: Fast Exponentiation
```java
public long power(long base, long exp, long mod) {
    long result = 1;
    base %= mod;
    
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    
    return result;
}
```

### Template 3: Extended GCD
```java
public class ExtGCD {
    int gcd, x, y;
    
    void extgcd(int a, int b) {
        if (b == 0) {
            gcd = a; x = 1; y = 0;
        } else {
            extgcd(b, a % b);
            int temp = x;
            x = y;
            y = temp - (a / b) * y;
        }
    }
}
```

## ⚡ Optimization Techniques

### 1. Precomputation
- **Factorials:** Precompute for combinatorial problems
- **Primes:** Use sieve for multiple queries
- **Powers:** Precompute small powers

### 2. Mathematical Properties
- **Modular Arithmetic:** Use properties to simplify calculations
- **Symmetry:** Exploit mathematical symmetries
- **Recurrence Relations:** Convert to matrix exponentiation

### 3. Efficient Algorithms
- **Sieve Variants:** Segmented sieve for large ranges
- **Fast Multiplication:** Karatsuba for very large numbers
- **Number Theoretic Transform:** For polynomial multiplication

## 📈 Complexity Analysis

### Time Complexities
- **Sieve of Eratosthenes:** O(n log log n)
- **Fast Exponentiation:** O(log n)
- **Matrix Exponentiation:** O(k³ log n) for k×k matrix
- **Extended GCD:** O(log min(a,b))

### Space Complexities
- **Sieve:** O(n)
- **Fast Exponentiation:** O(1)
- **Matrix Operations:** O(k²)
- **Combinatorics:** O(n) for precomputation

## 🎯 Key Takeaways

1. **Algorithm Selection:**
   - Choose appropriate primality test based on input size
   - Use precomputation for repeated queries
   - Apply mathematical properties to optimize

2. **Implementation Tips:**
   - Handle modular arithmetic carefully
   - Use long data type to avoid overflow
   - Implement extended GCD for advanced problems

3. **Common Applications:**
   - Cryptography and security
   - Combinatorial optimization
   - Number theory problems
   - Mathematical modeling

## 🚀 Next Steps
- Practice implementing mathematical algorithms from scratch
- Study advanced topics like elliptic curves and algebraic structures
- Apply to cryptographic and security problems
- Move to **Module 23: Problem Solving Framework** for systematic approaches

---
*Mathematical algorithms bridge the gap between theoretical mathematics and practical programming. Master these techniques to solve complex numerical and combinatorial problems efficiently.*
