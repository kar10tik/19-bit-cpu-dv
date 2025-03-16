module instruction_register (
    input CLK, 
    logic [WORD_SIZE-1:0], 
    control_bus_if IR_ctrl_if, 
    inout address_bus_if IR_addr_if, OPCODE
);

	import contants::*;
    logic CLK;
	logic [WORD_SIZE-1:0] temp;

	always_ff @(posedge CLK)
    begin
        if (IR_ctrl_if.LOAD_REG && IR_ctrl_if.LOAD_SELECT == LOAD_IR) 
        begin
            temp <= INSTR;
        end
        IR_ctrl_if.OPCODE <= temp[15:12];
        IR_addr_if.out_address <= temp[11:0]; // Send address operand
    end
endmodule