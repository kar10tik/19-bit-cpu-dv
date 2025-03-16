`timescale 1ns / 1ps

module instruction_memory_tb;
    import constants::*;
    
    logic clk;
    control_bus_if.memory ctrl_bus_if();
    address_bus_if.memory addr_bus_if();
    logic [WORD_SIZE-1:0] instruction;
    
    instruction_memory uut (
        .clk(clk),
        .ctrl_bus_if(ctrl_bus_if),
        .addr_bus_if(addr_bus_if),
        .instruction(instruction)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        ctrl_bus_if.RD_EN_IM = 0;
        addr_bus_if.address = 0;
        
        // Load test instructions
        uut.mem[0] = 19'h12340;
        uut.mem[1] = 19'h0ABCD;
        uut.mem[2] = 19'h05678;
        uut.mem[3] = 19'h1EFF0;
        
        // Test instruction read
        #10;
        ctrl_bus_if.RD_EN_IM = 1;
        addr_bus_if.address = 0;
        #10;
        $display("Instruction at address 0: %h", instruction);
        
        addr_bus_if.address = 1;
        #10;
        $display("Instruction at address 1: %h", instruction);
        
        addr_bus_if.address = 2;
        #10;
        $display("Instruction at address 2: %h", instruction);
        
        addr_bus_if.address = 3;
        #10;
        $display("Instruction at address 3: %h", instruction);
        
        ctrl_bus_if.RD_EN_IM = 0;
        #10;
        
        $stop;
    end
endmodule