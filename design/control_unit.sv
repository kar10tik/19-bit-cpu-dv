module control_unit(input CLK, control_bus_if.CU ctrl_bus_if);
//EN, OPCODE, output MODE, LOAD_IR, LOAD_PC, INC_PC, WR_EN_DM);
   import constants::*;
   import opcodes::*;
   
   typedef enum logic [1:0] {
        RESET = 2'b00,
        FETCH = 2'b01,
        DECODE = 2'b10,
        EXECUTE = 2'b11
    } state_t;

   state_t state, next_state;


   always_ff @(posedge CLK) begin: state_logic
      if (!EN)
         current_state <= RESET_STATE;
      else
         current_state <= NEXT_STATE;
   end

   always_comb begin: output_logic
      if(!EN)
         begin
               ctrl_bus_if.LOAD_REG = 0;
               ctrl_bus_if.LOAD_SELECT = LOAD_IR;
               ctrl_bus_if.INC_PC = 0;
               ctrl_bus_if.MUX_SELECT_A = 0;
               ctrl_bus_if.MUX_SELECT_B = 0;
         end
      
      else
      begin
         case (current_state)
            RESET_STATE:   begin
               ctrl_bus_if.LOAD_REG = 0;
               ctrl_bus_if.MUX_SELECT_A = 0;
               ctrl_bus_if.MUX_SELECT_B = 0;
			      ctrl_bus_if.inc_PC = 0;
			      ctrl_bus_if.MODE = 1'bZ;
			      we_DM = 0;
			      next_state = load;
            end

            
            FETCH_STATE: begin
               loadA = 0;
			      loadB = 0;
			      loadC = 0;
			      loadIR = 1;
			      loadPC = 1;
			      incPC = 0;
			      mode = 1'bZ;
			      we_DM = 0;
			      selA = 1'b0;
			      selB = 1'b0;
			      next_state = execute;
            end

            DECODE_STATE: begin
               case(ctrl_bus_if.OPCODE) 
                  NOT: begin

                  end

                  AND: begin

                  end

                  OR: begin

                  end

                  XOR: begin

                  end

                  ADD: begin

                  end

                  SUB: begin

                  end

                  INC: begin

                  end

                  DEC: begin

                  end
                  
               endcase
            end

            EXECUTE_STATE: begin

            end

      end

   end


endmodule