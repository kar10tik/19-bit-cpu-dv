module program_counter(input CLK, LOAD_PC, INC_PC, ADDRESS, output execadd);
localparam WORD_SIZE = 19;
logic [WORD_SIZE-1:0] address, execadd, temp;

always_ff @(posedge CLK)
begin
	if (LOAD_PC == 0 && INC_PC == 0) begin
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