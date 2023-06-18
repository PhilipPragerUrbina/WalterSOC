// Variant of BRAM that has two ports, one for reading and one for writing with different clocks
module DualPortBRAM # (
    parameter DEPTH = 256, //How many pieces of data
    parameter DATA_WIDTH = 8, //How many bits in each piece of data
    localparam ADDRESS_WIDTH = $clog2(DEPTH), //How many bits in the address
    parameter logic[ADDRESS_WIDTH-1:0] INITITIAL_VALUE = 8'h0020 //Initial value each piece of data is set to
    )
    (
        input logic clk_read, //Clock. This ram is synchronous, so there is one clock cycle of latency.
        input logic [ADDRESS_WIDTH-1:0] address_read, //Address to read from
        output logic [DATA_WIDTH-1:0] read_data, //Data read from the address(1 clock cycle delayed)

        input logic clk_write, //Clock. This ram is synchronous, so there is one clock cycle of latency.
        input logic [ADDRESS_WIDTH-1:0] address_write, //Address to write to
        input logic [DATA_WIDTH-1:0] write_data, //Data to write(1 clock cycle delayed until actually written)
        input logic write_enable //Write enable
    );
    logic [DATA_WIDTH-1:0] memory [DEPTH-1:0]; 

    initial begin
        integer i;
        for(i=0; i < DEPTH; i=i+1) begin
            memory[i] = INITITIAL_VALUE;
        end
        memory[0] = 8'h0048;//h
        memory[1] = 8'h0065;//e
        memory[2] = 8'h006c;//l
        memory[3] = 8'h006c;//l
        memory[4] = 8'h006f;//o
        memory[5] = 8'h0020;//space
        memory[6] = 8'h0057;//W
        memory[7] = 8'h006f;//o
        memory[8] = 8'h0072;//r
        memory[9] = 8'h006c;//l
        memory[10] = 8'h0064;//d
        memory[11] = 8'h0021;//!
        //todo remove
    end

    always_ff @(posedge clk_write) begin
        if(write_enable) begin
            memory[address_write] <= write_data;
        end
    end

    always_ff @(posedge clk_read) begin
        read_data <= memory[address_read];
    end
endmodule