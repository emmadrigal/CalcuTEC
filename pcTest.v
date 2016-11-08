`timescale 1ns / 1ps

module pcTest;

	// Inputs
	reg clk;
	reg [31:0] dir_in;

	// Outputs
	wire [31:0] dir_out;

	// Instantiate the Unit Under Test (UUT)
	PC_register uut (
		.clk(clk), 
		.dir_in(dir_in), 
		.dir_out(dir_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		dir_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10; clk = 0; dir_in = 234;
		#10; clk = 1; dir_in = 434;
		#10; clk = 0; dir_in = 122;
		#10; clk = 1; dir_in = 102;
		#10; clk = 0; dir_in = 345;
		#10; clk = 1; dir_in = 233;
		#10; clk = 0; dir_in = 111;
		#10; clk = 1; dir_in = 567;
		#10; clk = 0; dir_in = 234;
		#10; clk = 1; dir_in = 111;
		#10; clk = 0; dir_in = 567;
		#10; clk = 1; dir_in = 999;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		

	end
      
endmodule

