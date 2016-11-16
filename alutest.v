`timescale 1ns / 1ps


module alutest;

	// Inputs
	reg [31:0] dat1;
	reg [31:0] dat2;
	reg [3:0] control;
	reg set;

	// Outputs
	wire Z;
	wire N;
	wire C;
	wire V;
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.dat1(dat1), 
		.dat2(dat2), 
		.control(control), 
		.set(set), 
		.Z(Z), 
		.N(N), 
		.C(C), 
		.V(V), 
		.result(result)
	);
	
	/*
0 : add
1: sub
2: mul
3: or
4: lsl
5: lsr
*/

	initial begin
		// Initialize Inputs
		dat1 = 0;
		dat2 = 0;
		control = 0;
		set = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#10; dat1 = 4; dat2 = 4; control = 0;
		#10; dat1 = 4; dat2 = 4; control = 1;
		#10; dat1 = 4; dat2 = 4; control = 2;
		#10; dat1 = 4; dat2 = 0; control = 3;
		#10; dat1 = 256; dat2 = 4; control = 4;
		#10; dat1 = 256; dat2 = 4; control = 5;
        
		// Add stimulus here

	end
      
endmodule

