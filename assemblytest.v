`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:41:41 11/13/2016
// Design Name:   Ensamblador
// Module Name:   C:/Users/emmam/Documents/CalcuTEC/assemblytest.v
// Project Name:  CalcuTEC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Ensamblador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module assemblytest;

	// Inputs
	reg clk;
	reg [31:0] datoA;
	reg [31:0] datoB;
	reg [2:0] operacion;
	reg start;

	// Outputs
	wire [31:0] resultado;
	wire ready;
	wire error;

	// Instantiate the Unit Under Test (UUT)
	Ensamblador uut (
		.clk(clk),
		.datoA(datoA), 
		.datoB(datoB), 
		.operacion(operacion), 
		.start(start), 
		.resultado(resultado), 
		.ready(ready), 
		.error(error)
	);

	initial begin
		// Initialize Inputs
		datoA = 0;
		datoB = 0;
		operacion = 0;
		start = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10; datoA = 10; datoB = 5; operacion = 0; start = 0;
		#10; start = 1; 
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;start = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;  
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; datoA = 15; datoB = 5; operacion = 2; start = 0;
		#5; start = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#10; datoA = 60; datoB = 45; operacion = 1; start = 0;
		#10; start = 1; 
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;start = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;  
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;
		#5; clk = 0;
		#5; clk = 1;

	end
      
endmodule

