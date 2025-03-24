//MODIFICATIONS PENDING
module CPU (
    RCC_if.rcc rcc_bus,
    control_bus_if.ctrl control_bus,
    data_bus_if.data instruction_bus,
    data_bus_if.data data_bus,
    address_bus_if.addr data_addr_bus, 
    address_bus_if.addr instruction_addr_bus
);
    import constants::*;
    import opcodes::*;

    // Internal Signals
    //logic [WORD_SIZE - 1:0] instruction;    // 19-bit fetched instruction
    //logic [OPCODE_SIZE - 1:0] opcode;
    //logic [4:0] reg_dst, reg_src1, reg_src2;
    //logic [3:0] imm_value;
    //logic mode;
    //logic [WORD_SIZE-1:0] alu_result, mem_data;
    //logic [ADDR_SIZE-1:0] pc_out, mem_addr;

    // Program Counter
    program_counter pc (
        .pc_rcc_if(rcc_bus),
        .pc_ctrl_if(control_bus),
        .addr_if(instruction_addr_bus)
    );

    // Instruction Memory
    instruction_memory imem (
        .im_rcc_if(rcc_bus),
        .ctrl_bus_if(control_bus),
        .addr_bus_if(instruction_addr_bus)
    );

    // Instruction Register
    instruction_register ir (
        .ir_rcc_if(rcc_bus),
        .IR_ctrl_if(control_bus),
        .IR_addr_if(instruction_addr_bus)
    );

    // Register File
    register regfile (
        .reg_rcc_if(rcc_bus),
        .reg_ctrl_if(control_bus),
        .reg_data_if(data_bus)
    );

    // ALU
    arith_logic_unit alu (
        .ALU_control(control_bus),
        .ALU_data(data_bus),
        .operand1(cpu_data_if.data1), // FIXME
        .operand2(mode ? {12'b0, imm_value} : cpu_data_if.data2), // FIXME Select Register or Immediate
        .result(alu_result) // FIXME
    );

    // Data Memory
    data_memory dmem (
        .dmem_rcc_if(rcc_bus),
        .addr_bus_if(data_addr_bus),
        .data_bus_if(data_bus),
        .ctrl_bus_if(control_bus)
    );

    // Control Unit
    control_unit cu (
        .cu_rcc_if(rcc_bus),
        .ctrl_bus_if(control_bus)
    );

endmodule