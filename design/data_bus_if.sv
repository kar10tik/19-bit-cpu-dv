interface data_bus_if;
    import constants::*;
    logic [WORD_SIZE-1:0] data_in; //Data input to peripheral
    logic [WORD_SIZE-1:0] data_out; //Data output from peripheral

    modport device (
        input data_in,
        output data_out
    );

    modport reg_data (
        output data_out,
        input data_in
    );
endinterface