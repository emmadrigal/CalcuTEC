`timescale 1ns / 1ps


module controlTest;

	// Inputs
	reg [3:0] cond;
	reg [1:0] op;
	reg [5:0] funct;
	reg [1:0] sh;
	reg [3:0] ALU_flags;

	// Outputs
	wire ALU_set;
	wire sel_PC;
	wire sel_dirA;
	wire [1:0] imm_src;
	wire reg_wr;
	wire sel_B;
	wire mem_wr;
	wire sel_WB;
	wire sel_dest;
	wire [2:0] ALU_ctrl;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.cond(cond), 
		.op(op), 
		.funct(funct), 
		.sh(sh), 
		.ALU_flags(ALU_flags), 
		.ALU_set(ALU_set), 
		.sel_PC(sel_PC), 
		.sel_dirA(sel_dirA), 
		.imm_src(imm_src), 
		.reg_wr(reg_wr), 
		.sel_B(sel_B), 
		.mem_wr(mem_wr), 
		.sel_WB(sel_WB), 
		.sel_dest(sel_dest), 
		.ALU_ctrl(ALU_ctrl)
	);

	initial begin
		// Initialize Inputs
		cond = 0;
		op = 0;
		funct = 0;
		sh = 0;
		ALU_flags = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#10; cond = 15; op= 0; funct = 6'b000100; sh = 0;//SUB
		#10; cond = 15; op= 0; funct = 6'b100100; sh = 0;//SUBI*
		#10; cond = 15; op= 0; funct = 6'b000101; sh = 0;//SUBS*
		#10; cond = 15; op= 0; funct = 6'b001000; sh = 0;//ADD
		#10; cond = 15; op= 0; funct = 6'b101000; sh = 0;//ADDI*
		#10; cond = 15; op= 0; funct = 6'b011000; sh = 0;//OR
		#10; cond = 15; op= 0; funct = 6'b111000; sh = 0;//ORI*
		#10; cond = 15; op= 0; funct = 6'b011010; sh = 0;//LSL
		#10; cond = 15; op= 0; funct = 6'b111010; sh = 0;//LSLI*
		#10; cond = 15; op= 0; funct = 6'b011010; sh = 1;//LSR
		#10; cond = 15; op= 0; funct = 6'b111010; sh = 1;//LSRI*

		#10; cond = 15; op= 0; funct = 6'b000000; sh = 0;//MUL
		
		#10; cond = 15; op= 1; funct = 6'b010100; sh = 0;//SDR
		#10; cond = 15; op= 1; funct = 6'b010101; sh = 0;//LDR
		
		#10; cond = 15; op= 2; funct = 6'b110101; sh = 0;//Branch
        
		// Add stimulus here

	end
      
endmodule



