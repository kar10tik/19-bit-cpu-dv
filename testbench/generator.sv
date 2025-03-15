class Generator;
    Transaction trans;
    mailbox #(Transaction) gen2drv;

    function new(mailbox #(Transaction) mbox);
        this.gen2drv = mbox;
    endfunction

    task run();
        repeat (10) begin
            trans = new();
            void'(trans.randomize());
            gen2drv.put(trans);
        end
    endtask
endclass
