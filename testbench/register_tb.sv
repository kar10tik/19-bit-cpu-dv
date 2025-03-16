`timescale 1ns/1ps

module register_tb;
    import constants::*;

    logic clk;
    #5 always clk =~ clk;

    initial
    begin
    
    end

endmodule