module inst_register (input CLK, LOAD_IR, INSTR, output ADDRESS, OPCODE);
	localparam WORD_SIZE = 19; 
	bit CLK, LOAD_IR;
	input [WORD_SIZE - 1:0] INSTR;
	logic [11:0] ADDRESS;
	logic [5:0] OPCODE;
	logic [15:0] temp;

	always@(posedge CLK)
	begin
		if(LOAD_IR == 1) begin
			temp <= INSTR;
		end
	ADDRESS <= temp[11:0];
	OPCODE <= temp[15:12];
	end
endmodule