module CPU_19_bit(input CLK, en, we_IM, codein, immd, output za, zb, eq, gt, lt);
localparam WORD_SIZE = 19;
reg za, zb, eq, gt, lt;

wire [11:0] current_addr; wire [WORD_SIZE - 1:0] outIMd; wire [11:0] address; wire [3:0] opcode;
wire load_IR, loadAd, loadBd, loadCd, moded, we_DMd, selAd, selBd, load_PC, inc_PC;
wire [11:0] execaddd; wire [WORD_SIZE - 1:0] dataAoutd; wire [WORD_SIZE - 1:0] dataBoutd; wire [2*(WORD_SIZE) - 1:0] outALUd;
wire [2*(WORD_SIZE) - 1:0] currdat; wire [2*(WORD_SIZE) - 1:0] outDMd; wire [2*(WORD_SIZE) - 1:0] dataCoutd;
wire zad, zbd, eqd, gtd, ltd;

external_memory instr_memory #(parameter DATA_SIZE = 19) (.CLK(clk), .WR_EN(we_IM), .WR_DATA(codein), .ADDRESS(current_addr), .MEM_OUT(outIMd));
external_memory data_memory #(parameter DATA_SIZE = 38) (.CLK(clk), .WR_EN(we_IM), .WR_DATA(codein), .ADDRESS(current_addr), .MEM_OUT(outIMd));
inst_register   instr_reg (.CLK(clk), .LOAD_IR(load_IR), .INSTR(outIMd), .ADDRESS(addressd), .OPCODE(opcode));
control_unit    controller 	 (.CLK(clk), .EN(en), .OPCODE(opcode), .loadA(loadAd), .loadB(loadBd), .loadC(loadCd), .LOAD_IR(load_IR), .LOAD_PC(loadPCd), .INC_PC(incPCd), .MODE(moded), .WR_EN_DM(we_DMd), .selA(selAd), .selB(selBd));
program_counter 	PC (.CLK(clk), .LOAD_PC(load_PC), .INC_PC(inc_PC), .ADDRESS(address), .execadd(execaddd));
muxB		a5 (.clk(clk), .in1(execaddd), .in2(immd), .sel(selBd), .outB(current_addr));
register 		reg_A #(parameter WORD_SIZE = 19) (.clk(clk), .loadA(loadAd), .dataAin(outDMd[15:0]), .dataAout(dataAoutd));
register 		reg_B #(parameter WORD_SIZE = 19) (.clk(clk), .loadB(loadBd), .dataBin(outDMd[31:16]), .dataBout(dataBoutd));
register		reg_C #(parameter WORD_SIZE = 19) (.clk(clk), .loadC(loadCd), .dataCin(currdat), .dataCout(dataCoutd));
muxA		b1 (.clk(clk), .in1(outALUd), .in2({4'b0000,immd}), .sel(selAd), .outA(currdat));
arith_logic_unit 		ALU (.OPCODE(opcode), .OP_1(), .OP_2(), .MODE(moded), .outALU(outALUd));

endmodule