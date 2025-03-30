interface RCC_if; //Reset and clock control interface
    bit CLK, RST;

    modport rcc(input CLK, RST);
endinterface