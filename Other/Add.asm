(VERY_START)
@final
M=0
@digit_num
M=0
@key
M=0


(WAIT_KEY)
    @KBD
    D=M
    @key
    M=D            // Read keyboard
    @WAIT_KEY
    D;JEQ          // Wait until a key is pressed (non-zero)

    // Is "enter" pressed?
    @128
    D=D-A
    @NEXT_INPUT
    D;JEQ

    @128
    D=D+A

    @45
    D=D-A
    @SKIP
    D;JNE
    @final
    M=!M
    M=M+1
    @NEXT_INPUT
    0;JMP


    (SKIP)
    @digit_num
    D=M
    @R4
    D=D-A
    @NEXT_INPUT
    D;JGT
    @key
    D=M
    

// Convert ASCII to number by subtracting 48 (ASCII of 0)
    @48
    D=D-A 
    @R10
    M=D            // Store numeric value in R10

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

// input is read from R10 
@R10
D=M
@num
M=D

// if digit_num is 4 then jump to HUN where order is set to 10000
@digit_num
D=M
@R4
D=D-A
@TENTHOU
D;JEQ

// if digit_num is 3 then jump to THOU where order is set to 1000
@digit_num
D=M
@R3
D=D-A
@THOU
D;JEQ

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


// order is set to 10000 and goto MULTIPLY
(TENTHOU)
@10000
D=A
@order
M=D
@MULTIPLY
0;JMP

// order is set to 1000 and goto MULTIPLY
(THOU)
@1000
D=A
@order
M=D
@MULTIPLY
0;JMP

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

// if digit num is =<4 then go get another number
@R5 
D=D-A
@WAIT_KEY
D;JLE




(NEXT_INPUT)
@final
D=M
@VERY_START
D;JEQ
@R2
D=M
@SECOND_IN
D;JNE
@final
D=M
@R2
M=D
@VERY_START
0;JMP

(SECOND_IN)
@final
D=M
@VERY_START
D;JEQ
@R3
M=D



(ADD)
@R2
D=M
@R3
D=D+M
@R0
M=D


(END)
@R4
M=1
@END
0;JMP
