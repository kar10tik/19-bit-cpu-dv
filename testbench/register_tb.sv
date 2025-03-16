`timescale 1ns / 1ps

module register_tb;
    import constants::*;
    import opcodes::*;
    
    logic CLK;
    control_bus_if reg_ctrl_if();
    data_bus_if reg_data_if();
    
    register dut (
        .CLK(CLK), 
        .reg_ctrl_if(reg_ctrl_if), 
        .reg_data_if(reg_data_if)
    );
    
    always #5 CLK = ~CLK;
    
    initial begin
        CLK = 0;
        reg_ctrl_if.LOAD_REG = 0;
        reg_ctrl_if.LOAD_SELECT = 0;
        reg_data_if.data_in = 0;
        
        // Test writing to registers
        reg_ctrl_if.LOAD_REG = 1;
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_A;
        reg_data_if.data_in = 8'hAA;
        #10;
        
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_B;
        reg_data_if.data_in = 8'hBB;
        #10;
        
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_C;
        reg_data_if.data_in = 8'hCC;
        #10;
        
        // Switch to reading mode
        reg_ctrl_if.LOAD_REG = 0; 

        // Test reading from registers
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_A;
        #10;
        $display("Register A: %h", reg_data_if.data_out);
        
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_B;
        #10;
        $display("Register B: %h", reg_data_if.data_out);
        
        reg_ctrl_if.LOAD_SELECT = LOAD_REG_C;
        #10;
        $display("Register C: %h", reg_data_if.data_out);
        
        $stop;
    end
endmodule