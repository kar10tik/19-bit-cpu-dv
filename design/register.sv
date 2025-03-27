//Register file with three registers - A, B, C.

module register(RCC_if.rcc reg_rcc, control_bus_if ctrl_bus, data_bus_if.reg_data data_bus);
    import constants::*;
    import opcodes::*;

    logic [2:0] [WORD_SIZE-1:0] register_file;

    always_ff @ (posedge reg_rcc.CLK)
    begin   
        if (ctrl_bus.LOAD_REG == 1) 
        begin
            case (ctrl_bus.LOAD_SELECT)
                LOAD_REG_A: register_file[REG_A] <= data_bus.data_in;
                LOAD_REG_B: register_file[REG_B] <= data_bus.data_in;
                LOAD_REG_C: register_file[REG_C] <= data_bus.data_in;
                default: ;
            endcase
        end
        else if (ctrl_bus.LOAD_REG == 0) 
        begin
            case (ctrl_bus.LOAD_SELECT)
                LOAD_REG_A: data_bus.data_out <= register_file[REG_A];
                LOAD_REG_B: data_bus.data_out <= register_file[REG_B];
                LOAD_REG_C: data_bus.data_out <= register_file[REG_C];
                default: ;
            endcase
        end
    end

endmodule