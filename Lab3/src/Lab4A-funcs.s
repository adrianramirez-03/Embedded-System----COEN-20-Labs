//Adrian Ramirez
//COEN20 Lab 4
//October 20 2021

        .syntax         unified
        .cpu            cortex-m4
        .text


        .global         UseLDRB
        .align
        .thumb_func                     //Called before the start of each function

UseLDRB:
        .REPT           512             //Needs to repeat 512 times since we are copying 1 byte at a time
        LDRB            R2,[R1],1       //Read from R1 and load into R2, increment by 1 byte 
        STRB            R2,[R0],1       //Store R2 in R0 and increment by 1 byte
        .ENDR
        BX              LR


        .global         UseLDRH
        .align
        .thumb_func

UseLDRH:
        .REPT           256             //Needs to repeat 256 times since we are copying 2 bytes at a time
        LDRH            R2,[R1],2       //Read from R1 and load into R2, increment by 2 byte 
        STRH            R2,[R0],2       //Store R2 in R0 and increment by 2 byte
        .ENDR
        BX              LR


        .global         UseLDR
        .align
        .thumb_func

UseLDR:
        .REPT           128             //Needs to repeat 128 times since we are copying 4 bytes at a time
        LDR             R2,[R1],4       //Read from R1 and load into R2, increment by 4 byte
        STR             R2,[R0],4       //Store R2 in R0 and increment by 4 byte
        .ENDR
        BX              LR


        .global         UseLDRD
        .align
        .thumb_func

UseLDRD:
        .REPT           64              //Needs to repeat 64 times since we are copying 8 bytes at a time
        LDRD            R2,R3,[R1],8    //Read from R1 and load into R2 and R3, increment by 8 bytes
        STRD            R2,R3,[R0],8    //Store from R2 and R3 in R0 and increment by 8 bytes
        .ENDR
        BX              LR


        .global         UseLDM
        .align
        .thumb_func

UseLDM:
        PUSH            {R4-R9}         //Preserve registers R4-R9
        .REPT           16              //Repeat 16 times since we are copying 32 bytes at a time
        LDMIA           R1!,{R2-R9}     //Loads content from R1 to R2-R9
        STMIA           R0!,{R2-R9}     //Stores content from R2-R9 into R0
        .ENDR
        POP             {R4-R9}         //Restore registers R4-R9
        BX              LR

        .end
