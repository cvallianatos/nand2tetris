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

(SCAN)
	@KBD
	D=M
	@SCAN
   	D;JEQ // if i = 0 goto SCAN

@10
M=D

(DO_SCREEN)
	@SCREEN
	D=A
	@addr
	M=D      // addr = 16384, base address

	@8190	 // Set RAM[0] to a starting value = 17000
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
   		@SCAN
   		D;JGT // if i > n goto SCAN

		@10
		D=M
		@WHITE
   		D;JEQ  // goto WHITE

   		(BLACK)
		@addr
   		A=M
   		M=-1   // RAM[addr]=1111111111111111
		@OTHER
   		0;JMP  // goto OTHER

		(WHITE)
		@addr
   		A=M
   		M=0   // RAM[addr]=0000000000000000

		(OTHER)
   		@i
   		M=M+1  // i = i + 1
   		@addr
   		M=M+1  // addr = addr + 1
   		@LOOP
   		0;JMP  // goto LOOP


