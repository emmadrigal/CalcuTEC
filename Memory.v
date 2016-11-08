`timescale 1ns / 1ps

module Memory(
	input clk         , // Clock Input
	input [7:0] address     , // Address Input
	input [31:0] data        , // Data
	input we          , // Write Enable
	output reg [31:0] data_out     // Output Enable
);

//Variables
reg [31:0] mem [0:7];


// Memory Read Block 
always @* begin
	data_out <= mem[address];
end

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (negedge clk) begin
	if (we)
		mem[address] <= data;
end


endmodule