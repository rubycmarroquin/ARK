Members
----------------------------------------
Annie Nguyen
Ruby Marroquin
Kent Utomo


Introduction
----------------------------------------
The name of our architecture is called ARK and we want to make an
accumulator microprocessor. We chose the accumulator architecture 
because it is the most intuitive out of all the architectures for 
students to grasp. Our goal is to create a microcontroller that will
pass all three programs by the autograder.


Design
----------------------------------------
Our accumulator uses a 4-bit op code and a 5-bit operand. This means
that we can have at most 32 different registers and look up table 
(LUT) values. For this project, however, we will limit ourselves to 
using no more than 16 general purpose registers.

We have a total of 16 instructions.
    set_immediate 	(0000)
	Sets the accumulator value to the specified immediate (max = #31)


    set_register  	(0001)
	Sets the accumulator value to the value stored in the specified
	register


    set_memory    	(0010)
	Sets the accumulator value to the value stored in the data memory at 
	the specified index
	

    set_LUT 		(0011)
	Reads data from the LUT using the accumulator’s current value as an 
	address and writes it to the accumulator.


    move		(0100)
	Writes the current value of accumulator to the specified register


    store		(0101)
	Writes the current value of accumulator to the data memory at the 
	index given


    jump		(0110)
	Depending on the current value of the accumulator, jumps to the line 
	that correlates to the specified LUT index


    and_register	(0111)
	Computes bitwise AND on the accumulator's value and the value stored 
	in the specified register. The result is written to the accumulator.


    or_register		(1000)
	Computes bitwise OR on the accumulator's value and the value stored 
	in the specified register. The result is written to the accumulator.


    xor_register	(1001)
	Computes bitwise XOR on the accumulator's value and the value stored 
	in the specified register. The result is written to the accumulator.


    right_shift		(1010)
	Shifts the binary of the value in the accumulator to the right by 1


    left_shift		(1011)
	Shifts the binary of the value in the accumulator to the left by 1


    reduced_xor		(1100)
	Computes reduced XOR on the accumulator's value. The result is written 
	to the accumulator.


    add_immediate	(1101)
	Computes addition between the accumulator's value and the immediate 
	specified. The result is written to the accumulator.


    not_equal_register	(1110)
	Compares the accumulator's value and the value stored in the specified 
	register to see if they are equal. The result is written to the accumulator


    done  		(1111)
	Done flag

Absolute branching is supported via the use of the jump instruction and the 
LUT. The values in the LUT were hardcoded in advance. The instruction will
receive an LUT index as its operand and will use the LUT to see which line it will
actually jump to.


Testing
----------------------------------------
To test our ARK-hitecture, simply open up machine_code1.txt, machine_code2.txt, or
machine_code3.txt and copy the contents of the file into machine_code.txt. Then load 
up ModelSim and run the corresponding testbench. You can change the LFSR_init, pt_no,
and string in the testbenches in order to test different cases. 

Make sure to restart in between runs. The testbench should output a file with the 
results, which includes a score of how much is correct out of 64.
