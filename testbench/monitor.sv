class Monitor;
    virtual control_bus_if bus_if;
    mailbox #(Transaction) mon2scb;

    function new(virtual control_bus_if bus, mailbox #(Transaction) mbox);
        this.bus_if = bus;
        this.mon2scb = mbox;
    endfunction

    task run();
        forever begin
            Transaction trans = new();
            trans.result = bus_if.FLAGS;
            mon2scb.put(trans);
        end
    endtask
endclass
