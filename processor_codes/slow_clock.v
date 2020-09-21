module slow_clock(clkin,clkout);

reg [24:0] counter;
output reg clkout;
input clkin;

initial begin
    counter = 0;
    clkout = 0;
end

always @(posedge clkin) begin
    if (counter == 0) begin
        //counter <= 24999999;
		  //counter <= 12000000;
		  counter <= 10;
        clkout <= ~clkout;
    end else begin
        counter <= counter - 25'd1;
    end
end
endmodule
