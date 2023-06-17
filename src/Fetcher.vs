
module Fetcher # (
    parameter program_size = 254
  ) (
    input logic clk,
    input logic rst,
    input logic [7:0] pc,
    output logic [7:0] opcode,
    output logic [7:0] operand1,
    output logic [7:0] operand2,
    output logic [7:0] operand3

  );
  logic [31:0] instructions [program_size];

  
  initial begin
    $readmemh("./test/test_programs/simple.pootis.hex", instructions); //todo get to work
  end
  //todo enum
  //todo documentation

  always_ff @(posedge clk)
  begin
    if (rst)
    begin
      opcode <= 8'b00010010; //nop
      operand1 <= 0;
      operand2 <= 0;
      operand3 <= 0;
    end
    else
    begin
      opcode <= instructions[pc][31:24];
      operand1 <= instructions[pc][23:16];
      operand2 <= instructions[pc][15:8];
      operand3 <= instructions[pc][7:0];
    end
  end

endmodule
