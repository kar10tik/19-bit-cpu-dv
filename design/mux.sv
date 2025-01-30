module param_mux
#(parameter N = 2)
(
   input  logic [3:0] i_data [N-1:0],
   input  logic [2:0] sel, //the select pin is fixed at 3 bits since maximum N will be 8
   output logic [3:0] o_data
);
   assign o_data = i_data[sel];

endmodule