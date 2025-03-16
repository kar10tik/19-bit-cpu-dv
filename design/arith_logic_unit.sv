`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2024 22:16:38
// Design Name: 
// Module Name: arith_logic_unit
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


module arith_logic_unit (
    input logic clk, reset,
    input logic [WORD_SIZE-1:0] reg_data_1, reg_data_2,  // Operand inputs
    output logic [WORD_SIZE-1:0] result,  // ALU result output
    control_bus_if.ALU ALU_control,  
    data_bus_if.ALU ALU_data  
);
    import constants::*;
    import opcodes::*;

    // Instantiate Arithmetic and Logical Units
    arithmetic_unit ARITHMETIC (
        .opcode(ALU_control.OPCODE),
        .operand_1(reg_data_1),
        .operand_2(reg_data_2),
        .out(result)
    );

    logical_unit LOGIC (
        .opcode(ALU_control.OPCODE),
        .operand_1(reg_data_1),
        .operand_2(reg_data_2),
        .out(result)
    );

    // Select between Arithmetic and Logic operations
    always_comb begin
        case (ALU_control.OPCODE)
            NOT, AND, OR, XOR: result = LOGIC.out;  // Logic operations
            ADD, SUB, MUL, DIV, INC, DEC: result = ARITHMETIC.out;  // Arithmetic operations
            default: result = 0;
        endcase
    end

endmodule
