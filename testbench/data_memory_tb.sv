`timescale 1ns / 1ps

module data_memory_tb;
    import constants::*;

    logic clk;
    control_bus_if memory ctrl_bus();
    address_bus_if memory addr_bus();
    data_bus_if memory data_bus();

    // Instantiate the data_memory module
    data_memory uut (
        .clk(clk),
        .ctrl_bus_if(ctrl_bus),
        .addr_bus_if(addr_bus),
        .data_bus_if(data_bus)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        ctrl_bus.WR_EN_DM = 0;
        ctrl_bus.RD_EN_DM = 0;
        addr_bus.address = 0;
        data_bus.data_in = 0;

        // Write Test
        addr_bus.address = 10;
        data_bus.data_in = 19'h12345;
        ctrl_bus.WR_EN_DM = 1;
        #10;
        ctrl_bus.WR_EN_DM = 0;

        // Read Test
        ctrl_bus.RD_EN_DM = 1;
        #10;
        $display("Read data: %h", data_bus.data_out);
        ctrl_bus.RD_EN_DM = 0;

        // Another Write and Read Test
        addr_bus.address = 20;
        data_bus.data_in = 19'h1A2B3;
        ctrl_bus.WR_EN_DM = 1;
        #10;
        ctrl_bus.WR_EN_DM = 0;

        ctrl_bus.RD_EN_DM = 1;
        #10;
        $display("Read data: %h", data_bus.data_out);
        ctrl_bus.RD_EN_DM = 0;

        $stop;
    end
endmodule
