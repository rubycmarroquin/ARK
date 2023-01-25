// CSE141L
module mux_alu (    input[4:0]     Op,
                    input[7:0]     Register,
                    input[0:0]     Selector,
                    output logic[7:0]    y );
// fill in guts
always_comb begin
    case(Selector)					   
    1'b0: y = Op;	  
    1'b1: y = Register;
  endcase
end

endmodule