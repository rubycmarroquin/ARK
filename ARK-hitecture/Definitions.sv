//This file defines the parameters used in the alu
// CSE141L
//    Rev. 2020.5.27
// import package into each module that needs it
//   packages very useful for declaring global variables
package definitions;

// enum names will appear in timing diagram
    typedef enum logic[3:0] {
    set_immediate,      // done 0           0000
    set_register,       // done 1           0001
    set_memory,         // done 2           0010
    set_LUT,            // done 3           0011
    move,               // done 4           0100
    store,              // done 5           0101
    jump,               // done 6           0110
    and_register,       // done 7           0111
    or_register,        // done 8           1000
    xor_register,       // done 9           1001
    right_shift,        // done 10          1010
    left_shift,         // done 11          1011
    reduced_xor,        // done 12          1100
    add_immediate,      // done 13          1101
    not_equal_register, // done 14          1110
    done                // done 15          1111

        } op_mne;
endpackage // definitions