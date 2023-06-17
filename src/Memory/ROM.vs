// Read only memory inferred to block ram or distributed ram
module ROM # (
    parameter INIT_FILE = "rom.hex", //File to initialize from
    parameter DEPTH = 256, //How many pieces of data
    parameter DATA_WIDTH = 8, //How many bits in each piece of data
    localparam ADDRESS_WIDTH = $clog2(DEPTH) //How many bits in the address
    )
    (
        input logic clk, //Clock. This ram is synchronous, so there is one clock cycle of latency.
        input logic [ADDRESS_WIDTH-1:0] address, //Address to read from
        output logic [DATA_WIDTH-1:0] data //Data read from the address(1 clock cycle delayed)
    );
    logic [DATA_WIDTH-1:0] memory [DEPTH-1:0]; 

    initial begin
        $readmemh(INIT_FILE, memory);
    end

    always_ff @(posedge clk) begin
        data <= memory[address];
    end
endmodule;