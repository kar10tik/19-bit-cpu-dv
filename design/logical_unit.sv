`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 20:31:03
// Design Name: 
// Module Name: logical_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module logical_unit(input opcode, operand_1, operand_2, output out
    );
    parameter WORD_SIZE = 19;

    function AND_function(input [WORD_SIZE-1:0] in1, in2);
        return in1 & in2;
    endfunction


    function OR_function(input [WORD_SIZE-1:0] in1, in2);
        return in1 | in2;
    endfunction


    function XOR_function(input [WORD_SIZE-1:0] in1, in2);
        return in1 ^ in2;
    endfunction


    function NOT_function(input [WORD_SIZE-1:0] in1, in2);
        return ~in1;
    endfunction

endmodule
