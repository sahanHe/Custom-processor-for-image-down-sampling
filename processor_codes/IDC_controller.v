module IDC_controller(input [1:0] IDC_control,
						 input wire [15:0] instruction,
						 output reg [7:0] IDC_control_RRR,
						 output reg [7:0] IDC_control_RWR,
						 output reg [7:0] IDC_control_CRR,
						 output reg [7:0] IDC_control_CWR,
						 input clock);

reg [3:0] IDC_register;
		 
always@(instruction)
begin
	IDC_register <= instruction[11:8];
end
						
always@(posedge clock)
begin
	case(IDC_control)
	2'b00:
		begin
			IDC_control_RRR <= IDC_control_RRR; 
			IDC_control_RWR <= IDC_control_RWR;
			IDC_control_CRR <= IDC_control_CRR;
			IDC_control_CWR <= IDC_control_CWR;
		end
	2'b01:
		begin
			case(IDC_register)
			4'b1001:
				begin
					IDC_control_RRR <= IDC_control_RRR + 8'd1; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1010:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR + 8'd1;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1011:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR + 8'd1;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1100:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR + 8'd1;
				end
			default:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			endcase
		end
	2'b10:
		begin
			case(IDC_register)
			4'b1001:
				begin
					IDC_control_RRR <= IDC_control_RRR - 8'd1; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1010:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR - 8'd1;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1011:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR - 8'd1;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1100:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR - 8'd1;
				end
			default:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			endcase
		end
	2'b11:
		begin
			case(IDC_register)
			4'b1001:
				begin
					IDC_control_RRR <= 8'b0; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1010:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= 8'b0;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1011:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= 8'b0;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			4'b1100:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= 8'b0;
				end
			default:
				begin
					IDC_control_RRR <= IDC_control_RRR; 
					IDC_control_RWR <= IDC_control_RWR;
					IDC_control_CRR <= IDC_control_CRR;
					IDC_control_CWR <= IDC_control_CWR;
				end
			endcase
		end
	default:
		begin
			IDC_control_RRR <= IDC_control_RRR; 
			IDC_control_RWR <= IDC_control_RWR;
			IDC_control_CRR <= IDC_control_CRR;
			IDC_control_CWR <= IDC_control_CWR;
		end
	endcase
end		
		
endmodule