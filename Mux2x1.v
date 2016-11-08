`timescale 1ns / 1ps

module Mux2x1(
input port_select,
input [31:0] dat1,
input [31:0] dat2,
output reg [31:0] data_out
    );
	 
	 
always @* begin
	if(port_select)
		data_out = dat2;
	else
		data_out = dat1;
end


endmodule
