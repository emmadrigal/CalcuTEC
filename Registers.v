`timescale 1ns / 1ps

module Registers(
input clk,
input reg_write,
input [3:0] dirA,
input [3:0] dirB,
input [3:0] dir_WR,
input [31:0] data_in,

output [31:0] datA,
output [31:0] datB
    );
	 
//Local variables
reg [32:0] regs [0:3];
	 
always @(posedge clk) begin 
		datA = regs[dirA];
		datB = regs[dirB];
end

always @(negedge clk) begin 
	if(reg_write) begin
		regs[dir_WR] = data;
	end
end


endmodule
