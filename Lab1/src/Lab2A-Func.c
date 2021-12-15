//COEN 20L
//Adrian Ramirez Lopez
//10/6/2021
//
//Directions: Use your favorite text editor (not a word processor) to create a second C 
//source code file in the src subdirec- tory that implements the three functions shown below.


#include <stdio.h>
#include <math.h>
#include <stdint.h>

int32_t  Bits2Signed(int8_t bits[8]) { //Convert array of bits to signed int
    uint32_t val = 0;
    
    if(bits[7] == 1) { //checks if most significant bit is 1, if so, we know it's a negative integer
        val = -1;
    }

    for(int i = 6; i >= 0; i--) {
        val = ((2 * val) + bits[i]); //Showed work on ipad to make sure this works by doing a test case with 10000001
    }
    return val;
}


uint32_t Bits2Unsigned(int8_t bits[8]) { //Convert array of bits to unsigned int
    uint32_t val = 0;                     //Range will be between -128 and +127

    for(int i = 7; i >= 0; i--) {
        val = ((2 * val) + bits[i]);
    }
    return val;
}

void Increment(int8_t bits[8]) { //Add 1 to value represented by bit pattern
    int i;
    for(i = 0; i < 8; i++) { //Iterates through the entire binary number
        if(bits[i] == 0) { //If the value is equal to 0, it will change it to 1
            bits[i] = 1;
            break;
        }
        bits[i] = 0; //We know if the value isn't 0, it's a 1, so we must change it to 0
    }
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]) { //Opposite of Bits2Unsigned.
    int i = 0;

    while(n!=0) { //Will fill in bits starting from index 0
        bits[i] = n%2;
        n = n/2;
        i++;
    }

    for(int j = i; j < 8; j++) { //When n reaches 0, it will fill in with 0s
        bits[j] = 0;
    }

}
