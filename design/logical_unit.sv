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


module logical_unit (
    input logic [OPCODE_SIZE-1:0] opcode, // 5-bit opcode
    input logic [WORD_SIZE-1:0] operand_1, operand_2, // 19-bit operands
    output logic [WORD_SIZE-1:0] out // 19-bit result
);
    import constants::*;
    import opcodes::*;

    // Function for AND operation
    function logic [WORD_SIZE-1:0] AND_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 & in2;
    endfunction

    // Function for OR operation
    function logic [WORD_SIZE-1:0] OR_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 | in2;
    endfunction

    // Function for XOR operation
    function logic [WORD_SIZE-1:0] XOR_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 ^ in2;
    endfunction

    // Function for NOT operation (only needs one operand)
    function logic [WORD_SIZE-1:0] NOT_function(input logic [WORD_SIZE-1:0] in1);
        return ~in1;
    endfunction

    // Always block to select operation based on opcode
    always_comb begin
        case (opcode)
            AND: out = AND_function(operand_1, operand_2);
            OR:  out = OR_function(operand_1, operand_2);
            XOR: out = XOR_function(operand_1, operand_2);
            NOT: out = NOT_function(operand_1);
            default: out = 0; // Default case (NOP)
        endcase
    end

endmodule
