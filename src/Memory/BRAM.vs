// Memory inferred to block ram or distributed ram
module BRAM # (
    parameter DEPTH = 256, //How many pieces of data
    parameter DATA_WIDTH = 8, //How many bits in each piece of data
    localparam ADDRESS_WIDTH = $clog2(DEPTH), //How many bits in the address
    parameter logic[ADDRESS_WIDTH-1:0] INITIAL_VALUE = 0 //Initial value each piece of data is set to
    )
    (
        input logic clk, //Clock. This ram is synchronous, so there is one clock cycle of latency.
        input logic [ADDRESS_WIDTH-1:0] address_read, //Address to read from
        output logic [DATA_WIDTH-1:0] read_data, //Data read from the address(1 clock cycle delayed)

        input logic [ADDRESS_WIDTH-1:0] address_write, //Address to write to
        input logic [DATA_WIDTH-1:0] write_data, //Data to write(1 clock cycle delayed until actually written)
        input logic write_enable //Write enable
    );
    logic [DATA_WIDTH-1:0] memory [DEPTH-1:0]; 
    
    initial begin
        for(int i = 0; i < DEPTH; i++) begin
            memory[i] = INITIAL_VALUE;
        end
    end

    always_ff @(posedge clk) begin
        if(write_enable) begin
            memory[address_write] <= write_data;
        end
    end

    always_ff @(posedge clk) begin
        read_data <= memory[address_read];
    end
endmodule;