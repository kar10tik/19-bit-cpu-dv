`include "constants.svh"

module program_counter(input CLK, control_bus_if.PC pc_ctrl_if, ADDRESS, output execadd);

logic [WORD_SIZE-1:0] address, execadd, temp;

always_ff @(posedge CLK)
begin
	if (pc_ctrl_if.LOAD_PC == 0 && INC_PC == 0) begin
	    temp <= 'h0;
	end
	else if (LOAD_PC == 1 && INC_PC == 0) begin
	    temp <= address;
	end
	else if (LOAD_PC == 0 && INC_PC == 1) begin
	    temp <= temp + 'h1;
	end
	else begin
	    temp <= temp;
	end
	execadd <= temp;
end

endmodule