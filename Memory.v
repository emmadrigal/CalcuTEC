`timescale 1ns / 1ps

module Memory(
	input clk         , // Clock Input
	input [4:0] address     , // Address Input
	input [31:0] data        , // Data
	input we          , // Write Enable
	
	
	output wire [31:0] data_out,     //Output data
	
	//Usado para escribir a la memoria de instrucciones antes de ejecutar una instrucción
	input write_ins,
	input [4:0] ins_address,
	input [31:0] ins
);

//Variables
reg [31:0] mem [0:31];

// Memory Read Block 
assign data_out = mem[address];

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (negedge clk) begin
	if (we)
		mem[address] <= data;
end

//Usado para escribir instrucciones
always @(posedge write_ins) begin
	mem[ins_address] <= ins;
end


endmodule