module LFSR_lut(
  input       [3:0] address,
  output logic[7:0] LFSR_taps
  );

// assumes test bench provides only 0 through 8 in data_mem[62]  
always_comb case(address)
  0: LFSR_taps = 8'h60;	
  1: LFSR_taps = 8'h48;
  2: LFSR_taps = 8'h78;
  3: LFSR_taps = 8'h72;
  4: LFSR_taps = 8'h6A;
  5: LFSR_taps = 8'h69;
  6: LFSR_taps = 8'h5C;
  7: LFSR_taps = 8'h7E;
  8: LFSR_taps = 8'h7B;
// error conditon -- should never occur, needed for completeness of always_comb
  default: LFSR_taps = 8'h0;   // or 8'hx, if you like
endcase
  
endmodule 