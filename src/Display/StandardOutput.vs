// Text output module
module StandardOutput # () 
(
    input wire logic dot_clk,
    input wire logic rst,

    output logic [7:0] out_red,
    output logic [7:0] out_green,
    output logic [7:0] out_blue,

    output logic hsync,
    output logic vsync,
    output logic out_de,

    output logic  [15:0] out_x,
    output logic  [15:0] out_y
 
);

logic frame_start;
logic line_start;

logic [3:0] red, green, blue;
logic de;
logic signed [15:0] x, y;

always_ff @(posedge dot_clk) begin
    out_x <= $unsigned(x);
    out_y <= $unsigned(y);
    out_de <= de;
    out_red <= {2{red}};  // double signal width from 4 to 8 bits
    out_green<= {2{green}};
    out_blue <= {2{blue}};
end


DisplayGenerator generator(
    .de,
    .dot_clk,
    .rst,
    .frame_start,
    .line_start,
    .hsync,
    .vsync,
    .x,
    .y
);
/* verilator lint_off PINMISSING */
TextRenderer renderer(
    .dot_clk,
    .blue,
    .red,
    .green,
    .data_enable(de),
    .new_frame(frame_start),
    .new_line(line_start)
);

endmodule
