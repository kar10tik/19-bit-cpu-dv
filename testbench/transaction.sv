class Transaction;
    rand logic clk;
    rand logic reset;
    rand logic [4:0] opcode;
    rand logic [DATA_WIDTH-1:0] operand1, operand2;
    logic [DATA_WIDTH-1:0] result;
    
    function void display();
        $display("Opcode: %b | Operand1: %d | Operand2: %d | Result: %d",
                 opcode, operand1, operand2, result);
    endfunction
endclass
