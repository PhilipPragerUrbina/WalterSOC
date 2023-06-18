//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.8.11 Education
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Sat Jun 17 08:27:49 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	DVIOut your_instance_name(
		.I_rst_n(I_rst_n_i), //input I_rst_n
		.I_rgb_clk(I_rgb_clk_i), //input I_rgb_clk
		.I_rgb_vs(I_rgb_vs_i), //input I_rgb_vs
		.I_rgb_hs(I_rgb_hs_i), //input I_rgb_hs
		.I_rgb_de(I_rgb_de_i), //input I_rgb_de
		.I_rgb_r(I_rgb_r_i), //input [7:0] I_rgb_r
		.I_rgb_g(I_rgb_g_i), //input [7:0] I_rgb_g
		.I_rgb_b(I_rgb_b_i), //input [7:0] I_rgb_b
		.O_tmds_clk_p(O_tmds_clk_p_o), //output O_tmds_clk_p
		.O_tmds_clk_n(O_tmds_clk_n_o), //output O_tmds_clk_n
		.O_tmds_data_p(O_tmds_data_p_o), //output [2:0] O_tmds_data_p
		.O_tmds_data_n(O_tmds_data_n_o) //output [2:0] O_tmds_data_n
	);

//--------Copy end-------------------
