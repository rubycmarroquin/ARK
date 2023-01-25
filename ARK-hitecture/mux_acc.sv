// CSE141L
module mux_acc (   input [7:0]   LUT,
                                 ALU,
                                 Register,
                                 Memory,
                    input [4:0]  Immediate,
                    input [2:0]  Selector,
                    output logic[7:0] y );
// fill in guts
always_comb begin
    case(Selector)					   
    3'b000: y = LUT;	  
    3'b001: y = ALU;
    3'b010: y = Register;
    3'b011: y = Immediate;
    3'b100: y = Memory;
    default: y = 0;
  endcase
end

endmodule