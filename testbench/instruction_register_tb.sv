`timescale 1ns/1ps

module instruction_register_tb;

    import constants::*;
    logic clk;
    logic [OPCODE_SIZE-1:0] opcode;
    control_bus_if ctrl_bu_if();
    address_bus_if addr_bus_if();

    instruction_register DUT(.CLK(clk), );
    initial
    begin

    end

endmodule