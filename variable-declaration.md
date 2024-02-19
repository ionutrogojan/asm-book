# Variable Declaration

The most basic variable types we can declare and use in most programming languages are:

- integers
- floats
- strings

Technically speaking, strings are not a basic variable type. That would be a `char`. Nonetheless, strings are more common than `char`s are, so we will use them as an example.

Here we will have a look at each type and try to understand how variable declaration works in assembly

## Introduction

When a variable is declared by a programmer using their language of choice (compiled languages), it's type, scope and location are very well known within that source code, but what happens with the variable when the source code is compiled is not always certain.

Some variables can be optimised, some might be left out of the program because they are never used during execution. How does the compiler know what to do with each value?

## Sections

The main sections reserved for variable declarations are `.data`, `.rodata`, and `.bss`.

Some assemblers allow programmers to specify custom sections, but for the sake of simplicity, we will use the most common sections available in all assemblers.

These sections hold data who's memory allocation persists for the entirety of the program's execution. Not all sections consist of canstant variables, but all sections declare variables of a specific size which may not be changed.

Lastly, variables declared in these sections can be accessed at any point of the program execution which might make you think they are in a global scope.

Technically yes, but in low level programming, the idea of global scope does not exist. It is at the programmer's or compiler's discretion to use each variable in a "global scope" or not.

Lets start from the back

### .bss (Block Started by Symbol | Storage)

```asm
section .bss
    var resb 4    ; reserve 32-bit value (4 bytes) of uninitialised memory

section .text
global _start

_start:
    mov byte [var], 10    ; store the value 10 in var
```

Variables stored in the `.bss` section are unitialised. Well, they are, but their value is 0.

This acts like declaring an integer that will at some point in the program, update it's value.

The above example ilustrates this perfectly. We declare a varaible which is 4 bytes long or 32 bits and at some point in the instruction list, we update the value of `var` from 0, to 10.

Variables declared in the `.bss` section are mutable and have a life time equal to that of the program. In other words, the memory allocated is no freed until the process exits.

### .rodata (Read Only)

```asm
section .rodata
    number    dq 420    ; constant 64-bit value (8 bytes)
```

Some variables need to hold a constant value throughout the lifetime of the program, which is what the `.rodata` section is used for.

This variables are known at compile time and should not be modified. Modifying a variable declared in this section can result in runtime errors and undefined behaviour.

### .data

```asm
section .data
    point    dq 3.14    ; 64-bit value (8 bytes) double-precision floating-point

section .text
global _start

_start:
    mov dword [point] 3.2    ; update the point with a new value
```

Any variable declared in this section is initialised with a certain value, but it is not constant. `.data` variables are mutable and updates made to their value persist until the program execution finishes.

The above example shows how a 64-bit floating-point is initialised with a certain value and updated with another as necessary.

It must be noted that mutable values should not be assigned values outside of their bounds. Assigning a value which exceeds the available allocated space can result in runtime errors and undefined behaviour.

## Registers

Based on the use of certain values and optimisation level, some values might be assigned directly to a register and used right away, also known as an `immediate value`.

```asm
section .text
global _start

_start:
    mov rax, 10    ; update the rax register with the value 10
```

Immediate values are usually used for:

- a constant value used in aritmethic or logical operations
- specifying offsets or addresses for memory operations
- defining constants or literals within the code

Assigning immediate values should be done to appropriate registers, otherwise the program can encounter runtime errors and undefined behaviours.