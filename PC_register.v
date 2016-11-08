`timescale 1ns / 1ps

module PC_register(
	input clk,
	input [31:0] dir_in,
	output reg [31:0] dir_out
);
	 
reg [31:0] PC;
	 
always @(posedge clk) begin 
	dir_out = PC;
end

always @(negedge clk) begin 
	PC = dir_in;
end


endmodule
