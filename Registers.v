`timescale 1ns / 1ps

module Registers(
input clk,
input reg_write,
input [3:0] dirA,
input [3:0] dirB,
input [3:0] dir_WR,
input [31:0] data_in,

output wire [31:0] datA,
output wire [31:0] datB,

output wire [31:0] resultadoFinal
    );
	 
	 
assign datA = regs[dirA];
assign datB = regs[dirB];
assign resultadoFinal = regs[15];

//Local variables
reg [31:0] regs [0:15];
	 

initial begin
	regs[0] = 0;
	regs[1] = 0;
	regs[2] = 0;
	regs[3] = 0;
	regs[4] = 0;
	regs[5] = 0;
	regs[6] = 0;
	regs[7] = 0;
	regs[8] = 0;
	regs[9] = 0;
	regs[10] = 0;
	regs[11] = 0;
	regs[12] = 0;
	regs[13] = 0;
	regs[14] = 0;
	regs[15] = 0;		
end

always @(negedge clk) begin 
	if(reg_write)
		regs[dir_WR] = data_in;
end


endmodule
