# Programming by composition in PHP

## Code consistency and git diff

Prefer hanging indent. 1 less line change in the git diffs

```php
$map = [
    'a' => '123',
    'b' => '234' // Optional hanging indent
];

// without hanging indent
$map = [
    'a' => '123',
    'b' => '234', // change here
    'c' => '234'  // change here
];

// with hanging indent
$map = [
    'a' => '123',
    'b' => '234',
    'c' => '234',  // change here
];
```

## Coupling vs Cohesion

### Coupling

- **Definition**: Coupling refers to the degree of interdependence between software modules. It describes how closely connected different components or classes are in a system.
- **Types of Coupling:**

  - **Tight Coupling:** Occurs when a module heavily relies on the internal details of another module, making changes difficult and increasing the risk of introducing bugs.
  - **Loose Coupling:** Represents a design where modules interact with minimal knowledge of each other’s implementation details. This enhances flexibility and maintainability.

- **Benefits of Loose Coupling:**
  - Easier to maintain and modify systems since changes in one module will have minimal impact on others.
  - Promotes reusability because loosely coupled components can often be used in different contexts without significant alteration.

### Cohesion

- **Definition**: Cohesion refers to how closely related and focused the responsibilities of a single module are. It measures the degree to which the elements within a module work together to fulfill a single purpose.

- **Types of Cohesion**:

  - **High Cohesion**: Occurs when a module performs a single task or a set of related tasks, resulting in better organization and easier understanding of the code.
  - **Low Cohesion**: Indicates that a module has unrelated responsibilities, leading to chaos, confusion, and difficulties in maintaining the code.

- **Benefits of High Cohesion**:
  - Improved readability and maintainability, as modules have clearly defined purposes.
  - Easier testing and debugging because functionalities are grouped logically within a module.

### Relationship Between Coupling and Cohesion

- **Balance**: High cohesion within a module and low coupling between modules are ideal in software design. High cohesion increases the module's clarity and purpose while low coupling minimizes dependencies between modules.
- **Impact on Design**: Striving for high cohesion and low coupling in design leads to systems that are more modular, easier to understand, maintain, and extend.

### Conclusion

Understanding the concepts of coupling and cohesion helps developers create robust, maintainable, and scalable software architectures. Prioritizing high cohesion and low coupling in design decisions leads to better-structured code that is easier to work with over time.

## Type Safety

In PHP, type safety refers to the enforcement of data types in your programs to prevent type errors and ensure that functions receive the expected types of arguments and return the expected types of values. PHP's type system has evolved to include type hints and scalar type declarations, and using PHPDoc blocks can enhance type safety, especially in cases where strict typing is not enforced.

### Branded Types

Typically, it is considered best practice to not allow invalid states to be representable. Branded types help achieve this by creating unique types based on existing types, thus preventing accidental misuse. In PHP, you can implement branded types using classes or interfaces to ensure that only valid values can be instantiated.

#### Code Example: Email Validation

Here’s an example in PHP that demonstrates the concept of branded types using an Email class:

```php
class Email {
    private string $email;

    private function __construct(string $email) {
        $this->email = $email;
    }

    /**
     * Factory method to create a new Email instance.
     * Throws an exception if the email address is invalid.
     */
    public static function create(string $email): self {
        if (!self::isValidEmail($email)) {
            throw new InvalidArgumentException("Invalid email address");
        }
        return new self($email);
    }

    /**
     * Validates the given email address using a regex pattern.
     */
    private static function isValidEmail(string $email): bool {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    /**
     * Returns the email address as a string.
     */
    public function __toString(): string {
        return $this->email;
    }
}

// Usage Example
try {
    $myEmail = Email::create("valid.email@example.com");
    echo "Valid email created: " . $myEmail; // Output: Valid email created: valid.email@example.com

    $invalidEmail = Email::create("invalid-email"); // This will throw an error
} catch (InvalidArgumentException $error) {
    echo $error->getMessage(); // Output: Invalid email address
}
```

### Explanation of the Code

1. **Email Class**: The `Email` class serves as a branded type that holds a valid email address. The private constructor prevents instantiation outside the class.

2. **Factory Method**: The `create` method validates the provided email address. If the email is invalid, it throws an `InvalidArgumentException`, ensuring that only valid instances of `Email` can be created.

