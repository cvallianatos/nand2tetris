// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Find which number is larger and use the smaller as a counter

@0
D=M
@1
D=D-M
@PATH2
D;JGE

(PATH1)     // R0 < R1
    @2
    M=0     // R2 = 0
    @i
    M=0     // i=0
(LOOP1)
    @i
    D=M     // D=i
    @0
    D=D-M   // D=i-R0
    @END
    D;JGE    // if i-R0 >= 0 goto END

    @1
    D=M     // D=R1
    @2
    M=D+M   // R2=R2+R1
    @i
    M=M+1   // i=i+1
    @LOOP1
    0;JMP   // Repeat

(PATH2)     // R0 > R1
    @2
    M=0     // R2 = 0
    @i
    M=0     // i=0
(LOOP2)
    @i
    D=M     // D=i
    @1
    D=D-M   // D=i-R1
    @END
    D;JGE    // if i-R1 >= 0 goto END

    @0
    D=M     // D=R0
    @2
    M=D+M   // R2=R2+R0
    @i
    M=M+1   // i=i+1
    @LOOP2
    0;JMP   // Repeat

(END)
    @END
    0;JMP