module instruction_register (
    RCC_if.rcc rcc_bus, 
    control_bus_if ctrl_bus, 
    address_bus_if addr_bus,
    instruction_bus_if.ireg instruction_bus
);

	import contants::*;
    logic CLK;
	logic [WORD_SIZE-1:0] instr;

	always_ff @(posedge rcc_bus.CLK)
    begin
        if (ctrl_bus.LOAD_REG && ctrl_bus.LOAD_SELECT == LOAD_IR) 
        begin
            instr <= instruction_bus.instr_in;
        end
        ctrl_bus.OPCODE <= instr[WORD_SIZE - 1:WORD_SIZE - 5];
        addr_bus.out_address <= instr[WORD_SIZE - 6:0]; // Send address operand
    end
endmodule