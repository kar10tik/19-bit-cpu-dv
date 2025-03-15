module Testbench;
    control_bus_if bus_if();
    
    // Mailboxes
    mailbox #(Transaction) gen2drv = new();
    mailbox #(Transaction) drv2mon = new();
    mailbox #(Transaction) mon2scb = new();

    // Components
    Generator gen = new(gen2drv);
    Driver drv = new(bus_if, gen2drv, drv2mon);
    Monitor mon = new(bus_if, mon2scb);
    Scoreboard scb = new(mon2scb);

    initial begin
        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join
    end
endmodule
