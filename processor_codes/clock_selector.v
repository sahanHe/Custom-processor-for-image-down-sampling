module clock_selector(input clk_in,
							input clock_select,
							output wire clk_out);

wire c0;
wire c1;

clock25Mhz fast_clock(.inclk0(clk_in), .c0(c0));
slow_clock slow_clock(.clkin(clk_in), .clkout(c1));

assign clk_out = clock_select? c0:c1;

endmodule