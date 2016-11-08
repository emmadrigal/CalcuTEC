`timescale 1ns / 1ps

module memTest;

	// Inputs
	reg clk;
	reg [7:0]  address;
	reg [31:0]  data;
	reg we;
	reg [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Memory uut (
		.clk(clk), 
		.address(address), 
		.data(data), 
		.we(we), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		address = 0;
		data = 0;
		we = 0;
		data_out = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
        
		// Add stimulus here
		#10; clk = 1; address = 0; data = 1; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 1; data = 10; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 2; data = 100; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 3; data = 1000; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 4; data = 10000; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 5; data = 100000; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 6; data = 1000000; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 7; data = 10000000; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 0; data = 0; we = 0; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 5; data = 102; we = 1; data_out = 0;
		#10; clk = 0;
		#10; clk = 1; address = 0; data = 0; we = 0; data_out = 0;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1; address = 5; data = 0; we = 0; data_out = 0;
		#10; clk = 0;
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

	end
      
endmodule