3. **Validation**: The `isValidEmail` method uses PHP’s built-in `filter_var` function with the `FILTER_VALIDATE_EMAIL` filter, leveraging PHP's capabilities for robust validation.

4. **String Representation**: The `__toString` method allows the `Email` object to be converted to a string, providing an easy way to retrieve the email address value.

5. **Usage**: In the usage example, a valid email is created successfully, while attempting to create an invalid email results in an exception, preventing invalid states throughout the application.

### How to Use PHP Doc Blocks for Type Safety

Nominal vs structural types:

A nominal type would be its own type that encapsulates some thing. An example would be a class. A structural type is a type inferred from its contents. An example would be a record. A record in php may be typed out as something like `array{name: string, email: string}`

1. **Basic Type Declarations**: Use type declarations in function signatures to specify what types of parameters the function accepts and what type it returns. This provides basic type safety at runtime.

   ```php
   function add(int $a, int $b): int {
       return $a + $b;
   }
   ```

2. **Advanced Type Checking with PHPDoc**: PHPDoc comments can be used to annotate types in cases where you cannot enforce types directly (e.g., in older PHP versions). This helps tools like IDEs and static analysis tools understand expected types and ensures consistency in your codebase.

   ```php
   /**
    * Adds two numbers.
    *
    * @param int $a The first number.
    * @param int $b The second number.
    * @return int The sum of the two numbers.
    */
   function add($a, $b) {
       return $a + $b;
   }
   ```

3. **Specifying Complex Types**: You can specify complex types using PHPDoc, including arrays, objects, and nullable types.

   ```php
   /**
    * Processes user data.
    *
    * @param array<string, mixed> $userData An associative array of user data.
    * @return User|null Returns a User object or null if not found.
    */
   function processUserData(array $userData): ?User {
       // Implementation
   }
   ```

4. **Using Collection Types**: Utilize arrays and collections to indicate the expected structure of data.

   ```php
   /**
    * Gets a list of users.
    *
    * @return array<int, array{name: string, email: string, isAdmin?: boolean}> An array of User objects.
    */
   function getUsers() {
       // Implementation
   }
   ```

5. **Static Analysis Tools**: Tools like PHPStan or Psalm can analyze your code and check for type inconsistencies based on the declarations provided in your PHPDoc comments. This enhances type safety by identifying potential issues before runtime.

6. **Integration with IDEs**: Many modern Integrated Development Environments (IDEs) use the information in PHPDoc blocks to provide linting and autocomplete features, assisting developers in writing type-safe code.

### Conclusion

Using PHPDoc blocks is an effective way to enhance type safety in your PHP code. By documenting expected types for function parameters and return values, you improve code clarity, maintainability, and collaboration. Coupling these practices with PHP's built-in type declarations facilitates rigorous type checking and can catch potential errors during development instead of at runtime.

## Code Quality Metrics

Code quality metrics are quantitative measures that help assess various aspects of software quality, maintainability, and performance. These metrics provide insights into potential issues within the codebase, enabling developers to make informed decisions for improvement. Here are some key code quality metrics:

### 1. Cyclomatic Complexity

- **Definition**: Cyclomatic complexity is a software metric used to measure the complexity of a program by quantifying the number of linearly independent paths through its source code. It provides an indication of how complicated the control flow of a program is.
- **Calculation**: The cyclomatic complexity (CC) can be calculated using the formula: \[ CC = E - N + 2P \] where:

  - \(E\) = the number of edges in the control flow graph,
  - \(N\) = the number of nodes in the control flow graph,
  - \(P\) = the number of connected components (typically 1 for a single program).

- **Interpretation**:
  - A cyclomatic complexity score of 1-10 signifies low complexity and that the code is generally easy to understand and maintain.
  - Scores above 10 often indicate that the code might be too complex, leading to potential issues such as difficulty in testing, increased risk of bugs, and challenges in maintenance.
- **Use Cases**: Cyclomatic complexity is particularly useful for identifying areas of the code that may require refactoring or additional documentation. It can help prioritize code reviews and testing efforts, emphasizing sections with higher complexity.

### 2. Halstead Metrics

- **Definition**: Halstead metrics are a set of software metrics that measure various attributes of code based on the operators and operands used within it. These metrics focus on the size and complexity of the code, providing insights into the code's maintainability, understandability, and error proneness.

