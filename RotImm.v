`timescale 1ns / 1ps

module RotImm(
	input [23:0]  immediate,
	input [1:0]   imm_src,
	output reg [31:0] data
    );

wire [3:0] rot;
assign rot = immediate[11:8];

/*
0: inmediato para procesamiento de datos
1: inmediato para llamadas a memoria
2: inmediato para branches
*/

always @*
case(imm_src)
	0 			: begin//Rotation for data processing
		case(rot)
			0 : data = {24'b000000000000000000000000, immediate[7:0]};/**/
			1 : data = {immediate[1:0], 24'b000000000000000000000000, immediate[7:2]};
			2 : data = {immediate[3:0], 24'b000000000000000000000000, immediate[7:4]};
			3 : data = {immediate[5:0], 24'b000000000000000000000000, immediate[7:6]};
			4 : data = {immediate[7:0], 24'b000000000000000000000000};/**/
			5 : data = {2'b00,  immediate[7:0], 22'b0000000000000000000000};
			6 : data = {4'b0000,  immediate[7:0], 20'b00000000000000000000};
			7 : data = {6'b000000,  immediate[7:0], 18'b000000000000000000};
			8 : data = {8'b00000000,  immediate[7:0], 16'b0000000000000000};/**/
			9 : data = {10'b0000000000, immediate[7:0], 14'b00000000000000};
			10: data = {12'b000000000000, immediate[7:0], 12'b000000000000};
			11: data = {14'b00000000000000, immediate[7:0], 10'b0000000000};
			12: data = {16'b0000000000000000, immediate[7:0], 8'b00000000};/**/
			13: data = {18'b000000000000000000, immediate[7:0], 6'b000000};
			14: data = {20'b00000000000000000000, immediate[7:0], 4'b0000};
			default: data = {22'b0000000000000000000000, immediate[7:0], 2'b00};
		endcase
	end
	1 			: data = {20'b00000000000000000000 ,immediate[11:0]}; //Extention for memory
	2 			: data = {{8{immediate[23]}}, immediate}; //Extention for branch, No se alinea dado que la memoria los saltos son 1 en 1
	default  : data = -1;
endcase

endmodule
