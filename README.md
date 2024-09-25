# Computation of Characteristics of ED-strings

This repository includes some tools for computing characteristics of ED-strings.
Currently available are:

 - Computation of longest common extension (LCE) of all pairs of text-positions in an ED-string in C++
 - Computation of a minimal unique substring (SUS) with ASP (answer set programming) of an indeterminate string
 - Computation of a minimal absent word (MAW) with ASP of an indeterminate string

Requirements are a C++14 compiler and make or python/clingo for ASP.

## LCE Computation

Use `make` to compile the executable for LCE computation.
As input, the program requests the linearized form of an ED-string from standard input.
An example is `b(a|)c(abc|c)(a|b)`.

```sh
echo 'b(a|)c(abc|c)(a|b)' | ./lce.x
```

```output
  b ( a | ) c ( a b c | c ) ( a | b )
b 7 0 0 0 0 0 0 0 3 0 1 0 1 1 0 0 1 0 0
( 0 6 6 5 5 5 2 1 0 2 1 2 1 1 1 0 0 0 0
a 0 6 6 0 0 0 1 1 0 0 1 0 1 1 1 0 0 0 0
| 0 5 0 5 5 5 2 0 0 2 0 2 0 0 0 0 0 0 0
) 0 5 0 5 5 5 2 0 0 2 0 2 0 0 0 0 0 0 0
c 0 5 0 5 5 5 2 0 0 2 0 2 0 0 0 0 0 0 0
( 0 2 1 2 2 2 4 4 0 2 1 2 1 1 1 0 0 0 0
a 0 1 1 0 0 0 4 4 0 0 1 0 1 1 1 0 0 0 0
b 3 0 0 0 0 0 0 0 3 0 1 0 1 1 0 0 1 0 0
c 0 2 0 2 2 2 2 0 0 2 0 2 0 0 0 0 0 0 0
| 1 1 1 0 0 0 1 1 1 0 1 0 1 1 1 0 1 0 0
c 0 2 0 2 2 2 2 0 0 2 0 2 0 0 0 0 0 0 0
) 1 1 1 0 0 0 1 1 1 0 1 0 1 1 1 0 1 0 0
( 1 1 1 0 0 0 1 1 1 0 1 0 1 1 1 0 1 0 0
a 0 1 1 0 0 0 1 1 0 0 1 0 1 1 1 0 0 0 0
| 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
b 1 0 0 0 0 0 0 0 1 0 1 0 1 1 0 0 1 0 0
) 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```



## MAW/MUS Computation

To compute a MAW or MUS, use clingo on the ASP encoding of the specific problem and the encoded input.
An example for an encoded input is at `./sample/input.lp`.

```sh
clingo encoding/mus.lp sample/input.lp
clingo encoding/maw.lp sample/input.lp
```

To create an indeterminate string as input, create a file in the following format:

 - first row: all available characters, which are needed for MAW in case that we can select characters that do not appear in the indeterminate string
 - subsequent $k+1$-st row, $i$-th column: $k$-th character of the list of characters $T[i]$ if it exists, otherwise use the character in the previous row

Example:

```
ACGT
CTAACTG
CTAAGTT
```

Specifies an indeterminate string `CTAA(C|G)T(G|T)`.
See `sample/input.txt` for the input that generates `sample/input.lp`.
Finally, call `./translate.py <INPUT.TXT> <OUTPUT.LP>` to generate the encoded input.


### Advanced Usage

- `clingo --const n=50` will consider only the prefix of 50 characters of the input.
- `clingo --const r=2` will consider only the first two rows/sequences of the input

