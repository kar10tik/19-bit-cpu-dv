class Scoreboard;
    mailbox #(Transaction) mon2scb;
    
    function new(mailbox #(Transaction) mbox);
        this.mon2scb = mbox;
    endfunction

    task run();
        forever begin
            Transaction trans;
            mon2scb.get(trans);
            trans.display();
            
            if (trans.result !== expected_result(trans))
                $display("Mismatch: Expected %d, Got %d", expected_result(trans), trans.result);
            else
                $display("PASS");
        end
    endtask

    function logic [DATA_WIDTH-1:0] expected_result(Transaction trans);
        case (trans.opcode)
            5'b00000: return ~trans.operand1;
            5'b00001: return trans.operand1 & trans.operand2;
            5'b00010: return trans.operand1 | trans.operand2;
            5'b00011: return trans.operand1 ^ trans.operand2;
            5'b00100: return trans.operand1 + trans.operand2;
            5'b00101: return trans.operand1 - trans.operand2;
            default:  return 0;
        endcase
    endfunction
endclass
