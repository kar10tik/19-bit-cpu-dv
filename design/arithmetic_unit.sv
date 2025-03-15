`include "constants.svh"

module arithmetic_unit(input opcode, operand_1, operand_2, output out);
    logic [WORD_SIZE-1:0] operand_1, operand_2, out;
    logic [OPCODE_SIZE - 1:0] opcode;
    logical_unit logic1(.opcode(opcode), .operand_1(operand_1), .operand_2(operand_2), .out(out));

    function logic[WORD_SIZE-1:0] ADD_function(logic [WORD_SIZE-1:0] in1, [WORD_SIZE-1:0] in2);
       logic carry = 1'b0;
       out = logic1.XOR(logic1.XOR(in1, in2), carry);
       carry = (in1 & in2) | (carry & (in1 ^ in2));
       return out;
    endfunction
      
    
    function logic[WORD_SIZE-1:0] SUB_function(logic [WORD_SIZE-1:0] in1, [WORD_SIZE-1:0] in2);
        logic borrow = 1'b0;
        out = in1 ^ in2 ^ borrow;
        borrow = (~in1 & in2) | (borrow & ~(in1 ^ in2));
        return out;
    endfunction
    
    
    function logic[WORD_SIZE-1:0] MUL_function(logic [WORD_SIZE-1:0] in1, [WORD_SIZE-1:0] in2);
        while (in2)
            begin
                if (in2[18:0] & in1[18:0])
                    out = ADD(out, in1, out);
                else
                    in1 = in1 << 1;
                    in2 = in2 >> 1;
            end
    endfunction
    
    
    function logic[WORD_SIZE-1:0] DIV_function(logic [WORD_SIZE-1:0] in1, [WORD_SIZE-1:0] in2);
        logic remainder, temp;
        if (in1 == in2) begin
            remainder = 0;
            return 1;
        end
        else if (in1 < in2)
        begin
            ;
        end
        temp = SUB(in1, in2, temp);
    endfunction
    
    
    function logic[WORD_SIZE-1:0] INC_function(logic [WORD_SIZE-1:0] in1);
        return ADD(in1, 'b1, out);
    endfunction
    
    
    function logic[WORD_SIZE-1:0] DEC_function(logic [WORD_SIZE-1:0] in1);
        out = SUB(in1, 'b1, out);
    endfunction
endmodule