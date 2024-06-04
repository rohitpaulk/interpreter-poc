Follows the book https://craftinginterpreters.com/.

# Stage #1. Scanning: Parentheses

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

Same as above, add braces into the mix.

# Stage #3. Scanning: Other single-character tokens

`,`, `.`, `-`, `+`, `;`, `*`, `/`

Note that "//" cannot appear in the test, that would be a comment.

# Stage #4. Scanning: Errors

# Stage 4: Parsing