- **Key Halstead Metrics**:

  - **Program Length (N)**: The total number of operators and operands.
  - **Vocabulary (n)**: The number of distinct operators and operands.
  - **Volume (V)**: A measure of the size of the implementation. Calculated as: \[ V = N \times \log_2(n) \]
  - **Difficulty (D)**: Indicates the complexity of the program and is calculated as: \[ D = \frac{n_1}{2} \times \frac{N_2}{n_2} \] where \(n_1\) is the number of unique operators and \(n_2\) is the number of unique operands.
  - **Effort (E)**: A measure of the effort required to implement the program, calculated as: \[ E = D \times V \]

- **Interpretation**:

  - Higher values in Halstead metrics are generally indicative of more complex code that may be harder to understand and maintain.
  - For example, increasing complexity and decreasing volume might suggest a need for refactoring to enhance code clarity.

- **Use Cases**: Halstead metrics are valuable for assessing code maintainability and guiding refactoring efforts. They can also be used in automated analysis tools to give developers a quick overview of code complexity and potential areas for improvement.

### Coherence

Coherence refers to the logical and meaningful organization of elements within a software system or module. It is about how well the components of a module work together to fulfill a single purpose or task, ensuring that all parts contribute to the overall functionality in a cohesive manner.

### Key Characteristics of Coherence

1. **Purposeful Design**: A coherent system or module has a well-defined purpose. Each element within the module should relate directly to that purpose, making it easier for developers to understand its functionality.

2. **Consistency**: Coherent modules maintain consistent naming conventions, coding styles, and behaviors. This consistency aids developers in navigating and using the code, reducing the cognitive load.

3. **Logical Flow**: Coherent systems exhibit a clear logical flow, where the interactions between components are intuitive and align with the system's overall goals. This enhances user experience and makes the system easier to use.

### Benefits of Coherence

- **Improved Understandability**: When elements within a module are logically organized and share a common purpose, it becomes easier for developers and users to understand the codebase.

- **Ease of Maintenance**: Coherent modules are simpler to maintain and extend because changes are localized within a specific area of the code, reducing the potential for introducing bugs in unrelated parts.

- **Enhanced Collaboration**: Clear and coherent structures enable teams to work together more effectively. Developers can quickly understand each other's contributions, facilitating collaboration and code reviews.

### Conclusion

Coherence is a crucial aspect of software design that contributes to the overall quality, maintainability, and usability of code. By focusing on creating coherent modules and systems, developers can ensure that their software is not only functional but also easier to work with and understand.

### Summary

Cyclomatic complexity and Halstead metrics are essential tools for evaluating code quality. Cyclomatic complexity highlights potential areas of high complexity that may need more careful testing and maintenance, while Halstead metrics provide insights into code size, complexity, and effort required for implementation. Utilizing these metrics helps enhance the maintainability and reliability of software systems, ultimately leading to cleaner and more efficient codebases.

## Abstract algebra inspired pattern creation

Abstract algebra offers a rough guideline for creating design patterns. Not really in the strict sense though. They describe how discreet chunks of things get composed together. Each one builds on top of one another and offers more descriptive power.

### Monoids

Enable the composition and aggregation of values through an associative operation and identity element. They provide a simple and effective way to build complex structures from smaller components, promoting modularity and clarity in software design.

Examples of [Monoids in PHP](../952).

### Functor

Allow functions to be applied to values wrapped in a context (such as arrays or optional types). Functors facilitate mapping operations across collections, enhancing code reusability and encouraging a declarative programming style. They promote uniform handling of data transformations.

Examples of [Functors in PHP](../953).

### Monads

Allow for the chaining of operations while managing context and side effects. Monads encapsulate values within a computation framework, providing methods for transforming those values without losing context. This promotes clean and expressive code structures that avoid side effects, enabling functional programming paradigms within an object-oriented context.

Examples of [Monads in PHP](../954).

### Kleisli

Provide a means to work with functions that return monadic values, allowing for seamless composition of operations. A Kleisli arrow is a way to chain functions that produce monadic results, enhancing the structure of code by allowing the output of one function to be easily passed into another. This pattern promotes cleaner handling of computations that may involve side effects and supports a functional programming style.

Examples of [Kleisli Arrows in PHP](../955).