// Create Date:    2019.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-width, any-depth reg_file: just override the params!
*/
module RegFile #(parameter W=8, A=3)(		 // W = data path width (leave at 8); A = address pointer width
  input                Clk,
                       WriteEn,
  input         [3:0]  Addr,
  input         [7:0]  DataIn,
  output logic  [7:0]  DataOut
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] Registers[2**4];	               // or just registers[16] if we know D=4 always

// combinational reads 
/* can write always_comb in place of assign
    difference: assign is limited to one line of code, so
	always_comb is much more versatile     
*/
assign DataOut = Registers[Addr];

// sequential (clocked) writes 
always_ff @ (posedge Clk)
  if (WriteEn) begin
    Registers[Addr] <= DataIn;
  end
endmodule
