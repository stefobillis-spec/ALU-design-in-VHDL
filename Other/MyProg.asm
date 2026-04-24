// File: MyProg.asm
// Authors: Stefo Billis
// Purpose: Based on user keyboard input (maximum of 255), this program will find the factorial 
// of this value. First the program records user input one digit at a time and stores it in
// "final". When either the user presses "enter", or when "final" is tripple digits, the program
// executes the portion where the factorial is calculated. Finally, the calculated factorial
// is stored in "output" and R1 so it is easy to see.
// Note: Input needs to be typed starting with the single number, then the tens number, and then
// the hundreds number, so "135" would be typed "5", "3", "1".


@final
M=0
@digit_num
M=0


(WAIT_KEY)
    @KBD
    D=M            // Read keyboard
    @WAIT_KEY
    D;JEQ          // Wait until a key is pressed (non-zero)

    // Is "enter" pressed?
    @128
    D=D-A
    @FACTORIAL
    D;JEQ

    @128
    D=D+A

// Convert ASCII to number by subtracting 48 (ASCII of 0)
    @48
    D=D-A 
    @R0
    M=D            // Store numeric value in R0

// Wait for key release before reading again
(WAIT_RELEASE)
    @KBD
    D=M
    @WAIT_RELEASE
    D;JNE



(GET_NUM)
// order and the ten is reset to 0 and 10 respectively everytime
@order
M=0
@R10
D=A
@ten
M=D
@val
M=0

// input is read from R0 
@R0
D=M
@num
M=D

// if digit_num is 2 then jump to HUN where order is set to 100
@digit_num
D=M
@R2
D=D-A
@HUN
D;JEQ

// if digit_num is 1 then jump to TEN where order is set to 10
@digit_num
D=M
D=D-1
@TEN
D;JEQ

// if digit num is 0 then jump to ONE where order is set to 1
@digit_num
D=M
@ONE
D;JEQ

// order is set to 100 and goto MULTIPLY
(HUN)
@100
D=A
@order
M=D
@MULTIPLY
0;JMP

// order is set to 10 and goto MULTIPLY
(TEN)
@R10
D=A
@order
M=D
@MULTIPLY
0;JMP

// order is set to 1 
(ONE)
@order
M=1


// Multiplies the num by the order and stores the value in "val"
(MULTIPLY)
@num
D=M
@val
M=D+M
@order
M=M-1
D=M
@MULTIPLY
D;JGT

// Add the num to the final number and increment digit_num
@val
D=M
@final
M=D+M
@digit_num
M=M+1
D=M

// if digit num is =<2 then go get another number
@R2
D=D-A
@WAIT_KEY
D;JLE



// finds the factorial, based on in class example, of the value stored in "final".
// The final factorial is stored in "output" and R1.
(FACTORIAL)
@i
M=1 
@output
M=0 

(LOOP)
@i
D=M 
@final
D=D-M 
@STOP
D;JGT 
@output
D=M
@i
D=D+M 
@output
M=D 

@i
D=M
M=D+1
@LOOP
0;JMP


(STOP)
@output
D=M
@R1
M=D



(END)
@R4
M=1
@END
0;JMP