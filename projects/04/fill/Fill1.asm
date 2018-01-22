// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@SCREEN
D=A
@addr
M=D      // addr = 16384, base address

@256	 // Set RAM[0] to a starting value = 32
D=A

@0
M=D

@0
D=M
@n
M=D      // n = RAM[0]

@i
M=0      // i = 0

(LOOP)
   @i
   D=M
   @n
   D=D-M
   @END
   D;JGT // if i > n goto END

   @addr
   A=M
   M=-1   // RAM[addr]=1111111111111111

   @i
   M=M+1  // i = i + 1
   @32
   D=A
   @addr
   M=D+M  // addr = addr + 32
   @LOOP
   0;JMP  // goto LOOP
   
(END)
   @END   // end
   0;JMP  // infinite loop

