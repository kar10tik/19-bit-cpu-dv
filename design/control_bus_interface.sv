interface control_bus_if;
    logic ENABLE;
    logic RD_EN;
    logic WR_EN;
    logic INC_PC;
    logic LOAD_REG;
    logic [4:0] OPCODE;
    logic [3:0] FLAGS;
    logic MODE;

    modport memory(
        input RD_EN, WR_EN
    );

    modport PC(
        input INC_PC, LOAD_REG
    );

    modport REG(
        input LOAD_REG
    );

    modport ALU(
        input OPCODE, MODE,
        inout FLAGS
    );

    modport CU(
        input ENABLE, OPCODE,
        output RD_EN, WR_EN, INC_PC, LOAD_REG, MODE
        inout FLAGS
    );
endinterface