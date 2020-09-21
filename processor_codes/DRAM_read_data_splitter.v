module DRAM_read_data_splitter(output wire [7:0] output1,
								 output wire [7:0] output2,
								 input wire [7:0] inputsplitter);

assign output1 = inputsplitter;
assign output2 = inputsplitter;

endmodule