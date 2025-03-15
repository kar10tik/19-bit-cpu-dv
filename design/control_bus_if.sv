import constants::*;

interface control_bus_if;
    logic ENABLE; //Enable signal for control unit
    logic RD_EN; //Read enable
    logic WR_EN; //Write enable
    logic INC_PC; //Program counter increment
    logic LOAD_REG; //Load register
    logic LOAD_SELECT; //Select which register to load: 000 for PC, 001 for IR, 010 for RegA, 011 for RegB, 100 for RegC
    logic [OPCODE_SIZE:0] OPCODE; //
    logic [3:0] FLAGS; //ALU flags
    logic MODE; //ALU mode
    logic MUX_SELECT_A, MUX_SELECT_B; //MUX select signals

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
        output RD_EN, WR_EN, INC_PC, LOAD_REG, MODE, MUX_SELECT_A, MUX_SELECT_B,
        inout FLAGS
    );
endinterface