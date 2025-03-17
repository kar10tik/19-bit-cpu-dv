//MODIFICATIONS PENDING
module CPU (
    input logic clk,
    input logic reset,
    control_bus_if.ctrl cpu_ctrl_if,
    data_bus_if.data cpu_data_if,
    address_bus_if.addr cpu_addr_if
);
    import constants::*;
    import opcodes::*;

    // Internal Signals
    logic [WORD_SIZE - 1:0] instruction;    // 19-bit fetched instruction
    logic [OPCODE_SIZE - 1:0] opcode;
    logic [4:0] reg_dst, reg_src1, reg_src2;
    logic [3:0] imm_value;
    logic mode;
    logic [WORD_SIZE-1:0] alu_result, mem_data;
    logic [ADDR_SIZE-1:0] pc_out, mem_addr;

    // Program Counter
    ProgramCounter pc (
        .clk(clk),
        .reset(reset),
        .load(cpu_ctrl_if.LOAD_REG),
        .inc(cpu_ctrl_if.INC_PC),
        .in_address(mem_addr),
        .out_address(pc_out)
    );

    // Instruction Memory
    InstructionMemory imem (
        .clk(clk),
        .addr(pc_out),
        .data_out(instruction)
    );

    // Instruction Register
    InstructionRegister ir (
        .clk(clk),
        .reset(reset),
        .load(cpu_ctrl_if.ENABLE),
        .instr_in(instruction),
        .opcode(opcode),
        .reg_dst(reg_dst),
        .reg_src1(reg_src1),
        .reg_src2(reg_src2),
        .imm_value(imm_value),
        .mode(mode)
    );

    // Register File
    RegisterFile regfile (
        .clk(clk),
        .reset(reset),
        .load(cpu_ctrl_if.LOAD_REG),
        .src1(reg_src1),
        .src2(reg_src2),
        .dst(reg_dst),
        .data_in(alu_result),
        .data_out1(cpu_data_if.data1),
        .data_out2(cpu_data_if.data2)
    );

    // ALU
    ALU alu (
        .opcode(opcode),
        .mode(mode),
        .operand1(cpu_data_if.data1),
        .operand2(mode ? {12'b0, imm_value} : cpu_data_if.data2), // Select Register or Immediate
        .result(alu_result),
        .flags(cpu_ctrl_if.FLAGS)
    );

    // Data Memory
    DataMemory dmem (
        .clk(clk),
        .addr(cpu_addr_if.address),
        .data_in(cpu_data_if.data1),
        .data_out(mem_data),
        .read(cpu_ctrl_if.RD_EN_DM),
        .write(cpu_ctrl_if.WR_EN_DM)
    );

    // Control Unit
    ControlUnit cu (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .enable(cpu_ctrl_if.ENABLE),
        .rd_en(cpu_ctrl_if.RD_EN),
        .wr_en(cpu_ctrl_if.WR_EN),
        .inc_pc(cpu_ctrl_if.INC_PC),
        .load_reg(cpu_ctrl_if.LOAD_REG),
        .mode(cpu_ctrl_if.MODE),
        .flags(cpu_ctrl_if.FLAGS)
    );

endmodule