# Simple

Simple is a language proposed by Anthony A. Aaby in his book "Compiler Construction using Flex and Bison", as well as in Dan Popa's Romanian translation called "Construcția compilatoarelor folosind Flex și Bison" (the English version can be found [here](http://foja.dcs.fmph.uniba.sk/kompilatory/docs/compiler.pdf) and the Romanian version [here](https://www.researchgate.net/profile/Popa-Dan/publication/340581158_Constructia_compilatoarelor_folosind_Flex_si_Bison_revizuita_in_limba_romana_cu_acordul_autorului_initial/links/5e9205a292851c2f5297158d/Constructia-compilatoarelor-folosind-Flex-si-Bison-revizuita-in-limba-romana-cu-acordul-autorului-initial.pdf)).

# EBNF grammar

```
program ::= LET [ declarations ] IN command_seq END

declarations ::= INTEGER [ id_seq ] IDENTIFIER .

id_seq ::= id_seq... IDENTIFIER ,

command_seq ::= command... command

command ::= SKIP ;
| IDENTIFIER := expression ;
| IF expression THEN command_seq ELSE command_seq FI ;
| WHILE expression DO command_seq END ;
| READ IDENTIFIER ;
| WRITE expression ;

expression ::= NUMBER | IDENTIFIER | ’(’ expression ’)’
| expression + expression | expression − expression
| expression ∗ expression | expression / expression
| expression ˆ expression
| expression = expression
| expression < expression
| expression > expression
```

# Syntax
## General structure of program
The general structure of a Simple program is the following:
```
let
  [list of declarations]
in
  [list of statements]
end
```
where declarations and the statements are optional.

## Keywords and operators
```
+ - * / ^ < > = := do else end fi in integer let read skip then while write
```

Note: `^` represents exponentiation, thus `2 ^ 3 = 8`. `/` represents integer
division (because there's no support for doubles) (so `5 / 2 = 2` and not `2.5`
as expected). In this regard, it's identical to `/` in C/C++ when applied to
integers.

## Expressions, statements and variables
All statements end with a semicolon.

Variable declarations start with the `integer` keyword (the only data type
supported in this language, although only positive numbers are implemented) and
end with a dot. They go between the `let` and `in` keywords. For example:

```
let
  integer x.
in
  ...
end
```

You can also declare multiple variables, such as `integer x, y, z, t.`.

You can assign values to these variables (expressions involving other variables
or constants), using the `:=` operator. For instance:
```
let
  integer x, y.
in
  x := 3;
  y := 4 + x;
end
```

You can read values into variables using the `read` keyword and display the result of an expression or variable using `write`. For example:
```
let
  integer x, y.
in
  read x;
  y := 4 + x;
  write y;
end
```

## Arithmetic operators
```
let
  integer a, b, c1, c2, c3, c4, c5.
in
  a := 6;
  b := 3;
  c1 := a + b;
  c2 := a - b;
  c3 := a * b;
  c4 := a / b;
  c5 := a ^ b;
end
```

## Control flow, loops and comparison operators
The Simple language has two kinds of control flow blocks: the `if-then-else` block and the `while-do` block, as well as the `skip` keyword.

The `if-then-else` block follows this syntax:
```
if condition then
  [statements for true branch]
else
  [statements for false branch]
fi;
```

Note the semicolon at the end of `fi` (if spelled backwards). If one wishes to make a `if-then` block (so an action is taken only when the true branch has been reached), we can use the `skip` keyword as following:
```
if condition then
  [statements for true branch]
else
  skip;
fi;
```

Or, written in a more concise way, since the syntax allows it:
```
if condition then
  [statements for true branch]
else skip; fi;
```

As for the `while-do` loop, the syntax is the following:
```
while condition do
  [statements]
end;
```

We can represent an infinite loop by having `while 1 do ... end;` (similar to
`while (true) {}` from the ALGOL family).

The `skip` keyword is a bit less useful in loops, functionally being like the
`continue` keyword in many other languages (C, C++, Java, C# etc.), mostly used
in `if-then-else` blocks. Example:
```
let
  integer i.
in
  i := 0;
  while i < 30 do
    if (i / 2) * 2 = i then
      write i;
    else
      skip;
    fi;
  end;
end
```

You can also see in action the `<` and `=` comparison operators (of course, there also exists `>`). No other logical or comparison operators are implemented (and, or, not equal, less/greater than or equal etc.).
# Examples
Examples can be found in the ./examples directory in this repo.
## Arithmetic
```
let
in
  skip;
  skip;
  write (10 * 2) ^ 2 + 5 ^ 2 * (20 + 4) - 1 + 50 / 2;
end
```
## Sum of squares
```
let
  integer s1, s2, i, n;
in
  read n;

  s1 := 0;
  s2 := 0;
  i := 0;
  while i < n + 1 do
    s1 := s1 + i ^ 2;
  end;
  s2 := n * (n + 1) * (2*n + 1) / 6;
  write s1;
  write s2;
end
```
## Maximum of three numbers
```
let
  integer a, b, c, max.
in
  read a;
  read b;
  read c;
  if a > b then
    if a > c then
      max := a;
    else
      max := c;
    fi;
  else
    if b > c then
      max := b;
    else
      max := c;
    fi;
  fi;

  write max;
end
```
## Fibonacci
```
let
  integer n, fib, prev, tmp.
in
  n := 0;
  fib := 1;
  prev := 1;
  while n < 46 do
    if n < 2 then
      n := n + 1;
      write n;
    else
      tmp := fib;
      fib := fib + prev;
      prev := tmp;
    fi;
  write fib;
  n := n + 1;
  end;
end
```
