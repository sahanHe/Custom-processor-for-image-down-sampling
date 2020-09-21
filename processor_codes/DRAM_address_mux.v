module DRAM_address_mux(output wire [15:0] outputmux,
									input wire [15:0] inputmux1,
									input wire [15:0] inputmux2,
									input wire start_Tx,
									input wire Rx_done);


assign outputmux = start_Tx ? (Rx_done ? inputmux2 : inputmux2) : (Rx_done ? inputmux1 : inputmux2);



endmodule