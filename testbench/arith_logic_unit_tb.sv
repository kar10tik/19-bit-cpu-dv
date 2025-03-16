`timescale 1ns / 1ps
module arith_logic_unit_tb();
    import constants::*;
    import opcodes::*;

    logic clk;
    logic [WORD_SIZE-1:0] operand_1, operand_2;
    logic [WORD_SIZE-1:0] expected_result;
    logic [WORD_SIZE-1:0] result;
    logic test_pass;
    logic [OPCODE_SIZE-1:0] opcode;

    arith_logic_unit ALU (
        .clk(clk),
        .reg_data_1(operand_1),
        .reg_data_2(operand_2),
        .result(result),
        .ALU_control(opcode)
    );

    always #5 clk = ~clk;

    // Task to Run a Test Case
    task run_test(logic [OPCODE_SIZE-1:0] op, 
                  logic [WORD_SIZE-1:0] op1, 
                  logic [WORD_SIZE-1:0] op2, 
                  logic [WORD_SIZE-1:0] expected);
        begin
            opcode = op;
            operand_1 = op1;
            operand_2 = op2;
            #10; // Wait for ALU to compute

            // Check correctness
            if (result !== expected) begin
                $display("ERROR: OPCODE %b | Expected: %d, Got: %d", opcode, expected, result);
                test_pass = 0;
            end else begin
                $display("PASS: OPCODE %b | %d, %d -> %d", opcode, op1, op2, result);
            end
        end
    endtask

    initial begin
        clk = 0;
        test_pass = 1; //Initialize test pass signal

        $display("Starting ALU Test...");

        // Arithmetic Tests
        run_test(ADD, 19'd10, 19'd5, 19'd15);
        run_test(SUB, 19'd10, 19'd5, 19'd5);
        run_test(MUL, 19'd3, 19'd4, 19'd12);
        run_test(DIV, 19'd20, 19'd4, 19'd5);
        run_test(INC, 19'd10, 0, 19'd11);
        run_test(DEC, 19'd10, 0, 19'd9);

        // Logical Tests
        run_test(AND, 19'b1010101010101010101, 19'b1100110011001100110, 19'b1000100010001000100);
        run_test(OR, 19'b1010101010101010101, 19'b1100110011001100110, 19'b1110111011101110111);
        run_test(XOR, 19'b1010101010101010101, 19'b1100110011001100110, 19'b0110011001100110011);
        run_test(NOT, 19'b1010101010101010101, 0, 19'b0101010101010101010);

        if (test_pass) 
            $display("ALL TESTS PASSED SUCCESSFULLY!");
        else
            $display("SOME TESTS FAILED!");

        $finish;
    end
endmodule
