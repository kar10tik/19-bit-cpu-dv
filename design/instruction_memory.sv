module instruction_memory (
    input logic CLK,
    control_bus_if.memory ctrl_bus_if,
    address_bus_if.memory addr_bus_if,
    output logic [WORD_SIZE-1:0] instruction
);

import constants::*;
logic [WORD_SIZE-1:0] mem [0:1023]; 

always_ff @(posedge CLK or ctrl_bus_if.RESET) begin
    if (ctrl_bus_if.RESET)
        mem <= '{default: '0};
    else if (ctrl_bus_if.RD_EN_IM)
        instruction <= mem[addr_bus_if.address];
    
end

endmodule
