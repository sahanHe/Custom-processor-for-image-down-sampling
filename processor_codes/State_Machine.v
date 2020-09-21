module statemachine(input [15:0] instruction,
							input clock,
							input enable_processor,
							//output reg inc_pc,
							output reg load_instruction,
							output reg [3:0] ALU_control,
							output reg [3:0] select_source,
							output reg [2:0] select_destination,
							//input [3:0] source_register,
							//input [2:0] destination_register,
							output reg [1:0] IDC_control,
							output reg [1:0] MDR_control,
							output reg [1:0] MAR_control,
							output reg [1:0] PC_control,
							//output reg jump_enable,
							output reg write_DRAM,
							output reg start_Tx,
							output wire [5:0] LED);
		
							
reg [7:0] state;
assign LED = state[5:0];
reg [3:0] source_register;
reg [2:0] destination_register;
reg [3:0] opcode;

initial
begin
	state = 8'b00010000; //start
end

always@(instruction)
begin
	opcode = instruction[15:12];
	source_register = instruction[11:8];
	destination_register = instruction[2:0];
end

always@(negedge clock)
begin
	case(state)
		8'b00010000: //start
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				if (enable_processor)
				begin
					state <= 8'b00010001; //fetch1
				end
				else
				begin
					state <= 8'b00010000; //start
				end
			end
			
		8'b00010001: //fetch1
			begin
				load_instruction <= 1;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010010; //fetch2
			end
			
		8'b00010010: //fetch2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b01;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= {4'b0000, opcode}; //loaded instruction
			end
			
		8'b00000101: //add1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= source_register;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010011; //add2
			end
		
		8'b00010011: //add2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0001;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000110: //sub1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= source_register;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010100; //add2
			end
		
		8'b00010100: //sub2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0010;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000111: //mul1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b1011;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010101; //mul2
			end
			
		8'b00010101: //mul2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0011;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001000: //div1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b1011;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010110; //div2
			end
			
		8'b00010110: //div2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0100;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000011: //copy
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= source_register;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010111; //copy2
			end
			
		8'b00010111: //copy2
			begin
				load_instruction <= 0;
				if (destination_register == 3'b001)
					ALU_control <= 4'b0101;
				else
					ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				if (destination_register == 3'b001)
					select_destination <= 3'b000;
				else
					select_destination <= destination_register;
				if (destination_register == 3'b101)
					MDR_control <= 2'b10;
				else
					MDR_control <= 2'b00;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001100: //loadk
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0110;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000100: //jump
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b10;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001010: //inc
			begin
				load_instruction <= 0;
				if (source_register == 4'b0001)
					ALU_control <= 4'b0111;
				else
					ALU_control <= 4'b0000;
				if (source_register == 4'b0001)
					IDC_control <= 2'b00;
				else	
					IDC_control <= 2'b01;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001011: //dec
			begin
				load_instruction <= 0;
				if (source_register == 4'b0001)
					ALU_control <= 4'b1000;
				else
					ALU_control <= 4'b0000;
				if (source_register == 4'b0001)
					IDC_control <= 2'b00;
				else	
					IDC_control <= 2'b10;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001001: //clr
			begin
				load_instruction <= 0;
				if (source_register == 4'b0001)
					ALU_control <= 4'b1001;
				else
					ALU_control <= 4'b0000;
				if (source_register == 4'b0001)
					IDC_control <= 2'b00;
				else	
					IDC_control <= 2'b11;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000001: //load1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				if (source_register == 4'b0001)
					MAR_control <= 2'b01;
				else if (source_register == 4'b0010)	
					MAR_control <= 2'b10;
				else
					MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00011000; //load2
			end
			
		8'b00011000: //load2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b01;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00000010: //store1
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				if (source_register == 4'b0001)
					MAR_control <= 2'b01;
				else if (source_register == 4'b0010)	
					MAR_control <= 2'b11;
				else
					MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 0;
				state <= 8'b00011001; //store2
			end
			
		8'b00011001: //store2
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 1;
				start_Tx <= 0;
				state <= 8'b00010001; //fetch1
			end
			
		8'b00001111: //end
			begin
				load_instruction <= 0;
				ALU_control <= 4'b0000;
				select_source <= 4'b0000;
				select_destination <= 3'b000;
				PC_control <= 2'b00;
				IDC_control <= 2'b00;
				MDR_control <= 2'b00;
				MAR_control <= 2'b00;
				write_DRAM <= 0;
				start_Tx <= 1;
				state <= 8'b00001111; //noop
			end
			
		default: state <= 8'b00010000;
      endcase
	end
endmodule