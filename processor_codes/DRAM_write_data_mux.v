module DRAM_write_data_mux(output wire [7:0] outputmux,
									input wire [7:0] inputmux1,
									input wire [7:0] inputmux2,
									input wire select);
													 
assign outputmux = select ? inputmux1:inputmux2;

endmodule