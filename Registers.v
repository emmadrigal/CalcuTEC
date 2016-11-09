`timescale 1ns / 1ps

module Registers(
input clk,
input reg_write,
input [3:0] dirA,
input [3:0] dirB,
input [3:0] dir_WR,
input [31:0] data_in,

output wire [31:0] datA,
output wire [31:0] datB
    );
	 
//Local variables
reg [32:0] regs [0:15];
	 
assign datA = regs[dirA];
assign datB = regs[dirB];

always @(negedge clk) begin 
	if(reg_write)
		regs[dir_WR] = data_in;
end


endmodule
