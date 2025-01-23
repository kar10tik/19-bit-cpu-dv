package opcodes;

    //LOGICAL OPERATORS
    localparam NOT = 5'b00000;
    localparam AND = 5'b00001;
    localparam OR = 5'b000010;
    localparam XOR = 5'b00011;

    //ARITHMETIC OPERATORS
    localparam ADD = 5'b00100;
    localparam SUB = 5'b00101;
    localparam MUL = 5'b00110;
    localparam DIV = 5'b00111;
    localparam INC = 5'b01000;
    localparam DEC = 5'b01001;

    //CONTROL FLOW INSTRUCTIONS
    localparam JMP  = 5'b01100;
    localparam BEQ  = 5'b01101;
    localparam BNE  = 5'b01110;
    localparam CALL = 5'b01111;
    localparam RET  = 5'b10000;

    //MEMORY ACCESS INSTRUCTIONS
    localparam LD = 5'b10001;
    localparam ST = 5'b10010;

    //SPECIALIZED INSTRUCTIONS
    localparam FFT = 5'b10011;
    localparam ENC = 5'b10100;
    localparam DCR = 5'b10101;
    
endpackage