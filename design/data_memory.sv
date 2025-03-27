// Data memory module
module data_memory (
    RCC_if.rcc dmem_rcc,
    control_bus_if.memory ctrl_bus,
    address_bus_if.memory addr_bus,
    data_bus_if.memory data_bus
);

import constants::*;
logic [WORD_SIZE - 1:0] mem [0:1023];

always_ff @(posedge dmem_rcc.CLK or dmem_rcc.RESET) begin
    if (dmem_rcc.RESET)
        mem <= '{default: '0};
    else if (ctrl_bus.WR_EN_DM)
        mem[addr_bus.address] <= data_bus.data_in;
    else if (ctrl_bus.RD_EN_DM)
        data_bus.data_out <= mem[addr_bus.address];
end

endmodule
