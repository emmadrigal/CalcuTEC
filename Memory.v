`timescale 1ns / 1ps

module Memory(
	input clk         , // Clock Input
	address     , // Address Input
	data        , // Data
	input we          , // Write Enable
	data_out     // Output Enable
);


parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//Address Ports
input [ADDR_WIDTH-1:0] address;

//Data Ports
input [DATA_WIDTH-1:0]  data;
output [DATA_WIDTH-1:0] data_out;

//Variables
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];



// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (posedge clk) begin
	if (we)
		mem[address] = data;
end

// Memory Read Block 
always @ (negedge clk) begin
	data_out = mem[address];
end

endmodule // End of Module ram_sp_sr_sw