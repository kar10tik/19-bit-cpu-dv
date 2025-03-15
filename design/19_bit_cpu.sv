import constants::*
import opcodes::*

module CPU_19_bit(input CLK, EN, we_IM, codein, immediate_addr, output za, zb, eq, gt, lt);
    
    reg za, zb, eq, gt, lt;

    wire [11:0] current_addr, address; 
    wire [WORD_SIZE - 1:0] outIMd; 
    wire [3:0] opcode;
    wire load_IR, loadAd, loadBd, loadCd, moded, we_DMd, muxA_select, muxB_select, load_PC, inc_PC;
    wire [11:0] execaddd; wire [WORD_SIZE - 1:0] dataAoutd; 
    wire [WORD_SIZE - 1:0] dataBoutd; 
    wire [2*(WORD_SIZE) - 1:0] outALUd, currdat, outDMd, dataCoutd;
    wire zad, zbd, eqd, gtd, ltd;

    external_memory instruction_memory #(parameter DATA_SIZE = 19) (.CLK(clk), .WR_EN(we_IM), .WR_DATA(codein), .ADDRESS(current_addr), .MEM_OUT(outIMd));
    external_memory data_memory #(parameter DATA_SIZE = 38) (.CLK(clk), .WR_EN(we_IM), .WR_DATA(codein), .ADDRESS(current_addr), .MEM_OUT(outIMd));
    inst_register   instr_reg (.CLK(clk), .LOAD_IR(load_IR), .INSTR(outIMd), .ADDRESS(addressd), .OPCODE(opcode));
    control_unit    controller 	 (.CLK(clk), .EN(en), .OPCODE(opcode), .loadA(loadAd), .loadB(loadBd), .loadC(loadCd), .LOAD_IR(load_IR), .LOAD_PC(loadPCd), .INC_PC(incPCd), .MODE(moded), .WR_EN_DM(we_DMd), .selA(selAd), .selB(selBd));
    program_counter 	PC (.CLK(clk), .LOAD_PC(load_PC), .INC_PC(inc_PC), .ADDRESS(address), .execadd(execaddd));
    multiplexer	muxA (.clk(clk), .in1(execaddd), .in2(immediate_addr), .sel(muxA_select), .outB(current_addr));
    multiplexer	muxB (.clk(clk), .in1(outALUd), .in2({4'b0000,immediate_addr}), .sel(muxB_select), .outA(currdat));
    register 	reg_A #(parameter WORD_SIZE = 19) (.CLK(clk), .LOAD_REG(loadAd), .IN_DATA(outDMd[15:0]), .OUT_DATA(dataAoutd));
    register 	reg_B #(parameter WORD_SIZE = 19) (.CLK(clk), .LOAD_REG(loadBd), .IN_DATA(outDMd[31:16]), .OUT_DATA(dataBoutd));
    register	reg_C #(parameter WORD_SIZE = 19) (.CLK(clk), .LOAD_REG(loadCd), .IN_DATA(currdat), .OUT_DATA(dataCoutd));
    
    arith_logic_unit ALU (.OPCODE(opcode), .OP_1(), .OP_2(), .MODE(moded), .outALU(outALUd));

endmodule