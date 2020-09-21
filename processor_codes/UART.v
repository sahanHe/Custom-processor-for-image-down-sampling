module UART(input wire [7:0] data_in, //input data
				input wire wr_en, //enable tx
				input wire clk,
				output wire Tx,
				input wire Rx,
				output wire Tx_busy,
				output wire Rx_ready,
				output wire [7:0] data_out
				);		

wire Txclk_en, Rxclk_en;
wire Tx_en;
			
baudrate uart_baud(	.clk_50m(clk),
							.Rxclk_en(Rxclk_en),
							.Txclk_en(Txclk_en)
							);
transmitter uart_Tx(	.data_in(data_in),
							.wr_en(wr_en),
							.clk_50m(clk),
							.clken(Txclk_en), //We assign Tx clock to enable clock 
							.Tx(Tx),
							.Tx_busy(Tx_busy)
							);
receiver uart_Rx(	.Rx(Rx),
						.new_data_av(Rx_ready),
						.clk_50m(clk),
						.clken(Rxclk_en), //We assign Tx clock to enable clock 
						.data(data_out)
						);
endmodule