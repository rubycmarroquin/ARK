// Create Date:    15:50:22 10/02/2019 
// Design Name: 
// Module Name:    InstROM 
// Project Name:   CSE141L
// Tool versions: 
// Description: Verilog module -- instruction ROM template	
//	 preprogrammed with instruction values (see case statement)
//
// Revision: 2021.08.08
// instructions are 9 bits wide
// change A from default of 10 if you need <513 or >1024 instructions
import definitions::*;			          // includes package "definitions"
module InstROM #(parameter A=10, W=9) (
  input       [A-1:0] InstAddress,
  output logic[3:0]   Inst,
  output logic[4:0]   Op);

  op_mne op_mnemonic;	
	 
  // declare 2-dimensional array, W bits wide, 2**A words deep
  logic[W-1:0] inst_rom[2**A];
  
  //Determine what W is
  always_comb begin
    Op = inst_rom[InstAddress][4:0];   // Operand 
    Inst = inst_rom[InstAddress][8:5]; // Op code
  end

  initial begin		                     // load from external text file
  	$readmemb("machine_code.txt",inst_rom);
  end 
  
  always_comb
    op_mnemonic = op_mne'(Inst);			  // displays operation name in waveform viewer
endmodule