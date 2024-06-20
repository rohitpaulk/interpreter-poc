Follows the book https://craftinginterpreters.com/.

Chapters to test names: https://github.com/munificent/craftinginterpreters/blob/01e6f5b8f3e5dfa65674c2f9cf4700d73ab41cf8/tool/bin/test.dart#L599

# Stage #1. Scanning: Empty file

(instructions for this are already in the repository)

# Stage #2. Scanning: Parentheses

(instructions for this are already in the repository)

# Stage #3. Scanning: Braces

https://craftinginterpreters.com/scanning.html#recognizing-lexemes

Same as above, add braces into the mix.

# Stage #4. Scanning: Other single-character tokens

https://craftinginterpreters.com/scanning.html#recognizing-lexemes

`,`, `.`, `-`, `+`, `;`, `*`.

`/` is not covered here, it'll be covered in later stages.

# Stage #5. Scanning: Lexical errors

https://craftinginterpreters.com/scanning.html#lexical-errors

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

Tester implementation notes:

- Errors must be printed to stderr. The ordering compared to other statements doesn't matter.
- Test errors **first**, and test stdout tokens after.
- For errors, only test against lines that start with `[line <digit>]`. That way the user can still add other debug statements and not mess with our output. Also compare line-by-line, so that the diffs are easy to parse.
- Test exit code too!

# Stage #6: Scanning: Assignment & equality Operators

https://craftinginterpreters.com/scanning.html#operators

`=`, `==`.

# Stage #7: Scanning: Negation & inequality operators

https://craftinginterpreters.com/scanning.html#operators

`!` && `!=`.

# Stage #8: Scanning: Relational operators

https://craftinginterpreters.com/scanning.html#operators

`<`, `>`, `<=`, `>=`.

# Stage 9: Scanning: Division operator & comments

https://craftinginterpreters.com/scanning.html#longer-lexemes

# Stage #10. Scanning: Whitespace

https://craftinginterpreters.com/scanning.html#longer-lexemes

# Stage #11. Scanning: Multi-line errors

Now that whitespace is implemented, we can test whether line counting actually works for errors.

# Stage #12. Scanning: String literals

https://craftinginterpreters.com/scanning.html#string-literals

`"hello"`

# Stage #13. Scanning: Number literals

https://craftinginterpreters.com/scanning.html#number-literals

`123`, `123.123` etc.

# Stage #14. Scanning: Identifiers

https://craftinginterpreters.com/scanning.html#reserved-words-and-identifiers

`abcd`, `foo`, `bar` etc.

# Stage #15. Scanning: Reserved words

https://craftinginterpreters.com/scanning.html#reserved-words-and-identifiers

`or`, `if` etc.

<!-- # Extension 1: Parsing Expressions

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

## Extension 3: Interpreter -->
