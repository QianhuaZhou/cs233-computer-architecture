/**
 * @file
 * Contains an implementation of the extractMessage function.
 */
#include <iostream> // might be useful for debugging
#include <assert.h>
#include "extractMessage.h"

using namespace std;

unsigned char *extractMessage(const unsigned char *message_in, int length) {
    // length must be a multiple of 8
    assert((length % 8) == 0);

    // allocate an array for the output
    unsigned char *message_out = new unsigned char[length];
    for (int i = 0; i < length; i++) {
        message_out[i] = 0;
    }

    // TODO: write your code here
    unsigned int num_bytes = length / 8;

    // Extract bits from the encoded message
    for (unsigned int i = 0; i < num_bytes; ++i) { // Iterate over the number of output bytes
        for (unsigned int j = 0; j < 8; ++j) { // Iterate over each bit in the byte
            for(unsigned int k = 0; k < 8; ++k){
                unsigned char bit = (message_in[8*i + j] & (1 << (7 - k))) >> (7 - k);
                message_out[8*i + 7 - k] |= bit << j;
            }
        }
    }

    return message_out;
}