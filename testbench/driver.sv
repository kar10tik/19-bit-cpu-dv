class Driver;
    virtual control_bus_if bus_if;
    mailbox #(Transaction) drv2mon;
    mailbox #(Transaction) gen2drv;

    function new(virtual control_bus_if bus, mailbox #(Transaction) mbox1, mailbox #(Transaction) mbox2);
        this.bus_if = bus;
        this.gen2drv = mbox1;
        this.drv2mon = mbox2;
    endfunction

    task run();
        forever begin
            Transaction trans;
            gen2drv.get(trans);
            
            // Apply inputs
            bus_if.OPCODE = trans.opcode;
            bus_if.ENABLE = 1;
            
            #10;
            
            // Capture result
            trans.result = bus_if.FLAGS;
            drv2mon.put(trans);
        end
    endtask
endclass
