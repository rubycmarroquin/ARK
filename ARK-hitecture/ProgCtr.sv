// Design Name:    basic_proc
// Module Name:    InstFetch 
// Project Name:   CSE141L
// Description:    instruction fetch (pgm ctr) for processor
//
// Revision:  2021.01.27
//
module ProgCtr #(parameter L=10) (	   // value of L should = A in InstROM
  input              Reset,			   // reset, init, etc. -- force PC to 0 
                     Start, 
                     Clk,			   // PC can change on pos. edges only
  input        [L-3:0] BranchEn,	   // jump ... "how high?"
					             DataOutAcc,
					             LUT,
  output logic [L-1:0] ProgCtr         // the program counter register itself
  );
	 
// program counter can clear to 0, increment, or jump
  always_ff @(posedge Clk) begin              // or just always; always_ff is a linting construct
    //$display("ProgCtr: %d", ProgCtr);
    if(Reset)
      ProgCtr <= 0;                       // for first program; want different value for 2nd or 3rd
    else if (BranchEn == 1 & DataOutAcc == 1)
      ProgCtr <= LUT;
    else if(!Start)
      ProgCtr <= ProgCtr+'b1;            // default increment (no need for ARM/MIPS +4 -- why?)
  end
endmodule

