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
        .ctrl_bus_if(cpu_ctrl_if),
        .address_bus_if(cpu_addr_if)
    );

    // Instruction Memory
    InstructionMemory imem (
        .clk(clk),
        .addr_bus_if(cpu_addr_if)
    );

    // Instruction Register
    InstructionRegister ir (
        .clk(clk),
        .ctrl_bus_if(cpu_ctrl_if),
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
        .ctrl_bus_if(cpu_ctrl_if),
        .src1(reg_src1),
        .src2(reg_src2),
        .dst(reg_dst),
        .data_in(alu_result),
        .data_bus_if(cpu_data_if.data1)
    );

    // ALU
    ALU alu (
        .ctrl_bus_if(cpu_ctrl_if),
        .data_bus_if(cpu_data_if),
        .operand1(cpu_data_if.data1),
        .operand2(mode ? {12'b0, imm_value} : cpu_data_if.data2), // Select Register or Immediate
        .result(alu_result),
    );

    // Data Memory
    DataMemory dmem (
        .clk(clk),
        .addr_bus_if(cpu_addr_if),
        .data_bus_if(cpu_data_if),
        .ctrl_bus_if(cpu_ctrl_if)
    );

    // Control Unit
    ControlUnit cu (
        .clk(clk),
        .ctrl_bus_if(cpu_ctrl_if)
    );

endmodule