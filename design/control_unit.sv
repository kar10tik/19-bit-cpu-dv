`include "constants.svh"
`include "opcodes.svh"

module control_unit(input CLK, control_bus_if ctrl_bus_if);
//EN, OPCODE, output MODE, LOAD_IR, LOAD_PC, INC_PC, WR_EN_DM);

   logic[1:0] current_state, next_state; //State variables
   logic load_regA, load_regB, load_regC, load_PC, load_IR, inc_PC, select_A, select_B; //Register load and MUX select
   localparam RESET_STATE = 2'b00, FETCH_STATE = 2'b01, DECODE_STATE = 2'10, EXECUTE_STATE = 2'b11; //CPU states

   always_ff @(posedge CLK) begin: state_logic
      if (!EN)
         current_state <= RESET_STATE;
      else
         current_state <= NEXT_STATE;
   end

   always_comb begin: output_logic
      if(!EN)
         begin
               load_regA = 0;
               load_regB = 0;
               load_regC = 0;
               load_IR = 0;
               load_PC = 0;
               select_A = 0;
               select_B = 0;
         end
      
      else
      begin
         case (current_state)
            RESET_STATE:   begin
               load_regA = 0;
               load_regB = 0;
               load_regC = 0;
               load_IR = 0;
               load_PC = 0;
               select_A = 0;
               select_B = 0;
			      loadIR = 0;
			      loadPC = 0;
			      inc_PC = 0;
			      mode = 1'bZ;
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


               endcase
            end

            EXECUTE_STATE: begin

            end

      end

   end


endmodule