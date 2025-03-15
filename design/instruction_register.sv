`include "constants.svh"

module inst_register (input CLK, control_bus_if IR_ctrl_if, INSTR, output ADDRESS, OPCODE);
	bit CLK;
	input [WORD_SIZE - 1:0] INSTR;
	logic [11:0] ADDRESS;
	logic [15:0] temp;

	always_ff @(posedge CLK)
    begin
        if (IR_ctrl_if.LOAD_REG && IR_ctrl_if.LOAD_SELECT == LOAD_IR) 
        begin
            temp <= INSTR;
        end
        IR_ctrl_if.OPCODE <= temp[15:12];
        addr_if.out_address <= temp[11:0]; // Send address operand
    end
endmodule