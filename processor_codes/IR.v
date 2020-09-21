module IR(input clock,
			input wire [15:0] IRAM_data,
			output reg [15:0] instruction,
			//output wire [3:0] source_register,
			//output wire [2:0] destination_register,
			//output wire [3:0] multiply_divide_constant,
			//output wire [11:0] load_constant,
			//output wire [3:0] jump_condition,
			//output wire [7:0] jump_address,
			input wire load_instruction);

//assign source_register = instruction[11:8];
//assign destination_register = instruction[2:0];
//assign multiply_divide_constant = instruction[11:8];
//assign load_constant = instruction[11:0];
//assign jump_condition = instruction[11:8];
//assign jump_address = instruction[7:0];

initial
begin
instruction=16'b0;
end	
						
always @(posedge load_instruction)
begin
instruction=IRAM_data;
end

endmodule