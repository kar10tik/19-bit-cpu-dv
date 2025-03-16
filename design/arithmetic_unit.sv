module arithmetic_unit (
    input logic [OPCODE_SIZE-1:0] opcode, // 5-bit opcode
    input logic [WORD_SIZE-1:0] operand_1, operand_2, // 19-bit operands
    output logic [WORD_SIZE-1:0] out // 19-bit result
);
    import constants::*;
    import opcodes::*;

    // Function for Addition
    function logic [WORD_SIZE-1:0] ADD_function(input logic [WORD_SIZE-1:0] in1, in2);
        logic [WORD_SIZE-1:0] a, b, carry;
        a = in1;
        b = in2;
        carry = 0;
        
        while (b != 0) begin
            carry = a & b;  // Carry bits
            a = a ^ b;      // Sum without carry
            b = carry << 1; // Shift carry to left
        end
        
        return a;
    endfunction

    // Function for Subtraction
    function logic [WORD_SIZE-1:0] SUB_function(input logic [WORD_SIZE-1:0] in1, in2);
        return ADD_function(in1, ADD_function(~in2, 1)); // Two’s complement subtraction
    endfunction


    // Function for Multiplication (Shift-and-Add Algorithm)
    function logic [WORD_SIZE-1:0] MUL_function(input logic [WORD_SIZE-1:0] in1, in2);
        logic [WORD_SIZE-1:0] result;
        result = 0;
        while (in2 != 0) begin
            if (in2[0])  // Check LSB
                result = result + in1;
            in1 = in1 << 1; // Shift left (multiply by 2)
            in2 = in2 >> 1; // Shift right (divide by 2)
        end
        return result;
    endfunction

    // Function for Division (Binary Long Division)
    function logic [WORD_SIZE-1:0] DIV_function(input logic [WORD_SIZE-1:0] in1, in2);
        logic [WORD_SIZE-1:0] quotient, remainder;
        quotient = 0;
        remainder = in1;
        
        for (int i = WORD_SIZE - 1; i >= 0; i--) begin
            if (remainder >= (in2 << i)) begin
                remainder = remainder - (in2 << i);
                quotient = quotient | (1 << i);
            end
        end
        return quotient;
    endfunction

    // Function for Increment
    function logic [WORD_SIZE-1:0] INC_function(input logic [WORD_SIZE-1:0] in1);
        return in1 + 1;
    endfunction

    // Function for Decrement
    function logic [WORD_SIZE-1:0] DEC_function(input logic [WORD_SIZE-1:0] in1);
        return in1 - 1;
    endfunction

    // Always block to select operation based on opcode
    always_comb begin
        case (opcode)
            ADD: out = ADD_function(operand_1, operand_2);
            SUB: out = SUB_function(operand_1, operand_2);
            MUL: out = MUL_function(operand_1, operand_2);
            DIV: out = DIV_function(operand_1, operand_2);
            INC: out = INC_function(operand_1);
            DEC: out = DEC_function(operand_1);
            default: out = 0; // Default case (NOP)
        endcase
    end

endmodule