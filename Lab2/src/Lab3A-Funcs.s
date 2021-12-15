//Adrian Ramirez
//COEN20 Lab 3
//October 13 2021

        .syntax         unified
        .cpu            cortex-m4
        .text


/*
int32_t Add(int32_t a, int32_t b) { return a + b ; } */

        .global         Add
        .align
        .thumb_func                     //Called before the start of each function

Add:
        ADD             R0,R0,R1        //Adding a + b and loads it into register 0
        BX              LR              //returns function 


/* int32_t Less1(int32_t a) { return a - 1 ; } */

        .global         Less1
        .align
        .thumb_func

Less1:
        SUB             R0,R0,1         //Returns a - a and loads it into register 0
        BX              LR              //returns function


/*
int32_t Square2x(int32_t x) { return Square(x + x); } */

        .global         Square2x
        .align
        .thumb_func
        

Square2x:
        ADD             R0,R0,R0      //Returns x plus x and loads it into register 0
        B               Square        //returns the value that is returned from the function Square
        
    
/*
int32_t Last(int32_t x) { return x + SquareRoot(x); } */

        .global         Last
        .align
        .thumb_func

Last:
        PUSH            {R4,LR}     //Stores Register 4 and LR in the stack
        MOV             R4,R0       //Loads Register 4 with the contents of Register 0 (x)
        BL              SquareRoot  //Calls square root with R0 and loads it into R0a
        ADD             R0,R0,R4    //Adds register 0 (the sqaured value of x) and register 4 (the original x value) and loads it into Register 0
        POP             {R4,PC}     //Restores R4 

        .end