module transceiver(input wire Rx,
			  output wire Tx,
			  input wire start_Tx,
			  input wire clk,
			  input wire [7:0] data_in,
			  output wire [7:0] data_out,
			  output wire ready,
			  output wire [15:0] D_address,
			  output wire Rx_done,
			  output wire[15:0] LEDR,
			  output wire[7:0] LEDG,
			  output wire Tx_done,
			  input wire clear
			  );
wire tb;
wire wr_en;
reg en;
wire Rx_ready;

UART UART1(.data_in(data_in), //input data
			  .wr_en(wr_en), //enable tx
			  .clk(clk),
			  .Tx(Tx),
			  .Rx(Rx),
			  .Tx_busy(tb),
			  .Rx_ready(Rx_ready),//originally rx_ready
			  .data_out(data_out)
				);
reg busy;

reg status1;
reg status2;
reg status3;
reg [2:0] counter;
reg [2:0] counter2;
reg ready1;
reg ready2;
//wire ready;

reg[15:0] W_address;
reg [15:0]R_address;

assign D_address=status2?R_address:W_address;

assign Rx_done=status2;
assign wr_en=en;
assign LEDR=D_address;
assign LEDG=data_out;
assign ready=(~ready2) && ready1;
assign Tx_done=status3;
initial
begin
//full=0;
status1=0;
status2=0;
status3=0;
W_address=0;
R_address=0;
en=1;
counter=0;
counter2=0;
end

always@(posedge ready)//originally rx_ready
begin
if(~status1 && ~status2)
begin
counter=counter+1;
if(counter==2)
	status1=1;

end
else if(status1 && ~status2 && W_address<65535)
W_address=W_address+1;
if(W_address==65535)//5
		begin
		counter=counter+1;
		if(counter==4)
		begin
			status2=1;
			W_address=0;
		end
		end
		
end
always@(posedge clk)
begin
busy=tb;
ready1<=Rx_ready;
ready2<=ready1;
if(start_Tx && status2 && ~busy && R_address<65535 && counter2<2)
begin
en=0;
counter2=counter2+1;
end
else if(start_Tx && status2 && ~busy && R_address<65535 && counter2==2 )
begin
R_address=R_address+1;
en=0;
end
else if(R_address==65535 && status2 && ~busy)
	begin
	counter2=counter2+1;
		if (counter2==4)
		begin
			status3=1;
			en=1;
		end
	end

end
endmodule