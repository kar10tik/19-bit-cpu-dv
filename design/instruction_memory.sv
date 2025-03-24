import constants::*;

module instruction_memory (
    RCC_if.rcc im_rcc_if,
    control_bus_if.memory ctrl_bus_if,
    data_bus_if.memory inst_bus_if,
    address_bus_if.memory instr_addr_bus_if,
);

logic [WORD_SIZE-1:0] mem [0:1023]; 

always_ff @(posedge im_rcc_if.CLK or im_rcc_if.RESET) begin
    if (im_rcc_if.RESET)
        mem <= '{default: '0};
    else if (ctrl_bus_if.RD_EN_IM)
        instruction <= mem[addr_bus_if.address];
    
end

endmodule
