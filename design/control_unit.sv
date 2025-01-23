module control_unit(input CLK, EN, OPCODE, output MODE, LOAD_IR, LOAD_PC, INC_PC, WR_EN_DM);

   localparam reset_state = 2'b00, load_state = 2'b01, execute_state = 2'b10;
   logic[1:0] current_state, next_state; logic [4:0] OPCODE;
   logic load_regA, load_regB, load_regC, load_PC, load_IR, select_A, select_B;

   always_ff @( posedge CLK ) begin : state_logic
      if (!EN)
         current_state <= reset_state;
      else
         current_state <= next_state;
   end

   always_comb begin : output_logic
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
         
      end

   end


endmodule