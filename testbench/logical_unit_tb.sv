`timescale 1ns / 1ps

module logical_unit_tb;
    import constants::*;
    import opcodes::*;

    // Testbench Signals
    logic [WORD_SIZE-1:0] operand_1, operand_2, expected_result, result;
    logic [OPCODE_SIZE-1:0] opcode;
    logic test_pass;

    logical_unit LU (
        .opcode(opcode),
        .operand_1(operand_1),
        .operand_2(operand_2),
        .out(result)
    );

    // Task to Run a Test Case
    task run_test(logic [OPCODE_SIZE-1:0] op, 
                  logic [WORD_SIZE-1:0] op1, 
                  logic [WORD_SIZE-1:0] op2, 
                  logic [WORD_SIZE-1:0] expected);
        begin
            opcode = op;
            operand_1 = op1;
            operand_2 = op2;
            #10; // Wait for computation

            // Check correctness
            if (result !== expected) begin
                $display("ERROR: OPCODE %b | Expected: %d, Got: %d", opcode, expected, result);
                test_pass = 0;
            end else begin
                $display("PASS: OPCODE %b | %d, %d -> %d", opcode, op1, op2, result);
            end
        end
    endtask

    initial 
    begin
        clk = 0;
        test_pass = 1; // Assume all tests pass

        $display("Starting Logical Unit Test...");

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