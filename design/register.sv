//Prototype module for registers A-C.

module register(input CLK, LOAD_REG, IN_DATA, output OUT_DATA);
    import constants::*;
    import opcodes::*;
    parameter WORD_SIZE = 19;
    logic CLK, LOAD_REG;
    logic [WORD_SIZE-1] IN_DATA, OUT_DATA, temp_data;

    always_ff @ (posedge CLK)
    begin   
        if (LOAD_REG == 1) 
        begin
            OUT_DATA <= IN_DATA;
            temp_data <= IN_DATA;
        end
        else if (LOAD_REG == 0) 
        begin
            OUT_DATA <= temp_data;
        end
    end

endmodule