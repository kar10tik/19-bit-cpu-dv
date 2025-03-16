`timescale 1ns/1ps

module program_counter_tb;

  import constants::*;

  logic CLK;
  control_bus_if ctrl_if();
  address_bus_if addr_if();

  program_counter dut (
    .CLK(CLK),
    .pc_ctrl_if(ctrl_if.PC),
    .addr_if(addr_if.pc),
    .execadd()
  );

  always #5 CLK = ~CLK;  // 10 ns clock period

  // Test sequence
  initial begin

    CLK = 0;
    ctrl_if.LOAD_REG = 0;
    ctrl_if.LOAD_SELECT = LOAD_PC;
    ctrl_if.INC_PC = 0;
    addr_if.out_address = 0;

    // Apply reset condition
    #10;
    ctrl_if.INC_PC = 0;
    $display("RESET: addr_if.out_address = %h", addr_if.out_address);

    // Increment PC
    #10;
    ctrl_if.INC_PC = 1;
    $display("INCREMENT: addr_if.out_address = %h", addr_if.out_address);

    // Simulate FETCH
    #10;
    ctrl_if.LOAD_REG = 1;
    addr_if.in_address = 16'h1234;  // Simulate input address
    #10;
    ctrl_if.INC_PC = 0;
    $display("FETCH: addr_if.out_address = %h", addr_if.out_address);

    // Hold state
    #10;
    ctrl_if.LOAD_REG = 1;
    ctrl_if.INC_PC = 1;
    $display("HOLD: addr_if.out_address = %h", addr_if.out_address);

    // End simulation
    #50;
    $stop;
  end

endmodule
