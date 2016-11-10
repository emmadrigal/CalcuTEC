`timescale 1ns / 1ps


module processorTest;

	// Inputs
	reg clk;
	reg write_ins;
	reg [4:0] ins_address;
	reg [31:0] ins;
	
	reg [4:0] result_add;

	// Outputs
	wire [31:0] resultado_out;

	// Instantiate the Unit Under Test (UUT)
	ARMProcessor uut (
		.clk(clk), 
		.write_ins(write_ins), 
		.ins_address(ins_address), 
		.ins(ins), 
		.result_add(result_add), 
		.resultado_out(resultado_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		write_ins = 0;
		ins_address = 0;
		ins = 0;
		result_add = 4;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10; write_ins = 0; ins_address = 0; ins = 32'b11110010100000000000000000000100;//ADD $0, $0, 4
		#10; write_ins = 1;									//AW__opIcmd_S_Rn__Rd_/Rot/Immedia
		#10; write_ins = 0; ins_address = 1; ins = 32'b11110010100000000001000000001000;//ADD $1, $0, 8
		#10; write_ins = 1;									//AW__opIcmd_S_Rn__Rd_/Rot/Immedia
		#10; write_ins = 0; ins_address = 2; ins = 32'b11110110000000010000000000000000;//STR $1, $0, 0
		#10; write_ins = 1;									//AW__opI**B*L_Rn__Rd_/Immediate__
		#10; write_ins = 0; ins_address = 2; ins = 32'b11110110000000010000000000000000;//STR $1, $0, 0
		#10; write_ins = 1;									//AW__opI**B*L_Rn__Rd_/Immediate__
		#10; write_ins = 0; ins_address = 3; ins = 32'b11111010111111111111111111111011;//B 0
		#10; write_ins = 1;									//AW__op1L_______Immediate________
		#10; write_ins = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;
		#10; clk = 1;
		#10; clk = 0;

	end
      
endmodule

