import constants::*;

module instruction_memory (
    RCC_if.rcc im_rcc_if,
    control_bus_if.memory ctrl_bus_if,
    instruction_bus_if.imem inst_bus_if,
    address_bus_if.memory instr_addr_bus_if,
);

logic [WORD_SIZE-1:0] mem [0:1023]; 

always_ff @(posedge im_rcc_if.CLK or im_rcc_if.RESET) begin
    if (im_rcc_if.RESET)
        mem <= '{default: '0};
    else if (ctrl_bus_if.RD_EN_IM)
        inst_bus_if.instr_out <= mem[addr_bus_if.address];
    else if (ctrl_bus_if.WR_EN_IM)
        mem[addr_bus_if.address] <= inst_bus_if.instr_in;
end

endmodule
