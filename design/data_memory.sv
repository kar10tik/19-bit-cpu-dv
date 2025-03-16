

module data_memory (
    input logic clk,
    control_bus_if.memory ctrl_bus_if,
    address_bus_if.memory addr_bus_if,
    inout data_bus_if.memory data_bus_if
);

import constants::*;
logic [WORD_SIZE - 1:0] mem [0:1023];

always_ff @(posedge clk) begin
    if (ctrl_bus_if.WR_EN_DM)
        mem[addr_bus_if.address] <= data_bus_if.data_in;
    if (ctrl_bus_if.RD_EN_DM)
        data_bus_if.data_out <= mem[addr_bus_if.address];
end

endmodule
