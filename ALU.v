`timescale 1ns / 1ps

module ALU(
	input [31:0] dat1,
	input [31:0] dat2,
	input [3:0] control,

	output Z,
	output N, //Only the negative flag is implemented
	output C,
	output V,
	output [31:0] result
);

/*
0 : add
1: sub
2: mul
3: or
4: lsl
5: lsr
6:
7:
*/

always @* begin
	case(control)
		0 : begin
			result <= dat1 + dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		1 : begin
			result <= dat1 - dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		2 : begin
			result <= dat1 * dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		3 : begin
			result <= dat1 | dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		4 : begin
			result <= dat1 << dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		5 : begin
			result <= dat1 >> dat2;
			N <= (result[31] == 1) ? 1: 0;
		end
		default : result <= -1;
	endcase;
end


endmodule
