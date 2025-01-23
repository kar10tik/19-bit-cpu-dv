module external_memory(input CLK, WR_EN, ADDRESS, WR_DATA, output MEM_OUT);
    parameter DATA_SIZE; //DATA_SIZE decides the smallest chunk of memory accessed. 
    // For instruction memory DATA_SIZE = 19, for data memory DATA_SIZE = 38
    bit memory[unsigned int];
    bit WR_EN;
    logic [DATA_SIZE-1:0] WR_DATA, MEM_OUT;
    logic [11:0] ADDRESS;
    always@(posedge CLK)
    begin
        if (WR_EN == 1) begin
            memory[ADDRESS] = WR_DATA;
        end
        
        else if (we_DM == 0) begin
            MEM_OUT = memory[ADDRESS];
        end
    end
    
endmodule