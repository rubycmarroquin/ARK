/* CSE141L
   possible lookup table for PC target
   leverage a few-bit pointer to a wider number
   Lookup table acts like a function: here Target = f(Addr);
 in general, Output = f(Input); lots of potential applications 
*/
module LUT(
  input       [ 4:0] Addr,
  output logic[ 7:0] Target
  );

always_comb begin
  Target = 8'h001;	   // default to 1 (or PC+1 for relative) jump LUT[0]
  case(Addr)		   
    5'b00000:  Target = 8'h60; 
    5'b00001:	 Target = 8'h48;
    5'b00010:	 Target = 8'h78;
    5'b00011:	 Target = 8'h72;
    5'b00100:	 Target = 8'h6A;
    5'b00101:	 Target = 8'h69;
    5'b00110:	 Target = 8'h5C;
    5'b00111:	 Target = 8'h7E;
    5'b01000:	 Target = 8'h7B;
    5'b01001:	 Target = 8'h1C;
    5'b01010:	 Target = 8'h41;
    5'b01011:	 Target = 8'h49;
    5'b01100:	 Target = 8'h16;
    5'b01101:	 Target = 8'h33;
    5'b01110:	 Target = 8'hE;
    5'b01111:	 Target = 8'h4;
  endcase
end

endmodule