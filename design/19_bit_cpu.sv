//MODIFICATIONS PENDING
module CPU (
    RCC_if.rcc cpu_rcc_if,
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
    program_counter pc (
        .pc_rcc_if(cpu_rcc_if),
        .RESET(reset),
        .pc_ctrl_if(cpu_ctrl_if),
        .addr_if(cpu_addr_if)
    );

    // Instruction Memory
    instruction_memory imem (
        .im_rcc_if(cpu_rcc_if),
        .ctrl_bus_if(cpu_ctrl_if),
        .addr_bus_if(cpu_addr_if),
        .instruction(instruction) //FIXME
    );

    // Instruction Register
    instruction_register ir (
        .ir_rcc_if(cpu_rcc_if),
        .IR_ctrl_if(cpu_ctrl_if),
        .IR_addr_if(cpu_addr_if)
    );

    // Register File
    register regfile (
        .reg_rcc_if(cpu_rcc_if),
        .reg_ctrl_if(cpu_ctrl_if),
        .reg_data_if(cpu_data_if)
    );

    // ALU
    arith_logic_unit alu (
        .ALU_control(cpu_ctrl_if),
        .ALU_data(cpu_data_if),
        .operand1(cpu_data_if.data1),
        .operand2(mode ? {12'b0, imm_value} : cpu_data_if.data2), // FIXME Select Register or Immediate
        .result(alu_result)
    );

    // Data Memory
    data_memory dmem (
        .dmem_rcc_if(cpu_rcc_if),
        .addr_bus_if(cpu_addr_if),
        .data_bus_if(cpu_data_if),
        .ctrl_bus_if(cpu_ctrl_if)
    );

    // Control Unit
    control_unit cu (
        .cu_rcc_if(cpu_rcc_if),
        .ctrl_bus_if(cpu_ctrl_if)
    );

endmodule