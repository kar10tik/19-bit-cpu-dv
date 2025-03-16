//Prototype module for registers A-C.

module register(input logic CLK, control_bus_if reg_ctrl_if, inout data_bus_if.register reg_data_if);
    import constants::*;
    import opcodes::*;

    logic [2:0] [WORD_SIZE-1:0] register_file;

    always_ff @ (posedge CLK)
    begin   
        if (reg_ctrl_if.LOAD_REG == 1) 
        begin
            case (reg_ctrl_if.LOAD_SELECT)
                LOAD_REG_A: register_file[REG_A] <= reg_data_if.data_in;
                LOAD_REG_B: register_file[REG_B] <= reg_data_if.data_in;
                LOAD_REG_C: register_file[REG_C] <= reg_data_if.data_in;
                default: ;
            endcase
        end
        else if (reg_ctrl_if.LOAD_REG == 0) 
        begin
            case (reg_ctrl_if.LOAD_SELECT)
                LOAD_REG_A: reg_data_if.data_out <= register_file[REG_A];
                LOAD_REG_B: reg_data_if.data_out <= register_file[REG_B];
                LOAD_REG_C: reg_data_if.data_out <= register_file[REG_C];
                default: ;
            endcase
        end
    end

endmodule