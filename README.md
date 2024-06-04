Follows the book https://craftinginterpreters.com/.

# Stage #1. Scanning: Parentheses

https://craftinginterpreters.com/scanning.html#recognizing-lexemes

`(` and `)`

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
```

Notes:

- The `null` is just a placeholder for the "literal" value, which we'll use later when dealing with strings.

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

# Stage #5. Scanning: Multi-character errors

```
,.$()#
```

Expected output:

```
COMMA , null
DOT . null
ERROR line 1: Unexpected character $.
```

# Stage #6: Scanning: Errors across multiple lines

# Stage 4: Parsing
