import constants::*

module instruction_memory (
    input logic clk,
    control_bus_if.memory ctrl_bus_if,
    address_bus_if.memory addr_bus_if,
    output logic [WORD_SIZE-1:0] instruction
);

logic [WORD_SIZE-1:0] mem [0:1023]; 

always_ff @(posedge clk) begin
    if (ctrl_bus_if.RD_EN)
        instruction <= mem[addr_bus_if.address];
end

endmodule
