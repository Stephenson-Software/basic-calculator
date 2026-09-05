# basic-calculator

Really simple, limited calculator. Two numbers are read, one of four operations is chosen, and
the result is printed.

## Requirements

**Python 2.** The program uses `raw_input` and `print` statements, so it is rejected at parse time
by Python 3 and does not run there at all. It has been verified under Python 2.7.18.

Which interpreter this project should target going forward is an open question — see
[issue #1](https://github.com/Stephenson-Software/basic-calculator/issues/1).

## Run

```
python calculator.py
```

Four things are read from standard input, in this order: the first number, the second number, the
operation, and a final line that dismisses the exit prompt.

All four are required, including the last. An unattended run that supplies fewer than four lines
waits at whichever prompt it reached for as long as standard input stays open, and raises
`EOFError` once it closes — so omitting only the fourth line still prints the answer first and
fails afterwards. Wrapping such a run in `timeout` is advisable.

## Operations

The operation is matched case-insensitively against exactly these four words, spelled as the
prompt spells them:

| Type | Result |
|------|--------|
| `Add` | the two numbers added |
| `Subract` | the second number subtracted from the first |
| `Multiply` | the two numbers multiplied |
| `Divide` | the first number divided by the second, followed by the remainder |

Note the spelling of `Subract` — the correctly-spelled `subtract` is **not** accepted and falls
through to `That wasn't an option.`. This is tracked in
[issue #7](https://github.com/Stephenson-Software/basic-calculator/issues/7).

Anything else prints `That wasn't an option.` and exits. Surrounding whitespace is not stripped,
so a stray leading or trailing space is also rejected.

A second number of `0` combined with `Divide` prints `The second number can't be zero.` instead of
dividing. Every other combination of the four operations and two numbers is computed.

## Example

Transcript of a real run under Python 2.7.18. Input was piped rather than typed, which is why the
three prompts appear on one line with no echoed answers:

```
$ printf '6\n3\nadd\n\n' | python calculator.py
What is the first number? What is the second number? Add, Subract, Multiply or Divide? The answer is  9.0

Press Enter to exit.
```

The `Divide` branch additionally reports the remainder:

```
$ printf '7\n2\ndivide\n\n' | python calculator.py
What is the first number? What is the second number? Add, Subract, Multiply or Divide? The answer is  3.5  with  1.0  left over.

Press Enter to exit.
```

## Known limitations

All of the following were reproduced under Python 2.7.18 and are tracked as issues:

- Non-numeric text at either number prompt raises `ValueError` and exits, with no chance to retry
  ([#6](https://github.com/Stephenson-Software/basic-calculator/issues/6)).
- Both operands are floats, so `Divide` reports a true-division quotient *and* a float remainder —
  the same leftover twice ([#8](https://github.com/Stephenson-Software/basic-calculator/issues/8)).

## License

Stephenson Software Non-Commercial License. See [LICENSE](LICENSE).
