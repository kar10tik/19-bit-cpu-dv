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


module arith_logic_unit(input OPCODE, OP_1, OP_2, 
output out

    );
    import alu_opcodes::*;
    logic OPCODE[4:0], OP_1[4:0], OP_2[4:0];
    logic [4:0] out;
    
    arithmetic_unit arithmetic_logic1();
    
    always_comb begin : ALU_operations
        case (OPCODE)
            NOT: NOT_function();
            AND: AND_function();
            OR: OR_function();
            XOR: XOR_function();
            ADD: ADD_function();
            SUB: SUB_function();
            MUL: MUL_function();
            DIV: DIV_function();
            INC: INC_function();
            DEC: DEC_function();
            default: $display("Invalid OPCODE!");
        endcase
    end
     
endmodule
