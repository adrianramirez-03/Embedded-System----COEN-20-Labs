//Adrian Ramirez
//COEN20 Lab 6
//Nov 16 2021

        .syntax         unified
        .cpu            cortex-m4
        .text

        .global         ReverseBits
        .align
        .thumb_func

//uint32_t ReverseBits(uint32_t word);
ReverseBits:
        .rept           31              //Loops 31 times
        LSRS.N          R0, R0, 1       //Shifting right, saving carry in N Flag
        ADC             R1, R1, R1      //Add the carry bit in new register
        .endr

        LSRS.N          R0, R0, 1       //Shifts it one more time, saving carry in N flag
        ADC             R0, R1, R1      //Adding the last shifted bit
        BX              LR
        

        .global         ReverseBytes
        .align
        .thumb_func
//uint32_t ReverseBytes(uint32_t word);
ReverseBytes:
        ROR             R0, R0, 8       //ABCD becomes DABC (page 136 in txt book)
        UBFX            R1, R0, 16, 8   //Will copy R0 into R1 8 bits(width). 16 bits the bit number of the least significant bit in the bitfield (pg 152 in txt book)
        BFI             R0, R0, 16, 8   //Will copy R0 into R1, 8 bits (width). 16 bits being least significant bit that is to be copied.
        BFI             R0, R1, 0, 8    //Places A into C

        BX              LR

        .end