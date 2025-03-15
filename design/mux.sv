module multiplexer #(parameter N = 2)
(
   input  logic [3:0] input [N-1:0],
   input  logic [2:0] select_line, //the select pin is fixed at 3 bits since maximum N will be 8
   output logic [3:0] output
);
   assign output = input[select_line];

endmodule