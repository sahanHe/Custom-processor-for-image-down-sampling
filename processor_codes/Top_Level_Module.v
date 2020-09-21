module Top_Level_Module(input clk_in,
								//output wire [7:0] LED,
								//output wire [7:0] AC_LED,
								output [7:0] address_LED,
								output [7:0] data_LED,
								output [6:0] dout1,
								output [6:0] dout2,
								output [6:0] AC_0,
								output [6:0] AC_1,
								output [6:0] AC_2,
								//input start,
								//input clock_select,
								input Rx,
								output Tx,
								output start_Tx_indicator,
								//input select_DRAM_address,
								output Rx_indicator,
								output Tx_done,
								input clear_switch);
								
wire [7:0] IRAM_address;
wire [15:0] IRAM_to_processor;
wire [15:0] DRAM_address;
wire [7:0] DRAM_write_data;
wire write_DRAM;
wire [7:0] DRAM_read_data;
wire clk_out;
wire [15:0] DRAM_address_processor;
wire [7:0] DRAM_data_processor;
wire [7:0] DRAM_to_processor;
wire write_DRAM_processor;
wire enable_processor;
wire [7:0] DRAM_data_receiver;
//wire select_DRAM_write_data;
wire write_DRAM_receiver;
//wire select_DRAM_write_enable;
wire [7:0] DRAM_to_transmitter;
wire [15:0] DRAM_address_receiver;
wire [5:0] state_7seg;
wire [7:0] AC_LED;
wire Rx_done;
assign Rx_indicator = Rx_done;
assign address_LED = DRAM_address_receiver[15:8];
assign data_LED = DRAM_read_data;
wire start_Tx;
assign start_Tx_indicator = start_Tx;
								
IRAM IRAM(.address(IRAM_address),
		.clock(clk_in),
		.q(IRAM_to_processor));
		
DRAM DRAM(.address(DRAM_address),
		.clock(clk_in),
		.data(DRAM_write_data),
		.wren(write_DRAM),
		.q(DRAM_read_data));
		
Processor Processor(.IRAM_address(IRAM_address),
						  .IRAM_data(IRAM_to_processor),
						  .clock(clk_out),
						  .DRAM_address_processor(DRAM_address_processor),
						  .DRAM_output_data(DRAM_data_processor),
						  .DRAM_input_data(DRAM_to_processor),
						  .write_DRAM(write_DRAM_processor),
						  .enable_processor(Rx_done),
						  .start_Tx(start_Tx),
						  .LED(state_7seg),
						  .AC_LED(AC_LED));
						  
transceiver transceiver(.Rx(Rx),
								.Tx(Tx),
								.start_Tx(start_Tx),
								.clk(clk_in),
								.data_in(DRAM_to_transmitter),
								.data_out(DRAM_data_receiver),
								.ready(write_DRAM_receiver),
								.D_address(DRAM_address_receiver),
								.Rx_done(Rx_done),
								//.LEDR,
								//.LEDG,
								.Tx_done(Tx_done),
								.clear(clear_switch));
						  
DRAM_write_data_mux DRAM_write_data_mux(.outputmux(DRAM_write_data),
													 .inputmux1(DRAM_data_processor),
													 .inputmux2(DRAM_data_receiver),
													 .select(Rx_done));
													 
DRAM_write_enable_mux DRAM_write_enable_mux(.outputmux(write_DRAM),
													 .inputmux1(write_DRAM_processor),
													 .inputmux2(write_DRAM_receiver),
													 .select(Rx_done));
													 
DRAM_read_data_splitter DRAM_read_data_splitter(.output1(DRAM_to_processor),
													  .output2(DRAM_to_transmitter),
													  .inputsplitter(DRAM_read_data));
													
DRAM_address_mux DRAM_address_mux(.outputmux(DRAM_address),
											.inputmux1(DRAM_address_processor),
											.inputmux2(DRAM_address_receiver),
											.Rx_done(Rx_done),
											.start_Tx(start_Tx));
											
clock_selector clock_selector(.clk_in(clk_in),
										.clock_select(0),
										.clk_out(clk_out));
											
//UART_Transceiver UART_Transceiver(.data_in(DRAM_to_transmitter),
											 //.start_transmit(),
											 //.clk(clk_in),
											 //.Tx(Tx),
											 //.RX(Rx));
											 
											 
state_to_7seg state_to_7seg(.bin(state_7seg),
									 .dout1(dout1),
									 .dout2(dout2));	

AC_to_7seg AC_to_7seg(.din(AC_LED),
					   .dout2(AC_2),
						.dout1(AC_1),
						.dout0(AC_0));									 
													  
endmodule