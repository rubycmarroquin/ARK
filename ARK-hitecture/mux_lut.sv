// CSE141L
module mux_lut (    input[4:0]     DataOutAcc,
                                   Op,
                    input[0:0]     Selector,
                    output logic[7:0]    y );
// fill in guts
always_comb begin
    case(Selector)					   
    1'b0: y = DataOutAcc;	  
    1'b1: y = Op;
  endcase
end

endmodule