// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[3:0] Instruction,	   // machine code
  output logic RegWrEn  ,	   // write to reg_file (common)
			         MemWrEn  ,	   // write to mem (store only)
			         Ack		  ,    // "done w/ program"
               BranchEn ,
               write_en_acc,  // Write to write_en_acc
  output logic[2:0] mux_selector_acc, mux_selector_alu, mux_selector_lut
  );

  always_comb begin
    mux_selector_acc = 0;
    mux_selector_alu = 0;
    mux_selector_lut = 0;
    write_en_acc = 0;
    MemWrEn = 0;
    RegWrEn = 0;
    BranchEn = 0;
    Ack = 0;

    case (Instruction)
      set_immediate: begin
        $display("Displaying set_immediate");
        mux_selector_acc = 3'b011;
        write_en_acc = 1;
      end
      set_register: begin
        $display("Displaying set_register");
        mux_selector_acc = 3'b010;
        write_en_acc = 1;
      end
      set_memory: begin
        $display("Displaying set_memory");
        mux_selector_acc = 3'b100;
        write_en_acc = 1;
      end
      set_LUT: begin
        $display("Displaying set_LUT");
        mux_selector_lut = 0;
        mux_selector_acc = 0;
        write_en_acc = 1;
      end
      move: begin
        $display("Displaying move");
        RegWrEn = 1;
      end
      store: begin
        $display("Displaying store");
        MemWrEn = 1;
      end
      jump: begin
        $display("Displaying jump");
        BranchEn = 1;
        mux_selector_lut = 1;
      end
      and_register: begin
        $display("Displaying and_register");
        mux_selector_alu = 1;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      or_register: begin
        $display("Displaying or_register");
        mux_selector_alu = 1;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      xor_register: begin
        $display("Displaying xor_register");
        mux_selector_alu = 1;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      right_shift: begin
        $display("Displaying left_shift");
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      left_shift: begin
        $display("Displaying left_shift");
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      reduced_xor: begin
        $display("Displaying reduced_xor");
        mux_selector_alu = 1;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      add_immediate: begin
        $display("Displaying add_immediate");
        mux_selector_alu = 0;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      not_equal_register: begin
        $display("Displaying not_equal_register");
        mux_selector_alu = 1;
        mux_selector_acc = 1;
        write_en_acc = 1;
      end
      done: begin
        $display("Displaying done");
        Ack = 1;
      end
    endcase
  end
endmodule