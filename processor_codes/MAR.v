module MAR(input [15:0] AC_to_MAR,
			  input [7:0] RRR_in,
			  input [7:0] CRR_in,
			  input [7:0] RWR_in,
			  input [7:0] CWR_in,
			  output wire [15:0] MAR_to_DRAM,
			  input clock,
			  input [1:0] MAR_control);
			  
reg [15:0] MAR;
assign MAR_to_DRAM = MAR;
//reg [15:0] MAR_temp;
//assign MAR_to_DRAM = MAR + 17'd2;
			  
always@(posedge clock)
begin
	case(MAR_control)
	2'b00:
		begin
			MAR <= MAR;
		end
	2'b01:
		begin
			//MAR_temp = AC_to_MAR;
			//MAR = {1'b0,MAR_temp};
			MAR <= AC_to_MAR;
		end
	2'b10:
		begin
			//MAR_temp = {RRR_in,CRR_in};
			//MAR = {1'b0,MAR_temp};
			MAR <= {RRR_in,CRR_in};
		end
	2'b11:
		begin
			//MAR_temp = {RWR_in,CWR_in};
			//MAR = {1'b0,MAR_temp};
			MAR <= {RWR_in,CWR_in};
		end
	default:
		begin
			MAR <= MAR;
		end
	endcase
end
			  			  
endmodule

