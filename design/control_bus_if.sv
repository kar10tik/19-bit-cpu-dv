import constants::*;

interface control_bus_if;
    bit ENABLE; //Enable signal for control unit
    bit RD_EN_DM; //Read enable for data memory
    bit WR_EN_DM; //Write enable for data memory
    bit RD_EN_IM; //Read enable for instruction memory
    bit WR_EN_IM; //Write enable for instruction memory
    bit INC_PC; //Program counter increment
    bit LOAD_REG; //Load register
    bit LOAD_SELECT; //Select which register to load: 000 for PC, 001 for IR, 010 for RegA, 011 for RegB, 100 for RegC
    bit [OPCODE_SIZE - 1:0] OPCODE; //
    bit [FLAG_REG_SIZE - 1:0] FLAGS; //ALU flags
    bit MODE; //ALU mode
    bit MUX_SELECT_A, MUX_SELECT_B; //MUX select signals

    modport imem(
        input RD_EN_IM, WR_EN_IM
    );

    modport dmem(
        input RD_EN_DM, WR_EN_DM
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