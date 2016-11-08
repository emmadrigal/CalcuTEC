`timescale 1ns / 1ps

module muxtest;

	// Inputs
	reg port_select;
	reg [31:0] dat1;
	reg [31:0] dat2;

	// Outputs
	wire [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Mux2x1 uut (
		.port_select(port_select), 
		.dat1(dat1), 
		.dat2(dat2), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		port_select = 0;
		dat1 = 0;
		dat2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10; dat1 = 123; dat2 = 987;
		#50; port_select = 0; 
		#50; port_select = 1;
		#50; port_select = 0;
		#50; port_select = 1;
		#10; dat1 = 445; dat2 = 222;
		#50; port_select = 0;

	end
      
endmodule

