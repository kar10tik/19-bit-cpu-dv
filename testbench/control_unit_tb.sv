module control_unit_tb;
    import constants::*;
    import opcodes::*;

    logic CLK, EN;
    control_bus_if ctrl_bus_if();

    control_unit uut (
        .CLK(CLK),
        .EN(EN),
        .ctrl_bus_if(ctrl_bus_if)
    );

    always #5 CLK = ~CLK; // 10 time units per clock cycle

    initial begin
        CLK = 0;
        EN = 1;
        ctrl_bus_if.OPCODE = 5'b00000; // Default instruction
        
        // Reset the control unit
        #10 EN = 0;
        #10 EN = 1;

        // Test FETCH state
        #10 ctrl_bus_if.OPCODE = ADD;
        #10 ctrl_bus_if.OPCODE = SUB;
        #10 ctrl_bus_if.OPCODE = MUL;
        #10 ctrl_bus_if.OPCODE = DIV;
        #10 ctrl_bus_if.OPCODE = AND;
        #10 ctrl_bus_if.OPCODE = OR;
        #10 ctrl_bus_if.OPCODE = XOR;
        #10 ctrl_bus_if.OPCODE = NOT;
        #10 ctrl_bus_if.OPCODE = JMP;
        #10 ctrl_bus_if.OPCODE = BEQ;
        ctrl_bus_if.FLAGS[0] = 1; // Set zero flag
        #10 ctrl_bus_if.OPCODE = BEQ;
        ctrl_bus_if.FLAGS[0] = 0; // Clear zero flag
        #10 ctrl_bus_if.OPCODE = BNE;
        #10 ctrl_bus_if.OPCODE = CALL;
        #10 ctrl_bus_if.OPCODE = RET;
        #10 ctrl_bus_if.OPCODE = LD;
        #10 ctrl_bus_if.OPCODE = ST;
        #10 ctrl_bus_if.OPCODE = 5'b11111; // Test unknown instruction

        // Finish simulation
        #50 $stop;
    end
endmodule
