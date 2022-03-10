#!/bin/bash

bison -dv ./simple.y
gcc -c ./simple.tab.c
flex ./simple.lex
gcc -c ./lex.yy.c
gcc -o ../simple ./simple.tab.o ./lex.yy.o -lm -lfl