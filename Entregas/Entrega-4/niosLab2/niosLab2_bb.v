
module niosLab2 (
	clk_clk,
	leds_export,
	reset_reset_n,
	inputs_in_port,
	inputs_out_port);	

	input		clk_clk;
	output	[5:0]	leds_export;
	input		reset_reset_n;
	input	[5:0]	inputs_in_port;
	output	[5:0]	inputs_out_port;
endmodule
