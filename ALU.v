`timescale 1ns / 1ps

module ALU(
	input [31:0] dat1,
	input [31:0] dat2,
	input [3:0] control,
	
	input set,

	output reg Z,
	output reg N, 
	output reg C, //Not implemented
	output reg V, //Not implemented
	output reg [31:0] result
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
			result = dat1 + dat2;
		end
		1 : begin
			result = dat1 - dat2;
		end
		2 : begin
			result = dat1 * dat2;
		end
		3 : begin
			result = dat1 | dat2;
		end
		4 : begin
			result = dat1 << dat2;
		end
		5 : begin
			result = dat1 >> dat2;
		end
		default : result = -1;
	endcase;
	if(set) begin
		N = (result[31] == 1) ? 1: 0;
		Z = (result == 0) ? 1: 0;
	end
end


endmodule
