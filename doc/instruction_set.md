# POOTIS (PLATFORM ORIENTED OPTIMIZED TECHNOLOGY INSTRUCTIONS SET)
POOTIS is an instruction set specific to the walter SOC. 
# TODO How to diff reg or imm
# POOTIS8 (8-bit)
Most basic first generation instruction set.
All numbers are unsigned.
## Instruction format
1. 8 bit opcode
2. 8 bit operand
3. 8 bit operand
4. 8 bit operand
Operand can be register(4 bits to select register type followed by 4 bits for register size(see below)) or immediate value
Operand will be ignored if not needed.
Register contents can be used as pointers.
Immidiate pointers are relative to base pointer.
## Registers
All sizes are ignored for 8 bit.
1. Stack pointer(StackPtr). 0000 0000, Initial value is base pointer.
2. Program counter(ProgPtr). 0001 0000, Initial value is program start.
3. General purpose register 1(Reg1). 0010 0000
4. General purpose register 2(Reg2). 0011 0000
5. General purpose register 3(Reg3). 0100 0000
6. Counter register(Counter). 0101 0000
## Instruction set
1. Move(00000000): Move data from one register to another. MOV RegIn, RegOut
2. Load(00000001): Load data from memory to register. LOAD Addr(Reg), RegOut
3. Store(00000010): Store data from register to memory. STORE RegIn, Addr(Reg)

4. Add(00000011): Add two numbers. ADD In(Reg), RegIn, RegOut
5. Sub(00000100): Subtract two numbers. SUB In(Reg), RegIn, RegOut
6. Mul(00000101): Multiply two numbers. MUL In(Reg), RegIn, RegOut

7. Jump(00000110): Jump to address. JMP Addr(imm)
8. Jump if(00000111): Jump to address if condition is true(Leftmost bit is 1). JMP Addr(imm), Cond(Reg)

9. OR(00001000): Bitwise OR two numbers. OR In(Reg), RegIn, RegOut
10. AND(00001001): Bitwise AND two numbers. AND In(Reg), RegIn, RegOut
11. XOR(00001010): Bitwise XOR two numbers. XOR In(Reg), RegIn, RegOut
12. NOT(00001011): Bitwise NOT a number. NOT RegIn, RegOut

13. Equal(00001100): Check if two numbers are equal and produce either all 1's or all 0's. EQ In(Reg), RegIn, RegOut
14. Greater than(00001101): Check if first number is greater than second number and produce either all 1's or all 0's. GT In(Reg), RegIn, RegOut
15. Less than(00001110): Check if first number is less than second number and produce either all 1's or all 0's. LT In(Reg), RegIn, RegOut

16. Print(00001111): Print a number. PRINT RegIn
17. Print char(00010000): Print a character. PRINTC RegIn

18. Const Pointer(00010001): Get a pointer to a constant. CONSTP RegOut, Const#(imm)

19. No operation(00010010): Do nothing. NOP

## Sections
1. Constants
2. Size 0 constant to mark end of constants
3. Instructions(Start at first instruction)
## Constants
1. Size(Bytes)(8-bit)
2. Data
3. Next constant

# Pootis32 (32-bit)
Second generation instruction set.
All numbers are signed unless specified otherwise.
Padding?

## Instruction format
WIP.
## Registers
WIP.
## Instruction set
WIP.
### IO Extension(GPU & Sound & External devices)
### Fixed point Extension
### Trig Extension
### Floating point Extension
### Vector Extension

## Sections
1. Constants
2. Size 0 constant to mark end of constants
3. Instructions(Start at first instruction)
## Constants
1. Size(Bytes)(32-bit)
2. Data
3. Next constant
