

module data_memory (
    RCC_if.rcc dmem_rcc_if,
    control_bus_if.memory ctrl_bus_if,
    address_bus_if.memory addr_bus_if,
    inout data_bus_if.memory data_bus_if
);

import constants::*;
logic [WORD_SIZE - 1:0] mem [0:1023];

always_ff @(posedge dmem_rcc_if.clk or dmem_rcc_if.RESET) begin
    if (dmem_rcc_if.RESET)
        mem <= '{default: '0};
    else if (ctrl_bus_if.WR_EN_DM)
        mem[addr_bus_if.address] <= data_bus_if.data_in;
    else if (ctrl_bus_if.RD_EN_DM)
        data_bus_if.data_out <= mem[addr_bus_if.address];
end

endmodule
