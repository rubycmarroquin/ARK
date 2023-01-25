// Create Date:    2018.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2021.07.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			          // includes package "definitions"
module ALU #(parameter W=8, Ops=4)(
  input        [W-1:0]   InputA,          // data inputs
                         InputB,
  input        [Ops-1:0] Inst,		        // ALU opcode, part of microcode
  output logic [W-1:0]   Out  	          // data output 
// you may provide additional status flags, if desired
  );								    
	 
  op_mne op_mnemonic;			          // type enum: used for convenient waveform viewing


  always_comb begin
    Out = 0;                              // No Op = default
    case(Inst)
    add_immediate: Out = InputA + InputB;  
    reduced_xor: Out = ^(InputB);
    left_shift: Out = InputB << 1;
    right_shift: Out = InputB >> 1;
    xor_register: Out = InputA ^ InputB;
    or_register: Out = InputA | InputB;
    and_register: Out = InputA & InputB;
    not_equal_register: Out = InputA != InputB;
    endcase
  end

//always_ff(@posedge clk)
/*If (not_equal_register)
Zero = inputA != inputB
Output logic zeroFlag
*/
  always_comb
    op_mnemonic = op_mne'(Inst);			  // displays operation name in waveform viewer

endmodule