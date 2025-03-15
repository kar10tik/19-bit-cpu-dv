`include "constants.svh"

interface address_bus_if;
    logic [ADDR_WIDTH-1:0] address;

    modport memory (
        input address
    );

    modport pc (
        output address
    );

    modport cpu (
        output address
    );
endinterface
