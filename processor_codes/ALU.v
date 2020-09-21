module ALU(input wire [15:0] B,
			  input wire [3:0] ALU_control,
			  input wire [15:0] instruction,
			  output wire [15:0] AC_out,
			  output wire [7:0] AC_LED,
			  output wire Z_out,
			  input wire clock);

reg [15:0] AC;
reg [11:0] load_constant;
reg Z;
assign AC_out = AC;
assign AC_LED = AC[7:0];
assign Z_out = Z;

initial
begin
AC = 16'b0;
end

always@(instruction)
begin
	load_constant = instruction[11:0];
end

always @(AC)
	begin
		if(AC==16'b0) 
			Z <= 1; 
		else 
			Z <= 0;
	end
			
always @(posedge clock)
begin
	case(ALU_control)
	4'b0000:
	begin
		AC <= AC;
	end
	4'b0001:
	begin
		AC <= AC+B;
	end
	4'b0010:
	begin
		AC <= AC-B;
		//if(AC>{4'd0,A_bus}) AC <= AC-{4'd0,A_bus};
		//					else                AC <= {4'd0,A_bus}-AC;
	end
	4'b0011:
	begin
		AC <= AC*B;
	end
	4'b0100:
	begin
		AC <= AC/B;
	end
	4'b0101:
	begin
		AC <= B;
	end
	4'b0110:
	begin
		AC <= {4'b0,load_constant};
	end
	4'b0111:
	begin
		AC <= AC + 16'd1;
	end
	4'b1000:
	begin
		AC <= AC - 16'd1;
	end
	4'b1001:
	begin
		AC <= 16'b0;
	end
	endcase
end

endmodule