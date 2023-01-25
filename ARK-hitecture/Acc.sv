// Create Date:    2019.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-width, any-depth reg_file: just override the params!
*/
module Acc #(parameter W=8)(        		 // W = data path width (leave at 8); A = address pointer width
  input                Clk,
                       write_en_acc,
  input        [W-1:0] DataIn,
  output       [W-1:0] DataOut			 // showing two different ways to handle DataOutX, for
);

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] Register;	                 // or just registers[16] if we know D=4 always

// combinational reads 
/* can write always_comb in place of assign
    difference: assign is limited to one line of code, so
	always_comb is much more versatile     
*/
// assign is combinational logic

// BUT! We're not allowed to use a wire inside a always_ff

// sequential (clocked) writes 
always_ff @ (posedge Clk)
  if (write_en_acc)	begin       // works just like data_memory writes
    Register <= DataIn;
    //$display("\tDataInAcc:\t   %b", DataIn);
  end                    

assign  DataOut = Register;	     // This is problematic b/c assuming Register as register type OR wire type         
endmodule
