interface instruction_bus_if;
    import constants::*;
    logic [WORD_SIZE-1:0] instr_in; //Instruction input to peripheral
    logic [WORD_SIZE-1:0] instr_out; //Instruction output from peripheral

    modport imem (
        input instr_in,
        output instr_out
    );

    modport ireg(
        input instr_in,
        output instr_out
    );
endinterface