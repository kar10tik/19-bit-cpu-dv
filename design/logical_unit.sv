module logical_unit (
    control_bus_if.ALU ctrl_bus,
    input logic [WORD_SIZE-1:0] operand_1, operand_2,
    output logic [WORD_SIZE-1:0] out
);
    import constants::*;
    import opcodes::*;

    // AND
    function logic [WORD_SIZE-1:0] AND_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 & in2;
    endfunction

    // OR
    function logic [WORD_SIZE-1:0] OR_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 | in2;
    endfunction

    // XOR
    function logic [WORD_SIZE-1:0] XOR_function(input logic [WORD_SIZE-1:0] in1, in2);
        return in1 ^ in2;
    endfunction

    // NOT
    function logic [WORD_SIZE-1:0] NOT_function(input logic [WORD_SIZE-1:0] in1);
        return ~in1;
    endfunction

    // Opcode Execution
    always_comb begin
        case (ctrl_bus.OPCODE)
            AND: out = AND_function(operand_1, operand_2);
            OR:  out = OR_function(operand_1, operand_2);
            XOR: out = XOR_function(operand_1, operand_2);
            NOT: out = NOT_function(operand_1);
            default: out = 0; 
        endcase
    end

endmodule
