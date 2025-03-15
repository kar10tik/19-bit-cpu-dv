interface data_bus_if;
    import constants::*;
    logic [WORD_SIZE-1:0] data_in;
    logic [WORD_SIZE-1:0] data_out;

    modport memory (
        input data_in,
        output data_out
    );

    modport registers (
        output data_in,
        input data_out
    );

    modport alu (
        input data_in,
        output data_out
    );
endinterface