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

//!Data bus interface has not been used with ALU, instead registers A and B will output operands MUXed with immediate operands
module arith_logic_unit (
    control_bus_if.ALU ALU_control,    
    input logic [WORD_SIZE-1:0] operand_1, operand_2,  // Operand inputs
    output logic [WORD_SIZE-1:0] result  // ALU result output
);
    import constants::*;
    import opcodes::*;

    logic [WORD_SIZE-1:0] arith_result, logic_result;

    // Instantiate Arithmetic and Logical Units
    arithmetic_unit AU (
        .ctrl_bus_if(ALU_control),
        .operand_1(reg_data_1),
        .operand_2(reg_data_2),
        .out(arith_result)
    );

    logical_unit LU (
        .ctrl_bus_if(ALU_control),
        .operand_1(reg_data_1),
        .operand_2(reg_data_2),
        .out(logic_result)
    );

    // Select between Arithmetic/Logic operations based on MODE signal
    always_comb begin
        if (ALU_control.MODE) 
            result = logic_result;  // Logical operations
        else 
            result = arith_result;  // Arithmetic operations
        if (result == '0)
            ALU_control.FLAGS[ZERO_FLAG] = 1
        else if (result < 0) //TODO: MAKE BITWISE
            ALU_control.FLAGS[SIGN_FLAG] = 1
    end

endmodule
