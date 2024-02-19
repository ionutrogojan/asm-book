; Variable Declaration

; int
int8    db 69        ; 8-bit value (1 byte)
int16   dw 420       ; 16-bit value (2 bytes)
int32   dd 6969      ; 32-bit value (4 bytes)
int64   dq 420420    ; 64-bit value (8 bytes)

; The differnce between signed and unsigned integer values is all dependant on how they are being accesses and manipulated
; There is no way to explicitly declare whether the value is signed or unsigned

;float
float32 dd 3.14      ; 32-bit value (4 bytes) single-precision floating-point
float64 dq 69.420    ; 64-bit value (8 bytes) double-precision floating-point


section .data
; .data section holds mutable variables known at compile time.
; this variables declared can change their value throughout the life time of the program and remain in memory until the program exits
; the variables declared in .data can be accessed accross the entire program which makes it the responsability of the programer to decide whether the variable is in a global scope or not
section .rodata
; similar to the .data section, .rodata holds variables known at compile time thet are immutable.
; the values declared in .rodata can be accessed accross the entire program, but will not change their values

; string / char*
string  db "Hello World", 0    ; null-terminated string
; strings declared in the .data section are usually initialised as a sequence of chars, most of the time followed by a byte measure that returns the length of the array
; chars within the string can be updated during program execution
; strings declared in the .rodata section and also initialised as a constant sequence of chars that can not be modified during program execution
; attempting to update an immutable char sequence declared in the .rodata section will result in runtime errors and undefined behaviour depending on Operating System and program execution

; array
myArray    dd 1, 2, 3, 4, 5    ; 32-bit values (4 bytes)
; this is an array with an int32 type
; it is initialised with a sequence of values
; in C, this would look somethiong like this
; int myArray[] = { 1, 2, 3, 4, 5 };
; just like any variable declaration, if it is declared in the .data section, it's values can be updates, but if it is declared in the .rodata section, it is a constant array that can not grow, shrink or modify it's values
; arrays can grow and shrink as the program decides as long as the initialised array contains and has permission to access the necessary memory
; adding more values to an array which does not hold enough allocated space can result in runtime errors and undefined behaviour
; modifying values within an array which was declared as a constant sequence of bytes in the .rodata section will also result in runtime errors and undefined behaviour

; another way to declare an array of bytes, without specifying an initial value is to use the times instruction
myLargeArray    times 10    dd 0    ; 32-bit values (4 bytes) x 10
; this instruction tells the assembler to repeate the dd 0 directive 10 times which creates a sequence of 32-bit integers holding a 0 value

; now you may ask "What about an array of strings?"

; an array of strings in assembly is essentially an array where each element is a memory address pointing to a string
string0    db "This is the first string", 0    ; null-terminated string 0
string1    db "This is the second string", 0    ; null-terminated string 1
string2    db "This is the third string", 0    ; null-terminated string 2
myStringArray    dq string0, string1, string2    ; array of pointers to strings
; in 64-bit assembly, pointers are typically 8 bytes long, which is why the array is initialised using dq
; same as before, whether the values of each pointer can be modified or resized depends on allocated space and memory access permissions

; so by this point, you should have a basic understanding of how variable declaration works in assembly