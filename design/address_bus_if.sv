interface address_bus_if;
    import constants::*;
    logic [ADDR_SIZE-1:0] in_address;
    logic [ADDR_SIZE-1:0] out_address;

    modport memory (
        input in_address
    );

    modport pc (
        input in_address,  // Accept address (e.g., from JMP instruction)
        output out_address // Provide address for instruction fetch
    );

    modport ir (
        input in_address,  // Receive address for decoding
        output out_address // Send address operand for execution
    );

    modport cpu (
        input in_address,  // Receive addresses from memory, IR, or PC
        output out_address // Send addresses for execution or memory access
    );
endinterface
