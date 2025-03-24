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
    control_bus_if.ALU ALU_control,  
    data_bus_if.alu ALU_data,  
    input logic [WORD_SIZE-1:0] reg_data_1, reg_data_2,  // // FIXME Operand inputs
    output logic [WORD_SIZE-1:0] result  // // FIXME ALU result output
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

    // Select between Arithmetic and Logic operations based on MODE signal
    always_comb begin
        if (ALU_control.MODE) 
            result = logic_result;  // Logical operations
        else 
            result = arith_result;  // Arithmetic operations
    end

endmodule
