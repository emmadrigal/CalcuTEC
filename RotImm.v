`timescale 1ns / 1ps

module RotImm(
	input [23:0]  immediate,
	input [1:0]   imm_src,
	output [32:0] data
    );

wire [3:0] rot;
assign rot  = 2*immediate[11:8];

wire leftExt = rot - 8;
wire rightExt = 32 - rot;

/*
0: inmediato para procesamiento de datos
1: inmediato para llamadas a memoria
2: inmediato para branches
*/

always @*
case(imm_src)
	0 			: begin//Rotation for data processing
		if(rot > 6) begin
			data = {{leftExt{0}}, immediate[7:0], {rightExt{0}}};
		end
		else begin
			data = {immediate[rot:0], {22{0}}, immediate[8:rot]};
		end
	end
	1 			: data = {{20{0}} ,immediate[11:8]}; //Extention for memory
	2 			: data = {{6{immediate[23]}} ,immediate, {2{0}}}; //Extention for branch
	default  : data= -1;
endcase

endmodule
