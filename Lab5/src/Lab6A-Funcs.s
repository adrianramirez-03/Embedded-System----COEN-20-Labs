//Adrian Ramirez
//COEN20 Lab 6
//October 27 2021

        .syntax         unified
        .cpu            cortex-m4
        .text


//void MatrixMultiply(int32_t A[3][3], int32_t B[3][3], int32_t C[3][3]);
MatrixMultiply:
        PUSH            {R4,R5,R6,LR}   //Preserving R4-R6 + LR on stack
        BL              TireDiam        //Calling TireDiam to get diameter 
        
        LDR             R2,=1587500     //Loading divisor value into R2
        LDR             R3,=4987290     //Loading value into R3
        LDR             R4,=3927        //Loading value into R4
        
        MUL             R5,R4,R0        //R5 <-- R4(3927)*R0(lower half)
        MLA             R6,R3,R1,R5     //R6 <-- R3(4987290)*R1(upper half) + R5
        UDIV            R1,R6,R2        //R1 <-- R6/R2  [QUOTIENT]
        MLS             R0,R2,R1,R6     //R0 <-- (R6 - (R1*R6)) [REMAINDER]
        
        POP             {R4,R5,R6,LR}   //Restore R4-R6 and LR
        BX              LR              //Returns R1(Quotient) and R0(Remainder)
        
        .end

