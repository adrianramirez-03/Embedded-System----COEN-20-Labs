//Adrian Ramirez
//COEN20 Lab 7
//November 16 2021

        .syntax         unified
        .cpu            cortex-m4
        .text

        .global Zeller1
        .align
        .thumb_func

//uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C))
Zeller1:
        ADD             R0, R0, R2              //R0 <-- k + D
        ADD             R0, R0, R2, LSR 2       //R0 <-- k + D + D/4
        ADD             R0, R0, R3, LSR 2       //R0 <-- k + D + D/4 + C/4
        SUB             R0, R0, R3, LSL 1       //R0 <-- k + D + D/4 + C/4 - 2C

        LDR             R2, =13                 //R2 <-- 13
        MUL             R1, R1, R2              //R1 <-- m x 13
        SUB             R1, R1, 1               //R1 <-- m*13 -1

        LDR             R2, =5                  //R2 <-- 5
        UDIV            R1, R1, R2              //R1 <-- (m*13 - 1)/5
        ADD             R0, R0, R1              //R0 <-- k + D + D/4 + C/4 - 2C + R1(or 13*m -1)/7)

        LDR             R2, =7                  //R2 <-- 7
        SDIV            R1, R0, R2              //R1 <-- R0/R2
        MLS             R0, R1, R2, R0          ////remainder = dividend - (quotient*divisor)

        CMP             R0, 0                   //If R0 <= 0.... add 7
        IT              LT
        ADDLT           R0, R0, 7               
       
        BX              LR


        .global         Zeller2
        .align
        .thumb_func

//uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C))
Zeller2:
        ADD             R0, R0, R2              //R0 <-- k + D
        ADD             R0, R0, R2, LSR 2       //R0 <-- k + D + D/4
        ADD             R0, R0, R3, LSR 2       //R0 <-- k + D + D/4 + C/4
        SUB             R0, R0, R3, LSL 1       //R0 <-- k + D + D/4 + C/4 - 2C             

        ADD             R2, R1, R1, LSL 4       //R2 <-- 16x
        SUB             R1, R2, R1, LSL 2       //R1 <-- 16x - 4x = 13xm
        SUB             R1, R1, 1               //R1 <-- 13xm - 1             

        LDR             R2, =5                  //R2 <-- 5
        UDIV            R1, R1, R2              //dividing (13xm -1) by 5
        ADD             R0, R0, R1              //R0 <-- k + D + D/4 + C/4 - 2C + R1
       
        LDR             R2, =7                  //R2 <-- 7
        SDIV            R1, R0, R2              //R1 <-- R0/R2

        RSB             R1, R1, R1, LSL 3       //7x (divisor * quotient)
        SUB             R0, R0, R1              //Remainder = dividend - (divisor * quotient)
        
        CMP             R2, 0                   //add 7 if remainder is <= 0
        IT              LT
        ADDLT           R2, R2, 7

        BX              LR


        .global Zeller3
        .align
        .thumb_func

//uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C))
Zeller3:
        ADD             R0, R0, R2              //R0 <-- k + D
        ADD             R0, R0, R2, LSR 2       //R0 <-- k + D + D/4
        ADD             R0, R0, R3, LSR 2       //R0 <-- k + D + D/4 + C/4
        SUB             R0, R0, R3, LSL 1       //R0 <-- k + D + D/4 + C/4 - 2C

        ADD             R2, R1, R1, LSL 4       //R2 <-- 16x
        SUB             R1, R2, R1, LSL 2       //R1 <-- 16x - 4x = 13xm
        SUB             R1, R1, 1               //R1 <-- 13xm - 1

        LDR             R2, =3435973837         //using website reference for unsigned divisor of 5 we get 3435973837
        UMULL           R3, R2, R2, R1          //unsigned multiply 32 bit into 64 bit product. R1 = dividend, R2 = divisor, R3.R2 is where product is stored
        LSR             R1, R2, 2               //using website reference

        ADD             R0, R0, R1              //R0 <-- k + D + D/4 + C/4 - 2C + R1

        LDR             R2, =2454267027         //using website reference for signed divisor of 7 we get 2454267027
        SMMLA           R2, R2, R0, R0          //Signed Most significant word Multiply with Accumulation. Using website reference to find quotient and remainder
        LSR             R3, R0, 31              //R3 <-- R0 >> 31
        ADD             R1, R3, R2, ASR 2       //using website reference but plugged in my own registers

        RSB             R1, R1, R1, LSL 3       //7x (divisor * quotient)
        SUB             R0, R0, R1              //Remainder = dividend - (divisor * quotient)

        CMP             R0, 0                   //Check if R0 <= 0, if <= 0 add 7
        IT              LT
        ADDLT           R0, R0, 7               //add 7 to remainder

        BX              LR

        .end