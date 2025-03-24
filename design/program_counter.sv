module program_counter(RCC_if.rcc pc_rcc_if, control_bus_if.PC pc_ctrl_if, address_bus_if.pc addr_if);

import constants::*;
always_ff @(posedge pc_rcc_if.CLK or posedge pc_rcc_if.RESET) 
begin
	if (pc_rcc_if.RESET)
	begin
		addr_if.out_address <= 'h0;
	end
	else
	begin
		if (pc_ctrl_if.LOAD_REG == 0 && pc_ctrl_if.LOAD_SELECT == LOAD_PC)
		begin
			if (pc_ctrl_if.INC_PC == 0)	//RESET by control unit
				addr_if.out_address <= 'h0;

			if (pc_ctrl_if.INC_PC == 1)
				addr_if.out_address <= addr_if.out_address + 'h1;
		end

		else if (pc_ctrl_if.LOAD_REG == 1 && pc_ctrl_if.LOAD_SELECT == LOAD_PC)
		begin
			if (pc_ctrl_if.INC_PC == 0) //FETCH state
				addr_if.out_address <= addr_if.in_address;
			else
				addr_if.out_address <= addr_if.out_address;
		end

		else 
		begin
		    addr_if.out_address <= addr_if.out_address;
		end
	end
end

endmodule