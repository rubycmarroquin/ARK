// Revision Date:    2020.08.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(		   // you will have the same 3 ports
    input        Reset,	   // init/reset, active high
			     Start,    // start next program
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
    );

wire [ 9:0] PgmCtr,        // program counter
			PCTarg;
wire [ 1:0] TargSel;       // which of 4 jump/branch options?
wire [ 8:0] Instruction;   // our 9-bit opcode
wire [ 7:0] ReadA, ReadB;  // reg_file outputs
wire [ 7:0] InA, InB, 	   // ALU operand inputs
            ALU_out;       // ALU result
wire [ 7:0] RegWriteValue, // data in to reg file
            MemWriteValue, // data in to data_memory
	   	    MemReadValue,  // data out from data_memory
			DataInAcc,
			DataOutAcc,
			DataOutReg,
			DataOutMem,
			DataInLUT,
			DataOutLUT;
wire        MemWrite,	   // data_memory write enable
			RegWrEn,	   // reg_file write enable
            Jump;	       // to program counter: jump 
wire [ 2:0]	mux_selector_acc,
			mux_selector_alu,
			mux_selector_lut;
logic[0:0]	write_en_acc;
logic[4:0]  Op;
logic[15:0] CycleCt;	   // standalone; NOT PC!
logic[7:0]  BranchEn;	   // to program counter: branch enable

// Fetch stage = Program Counter + Instruction ROM
  ProgCtr PC1 (                     // this is the program counter module
    .Reset        (Reset   ) ,   // reset to 0
    .Start        (Start   ) ,   // SystemVerilog shorthand for .grape(grape) is just .grape 
    .Clk          (Clk     ) ,   //    here, (Clk) is required in Verilog, optional in SystemVerilog
    .BranchEn     (BranchEn  ) ,   // "where to?" or "how far?" during a jump or branch
	.DataOutAcc   (DataOutAcc) ,
	.LUT		  (DataOutLUT) ,
    .ProgCtr      (PgmCtr  )     // program count = index to instruction memory
    );					  

// Mux
mux_acc Mux_acc (
  .LUT(DataOutLUT),
  .ALU(ALU_out),
  .Register(DataOutReg),
  .Immediate(Op),
  .Memory(DataOutMem),
  .Selector (mux_selector_acc),
  .y(DataInAcc)
);

mux_alu Mux_alu (
  .Op (Op),
  .Register (DataOutReg),
  .Selector (mux_selector_alu),
  .y (InA)
);

mux_lut Mux_lut (
  .DataOutAcc (DataOutAcc),
  .Op (Op),
  .Selector (mux_selector_lut),
  .y (DataInLUT)
);

Acc Acc (
	.Clk(Clk),
	.write_en_acc(write_en_acc),
	.DataIn(DataInAcc),
	.DataOut(DataOutAcc)
);

// Lookup table to handle 10-bit program counter jumps w/ only 2 bits
LUT LUT1(.Addr         (DataInLUT) ,
         .Target       (DataOutLUT)
    );

// instruction memory -- holds the machine code pointed to by program counter
  InstROM #(.W(9)) IR1(
	.InstAddress  (PgmCtr     ) , 
	.Inst	      (Instruction)	,
	.Op			  (Op		  )
	);

// Decode stage = Control Decoder + Reg_file
// Control decoder
  Ctrl Ctrl1 (
	.Instruction  (Instruction) ,  // from instr_ROM
	.RegWrEn      (RegWrEn    )	,  // register file write enable
	.MemWrEn      (MemWrite   ) ,  // data memory write enable
	.BranchEn	  (BranchEn	  ) , 
    .Ack          (Ack        )	,  // "done" flag
	.write_en_acc (write_en_acc),
	.mux_selector_acc(mux_selector_acc),
	.mux_selector_alu(mux_selector_alu),
	.mux_selector_lut(mux_selector_lut)
  );

// reg file
	RegFile #(.W(8),.A(3)) RF1 (			  // D(3) makes this 8 elements deep
 	  .Clk    				  ,
	  .WriteEn   (RegWrEn)    , 
	  .Addr		 (Op)	      ,
	  .DataIn	 (DataOutAcc)  ,
	  .DataOut   (DataOutReg)
	);
/* one pointer, two adjacent read accesses: 
  (sample optional approach)
	.raddrA ({Instruction[5:3],1'b0});
	.raddrB ({Instruction[5:3],1'b1});
*/

// controlled by Ctrl1 -- must be high for load from data_mem; otherwise usually low
    ALU ALU1  (
	  .InputA  (InA),
	  .InputB  (DataOutAcc), 
	  .Inst    (Instruction),
	  .Out     (ALU_out)                    //regWriteValue),
	  );
  
	DataMem DM1(
		.DataAddress  (DataOutReg)  , 
		.WriteEn      (MemWrite)	, 
		.DataIn       (DataOutAcc)	, 
		.DataOut      (DataOutMem)  , 
		.Clk 		  	    	    ,
		.Reset		  (Reset)
	);
	
/* count number of instructions executed
      not part of main design, potentially useful
      This one halts when Ack is high  
*/
always_ff @(posedge Clk)
  if (Reset)	   // if(start)
  	CycleCt <= 0;
  else if(Ack == 0)   // if(!halt)
  	CycleCt <= CycleCt+16'b1;

endmodule