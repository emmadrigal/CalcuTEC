`timescale 1ns / 1ps


module registersTest;

	// Inputs
	reg clk;
	reg reg_write;
	reg [3:0] dirA;
	reg [3:0] dirB;
	reg [3:0] dir_WR;
	reg [31:0] data_in;

	// Outputs
	wire [31:0] datA;
	wire [31:0] datB;

	// Instantiate the Unit Under Test (UUT)
	Registers uut (
		.clk(clk), 
		.reg_write(reg_write), 
		.dirA(dirA), 
		.dirB(dirB), 
		.dir_WR(dir_WR), 
		.data_in(data_in), 
		.datA(datA), 
		.datB(datB)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reg_write = 0;
		dirA = 0;
		dirB = 0;
		dir_WR = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5; clk = 1; reg_write = 1; dir_WR = 0; data_in = 1;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 1; data_in = 12;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 2; data_in = 123;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 3; data_in = 1234;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 4; data_in = 2345;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 5; data_in = 3456;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 6; data_in = 4567;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 7; data_in = 5678;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 8; data_in = 6789;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 9; data_in = 12345;
		#5; clk = 0;
		#5; clk = 1; reg_write = 1; dir_WR = 10; data_in = 23456;
		#5; clk = 0;
		
		#5; clk = 1; dirA = 0; dirB = 1;
		#5; clk = 0;
		#5; clk = 1; dirA = 2; dirB = 3;
		#5; clk = 0;
		#5; clk = 1; dirA = 4; dirB = 5;
		#5; clk = 0;
		#5; clk = 1; dirA = 6; dirB = 7;
		#5; clk = 0;
		#5; clk = 1; dirA = 8; dirB = 9;
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

