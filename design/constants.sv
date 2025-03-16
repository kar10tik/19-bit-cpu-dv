package constants;

localparam WORD_SIZE = 19; //Data and instruction sizes are 19 bits
localparam ADDR_SIZE = 20; //Address size in data memory is 20 bits
localparam OPCODE_SIZE = 5; //Opcodes are 5 bits wide
localparam FLAG_REG_SIZE = 4;

//Register load control signals for LOAD_SELECT
localparam LOAD_PC = 3'b000;
localparam LOAD_IR = 3'b001;
localparam LOAD_REG_A = 3'b010;
localparam LOAD_REG_B = 3'b011;
localparam LOAD_REG_C = 3'b100;

//Register file constants
localparam REG_A = 2'b00;
localparam REG_B = 2'b01;
localparam REG_C = 2'b10;

export constants::*;

endpackage: constants