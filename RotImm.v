`timescale 1ns / 1ps

module RotImm(
	input [12:0]  immediate,
	input [1:0]   imm_src,
	output [32:0] data
    );

wire [3:0] rot;
//assign [3:0] rot  = immediate[11:8] + immediate[11:8];

always @*
case(imm_src)
	0 			: data = {immediate[12:0],immediate[15:12]}; //Rotation for data processing
	1 			: data = 1; //Extention for memory
	2 			: data = 2; //Extention for branch
	default  : data= -1;
endcase

endmodule
