`timescale 1ns / 1ps

module PC_register(
	input clk,
	input reset,
	input [31:0] dir_in,
	output reg [31:0] dir_out
);
	 
reg [31:0] PC;


reg executing = 0;
wire start = reset ^ executing;
	 
always @(posedge clk) begin 
	if(start) begin
		PC = 0;
		executing = 1;
	end
	dir_out = PC;
end

always @(negedge clk) begin 
	PC = dir_in;
end


endmodule
