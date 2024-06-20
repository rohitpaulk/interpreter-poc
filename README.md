Follows the book https://craftinginterpreters.com/.

Chapters to test names: https://github.com/munificent/craftinginterpreters/blob/01e6f5b8f3e5dfa65674c2f9cf4700d73ab41cf8/tool/bin/test.dart#L599

# Stage #1. Scanning: EOF

In this stage, you'll start implementing a "Scanner" as described in the ["Scanning" chapter](https://craftinginterpreters.com/scanning.html#recognizing-lexemes).

We'll start with parsing an empty file, which should return a single token: `EOF`.

### Tests

The tester will create an empty file `test.lox` and execute your program like this:

```bash
./your_program.sh tokenize test.lox
```

The output should be:

```
EOF null null
```

# Stage #1. Scanning: Parentheses

In this stage, you'll start implementing a "Scanner" as described in the ["Scanning" chapter](https://craftinginterpreters.com/scanning.html#recognizing-lexemes).

We'll start with parsing parentheses (`(` and `)`).

## Tests

The tester will create a file `test.lox` with the tokens `(` and `)` in random order. For example:

```
(()
```

It'll then execute your program like this:

```bash
./your_program.sh tokenize test.lox
```

The tester will verify that the output matches the tokens in `test.lox`:

```
LEFT_PAREN ( null
LEFT_PAREN ( null
RIGHT_PAREN ) null
EOF null null
```

This output format matches that in [`lox/Token.java`](https://craftinginterpreters.com/scanning.html#location-information) from the book.

### Notes

- `null` is just a placeholder for the "literal" value, which we'll use later when dealing with strings & numbers.
- The last token is `EOF`, which stands for "End of File". This is a special token that represents the end of the input file.

# Stage #2. Scanning: Braces

https://craftinginterpreters.com/scanning.html#recognizing-lexemes

Same as above, add braces into the mix.

# Stage #3. Scanning: Other single-character tokens

https://craftinginterpreters.com/scanning.html#recognizing-lexemes

`,`, `.`, `-`, `+`, `;`, `*`.

`/` is not covered here, it'll be covered in later stages.

# Stage #4. Scanning: Single line errors

```
,.$(#
```

Expected output:

```
COMMA , null
DOT . null
[line 1] Error: Unexpected character.
LEFT_PAREN ( null
[line 1] Error: Unexpected character.
```

Also test exit code!

# Stage #5: Scanning: Assignment & equality Operators

https://craftinginterpreters.com/scanning.html#operators

`=`, `==`.

# Stage #6: Scanning: Negation & inequality operators

https://craftinginterpreters.com/scanning.html#operators

`!` && `!=`.

# Stage #7: Scanning: Relational operators

https://craftinginterpreters.com/scanning.html#operators

`<`, `>`, `<=`, `>=`.

# Stage 8: Scanning: Division operator & comments

https://craftinginterpreters.com/scanning.html#longer-lexemes

# Stage #9. Scanning: Whitespace

# Stage #10. Scanning: String literals

`"hello"`

https://craftinginterpreters.com/scanning.html#string-literals

# Stage #11. Scanning: Integer literals

`123`

https://craftinginterpreters.com/scanning.html#number-literals

# Stage #12. Scanning: Decimal/float literals

`123.456`

https://craftinginterpreters.com/scanning.html#number-literals

# Stage #13. Scanning: Identifiers

`abcd`, `foo`, `bar` etc.

# Stage #14. Scanning: Reserved words

`or`, `if` etc.

# Extension 1: Parsing Expressions

Grammar for full extension:

```bash
expression     → literal
               | unary
               | binary
               | grouping ;

literal        → NUMBER | STRING | "true" | "false" | "nil" ;
grouping       → "(" expression ")" ;
unary          → ( "-" | "!" ) expression ;
binary         → expression operator expression ;
operator       → "==" | "!=" | "<" | "<=" | ">" | ">="
               | "+"  | "-"  | "*" | "/" ;
```

## Stage #1. Unary operators & literals

```
-1 => (- 1)
!2 => (! 2)
!true => (! true)
!false => (! false)
!"test" => (! "test")
```

## Stage #2. Binary operators: Addition & Subtraction

expression → ...
equality → ...
comparison → ...
term → ...
factor → ...
unary → ...
primary → ...

```
1 + 2 => (+ 1 2)
1 + 2 + 3 => (+ 1 (+ 2 3))
1 - 2 => (- 1 2)
1 + 2 - 3 => (+ 1 (- 2 3))
```

## Stage #4. Binary operators: Multiplication

```
"hello" != "world"
```

```
./your_program.sh parse test.lox
(!= "hello" "world")
```

## Stage #1. Equality

```
"hello"
```

```
./your_program.sh parse test.lox
("hello")
```

## Extension 2: Evaluation Expressions

## Extension 3: Interpreter
