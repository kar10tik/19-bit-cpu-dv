

module data_memory (
    input logic clk,
    control_bus_if.memory bus_if,
    address_bus_if.memory addr_bus,
    data_bus_if.memory data_bus
);

import constants::*;
logic [WORD_SIZE - 1:0] mem [0:1023];

always_ff @(posedge clk) begin
    if (bus_if.WR_EN)
        mem[addr_bus.address] <= data_bus.data_in;
    if (bus_if.RD_EN)
        data_bus.data_out <= mem[addr_bus.address];
end

endmodule
