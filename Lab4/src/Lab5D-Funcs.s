//Adrian Ramirez
//COEN20 Lab 5
//October 27 2021

        .syntax         unified
        .cpu            cortex-m4
        .text


        .global         TireDiam
        .align
        .thumb_func                     //Called before the start of each function

//uint64_t TireDiam(uint32_t W, uint32_t A, uint32_t R);
TireDiam:
        PUSH            {R4, LR}        //Preserve R4 and LR on stack
        
        LDR             R3,=1270        //Loading 1270 into R3
        MUL             R4,R0,R1        //R4 <-- (A*W)
        UDIV            R0,R4,R3        //R0 <-- (R4/R3)
        ADDS            R1,R0,R2        //R1 <-- R0+R2
        MLS             R0,R3,R0,R4     //R0 <-- (R4 - (R0*R3))
        
        POP             {R4, LR}        //Restore R4 and LR
        BX              LR              //Returns R1(Quotient) and R0(Remainder)


        .global         TireCirc
        .align
        .thumb_func

//uint64_t TireCirc(uint32_t W, uint32_t A, uint32_t R);
TireCirc:
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
