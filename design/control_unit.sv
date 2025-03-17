module control_unit(
   input logic CLK, 
   control_bus_if.CU ctrl_bus_if);

    import constants::*;
    import opcodes::*;

    // CPU states
    typedef enum logic [1:0] {
        RESET_STATE   = 2'b00,
        FETCH_STATE   = 2'b01,
        DECODE_STATE  = 2'b10,
        EXECUTE_STATE = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic with asynchronous reset
    always_ff @(posedge CLK or posedge ctrl_bus_if.RESET) begin
        if (ctrl_bus_if.RESET)
            current_state <= RESET_STATE;
        else
            current_state <= next_state;
    end

    // Control signal logic
    always_comb begin : output_logic
        // Default control signals
        ctrl_bus_if.LOAD_REG = 0;
        ctrl_bus_if.INC_PC = 0;
        ctrl_bus_if.WR_EN_DM = 0;
        ctrl_bus_if.RD_EN_DM = 0;
        ctrl_bus_if.WR_EN_IM = 0;
        ctrl_bus_if.RD_EN_IM = 0;
        ctrl_bus_if.LOAD_SELECT = 1'b0;
        ctrl_bus_if.MUX_SELECT_A = 0;
        ctrl_bus_if.MUX_SELECT_B = 0;
        ctrl_bus_if.MODE = 1'bZ;

        case (current_state)
            RESET_STATE: begin
                next_state = FETCH_STATE;
            end


            FETCH_STATE: begin
                ctrl_bus_if.LOAD_REG = 1;
                ctrl_bus_if.LOAD_SELECT = LOAD_IR; 
                ctrl_bus_if.INC_PC = 1; // Increment PC after fetch
                next_state = DECODE_STATE;
            end


            DECODE_STATE: begin
                case (ctrl_bus_if.OPCODE)
                    // Logical Instructions
                    NOT: begin
                        ctrl_bus_if.MODE = 1'b1; // ALU Logical Mode
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_REG_A; // Load into Register A
                        next_state = EXECUTE_STATE;
                    end

                    AND, OR, XOR: begin
                        ctrl_bus_if.MODE = 1'b1; // ALU Logical Mode
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_REG_B; // Load into Register B
                        next_state = EXECUTE_STATE;
                    end

                    // Arithmetic Instructions
                    ADD, SUB, INC, DEC: begin
                        ctrl_bus_if.MODE = 1'b0; // ALU Arithmetic Mode
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_REG_C; // Load into Register C
                        next_state = EXECUTE_STATE;
                    end

                    MUL, DIV: begin
                        ctrl_bus_if.MODE = 1'b0; // ALU Arithmetic Mode
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_REG_A; // Load into Register A
                        next_state = EXECUTE_STATE;
                    end

                    // Control Flow Instructions
                    JMP: begin
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_PC; // Load PC with new address
                        ctrl_bus_if.LOAD_PC = 1;
                        next_state = FETCH_STATE;
                    end

                    BEQ: begin
                        if (ctrl_bus_if.FLAGS[0]) begin // Zero flag
                            ctrl_bus_if.LOAD_REG = 1;
                            ctrl_bus_if.LOAD_SELECT = LOAD_PC;
                            ctrl_bus_if.LOAD_PC = 1;
                        end
                        next_state = FETCH_STATE;
                    end

                    BNE: begin
                        if (!ctrl_bus_if.FLAGS[0]) begin // Not Zero flag
                            ctrl_bus_if.LOAD_REG = 1;
                            ctrl_bus_if.LOAD_SELECT = LOAD_PC;
                            ctrl_bus_if.LOAD_PC = 1;
                        end
                        next_state = FETCH_STATE;
                    end

                    CALL: begin
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_PC;
                        ctrl_bus_if.LOAD_PC = 1;
                        next_state = FETCH_STATE;
                    end

                    RET: begin
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_PC;
                        ctrl_bus_if.LOAD_PC = 1;
                        next_state = FETCH_STATE;
                    end

                    // Memory Instructions
                    LD: begin
                        ctrl_bus_if.RD_EN_DM = 1;
                        ctrl_bus_if.LOAD_REG = 1;
                        ctrl_bus_if.LOAD_SELECT = LOAD_REG_A; // Load data into Register A
                        next_state = EXECUTE_STATE;
                    end

                    ST: begin
                        ctrl_bus_if.WR_EN = 1;
                        next_state = EXECUTE_STATE;
                    end

                    default: next_state = FETCH_STATE;
                endcase
            end


            EXECUTE_STATE: begin
                case (ctrl_bus_if.OPCODE)
                    NOT, AND, OR, XOR, ADD, SUB, INC, DEC, MUL, DIV: begin
                        ctrl_bus_if.LOAD_REG = 1;
                    end

                    LD, ST: begin
                        ctrl_bus_if.WR_EN = 0;
                        ctrl_bus_if.RD_EN_DM = 0;
                    end

                    default: ;
                endcase
                next_state = FETCH_STATE;
            end

        endcase
    end
endmodule
