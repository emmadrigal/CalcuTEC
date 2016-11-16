`timescale 1ns / 1ps

module immTest;

	// Inputs
	reg [23:0] immediate;
	reg [1:0] imm_src;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	RotImm uut (
		.immediate(immediate), 
		.imm_src(imm_src), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		immediate = 0;
		imm_src = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#50; immediate = 24'b111111111111111100010101;
		#50; immediate = 24'b111111111111000000010101;
		#50; immediate = 24'b111111111111000100010101;
		#50; immediate = 24'b111111111111001000010101;
		#50; immediate = 24'b111111111111010000010101;
		#50; immediate = 24'b111111111111100000010101;
		
		#50; immediate = 24'b111111111111100101010101; imm_src = 1;
		#50; immediate = 24'b111111111111100000010101;
		
		#50; immediate = 24'b111111111111100101010101; imm_src = 2;
		#50; immediate = 24'b011111111111100101010101;
		#50; immediate = 24'b010111111111100101010101;

	end
      
endmodule

