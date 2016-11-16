`timescale 1ns / 1ps

module sumador(
input [31:0] A,
input [31:0] B,
output reg [31:0] resultado
    );
	 
	 
always @*
	resultado = A + B;


endmodule
