module GowinTop
(
    input             I_clk           , //27Mhz
    input             I_rst_n         ,
    output            O_tmds_clk_p    ,
    output            O_tmds_clk_n    ,
    output     [2:0]  O_tmds_data_p   ,//{r,g,b}
    output     [2:0]  O_tmds_data_n   
);

wire dot_clk;

Gowin_rPLL PLL (dot_clk,I_clk);

wire [7:0] r,g,b;
wire hysnc,vsync,de;
wire [15:0] x,y;

StandardOutput out
(
    .dot_clk,
    .rst(1'b0),
    .out_red(r),
    .out_blue(b),
    .out_green(g),
    .hsync,
    .vsync,
    .out_de(de),
    .out_x(x),
    .out_y(y)
);

DVIOut DVI(
	.I_rst_n,
	.I_rgb_clk(dot_clk),
	.I_rgb_vs(vsync),
	.I_rgb_hs(hsync),
	.I_rgb_de(de),
	.I_rgb_r(r),
	.I_rgb_g(g),
	.I_rgb_b(b),
	.O_tmds_clk_p,
	.O_tmds_clk_n,
	.O_tmds_data_p,
	.O_tmds_data_n
);



endmodule